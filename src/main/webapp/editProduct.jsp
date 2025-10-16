<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.src.model.Product" %>
<%@ page import="com.src.dao.ProductDAO" %>
<%@ page import="com.src.dao.ProductDAOImpl" %>

<%
    // 1. Retrieve the product ID from the URL parameter
    String productIdParam = request.getParameter("id");
    
    Product product = null;
    boolean productFound = false;
    
    if (productIdParam != null && !productIdParam.trim().isEmpty()) {
        try {
            // Convert the ID to the correct type (assuming String ID based on your other code, 
            // but use Integer.parseInt if it's an int)
            String productId = productIdParam; 
            
            // 2. Instantiate the DAO
            ProductDAO productDAO = new ProductDAOImpl();
            
            // 3. Fetch the product details
            product = productDAO.findById(productId); // Assume findById method exists
            
            if (product != null) {
                productFound = true;
            }
        } catch (Exception e) {
            // Log the exception in a real application
            e.printStackTrace();
            // Optionally redirect or show an error message
        }
    }
    
    // Handle case where product ID is missing or product is not found
    if (!productFound) {
        // You might want to redirect to the product list page with an error message
        response.sendRedirect("manageProducts.jsp?error=product_not_found");
        return; // Stop further processing of the JSP
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Product - Zinkit Grocery</title>
<link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
/* --- STYLES COPIED FROM ADDPRODUCT.JSP --- */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f7fafc;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    color: #333;
}
.form-container {
    background-color: #ffffff;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    width: 90%;
    max-width: 900px;
    box-sizing: border-box;
}
.form-header {
    text-align: center;
    margin-bottom: 25px;
}
.form-header .logo {
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    color: inherit;
    margin-bottom: 10px;
}
.form-header .logo img {
    height: 35px;
    margin-right: 10px;
}
.form-header h2 {
    margin: 0;
    font-size: 24px;
    font-weight: 600;
}
.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px 30px;
}
.form-group {
    margin-bottom: 10px;
}
.form-group label {
    display: block;
    font-weight: 500;
    margin-bottom: 8px;
    font-size: 14px;
}
.input-wrapper {
    position: relative;
}
.input-wrapper i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #aaa;
}
.form-input, select {
    width: 100%;
    padding: 12px 15px 12px 40px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    box-sizing: border-box;
    transition: border-color 0.2s;
}
.form-input:focus, select:focus {
    outline: none;
    border-color: #249b69;
}
textarea {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    resize: vertical;
}
.form-button {
    width: 100%;
    padding: 14px;
    background-color: #249b69;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s;
    margin-top: 20px;
}
.form-button:hover {
    background-color: #1e8258;
}

/* Specific styling for Edit */
.product-id-display {
    padding: 12px 15px;
    background-color: #e9ecef;
    border: 1px solid #ced4da;
    border-radius: 5px;
    font-weight: 600;
    color: #495057;
    margin-left: 40px; /* Aligns with input text */
}

/* Lock input styling for disabled field */
input[disabled] {
    background-color: #e9ecef;
    cursor: not-allowed;
}
.back-link {
	            display: inline-block;
	            margin-bottom: 15px;
	            color: #249b69;
	            text-decoration: none;
	            font-weight: 500;
	        }
/* --- END OF STYLES --- */
</style>
</head>

<body>
    <div class="form-container">
        <a href="manageProducts.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Manage Products</a>
        <div class="form-header">
            <a href="index.jsp" class="logo">
                <img src="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg" alt="Zinkit Logo">
                <span><strong>Zinkit</strong><br>GROCERY</span>
            </a>
            <h2>Edit Product: <%= product.getProductName() %></h2>
            <p>Update the details for the product below.</p>
        </div>

        <form action="./UpdateProductServlet" method="POST">
            <div class="form-grid">
            
                <div class="form-group">
                    <label for="productId">Product ID</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-barcode"></i>
                        <input type="text" id="productId" name="productId" class="form-input" 
                            value="<%= product.getProductId() %>" disabled>
                    </div>
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                </div>

                <div class="form-group">
                    <label for="productName">Product Name</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-box"></i>
                        <input type="text" id="productName" name="productName" class="form-input" 
                            value="<%= product.getProductName() %>" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-list"></i>
                        <select id="category" name="category" class="form-input" required>
                            <option value="">-- Select Category --</option>
                            <% 
                                String currentCategory = product.getCategory() != null ? product.getCategory().toString() : "";
                            %>
                            <option value="VEGETABLES" <%= "VEGETABLES".equals(currentCategory) ? "selected" : "" %>>VEGETABLES</option>
                            <option value="FRUITS" <%= "FRUITS".equals(currentCategory) ? "selected" : "" %>>FRUITS</option>
                            <option value="DAIRY" <%= "DAIRY".equals(currentCategory) ? "selected" : "" %>>DAIRY</option>
                            <option value="BAKERY" <%= "BAKERY".equals(currentCategory) ? "selected" : "" %>>BAKERY</option>
                            <option value="BEVERAGES" <%= "BEVERAGES".equals(currentCategory) ? "selected" : "" %>>BEVERAGES</option>
                            <option value="SNACKS" <%= "SNACKS".equals(currentCategory) ? "selected" : "" %>>SNACKS</option>
                            <option value="MEAT_SEAFOOD" <%= "MEAT_SEAFOOD".equals(currentCategory) ? "selected" : "" %>>MEAT & SEAFOOD</option>
                            <option value="FROZEN_FOODS" <%= "FROZEN_FOODS".equals(currentCategory) ? "selected" : "" %>>FROZEN FOODS</option>
                            <option value="HOUSEHOLD_ITEMS" <%= "HOUSEHOLD_ITEMS".equals(currentCategory) ? "selected" : "" %>>HOUSEHOLD ITEMS</option>
                            <option value="PERSONAL_CARE" <%= "PERSONAL_CARE".equals(currentCategory) ? "selected" : "" %>>PERSONAL CARE</option>
                            <option value="GRAINS_PULSES" <%= "GRAINS_PULSES".equals(currentCategory) ? "selected" : "" %>>GRAINS & PULSES</option>
                            <option value="SPICES_CONDIMENTS" <%= "SPICES_CONDIMENTS".equals(currentCategory) ? "selected" : "" %>>SPICES & CONDIMENTS</option>
                            <option value="OILS_FATS" <%= "OILS_FATS".equals(currentCategory) ? "selected" : "" %>>OILS & FATS</option>
                            <option value="BABY_CARE" <%= "BABY_CARE".equals(currentCategory) ? "selected" : "" %>>BABY CARE</option>
                            <option value="CLEANING_SUPPLIES" <%= "CLEANING_SUPPLIES".equals(currentCategory) ? "selected" : "" %>>CLEANING SUPPLIES</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="price">Price (₹)</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-tag"></i>
                        <input type="number" id="price" name="price" class="form-input" 
                            value="<%= String.format("%.2f", product.getPrice()) %>" step="0.01" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="discount">Discount (%)</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-percent"></i>
                        <input type="number" id="discount" name="discount" class="form-input" 
                            value="<%= String.format("%.2f", product.getDiscount()) %>" step="0.01">
                    </div>
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity in Stock</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-cubes"></i>
                        <input type="number" id="quantity" name="quantity" class="form-input" 
                            value="<%= product.getQuantityInStock() %>" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="unit">Unit</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-weight-scale"></i>
                        <input type="text" id="unit" name="unit" class="form-input" 
                            value="<%= product.getUnit() %>" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="imageUrl">Image URL</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-image"></i>
                        <input type="url" id="imageUrl" name="imageUrl" class="form-input" 
                            value="<%= product.getImageUrl() %>" required>
                    </div>
                </div>

                <div class="form-group" style="grid-column: 1 / span 2;">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="3" required><%= product.getDescription() %></textarea>
                </div>
            </div>

            <button type="submit" class="form-button">Update Product</button>
        </form>
    </div>
</body>
</html>