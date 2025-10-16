<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Product - Zinkit Grocery</title>
<link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
.hero {
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
    margin-top:25px;
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
<div class="hero">
    <div class="form-container">
        <a href="manageProducts.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Manage Products</a>
        <div class="form-header">
            <a href="index.jsp" class="logo">
                <img src="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg" alt="Zinkit Logo">
                <span><strong>Zinkit</strong><br>GROCERY</span>
            </a>
            <h2>Add New Product</h2>
            <p>Enter product details to add it to your store.</p>
        </div>

        <form action="./AddProductServlet" method="POST">
            <div class="form-grid">
                <div class="form-group">
                    <label for="productId">Product ID</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-barcode"></i>
                        <input type="text" id="productId" name="productId" class="form-input" placeholder="e.g., P001" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="productName">Product Name</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-box"></i>
                        <input type="text" id="productName" name="productName" class="form-input" placeholder="e.g., Broccoli" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-list"></i>
                        <select id="category" name="category" class="form-input" required>
                            <option value="">-- Select Category --</option>
                            <option value="VEGETABLES">VEGETABLES</option>
                            <option value="FRUITS">FRUITS</option>
                            <option value="DAIRY">DAIRY</option>
                            <option value="BAKERY">BAKERY</option>
                            <option value="BEVERAGES">BEVERAGES</option>
                            <option value="SNACKS">SNACKS</option>
                            <option value="MEAT_SEAFOOD">MEAT & SEAFOOD</option>
                            <option value="FROZEN_FOODS">FROZEN FOODS</option>
                            <option value="HOUSEHOLD_ITEMS">HOUSEHOLD ITEMS</option>
                            <option value="PERSONAL_CARE">PERSONAL CARE</option>
                            <option value="GRAINS_PULSES">GRAINS & PULSES</option>
                            <option value="SPICES_CONDIMENTS">SPICES & CONDIMENTS</option>
                            <option value="OILS_FATS">OILS & FATS</option>
                            <option value="BABY_CARE">BABY CARE</option>
                            <option value="CLEANING_SUPPLIES">CLEANING SUPPLIES</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="price">Price (₹)</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-tag"></i>
                        <input type="number" id="price" name="price" class="form-input" placeholder="e.g., 60.00" step="0.01" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="discount">Discount (%)</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-percent"></i>
                        <input type="number" id="discount" name="discount" class="form-input" placeholder="e.g., 10" step="0.01">
                    </div>
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity in Stock</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-cubes"></i>
                        <input type="number" id="quantity" name="quantity" class="form-input" placeholder="e.g., 100" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="unit">Unit</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-weight-scale"></i>
                        <input type="text" id="unit" name="unit" class="form-input" placeholder="e.g., 1kg" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="imageUrl">Image URL</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-image"></i>
                        <input type="url" id="imageUrl" name="imageUrl" class="form-input" placeholder="Paste product image link" required>
                    </div>
                </div>

                <div class="form-group" style="grid-column: 1 / span 2;">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="3" placeholder="Enter a short product description" required></textarea>
                </div>
            </div>

            <button type="submit" class="form-button">Add Product</button>
        </form>
    </div>
</div>
</body>
</html>
