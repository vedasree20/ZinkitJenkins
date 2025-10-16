<%@page import="com.src.service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.src.service.*" %>
<%@ page import="com.src.dao.*" %>
<%@ page import="com.src.model.*" %>
<%-- 
    NOTE: The previous imports for ZinkitProduct and ProductDAO are
    commented out, as the full model isn't available.
    I'm using a simple Map to represent a cart item for demonstration.
    You should replace this with your actual ZinkitProduct model and 
    Cart management logic (e.g., from a session or database). 
--%>
<%-- <%@ page import="com.zinkit.model.ZinkitProduct" %>
<%@ page import="com.zinkit.dao.ProductDAO" %>
<%@ page import="com.zinkit.dao.ProductDAOImpl" %> --%>

<%
    Object userIdObj = session.getAttribute("userId");
    double cartSubtotal = 0.0;
    double zinkitCoins = 0.0;

    if(userIdObj != null){
        String userId = userIdObj.toString();

        // Fetch cart subtotal
        CartDAO cartDAO = new CartDAOImpl(CartDAO.getConnection());
        CartService cartService = new CartServiceImpl(cartDAO);
        java.util.List<com.src.model.Cart> cartItems = cartService.getCartItemsByUserId(userId);
        if(cartItems != null){
            for(com.src.model.Cart item : cartItems){
                cartSubtotal += item.getPriceAtTime() * item.getQuantity();
            }
        }

        // Fetch user info
        UserService userService = new UserServiceImpl();
        User user = userService.findById(userId);
        if(user != null){
            zinkitCoins = user.getWalletBalance(); // Assuming `getZinkitCoins()` exists
        }
    }

    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("en","IN"));
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zinkit - Shopping Cart</title>
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
/* --- Header Styles --- */
        /* --- Re-using CSS from index.jsp --- */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            color: #333;
            background-color: #fff;
        }
        

.main-header {
    padding: 20px 0;
    border-bottom: 1px solid #eee;
    background-color: #fff;
    position: sticky;
    top: 0;
    z-index: 999;
}

.main-header .container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 15px;
}

.main-header .logo {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #333;
}

.main-header .logo span {
    font-size: 16px;
    line-height: 1.2;
    font-weight: 600;
}

.search-bar {
    display: flex;
    border: 1px solid #ddd;
    border-radius: 5px;
    overflow: hidden;
    width: 500px;
    margin-right:90px;
}

.search-bar input {
    flex-grow: 1;
    border: none;
    padding: 10px 15px;
    font-size: 14px;
}

.search-bar input:focus {
    outline: none;
}

.search-bar button {
    background-color: #249b69;
    color: white;
    cursor: pointer;
    border: none;
    padding: 10px 15px;
}

.user-actions {
    display: flex;
    align-items: center;
    gap: 40px;
}

.user-actions .action-item {
    display: flex;
    align-items: center;
    gap:10px;
    text-decoration: none;
    color: #555;
    font-size: 14px;
}

.user-actions .action-item i {
    font-size: 22px;
    margin-right: 8px;
    color: #249b69;
}

/* Profile Dropdown CSS */
.user-profile-dropdown {
    position: relative;
    cursor: pointer;
}

.user-profile-trigger {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #555;
    font-size: 14px;
}

.user-profile-trigger img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}

.user-profile-trigger span i {
    margin-left: 8px;
    font-size: 12px;
    transition: transform 0.2s ease-in-out;
}

.user-profile-dropdown:hover .user-profile-trigger span i {
    transform: rotate(180deg);
}

.dropdown-content {
    display: none;
    position: absolute;
    top: 120%;
    right: 0;
    background-color: white;
    min-width: 180px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.15);
    z-index: 100;
    border-radius: 8px;
    overflow: hidden;
    padding: 5px 0;
    border: 1px solid #eee;
}

.user-profile-dropdown:hover .dropdown-content {
    display: block;
}

.dropdown-content ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.dropdown-content ul li a {
    color: #333;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    font-size: 14px;
    white-space: nowrap;
    transition: background-color 0.2s;
}

.dropdown-content ul li a i {
    margin-right: 12px;
    color: #555;
}

.dropdown-content ul li a:hover {
    background-color: #f5f5f5;
}
</style>
</head>
<body>

    <header class="main-header">
    <div class="container">
        <!-- Logo -->
        <a href="index.jsp" class="logo">
            <span>
                <strong>Zinkit</strong>
                <br>GROCERY
            </span>
        </a>

        <!-- Search Bar -->
        <form class="search-bar" action="SearchProductServlet" method="GET">
            <input type="text" name="query" placeholder="Search for items...">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>

        <!-- User Actions -->
        <div class="user-actions">
        <!-- 
            <a href="#" class="action-item">
                <i class="fa-regular fa-heart"></i>
                <span>Wishlist</span>
            </a>
         -->
         <%
                        UserService us = new UserServiceImpl();
                        User u = (userIdObj != null) ? us.findById(userIdObj.toString()) : null;
         %>
			<%if(u!=null){ %>
            <a href="CartNew.jsp" class="action-item">
                <i class="fa-solid fa-cart-shopping"></i>
                <span>My cart <b><%= currencyFormatter.format(cartSubtotal) %></b></span>
            </a>

            <a href="AddMoney.jsp" class="action-item">
                <i class="fa-solid fa-coins"></i>
                <%
                         us = new UserServiceImpl();
                         u = (userIdObj != null) ? us.findById(userIdObj.toString()) : null;
                        if(u!=null){
                        	zinkitCoins = u.getWalletBalance();
                        }
                %>
                <span>Zinklets<br><b><%= zinkitCoins %></b></span>
            </a>
            <%} %>

            <!-- User Profile Dropdown -->
            <div class="user-profile-dropdown">
                <div class="user-profile-trigger">
                    <img src="https://i.pinimg.com/736x/41/e4/65/41e4658e2c0a9d3994d06c09b471ca44.jpg" alt="User Avatar">
                    <%
                         us = new UserServiceImpl();
                         u = (userIdObj != null) ? us.findById(userIdObj.toString()) : null;
						boolean isAdmin = (u != null && "vedasree2045@gmail.com".equals(u.getEmail())); 
                    %>
                    <span><%= u != null ? u.getUsername() : "Zinky" %> <i class="fa-solid fa-caret-down"></i></span>
                </div>
                <div class="dropdown-content">
                	<% if(u!=null){ %>
                    <ul>
                        <li><a href="editProfile.jsp"><i class="fa-solid fa-user-pen"></i> Edit Profile</a></li>
                         <% if (isAdmin) { %>
                        <li>
						    <a href="manageProducts.jsp">
						        <i class="fa-solid fa-box"></i> Manage Products
						    </a>
						</li>
						<li>
						    <a href="manageDiscounts.jsp">
						        <i class="fa-solid fa-tag"></i> Manage Discounts
						    </a>
						</li>
						<li>
						    <a href="allOrders.jsp">
						        <i class="fa-solid fa-receipt"></i> Check All Orders
						    </a>
						</li>
			            <% } %>
                        <li><a href="ViewOrdersServlet"><i class="fa-solid fa-box-archive"></i> View Orders</a></li>
                        <li><a href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
                    </ul>
                    <% }else{ %>
                    <ul>
                        <li><a href="login.jsp"><i class="fa-solid fa-user-pen"></i> Login</a></li>
                    </ul>
                    <% } %>
                </div>
            </div>

        </div>
    </div>
</header>

</body>
</html>



