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
<%@ include file="header.jsp" %>
<%

				    double walletBalance = (u != null) ? u.getWalletBalance() : 0.0;
				%>

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
    CartDAO cartDAO = new CartDAOImpl(CartDAO.getConnection());
    CartService cartService = new CartServiceImpl(cartDAO);
    
   
    String userId = userIdObj.toString();
    List<Cart> cartItems = cartService.getCartItemsByUserId(userId);

    double subtotal = 0.0;
    if (cartItems != null) {
        for (Cart item : cartItems) {
            subtotal += item.getPriceAtTime() * item.getQuantity();
        }
    }

    // --- Discount preparation ---
    DiscountService discountService = new DiscountServiceImpl(new DiscountDaoImpl());
    List<Discount> activeDiscounts = discountService.getAllActiveDiscounts();
    
    boolean isAnyDiscountApplicable = false;
    double lowestMinCartValue = Double.MAX_VALUE;
    if (activeDiscounts != null) {
        for (Discount d : activeDiscounts) {
            if (d.getMinCartValue() <= subtotal) {
                isAnyDiscountApplicable = true;
            }
            if (d.getMinCartValue() < lowestMinCartValue) {
                lowestMinCartValue = d.getMinCartValue();
            }
        }
    }

    // --- Validate applied coupon ---
    String appliedCouponId = (String) session.getAttribute("appliedCouponId");
    Double discountAmount = (Double) session.getAttribute("discountAmount");
    if (discountAmount == null) discountAmount = 0.0;

    if (appliedCouponId != null) {
        Discount appliedDiscount = discountService.getDiscountById(appliedCouponId);
        if (appliedDiscount == null || subtotal < appliedDiscount.getMinCartValue()) {
            // coupon no longer valid
            discountAmount = 0.0;
            session.removeAttribute("discountAmount");
            session.removeAttribute("appliedCouponId");
            session.setAttribute("couponStatus", "error_reset");
            appliedCouponId = null;
        }
    }

    double shippingCost = (subtotal > 100) ? 0.0 : 40.0;
    double grandTotal = subtotal + shippingCost;
    double finalGrandTotal = grandTotal - discountAmount;

	NumberFormat searchCurrencyFormatter = NumberFormat.getCurrencyInstance(Locale.forLanguageTag("en-IN"));
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
    <style type="text/css">
        /* --- Re-using CSS from index.jsp --- */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            color: #333;
            background-color: #fff;
            height:100vh;
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
        
        /* --- NEW CSS FOR CART PAGE --- */
        main {
            padding: 40px 0;
            background-color: #f8f8f8;
        }

        .cart-page-content {
            display: flex;
            gap: 30px;
            align-items: flex-start; /* Important for left/right alignment */
            justify-content: space-between;
        }
        
        .cart-items-section {
            flex-grow: 1;
            flex-basis: 65%; /* Take up about 2/3 of the space */
        }
        
        .cart-summary-section {
            flex-basis: 30%; /* Take up about 1/3 of the space */
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            position: sticky; /* Sticky sidebar */
            top: 30px;
        }

        h2.page-title {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 25px;
            color: #249b69;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
        }

        /* Cart Item Card Styling */
        .cart-item {
            display: flex;
            align-items: center;
            background-color: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            transition: box-shadow 0.2s;
        }

        .cart-item:hover {
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        
        .item-image {
            width: 80px;
            height: 80px;
            border-radius: 6px;
            overflow: hidden;
            margin-right: 15px;
            flex-shrink: 0; /* Prevents image from shrinking */
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .item-details {
            flex-grow: 1;
        }
        
        .item-details h3 {
            font-size: 16px;
            font-weight: 600;
            margin: 0 0 5px 0;
        }

        .item-details p {
            font-size: 14px;
            color: #777;
            margin: 0;
        }
        
        .item-price {
            font-size: 16px;
            font-weight: 700;
            color: #249b69;
            width: 100px;
            text-align: right;
            flex-shrink: 0;
        }

        .item-quantity {
            display: flex;
            align-items: center;
            margin-left: 20px;
            flex-shrink: 0;
        }

        .quantity-control {
            display: flex;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            margin: 0 10px;
        }

        .quantity-control button {
            background-color: #f7f7f7;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 16px;
            color: #555;
        }

        .quantity-control input {
            width: 30px;
            text-align: center;
            border: none;
            font-size: 14px;
            font-weight: 500;
        }
        
        .remove-item-btn {
            background: none;
            border: none;
            color: #ff4d4d;
            cursor: pointer;
            font-size: 18px;
            margin-left: 20px;
            padding: 5px;
            flex-shrink: 0;
        }

        /* Cart Summary Styling */
        .summary-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            border-bottom: 1px dashed #eee;
            padding-bottom: 10px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 16px;
        }

        .summary-row.total {
            font-size: 20px;
            font-weight: 700;
            color: #333;
            border-top: 2px solid #249b69;
            padding-top: 15px;
            margin-top: 20px;
        }
        
        .summary-row span:last-child {
            font-weight: 600;
            color: #249b69;
        }

        .summary-row.total span:last-child {
            color: #d9534f; /* Highlight total */
        }
        
        .checkout-btn {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #249b69;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            margin-top: 20px;
            transition: background-color 0.2s;
        }
        
        .checkout-btn:hover {
            background-color: #1a7a53;
        }
        
        .empty-cart-message {
            text-align: center;
            padding: 50px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .empty-cart-message i {
            font-size: 50px;
            color: #ccc;
            margin-bottom: 15px;
        }
        .empty-cart-message h3 {
            color: #555;
        }

        /* --- Coupon/Promo Code Section Style --- */
        .coupon-section {
            padding: 15px;
            background-color: #f7fff7; /* Light green background */
            border: 1px dashed #b8e0b8;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .coupon-section h4 {
            font-size: 16px;
            font-weight: 600;
            color: #249b69;
            margin-top: 0;
            margin-bottom: 10px;
        }

        .coupon-input-group {
            display: flex;
            gap: 10px;
        }

        .coupon-input-group input[type="text"] {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.2s;
        }

        .coupon-input-group input[type="text"]:focus {
            outline: none;
            border-color: #249b69;
        }

        .coupon-input-group button {
            background-color: #249b69;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
            flex-shrink: 0; /* Prevents button from shrinking */
        }

        .coupon-input-group button:hover {
            background-color: #1a7a53;
        }

        .coupon-input-group button:active {
            transform: scale(0.98);
        }
        
        /* Style for the discount row in the summary */
        .summary-row.discount {
            color: #d9534f; /* Red for savings */
            font-weight: 600;
        }

        .summary-row.discount span:last-child {
            color: #d9534f;
        }
        
    </style>
</head>
<body>
<!--  -->
    
    <main>
    <div class="container cart-page-content">
        
        <% if (cartItems != null && !cartItems.isEmpty()) { %>
        
            <section class="cart-items-section">
                <h2 class="page-title">Shopping Cart (<%= cartItems.size() %> Items)</h2>

                <% 
                    // Loop through each cart item
                    ProductService ps = new ProductServiceImpl();
                    for (Cart item : cartItems) { 
                        Product p = ps.getProductById(item.getProductId());
                        double total = item.getPriceAtTime() * item.getQuantity();
                        String imageUrl = (p != null && p.getImageUrl() != null) ? p.getImageUrl() : "images/default_product.jpg";
                %>

                <div class="cart-item">
                    <div class="item-image">
                        <img src="<%= imageUrl %>" alt="<%= p != null ? p.getProductName() : "Product Image" %>">
                    </div>
                    
                    <div class="item-details">
                        <h3><%= p != null ? p.getProductName() : "Product Not Found" %></h3>
                        <p>Unit Price: <%= currencyFormatter.format(item.getPriceAtTime()) %></p>
                    </div>

                    <div class="item-quantity">
                        <form action="UpdateCartServlet" method="POST" style="display:flex;">
                            <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                            <div class="quantity-control">
                                <button type="submit" name="action" value="decrease">-</button>
                                <input type="text" name="quantityDisplay" value="<%= item.getQuantity() %>" readonly>
                                <button type="submit" name="action" value="increase">+</button>
                            </div>
                        </form>
                    </div>

                    <div class="item-price">
                        <%= currencyFormatter.format(total) %>
                    </div>

                    <div class="item-remove">
                        <form action="./RemoveCartItemServlet" method="POST">
                            <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                            <button type="submit" class="remove-item-btn" title="Remove Item">
                                <i class="fa-solid fa-trash-can"></i>
                            </button>
                        </form>
                    </div>
                </div> <% } %> 
            </section>

             <aside class="cart-summary-section">
                 <h3 class="summary-title" style="margin-top: 25px;">Order Details</h3>
                
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span><%= currencyFormatter.format(subtotal) %></span>
                </div>
                
                <div class="summary-row">
                    <span>Shipping Estimate</span>
                    <span><%= shippingCost == 0.00 ? "Free" : currencyFormatter.format(shippingCost) %></span>
                </div>
                
                	<%
                	if(discountAmount>0.0){
                	%>
                    <div class="summary-row discount">
                        <span>Coupon Discount</span>
                        <span>- <%= currencyFormatter.format(discountAmount) %></span>
                    </div>
                    <%} %>
                
                <div class="summary-row total">
                    <span>Order Total</span>
                    <span><%= currencyFormatter.format(finalGrandTotal) %></span>
                </div>
                
                <%
				    // Save updated totals in session
				    session.setAttribute("cartItems", cartItems);
				    session.setAttribute("subtotal", subtotal);
				    session.setAttribute("shippingCost", shippingCost);
				    session.setAttribute("grandTotal", finalGrandTotal); 
				
				%>
				
				
				<% if (walletBalance > 0) { %>
				    <div class="summary-row">
				        <label style="display:flex; align-items:center; gap:10px; cursor:pointer;">
				            <input type="checkbox" name="useWallet" id="useWalletCheckbox" 
				                   onchange="updateGrandTotal()" />
				            Use Wallet Balance (<%= currencyFormatter.format(walletBalance) %>)
				        </label>
				    </div>
				<% } %>
				
                
					<a href="Payment.jsp?subtotal=<%= subtotal %>&shippingCost=<%= shippingCost %>&discountAmount=<%= discountAmount %>" 
					   class="checkout-btn" 
					   id="checkoutBtn">
					   Proceed to Checkout
					</a>
					<script>
					document.addEventListener("DOMContentLoaded", () => {
					    const checkoutBtn = document.getElementById('checkoutBtn');
					    const walletCheckbox = document.getElementById('useWalletCheckbox');

					    if (!checkoutBtn || !walletCheckbox) return;

					    checkoutBtn.addEventListener('click', function(e) {
					        e.preventDefault();

					        const useWallet = walletCheckbox.checked ? 'true' : 'false';
					        alert("Wallet checked? " + useWallet); // TEST: should show true/false

					        // Build the URL correctly
					        const url = new URL(checkoutBtn.href, window.location.origin);
					        url.searchParams.set('useWallet', useWallet);
					        
					        

					        window.location.href = url.toString();
					    });
					});


						</script>

      
	          <div class="coupon-section"  style="margin-top: 20px;">
                    <h4><i class="fa-solid fa-tag" style="margin-right: 5px;"></i> Apply a Promo Code</h4>
                    
                    <form action="ApplyCouponServlet" method="POST">
                        <div class="coupon-input-group">
                            <input type="text" id="couponCodeInput" name="couponCode" placeholder="Enter code or select an offer" 
                                value="<%= appliedCouponId != null ? appliedCouponId : "" %>" required>
                            <button type="submit" id="applyCouponBtn" 
                                <% if (discountAmount > 0.0) { %>disabled title="A coupon is already applied."<% } %>
                            >
                                Apply
                            </button>
                            <% if (discountAmount > 0.0) { %>
                                <button type="submit" name="action" value="remove" style="background-color: #d9534f;" title="Remove Applied Coupon">
                                    <i class="fa-solid fa-xmark"></i>
                                </button>
                            <% } %>
                        </div>

                        <%-- Status Messages --%>
                        <%
                            String couponStatus = (String) session.getAttribute("couponStatus");
                            if ("success".equals(couponStatus)) {
                        %>
                            <p style="color:#249b69; font-size:13px; margin-top:10px;">Coupon applied successfully! You saved **<%= currencyFormatter.format(discountAmount) %>**.</p>
                        <%
                            } else if ("error".equals(couponStatus)) {
                        %>
                            <p style="color:#d9534f; font-size:13px; margin-top:10px;">Invalid, expired, or inapplicable coupon code.</p>
                        <%
                            } else if ("error_reset".equals(couponStatus)) {
                        %>
                            <p style="color:#d9534f; font-size:13px; margin-top:10px;">Cart modified. Previous coupon was automatically removed as it no longer applies.</p>
                        <%
                            }
                            session.removeAttribute("couponStatus"); 
                        %>
                        
                        <%-- Discount Applicability Hint --%>
                        <% if (!isAnyDiscountApplicable && lowestMinCartValue != Double.MAX_VALUE) { %>
                            <p style="font-size:13px; color:#d9534f; margin-top:10px; font-weight: 500;">
                                <i class="fa-solid fa-triangle-exclamation" style="margin-right: 5px;"></i> 
                                Add **<%= currencyFormatter.format(lowestMinCartValue - subtotal) %>** more to unlock discounts!
                            </p>
                        <% } %>
                        
                        <%-- Display Active Discounts with Radio Buttons --%>
                        <div class="active-discounts" style="margin-top: 15px; border-top: 1px dashed #eee; padding-top: 15px;">
                            <h5 style="font-size:14px; color:#555; margin-bottom: 8px;">
                                Select an Offer:
                            </h5>
                            
                            <div class="discount-list" style="display: flex; flex-direction: column; gap: 8px;">
                                
                                <%
                                    if (activeDiscounts != null && !activeDiscounts.isEmpty()) {
                                        for (com.src.model.Discount d : activeDiscounts) {
                                            boolean isApplicable = d.getMinCartValue() <= subtotal;
                                            boolean isApplied = d.getId().equals(appliedCouponId);
                                %>
                                    <label style="display: flex; align-items: center; cursor: pointer; font-size: 13px; 
                                        <%= isApplicable ? "font-weight: 500; color: #333;" : "color: #777; opacity: 0.7;" %>
                                        ">
                                        <input type="radio" 
                                            name="selectedCoupon" 
                                            value="<%= d.getId() %>" 
                                            onchange="document.getElementById('couponCodeInput').value = this.value; document.getElementById('applyCouponBtn').disabled = <%= isApplicable %> ? false : true;"
                                            <%= isApplied ? "checked" : "" %>
                                            <%= isApplicable ? "" : "disabled" %>
                                            style="margin-right: 8px;"
                                        >
                                        
                                        <span title="Minimum cart value of <%= currencyFormatter.format(d.getMinCartValue()) %> required.">
                                            [**<%= d.getId() %>**] - 
                                            <%= d.isPercentage() ? d.getValue() + "% OFF" : currencyFormatter.format(d.getValue()) + " OFF" %>
                                            (Min Cart: <%= currencyFormatter.format(d.getMinCartValue()) %>)
                                            <%= isApplied ? "(Applied)" : (isApplicable ? "" : "(Not Met)") %>
                                        </span>
                                    </label>
                                <%
                                        }
                                    } else {
                                %>
                                        <p style="color:#777; font-size:13px;">No active discounts at the moment.</p>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </form>
                </div>
                
                 
            </aside>
                  
                 
            
        <% } else { %>
            <div class="cart-items-section empty-cart-message">
                <i class="fa-solid fa-cart-shopping"></i>
                <h3>Your cart is empty!</h3>
                <p>
                    Looks like you haven't added any groceries yet. 
                    <a href="index.jsp" style="color:#249b69; text-decoration:none; font-weight:500;">
                        Start shopping now!
                    </a>
                </p>
            </div>
        <% } %>

    </div>
</main>

</body>
<script>
    const walletBalance = <%= walletBalance %>;
    const originalTotal = <%= finalGrandTotal %>;

    function updateGrandTotal() {
        const checkbox = document.getElementById('useWalletCheckbox');
        const grandTotalSpan = document.querySelector('.summary-row.total span:last-child');

        let newTotal = originalTotal;
        if (checkbox.checked) {
            newTotal -= walletBalance;
            if (newTotal < 0) newTotal = 0;
        }
        grandTotalSpan.textContent = new Intl.NumberFormat('en-IN', { style: 'currency', currency: 'INR' }).format(newTotal);
    }
</script>


</html>