<%@ page import="java.util.*,com.src.model.*,com.src.dao.*" %>
<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
OrderDAO orderDao = new OrderDAOImpl();
ProductDAO productDao = new ProductDAOImpl();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders - Zinkit</title>
<link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #f7f8fa;
        margin: 0;
        padding: 40px 20px;
    }
    .container {
        max-width: 1000px;
        margin: auto;
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.07);
    }
    h1 {
        color: #249b69;
        font-weight: 700;
        font-size: 28px;
        text-align: center;
        margin-bottom: 40px;
    }
    .order-card {
        border: 1px solid #eaeaea;
        border-radius: 10px;
        margin-bottom: 25px;
        padding: 20px;
        background: #fff;
        box-shadow: 0 3px 10px rgba(0,0,0,0.05);
        transition: transform 0.2s ease;
    }
    .order-card:hover {
        transform: translateY(-3px);
    }
    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px dashed #ddd;
        padding-bottom: 8px;
        margin-bottom: 12px;
    }
    .order-id {
        font-weight: 600;
        color: #249b69;
    }
    .order-status {
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
        background-color: #e9fef3;
        color: #1e8258;
        text-transform: uppercase;
    }
    .order-details p {
        margin: 6px 0;
        font-size: 14px;
        color: #555;
    }
    .order-total {
        font-weight: bold;
        color: #222;
        font-size: 16px;
        margin-top: 10px;
    }
    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
        gap: 15px;
        margin-top: 20px;
    }
    .product-card {
        background: #f8f9fa;
        border: 1px solid #eee;
        border-radius: 10px;
        padding: 10px;
        text-align: center;
        transition: all 0.2s ease;
    }
    .product-card:hover {
        transform: scale(1.03);
        background: #fff;
        box-shadow: 0 3px 10px rgba(0,0,0,0.07);
    }
    .product-card img {
        width: 100px;
        height: 100px;
        object-fit: contain;
        border-radius: 8px;
    }
    .product-name {
        font-size: 14px;
        font-weight: 500;
        color: #333;
        margin: 10px 0 5px;
    }
    .product-price {
        font-size: 13px;
        color: #249b69;
        font-weight: 600;
    }
    .product-qty {
        font-size: 12px;
        color: #555;
    }
    .no-orders {
        text-align: center;
        color: #777;
        background: #fafafa;
        padding: 40px;
        border-radius: 8px;
        border: 1px dashed #ddd;
    }
     .back-link {
            display: inline-block;
            margin-bottom: 15px;
            color: #249b69;
            text-decoration: none;
            font-weight: 500;
        }
</style>
</head>
<body>
<div class="container">
        <a href="index.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>'
    <h1>My Orders</h1>

    <% if (orders == null || orders.isEmpty()) { %>
        <div class="no-orders">
            <i class="fa-solid fa-box-open" style="font-size:40px; margin-bottom:10px;"></i>
            <p>You haven't placed any orders yet.</p>
        </div>
    <% } else { 
        for (Order o : orders) {
            List<OrderItem> items = orderDao.fetchItemsByOrder(o.getOrderId());
    %>
        <div class="order-card">
            <div class="order-header">
                <div class="order-id">Order #<%= o.getOrderId() %></div>
                <div class="order-status"><%= o.getOrderStatus() %></div>
            </div>

            <div class="order-details">
                <p><strong>Payment:</strong> <%= o.getPaymentMethod() %></p>
                <p><strong>Date:</strong> <%= o.getOrderDate() %></p>
                <p><strong>Address:</strong> <%= o.getDeliveryAddress() %>, <%= o.getCity() %></p>
                <p class="order-total"><i class="fa-solid fa-indian-rupee-sign"></i> <%= o.getTotalAmount() %></p>
            </div>

            <div class="product-grid">
                <% for (OrderItem item : items) {
                    Product product = productDao.findById(item.getProductId());
                %>
                <div class="product-card">
                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getProductName() %>">
                    <div class="product-name"><%= product.getProductName() %></div>
                    <div class="product-price">&#8377;<%= item.getPriceAtTime() %></div>
                    <div class="product-qty">Qty: <%= item.getQuantity() %></div>
                    <div class="product-total"><small>Total:</small> &#8377;<%= item.getQuantity() * item.getPriceAtTime() %></div>
                </div>
                <% } %>
            </div>
        </div>
    <% } } %>
</div>
</body>
</html>
