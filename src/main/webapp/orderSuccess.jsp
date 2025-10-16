<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed Successfully - Zinkit</title>
            <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <style>
        /* 1. Modal Backdrop and Centering */
        body { 
            font-family: 'Poppins', sans-serif; 
            background: #f7f7f7; 
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden; /* Prevent scrolling when modal is visible */
        }
        
        .modal-backdrop {
            position: fixed; /* Stays in place when scrolling */
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6); /* Dark translucent overlay */
            display: flex; /* Use flexbox to center the content */
            justify-content: center;
            align-items: center;
            z-index: 1000; /* Ensure it's above all other content */
        }

        /* 2. Modal Content Box (The Success Box) */
        .order-modal-content { 
            background: white; 
            padding: 40px; 
            border-radius: 12px; 
            text-align: center; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.25); /* Stronger shadow on the modal itself */
            width: 100%;
            max-width: 450px;
            border-top: 5px solid #249b69; /* Zinkit Green Accent border */
            transform: scale(1); /* Initial state for animation */
            transition: transform 0.3s ease-out;
        }

        /* --- Content Styling (Copied from previous stylish version) --- */
        .icon-circle {
            background-color: #e9fef3; 
            color: #249b69;
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            font-size: 36px;
            margin-bottom: 25px;
        }

        .order-modal-content h1 { 
            color: #333; 
            font-size: 26px; 
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 10px;
        }
        
        .order-modal-content p { 
            color: #555; 
            font-size: 15px; 
            line-height: 1.6;
            margin-bottom: 5px;
        }

        .order-modal-content strong {
            color: #249b69;
            font-weight: 600;
        }

        /* Button Styling */
        .order-modal-content a.modal-btn { 
            display: inline-block; 
            margin-top: 30px; 
            padding: 12px 25px; 
            background: #249b69; 
            color: white; 
            border: none;
            border-radius: 8px; 
            text-decoration: none; 
            font-weight: 600;
            transition: background-color 0.2s, transform 0.2s;
            box-shadow: 0 4px 10px rgba(36, 155, 105, 0.3);
        }
        
        .order-modal-content a.modal-btn:hover { 
            background: #1e8258; 
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    
    <div class="modal-backdrop">
        <div class="order-modal-content">
            <div class="icon-circle">
                <i class="fa-solid fa-check"></i>
            </div>
            <h1>Order Confirmed!</h1>
            <p>Your order has been successfully placed.</p>
            <p>Your tracking ID: <strong>#<%= request.getAttribute("orderId") %></strong></p>
            <p>Thank you for shopping with Zinkit!</p>
            <a href="ViewOrdersServlet" class="modal-btn">
                <i class="fa-solid fa-receipt"></i> View My Orders
            </a>
            <a href="index.jsp" class="modal-btn">
                <i class="fa-solid fa-house"></i>  Back to Home
            </a>
            </div>
    </div>
    
    </body>
</html>