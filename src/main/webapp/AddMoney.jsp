<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.src.model.User" %>
<%@ page import="com.src.service.*" %>

<%
String id = session.getAttribute("userId").toString();
UserService us = new UserServiceImpl();
User u = us.findById(id); 
if (u == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Money to Wallet</title>
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
      /* Base Styles */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f4f6f8;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

/* Wallet Form Container */
.wallet-form {
    background: #fff;
    padding: 40px 50px;
    border-radius: 15px;
    box-shadow: 0 8px 30px rgba(0,0,0,0.15);
    text-align: center;
    width: 350px;
    max-width: 90%;
}

.wallet-form h2 {
    margin-bottom: 30px;
    color: #333;
    font-weight: 600;
}

/* Balance Display */
.balance-info {
    margin: 20px 0;
    padding: 10px;
    background-color: #e6f7ff;
    border: 1px solid #b3e0ff;
    border-radius: 8px;
    color: #0056b3;
    font-weight: 500;
}

.balance-info span {
    font-weight: 600;
    color: #007bff;
}

/* Form Inputs */
.wallet-form input[type="number"] {
    width: calc(100% - 20px);
    padding: 12px 10px;
    margin: 15px 0;
    border-radius: 8px;
    border: 1px solid #ddd;
    font-size: 16px;
    transition: border-color 0.3s;
}

.wallet-form input[type="number"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Submit Button */
.wallet-form button {
    width: 100%;
    padding: 15px 20px;
    border: none;
    border-radius: 8px;
    background-color: #28a745;
    color: white;
    font-size: 17px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.1s;
}

.wallet-form button:hover {
    background-color: #218838;
}

.wallet-form button:active {
    transform: scale(0.99);
}


/* Back Link */
			.back-link {
	            display: inline-block;
	            margin-bottom: 15px;
	            color: #249b69;
	            text-decoration: none;
	            font-weight: 500;
	        }
.back-link:hover {
    color: #0056b3;
    text-decoration: underline;
}

.back-link i {
    margin-right: 5px;
}
    </style>
</head>
<body>
    <div class="wallet-form">
        <h2>Add Money to Wallet</h2>
        <form action="AddWalletServlet" method="post">
            <input type="hidden" name="userId" value="<%= u.getUserId() %>" />
            <input type="number" name="amount" placeholder="Enter amount" required min="1" />
            <button type="submit">Add Money</button>
        </form>

        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>

        <p>Current Balance: ₹ <%= u.getWalletBalance() %></p>
        <a href="index.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
    </div>
</body>
</html>
