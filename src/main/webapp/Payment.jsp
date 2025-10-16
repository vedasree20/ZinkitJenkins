<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.src.model.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.src.service.*" %>

<%
    List<Cart> cartItems = (List<Cart>) session.getAttribute("cartItems");
    double subtotal = session.getAttribute("subtotal") != null ? (double) session.getAttribute("subtotal") : 0.0;
    double shippingCost = session.getAttribute("shippingCost") != null ? (double) session.getAttribute("shippingCost") : 0.0;
    double grandTotal = session.getAttribute("grandTotal") != null ? (double) session.getAttribute("grandTotal") : 0.0;

    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
%>
<%
    double discountAmount = request.getParameter("discountAmount") != null ? 
                            Double.parseDouble(request.getParameter("discountAmount")) : 0.0;
    boolean useWallet = request.getParameter("useWallet") != null && 
                        Boolean.parseBoolean(request.getParameter("useWallet"));

    double walletBalance = 0.0;
    UserService us = new UserServiceImpl();
    String uid = session.getAttribute("userId").toString();
    User u = us.findById(uid);
    if (u != null) {
        walletBalance = u.getWalletBalance();
    }
    System.out.println(useWallet);
    System.out.println(walletBalance);

    double finalTotal = grandTotal;
    if (useWallet && walletBalance > 0) {
        finalTotal -= walletBalance;
        if(finalTotal < 0) finalTotal = 0.0;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zinkit - Secure Checkout</title>
    
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* --- General Page Setup --- */
        body {
            font-family: 'Nunito Sans', sans-serif;
            margin: 0;
            color: #333;
            background-color: #f4f7f9;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 40px 20px;
            box-sizing: border-box;
        }

        .checkout-container {
            max-width: 900px;
            width: 100%;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .checkout-header {
            padding: 20px 30px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .checkout-header .logo-text {
            font-size: 24px;
            font-weight: 800;
            color: #249b69;
        }

        .checkout-body {
            display: flex;
        }

        .checkout-col {
            padding: 30px;
        }

        /* --- Order Summary Column --- */
        .order-summary {
            flex: 0 0 320px;
            background-color: #f8f9fa;
            border-right: 1px solid #e9ecef;
        }

        .order-summary h2 {
            font-size: 20px;
            margin-top: 0;
            margin-bottom: 25px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 14px;
            color: #495057;
        }
        
        .summary-item .item-price {
            font-weight: 600;
        }

        .summary-divider {
            border: 0;
            border-top: 1px dashed #ced4da;
            margin: 20px 0;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 18px;
            font-weight: 700;
            color: #212529;
            margin-top: 20px;
        }

        .summary-total span:last-child {
            color: #249b69;
            font-size: 20px;
        }

        /* --- Payment Method Column --- */
        .payment-method {
            flex-grow: 1;
        }
        
        .payment-method h2 {
            font-size: 20px;
            margin-top: 0;
            margin-bottom: 20px;
        }

        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 25px;
        }

        .payment-option {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            cursor: pointer;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        
        .payment-option.selected {
            border-color: #249b69;
            box-shadow: 0 0 0 3px rgba(36, 155, 105, 0.15);
        }

        .payment-option label {
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
        }

        .payment-option input[type="radio"] {
            transform: scale(1.2);
            accent-color: #249b69;
        }
        
        .card-logos img {
            height: 24px;
            margin-left: 5px;
        }

        /* --- Forms & Info Sections --- */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #495057;
            margin-bottom: 6px;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 16px;
            font-family: 'Nunito Sans', sans-serif;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-group input[type="text"]:focus {
            outline: none;
            border-color: #249b69;
            box-shadow: 0 0 0 3px rgba(36, 155, 105, 0.15);
        }

        .form-row {
            display: flex;
            gap: 20px;
        }
        .form-row .form-group {
            flex: 1;
        }

        #cod-info {
            background-color: #e9fef3;
            border: 1px solid #b8ebd2;
            color: #1e8258;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }

        #cod-info i {
            font-size: 24px;
            margin-bottom: 10px;
            display: block;
        }

        .confirm-btn {
            width: 100%;
            padding: 15px;
            background-color: #249b69;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        .confirm-btn:hover {
            background-color: #1e8258;
        }
        
        /* --- Responsive Design --- */
        @media (max-width: 800px) {
            body {
                padding: 20px 10px;
            }
            .checkout-body {
                flex-direction: column;
            }
            .order-summary {
                border-right: none;
                border-bottom: 1px solid #e9ecef;
            }
        }
    </style>
</head>
<body>

    <div class="checkout-container">
        <header class="checkout-header">
            <img src="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg" height="50px"/>
            <span class="logo-text">Zinkit Checkout</span>
        </header>

        <main class="checkout-body">
            
            <section class="checkout-col order-summary">
                <h2>Your Order</h2>
<% if (cartItems != null && !cartItems.isEmpty()) { %>
    <% for (Cart item : cartItems) { 
           double total = item.getPriceAtTime() * item.getQuantity();
           // If you want product names, fetch using ProductService as in CartNew.jsp
           ProductService ps = new ProductServiceImpl();
           Product p = ps.getProductById(item.getProductId());
    %>
        <div class="summary-item">
            <span class="item-name"><%= p.getProductName() %> (x<%= item.getQuantity() %>)</span>
            <span class="item-price"><%= currencyFormatter.format(total) %></span>
        </div>
    <% } %>

    <hr class="summary-divider">

    <div class="summary-item">
        <span>Subtotal</span>
        <span><%= currencyFormatter.format(subtotal) %></span>
    </div>
    
  

    <div class="summary-row discount">
        <span>Coupon Discount</span>
        <span>- <%= currencyFormatter.format(discountAmount) %></span>
    </div>
    
    <%if(useWallet){ %>
    <div class="summary-row discount">
        <span>Wallet Discount</span>
        <span>- Applied</span>
    </div>
    <%} %>
                
                
    <div class="summary-item">
        <span>Delivery Fee</span>
        <span><%= shippingCost == 0.0 ? "FREE" : currencyFormatter.format(shippingCost) %></span>
    </div>
                  
    
  <div class="summary-total">
    <span>To Pay</span>
    <span><%= currencyFormatter.format(finalTotal) %></span>
</div>
<% if (useWallet && walletBalance > 0) { %>
    <p style="color:#249b69; font-size:14px;">Wallet applied: <%= currencyFormatter.format(walletBalance) %></p>
<% } %>

<% } %>
            </section>

            <section class="checkout-col payment-method">
                <h2>Choose Payment Method</h2>

                <form action="./PlaceOrderServlet" method="POST">
                    <div class="payment-options">
                        <div class="payment-option selected" id="cardOptionContainer">
                        <input type="hidden" name="useWallet" value="<%= request.getParameter("useWallet") %>">
                        
                            <label for="cardOption">
                                <input type="radio" name="paymentMethod" value="card" id="cardOption" checked>
                                Pay with Card
                                <span class="card-logos">
                                    <img src="https://i.pinimg.com/1200x/bd/ba/7f/bdba7f9470ce0f566db9f0a7f1ebbbf3.jpg" alt="Visa">
                                    <img src="https://i.pinimg.com/1200x/be/f1/bc/bef1bca7bb930f868c679a5c6b37056a.jpg" alt="Mastercard">
                                </span>
                            </label>
                        </div>

                        <div class="payment-option" id="codOptionContainer">
                            <label for="codOption">
                                <input type="radio" name="paymentMethod" value="cod" id="codOption">
                                Cash on Delivery (COD)
                            </label>
                        </div>
                    </div>
                    
                    <div id="card-payment-form">
                        <div class="form-group">
                            <label for="card-name">Cardholder Name</label>
                            <input type="text" id="card-name" placeholder="Vedasree A">
                        </div>
                        <div class="form-group">
                            <label for="card-number">Card Number</label>
                            <input type="text" id="card-number" placeholder="1234 5678 9101 1121">
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="expiry-date">Expiry Date</label>
                                <input type="text" id="expiry-date" placeholder="MM / YY">
                            </div>
                            <div class="form-group">
                                <label for="cvv">CVV</label>
                                <input type="text" id="cvv" placeholder="123">
                            </div>
                        </div>
                    </div>

                    <div id="cod-info" style="display: none;">
                        <i class="fa-solid fa-hand-holding-dollar"></i>
                        <p>You can pay in cash to our delivery agent upon receiving your order.</p>
                    </div>
                    
                    <button type="submit" class="confirm-btn">Confirm & Place Order</button>
                </form>
            </section>
        </main>
    </div>

    <script>
        // Get references to the elements
        const cardOption = document.getElementById('cardOption');
        const codOption = document.getElementById('codOption');
        const cardOptionContainer = document.getElementById('cardOptionContainer');
        const codOptionContainer = document.getElementById('codOptionContainer');
        const cardForm = document.getElementById('card-payment-form');
        const codInfo = document.getElementById('cod-info');

        // Function to handle payment option change
        function handlePaymentChange() {
            if (cardOption.checked) {
                cardForm.style.display = 'block';
                codInfo.style.display = 'none';
                cardOptionContainer.classList.add('selected');
                codOptionContainer.classList.remove('selected');
            } else if (codOption.checked) {
                cardForm.style.display = 'none';
                codInfo.style.display = 'block';
                cardOptionContainer.classList.remove('selected');
                codOptionContainer.classList.add('selected');
            }
        }

        // Add event listeners
        cardOption.addEventListener('change', handlePaymentChange);
        codOption.addEventListener('change', handlePaymentChange);

        // Also trigger change on container click for better UX
        cardOptionContainer.addEventListener('click', () => {
            cardOption.checked = true;
            handlePaymentChange();
        });

        codOptionContainer.addEventListener('click', () => {
            codOption.checked = true;
            handlePaymentChange();
        });

        // Initial check on page load
        handlePaymentChange();
        
    </script>
</body>
</html>