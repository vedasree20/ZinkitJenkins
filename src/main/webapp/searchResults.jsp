<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.src.model.Product, com.src.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.src.service.*" %>
<%@ page import="com.src.dao.*" %>
<%@ include file="header.jsp" %>

<%
    // Server-side logic to retrieve data
    List<Product> results = (List<Product>) request.getAttribute("searchResults");
    String searchQuery = (String) request.getAttribute("searchQuery");
   // User u = (User) session.getAttribute("loggedInUser");
    
    // Ensure searchQuery is not null for display
    String displaySearchQuery = searchQuery != null ? searchQuery : "";
%>
<%
	NumberFormat searchCurrencyFormatter = NumberFormat.getCurrencyInstance(Locale.forLanguageTag("en-IN"));
    double subtotal = 0.0;
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results for "<%= displaySearchQuery %>" - Zinkit</title>
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style type="text/css">
        /* --- General Zinkit Styling (Copied from your index.jsp) --- */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            color: #333;
            background-color: #fff;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
            display: flex;
            align-items: center; /* Default alignment */
            justify-content: space-between; /* Default justification */
        }
        
        /* Header Section */
        .main-header {
            padding: 20px 0;
            border-bottom: 1px solid #eee;
        }
        
        .main-header .logo {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: inherit;
        }
        
        .main-header .logo span {
            font-size: 14px;
            line-height: 1.2;
        }
        
        .search-bar {
            display: flex;
            border: 1px solid #ddd;
            margin-left:100px;
            border-radius: 5px;
            overflow: hidden;
            width: 650px;
        }
        
        .search-bar input {
            flex-grow: 1;
            border: none;
            padding: 10px;
            font-size: 14px;
            padding-left: 15px;
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
            gap: 25px;
        }
        
        .user-actions .action-item {
            display: flex;
            align-items: center;
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
            width: 16px;
        }

        .dropdown-content ul li a:hover {
            background-color: #f5f5f5;
        }
        

        /* Header Styles (Required for consistent header) */
        .main-header { padding: 20px 0; border-bottom: 1px solid #eee; background-color: white; }
        .main-header .logo span { font-size: 14px; line-height: 1.2; }
        .search-bar { display: flex; border: 1px solid #ddd; margin-left: 100px; border-radius: 5px; overflow: hidden; width: 650px; }
        .search-bar input { flex-grow: 1; padding: 10px 15px; border: none; font-size: 14px; }
        .search-bar button { background-color: #249b69; color: white; cursor: pointer; padding: 10px 15px; border: none; }
        .user-actions { display: flex; align-items: center; gap: 25px; }
        .user-actions .action-item i { font-size: 22px; margin-right: 8px; color: #249b69; }
        .user-actions .user-profile img { width: 40px; height: 40px; border-radius: 50%; margin-right: 10px; }
        .login-btn button { background-color: #249b69; color: white; border: none; padding: 10px 20px; border-radius: 5px; font-weight: 600; cursor: pointer; }
        /* ... (Include all other necessary header/menu styles here) ... */

        /* --- Search Results Specific Layout --- */
        .search-results-wrapper {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .search-results-wrapper h2 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            color: #333;
            padding-bottom: 10px;
            border-bottom: 2px solid #eee;
        }
        
        .search-results-wrapper h2 strong {
            color: #249B69;
        }

        .no-results-message {
            font-size: 18px;
            color: #777;
            text-align: center;
            padding: 50px 0;
            background-color: #fff;
            border-radius: 10px;
            border: 1px solid #eee;
        }

        /* The beautiful GRID layout for the results */
        .product-grid {
            display: grid;
            /* Using 4 columns for a clean look, adjust as desired */
            grid-template-columns: repeat(4, 1fr); 
            gap: 20px;
        }
        
        /* --- Product Card Styling (Copied from your index.jsp) --- */

        .product-card {
            background-color: white;
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 15px;
            transition: box-shadow 0.3s;
            text-align: left;
        }

        .product-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .product-card img {
            width: 100%;
            max-height: 140px;
            object-fit: contain;
            margin-bottom: 10px;
        }

        .product-card .product-category {
            font-size: 12px;
            color: #999;
            margin: 0;
        }

        .product-card h3 {
            font-size: 16px;
            font-weight: 600;
            margin: 5px 0;
        }
        
        .product-card .product-seller {
             font-size: 13px;
             color: #666;
             margin: 10px 0;
        }

        .product-card .product-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }

        .product-card .price b {
            color: #249B69;
            font-size: 18px;
            margin-right: 5px;
        }

        .product-card .add-btn {
            background-color: #249B69;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .product-card .add-btn i {
            margin-right: 5px;
        }

        /* Responsive adjustments for the grid */
        @media (max-width: 1200px) {
            .product-grid { grid-template-columns: repeat(3, 1fr); }
        }

        @media (max-width: 768px) {
            .product-grid { grid-template-columns: repeat(2, 1fr); }
            .search-results-wrapper h2 { font-size: 24px; }
        }

        @media (max-width: 576px) {
            .product-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<<!--
    
      <header class="main-header">
        <div class="container">
            <a href="index.jsp" class="logo">
                <span>
                    <strong>Zinkit</strong>
                    <br>GROCERY
                </span>
            </a>

            <form class="search-bar" action="SearchProductServlet" method="GET">
                <input type="text" name="query" placeholder="Search for items...">
                <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>

            <div class="user-actions">
                <a href="#" class="action-item">
                    <i class="fa-regular fa-heart"></i>
                    <span>Wishlist</span>
                </a>
                <a href="CartNew.jsp" class="action-item">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span>My cart <br><b>
                    //start
                   currencyFormatter.format(subtotal)</b></span>
                   //end
                </a>
                
			<div class="user-profile-dropdown">
			    <div class="user-profile-trigger">
			        <img src="https://i.pinimg.com/736x/db/4c/c4/db4cc46371c5910c2de13e68da83379d.jpg" alt="User Avatar">
			       
			        ///start
			            UserService us = new UserServiceImpl();
			            Object userIdObj = session.getAttribute("userId");
			            if (userIdObj == null) {
			                // User is not logged in, redirect to login
			                response.sendRedirect("login.jsp");
			                return; // stop further processing
			            }
			            String userIdD = userIdObj.toString();
			             u = us.findById(userIdD);
			        //end
			        <span>
			        //start
			        u != null ? u.getUsername() : ""
			        //end
			         <i class="fa-solid fa-caret-down"></i></span>
			    </div>
			    <div class="dropdown-content">
			        <ul>
			            <li><a href="editProfile.jsp"><i class="fa-solid fa-user-pen"></i> Edit Profile</a></li>
			            <li><a href="viewOrders.jsp"><i class="fa-solid fa-box-archive"></i> View Orders</a></li>
			            <li><a href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
			        </ul>
			    </div>
			</div>

            </div>
        </div>
    </header>
 - -->
    <main>
        <div class="search-results-wrapper">
            <h2>Search Results for "<strong><%= displaySearchQuery %></strong>"</h2>

            <% if (results == null || results.isEmpty()) { %>
                <p class="no-results-message">
                    No products found matching your query: **<%= displaySearchQuery %>**. Please try a different search term.
                </p>
            <% } else { %>
                <div class="product-grid">
                    <% for (Product p : results) { %>
                        <div class="product-card">
                            <img src="<%= p.getImageUrl() != null ? p.getImageUrl() : "https://via.placeholder.com/150" %>" alt="<%= p.getProductName() %>">
                            
                            <p class="product-category"><%= p.getCategory() != null ? p.getCategory().name().replace("_"," ") : "General" %></p>
                            <h3><%= p.getProductName() %></h3>
                            <p class="product-seller">By Zinkit</p>
                            
                            <div class="product-footer">
                                <p class="price"><b>₹<%= p.getPrice() %></b></p>
                                
                                <form action="AddToCartServlet" method="post">
                                    <input type="hidden" name="userId" value="<%= u != null ? u.getUserId() : "" %>">
                                    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                    <input type="hidden" name="priceAtTime" value="<%= p.getPrice() %>">
                                    <button type="submit" class="add-btn">
                                        <i class="fa-solid fa-plus"></i> Add
                                    </button>
                                </form>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    </main>

    <script>
        // JS for dropdown menu (if needed)
        document.getElementById('profile-btn').addEventListener('click', function() {
            document.getElementById('dropdown-menu').classList.toggle('show');
        });

        window.onclick = function(event) {
            if (!event.target.matches('#profile-btn') && !event.target.closest('#profile-btn')) {
                var dropdown = document.getElementById('dropdown-menu');
                if (dropdown.classList.contains('show')) {
                    dropdown.classList.remove('show');
                }
            }
        }
    </script>
</body>
</html>