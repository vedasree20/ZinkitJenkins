<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Action Required</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    
    <style>
        /* BASE STYLES */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background-color: #f8f8f8; /* A neutral background color */
        }
        
        /* MODAL BACKDROP */
        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            /* Dark semi-transparent background */
            background-color: rgba(0, 0, 0, 0.6); 
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1050; /* Above all other elements */
        }
        
        /* MODAL CONTAINER */
        .modal-content {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 400px; /* Max width for a nice modal size */
            text-align: center;
            position: relative;
        }

        /* ICON STYLES */
        .modal-content i:not(.modal-actions a i) {
            font-size: 50px;
            color: #249b69; /* Warning yellow */
            margin-bottom: 20px;
        }
        
        /* HEADER STYLES */
        .modal-content h4 {
            font-size: 22px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        
        /* PARAGRAPH STYLES */
        .modal-content p {
            font-size: 15px;
            color: #777;
            margin-bottom: 30px;
        }

        /* ACTIONS CONTAINER */
        .modal-actions {
            /* Ensures proper spacing for the button row */
            display: flex;
            justify-content: center;
            gap: 16px; /* Space between buttons */
            flex-wrap: wrap; /* Allows buttons to stack on smaller screens */
        }

        /* GENERAL BUTTON STYLES */
        .modal-actions a {
            flex: 1 1 45%; /* Allows buttons to grow/shrink but maintain min size */
            max-width: 180px; /* Max width for button */
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.2s, box-shadow 0.2s;
            display: flex; /* For centering content (icon and text) */
            align-items: center;
            justify-content: center;
        }
        
        .modal-actions a i {
            margin-right: 8px;
        }

        /* PRIMARY BUTTON (LOGIN) */
        .btn-login {
            background-color: #249b69; /* Primary action color */
            color: white;
            border: 1px solid #249b69;
        }
        
        .btn-login:hover {
            background-color: #1a7a53;
            border-color: #1a7a53;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        /* SECONDARY BUTTON (CANCEL) */
        .btn-cancel {
            background-color: #f0f0f0;
            color: #555;
            border: 1px solid #ddd;
        }

        .btn-cancel:hover {
            background-color: #e0e0e0;
            border-color: #ccc;
        }
        
        /* MEDIA QUERY for smaller screens (optional but good practice) */
        @media (max-width: 450px) {
            .modal-content {
                padding: 20px;
                margin: 20px;
            }
            .modal-actions a {
                flex: 1 1 100%; /* Stack buttons vertically */
                max-width: none;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>

<%
    // Get the previous page URL (the one that tried to add the item)
    // This is useful for redirecting the user back to the product page after they log in
    String referer = request.getHeader("Referer");
    
    // Check if the referer is null, empty, or points to the login page itself (to avoid loops)
    if (referer == null || referer.isEmpty() || referer.contains("login.jsp")) {
        referer = "index.jsp"; // Default fallback
    }
    
    // Store the return path in session for the login servlet
    // This is the key part that lets the login process know where to send the user next
    session.setAttribute("redirectAfterLogin", referer);
%>

<div class="modal-backdrop" id="loginModal">
    <div class="modal-content">
        <i class="fa-solid fa-triangle-exclamation"></i>
        
        <h4>Action Required</h4>
        <p>You must be logged in to add products to your cart. Please log in or create an account to continue shopping.</p>
        
        <div class="modal-actions">
            <a href="login.jsp" class="btn-login">
                <i class="fa-solid fa-right-to-bracket"></i> Login / Sign Up
            </a>
            
            <a href="<%= referer %>" class="btn-cancel">
                <i class="fa-solid fa-xmark"></i> Stay on Page
            </a>
        </div>
    </div>
</div>

</body>
</html>