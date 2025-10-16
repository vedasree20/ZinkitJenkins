<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>My Wallet</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .wallet-card {
            background: #fff;
            border-radius: 15px;
            padding: 40px 60px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 {
            color: #333;
        }
        .amount {
            font-size: 36px;
            color: #28a745;
            font-weight: bold;
            margin-top: 10px;
        }
        a {
            text-decoration: none;
            color: #007bff;
            display: inline-block;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="wallet-card">
        <h2>Wallet Balance</h2>
        <p class="amount">₹ <%= u.getWalletBalance() %></p>
        <a href="AddMoney.jsp">Add Money</a>
    </div>
</body>
</html>
