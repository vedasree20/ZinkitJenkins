<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.src.model.Product" %>
<%@ page import="com.src.dao.ProductDAO" %>
<%@ page import="com.src.dao.ProductDAOImpl" %>
<%
	String searchKeyword = (String) request.getAttribute("searchKeyword");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Zinkit Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .container {
            max-width: 1300px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #249b69;
            margin-bottom: 25px;
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 10px;
            font-weight: 600;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background-color: #249b69;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
        }
        tr:hover {
            background-color: #f5fff8;
        }
        td img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }
        .actions-cell a {
            color: #249b69;
            margin-right: 15px;
            text-decoration: none;
            transition: color 0.2s;
        }
        .actions-cell a:hover {
            color: #1a7a53;
        }
        .delete-btn {
            color: #dc3545 !important;
        }
        .add-btn {
            background-color: #249b69;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
            font-weight: 500;
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
                <a href="index.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
    
        <h2>All Products</h2>
        <div class="action-bar">
            <form action="searchProductsServlet" method="GET" class="search-form">
                <input type="text" name="keyword" class="search-input"
                    placeholder="Search by code or name..."
                    value="<%= searchKeyword != null ? searchKeyword : "" %>">
                <button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>
	 		<a href="addProduct.jsp" class="add-btn">
	            <i class="fa-solid fa-plus"></i> Add New Product
	        </a>       
         </div>     
          

        <%
        List<Product> products = (List<Product>) request.getAttribute("products");

        if (products == null) {
            ProductDAO productDAO = new ProductDAOImpl();
            products = productDAO.findAll(); // fallback if servlet not used
        }

        %>

        <% if (products.isEmpty()) { %>
            <p>No products found in the database.</p>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price (₹)</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // 3. Loop through the list and populate the table rows
                        for (Product p : products) { 
                    %>
                        <tr>
                            <td><%= p.getProductId() %></td>
                            <td>
                                <img src="<%= p.getImageUrl() != null ? p.getImageUrl() : "https://via.placeholder.com/50" %>" alt="Product Image">
                            </td>
                            <td><%= p.getProductName() %></td>
                            <td><%= p.getCategory() != null ? p.getCategory().toString().replace("_", " ") : "N/A" %></td>
                            <td><%= String.format("%.2f", p.getPrice()) %></td>
                            <td><%= p.getQuantityInStock() %></td>
                            <td class="actions-cell">
                                <a href="editProduct.jsp?id=<%= p.getProductId() %>" title="Edit">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
								<a href="DeleteProductServlet?productId=<%= p.getProductId() %>" 
								   class="delete-btn" 
								   title="Delete" 
								   onclick="return confirm('Are you sure you want to delete <%= p.getProductName() %>?');">
								   <i class="fa-solid fa-trash-can"></i>
								</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
        
    </div>

</body>
</html>