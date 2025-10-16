<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.src.model.User, com.src.model.Discount, com.src.model.DiscountType, com.src.service.DiscountServiceImpl, com.src.service.DiscountService, com.src.dao.DiscountDaoImpl, com.src.dao.DiscountDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.List, com.src.model.Discount" %>
<%@ page import="javax.ws.rs.client.Client, javax.ws.rs.client.ClientBuilder, javax.ws.rs.client.WebTarget" %>
<%@ page import="javax.ws.rs.core.GenericType, javax.ws.rs.core.MediaType" %>
<%@ page import="com.src.model.DiscountWrapper" %>
<%
    // Create Jersey client
    Client client = ClientBuilder.newClient();
    WebTarget target = client.target("http://localhost:8082/ZinkitJersey/webresources/myresource/search");

    
    // Fetch list of products

		DiscountWrapper wrapper = target.request(MediaType.APPLICATION_JSON)
		                                .get(DiscountWrapper.class);
		
		List<Discount> discounts = wrapper.getDiscount();


%>

<%
    // Admin access check
    User currentUser = (User) session.getAttribute("loggedInUser");
   
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    DecimalFormat df = new DecimalFormat("0.00");

    if (discounts == null) {
        // If servlet didn’t set it (first time load)
        DiscountDao da = new DiscountDaoImpl();
        DiscountService ds = new DiscountServiceImpl(da);
        discounts = ds.getAllDiscounts();
    }

    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Discounts - Zinkit Admin</title>
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f7fafc;
            margin: 0;
            padding: 40px 20px;
            color: #333;
        }

        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .admin-header {
            text-align: center;
            border-bottom: 2px solid #eee;
            margin-bottom: 40px;
            padding-bottom: 20px;
        }

        .admin-header h2 {
            color: #249b69;
            font-size: 32px;
            margin: 0;
        }

        .admin-header p {
            color: #777;
            margin-top: 5px;
        }

        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .search-form {
            display: flex;
            width: 350px;
        }

        .search-input {
            flex: 1;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px 0 0 5px;
        }

        .search-btn {
            background-color: #f7fafc;
            border: 1px solid #ddd;
            border-left: none;
            color: #249b69;
            border-radius: 0 5px 5px 0;
            padding: 10px 15px;
            cursor: pointer;
        }

        .primary-button {
            padding: 12px 20px;
            background-color: #249b69;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
        }

        .primary-button:hover {
            background-color: #1e8258;
        }

        .discount-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .discount-table th, .discount-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        .discount-table th {
            background-color: #e6f8f0;
            color: #1e8258;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
        }

        .discount-table tr:hover {
            background-color: #f5f5f5;
        }

        .edit-btn, .delete-btn {
            border: none;
            border-radius: 5px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            padding: 8px 12px;
            transition: opacity 0.2s;
        }

        .edit-btn { background-color: #ffc107; color: #333; }
        .delete-btn { background-color: #dc3545; color: white; }

        .edit-btn:hover, .delete-btn:hover { opacity: 0.8; }

        .status-active {
            background: #28a745;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-inactive {
            background: #6c757d;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }

        .message {
            padding: 10px;
            margin: 15px 0;
            border-radius: 5px;
            text-align: center;
            font-weight: 600;
        }

        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .no-discounts {
            text-align: center;
            padding: 40px;
            color: #777;
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

    <div class="admin-container">
        <a href="index.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
        <div class="admin-header">
            <h2>Discount Code Management</h2>
            <p>Admin control panel for all promotional discounts.</p>
        </div>

        <% if (successMessage != null) { %>
            <div class="message success"><%= successMessage %></div>
        <% } %>
        <% if (errorMessage != null) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } %>

        <div class="action-bar">
            <form action="searchDiscounts" method="GET" class="search-form">
                <input type="text" name="keyword" class="search-input"
                    placeholder="Search by code or name..."
                    value="<%= searchKeyword != null ? searchKeyword : "" %>">
                <button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>

            <button class="primary-button" onclick="location.href='addDiscount.jsp'">
                <i class="fa-solid fa-plus"></i> Add New Discount
            </button>
        </div>

        <table class="discount-table">
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Type</th>
                    <th>Value</th>
                    <th>Min. Cart (₹)</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (discounts == null || discounts.isEmpty()) { %>
                    <tr>
                        <td colspan="6" class="no-discounts">
                            <% if (searchKeyword != null && !searchKeyword.trim().isEmpty()) { %>
                                No discounts found for "<strong><%= searchKeyword %></strong>".
                            <% } else { %>
                                No discounts available. Click "Add New Discount" to create one.
                            <% } %>
                        </td>
                    </tr>
                <% } else { 
                    for (Discount d : discounts) { %>
                        <tr>
                            <td><%= d.getId() %></td>
                            <td><%= d.getType().name() %></td>
                            <td><%= df.format(d.getValue()) %><%= d.isPercentage() ? "%" : "₹" %></td>
                            <td>₹<%= df.format(d.getMinCartValue()) %></td>
                            <td>
                                <span class="<%= d.isActive() ? "status-active" : "status-inactive" %>">
                                    <%= d.isActive() ? "Active" : "Inactive" %>
                                </span>
                            </td>
                            <td>
                                <form action="EditDiscount.jsp" method="GET" style="display:inline;">
                                    <input type="hidden" name="discountId" value="<%= d.getId() %>">
                                    <button type="submit" class="edit-btn">
                                        <i class="fa-solid fa-pen-to-square"></i> Edit
                                    </button>
                                </form>

                                <a href="deleteDiscount?discountId=<%= d.getId() %>" onclick="return confirm('Are you sure you want to delete this discount?');">
                                    <button class="delete-btn">
                                        <i class="fa-solid fa-trash-can"></i> Delete
                                    </button>
                                </a>
                            </td>
                        </tr>
                <% } } %>
            </tbody>
        </table>
    </div>
</body>
</html>
