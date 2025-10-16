<%@page import="com.src.dao.ProductDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.src.model.User" %>
<%@ page import="com.src.model.*"%>
<%@ page import="com.src.dao.*"%>
<%@ page import="java.util.*, com.src.dao.*, com.src.model.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zinkit - Online Grocery Store</title>
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style type="text/css">
body {
    font-family: 'Poppins', sans-serif;
    margin: 0;
    color: #333;
    background-color: #fff;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 15px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

/* Header Section */
.main-header {
    padding: 20px 0;
    border-bottom: 1px solid #eee;
}

.main-header .logo {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: inherit;
}

.main-header .logo img {
    height: 40px;
    margin-right: 10px;
}

.main-header .logo span {
    font-size: 14px;
    line-height: 1.2;
}

.search-bar {
    display: flex;
    border: 1px solid #ddd;
    margin-left:100px;
    border-radius: 5px;
    overflow: hidden;
    width: 650px;
}

.search-bar select, .search-bar input, .search-bar button {
    border: none;
    padding: 10px;
    font-size: 14px;
}

.search-bar select {
    background: #f7f7f7;
    padding-right: 25px;
}

.search-bar input {
    flex-grow: 1;
    padding-left: 15px;
}

.search-bar input:focus {
    outline: none;
}

.search-bar button {
    background-color: #249b69;
    color: white;
    cursor: pointer;
    padding: 10px 15px;
}

.user-actions {
    display: flex;
    align-items: center;
    gap: 25px;
}

.user-actions .action-item, .user-actions .user-profile {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #555;
    font-size: 14px;
}

.user-actions .action-item i {
    font-size: 22px;
    margin-right: 8px;
    color: #249b69;
}

.user-actions .user-profile img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}

/* Main Navigation */
.main-nav {
    padding: 15px 0;
    border-bottom: 1px solid #eee;
}

.browse-btn {
    background-color: #249b69;
    color: white;
    border: none;
    padding: 12px 20px;
    border-radius: 5px;
    font-weight: 600;
    cursor: pointer;
    font-size: 14px;
}

.browse-btn i {
    margin-right: 8px;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 30px;
    margin: 0;
    padding: 0;
}

.nav-links a {
    text-decoration: none;
    color: #333;
    font-weight: 500;
}

.nav-links a.active, .nav-links a:hover {
    color: #249b69;
}

.nav-links a i {
    margin-right: 5px;
}

.support-center {
    display: flex;
    align-items: center;
    gap: 10px;
}

.support-center i {
    font-size: 30px;
    color: #249b69;
}

.support-center div {
    line-height: 1.3;
}

.support-center strong {
    font-size: 18px;
}

.support-center span {
    font-size: 12px;
    color: #777;
}

/* Hero Section */
.hero {
    background-color: #e5f3ea;
    padding: 60px 0;
    background-image: url('https://xw9yfaknjqdygika.public.blob.vercel-storage.com/H5ck7yb-IKvsE52Y5McpxQR3h6Oh16dTfWpoL3.jpeg'); /* Faint background pattern */
    background-size: cover;
    background-position: center;
    position: relative;
}

.hero-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.hero-text {
    max-width: 500px;
}

.hero-text h1 {
    font-size: 48px;
    font-weight: 700;
    line-height: 1.2;
    margin: 0 0 15px 0;
}

.hero-text p {
    font-size: 18px;
    color: #555;
    margin-bottom: 30px;
}

.subscribe-form {
    display: flex;
    position: relative;
    max-width: 400px;
}

.subscribe-form i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #aaa;
}

.subscribe-form input {
    flex-grow: 1;
    border: 1px solid #ddd;
    border-radius: 5px 0 0 5px;
    padding: 15px 15px 15px 40px; /* Left padding for icon */
    font-size: 14px;
}

.subscribe-form input:focus {
    outline-color: #249b69;
}

.subscribe-form button {
    background-color: #249b69;
    color: white;
    border: none;
    padding: 15px 25px;
    border-radius: 0 5px 5px 0;
    font-weight: 600;
    cursor: pointer;
    font-size: 14px;
}

.login-btn button{
 	background-color: #249b69;
    color: white;
    border: none;
    padding: 15px 25px;
    border-radius: 5px;
    font-weight: 600;
    cursor: pointer;
    font-size: 14px;
}

.hero-image {
    position: relative;
    width: 50%;
}

.hero-image img {
    max-width: 100%;
    display: block;
}

.carousel-dots {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 8px;
}

.carousel-dots .dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: #ccc;
    cursor: pointer;
}

.carousel-dots .dot.active {
    background-color: #249b69;
}
/* General Setup */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f7f7f7;
    color: #333;
    margin: 0;
}

.page-container {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
}

/* Section Header Styles */
.store-section {
    margin-bottom: 50px;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.section-header h2 {
    font-size: 24px;
    font-weight: 600;
    margin: 0;
}

.section-header .filters a {
    text-decoration: none;
    color: #666;
    margin-left: 20px;
    font-size: 14px;
    font-weight: 500;
}

.section-header .filters a.active {
    color: #249B69;
    font-weight: 600;
}

/* Carousel and Navigation */
.carousel {
    position: relative;
}

.nav-arrow {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: white;
    border: 1px solid #eee;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    cursor: pointer;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    z-index: 10;
}

.prev-arrow { left: -20px; }
.next-arrow { right: -20px; }

/* Category Section Styles */
.category-list {
    display: flex;
    gap: 20px;
    overflow-x: auto;
    padding-bottom: 15px;
    /* Hide scrollbar */
    -ms-overflow-style: none;  
    scrollbar-width: none;  
}
.category-list::-webkit-scrollbar {
    display: none;
}

.category-card {
    flex: 0 0 140px; /* Prevents shrinking, sets base width */
    padding: 15px;
    border-radius: 10px;
    text-align: center;
    mix-blend-mode: darken;
}

.category-card img {
    max-width: 80px;
    margin-bottom: 10px;
}

.category-card h3 {
    margin: 0 0 5px 0;
    font-size: 16px;
}

.category-card p {
    margin: 0;
    font-size: 12px;
    color: #777;
}

/* Featured Products Section Styles */
.product-list {
    display: flex;
    gap: 20px;
    overflow-x: auto;
    padding-bottom: 15px;
    /* Hide scrollbar */
    -ms-overflow-style: none;  
    scrollbar-width: none;  
}
.product-list::-webkit-scrollbar {
    display: none;
}

.product-card {
    flex: 0 0 200px; /* Adjust width as needed */
    background-color: white;
    border: 1px solid #eee;
    border-radius: 10px;
    padding: 15px;
}

.product-card img {
    width: 100%;
    max-height: 140px;
    object-fit: contain;
    margin-bottom: 10px;
}

.product-card .product-category {
    font-size: 12px;
    color: #999;
    margin: 0;
}

.product-card h3 {
    font-size: 16px;
    font-weight: 600;
    margin: 5px 0;
}

.product-card .rating {
    font-size: 12px;
    color: #FFB800;
}

.product-card .rating span {
    color: #999;
    margin-left: 5px;
}

.product-card .product-seller {
    font-size: 13px;
    color: #666;
    margin: 10px 0;
}

.product-card .product-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 15px;
}

.product-card .price b {
    color: #249B69;
    font-size: 18px;
    margin-right: 5px;
}

.product-card .price s {
    color: #aaa;
    font-size: 14px;
}

.product-card .add-btn {
    background-color: #249B69;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 8px 15px;
    font-weight: 600;
    cursor: pointer;
}

.product-card .add-btn i {
    margin-right: 5px;
}

/* Banners Section Styles */
.banners-section {
    display: flex;
    gap: 20px;
}

.banner-card {
    flex: 1;
    border-radius: 10px;
    padding: 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
    overflow: hidden;
}

.delivery-banner { background-color: #FEEFEA; }
.organic-banner { background-color: #E9FEF3; }

.banner-text {
    z-index: 1;
}

.banner-tag {
    font-weight: 600;
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 12px;
}

.delivery-tag { background-color: #F8D4C3; color: #E97232; }
.organic-tag { background-color: #B8EBD2; color: #249B69; }

.banner-card h3 {
    font-size: 22px;
    margin: 15px 0 10px 0;
}

.banner-card p {
    font-size: 14px;
    color: #555;
    max-width: 200px;
    margin-bottom: 20px;
}

.banner-card .banner-btn {
    text-decoration: none;
    background-color: #fff;
    color: #333;
    padding: 10px 20px;
    border-radius: 20px;
    font-weight: 600;
    font-size: 14px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.banner-card .banner-img {
    max-height: 150px;
    z-index: 1;
}
/* General Setup */
body {
    font-family: 'Poppins', sans-serif;
    margin: 0;
    color: #333;
    background-color: #F7F7F7;
}

.zcontainer {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* Hero Section */
.zhero {
    background-color: #E6F8F0;
    background-image: url('https://planongroup-my.sharepoint.com/:i:/r/personal/vedasree_a_planonsoftware_com/Documents/Pictures/Screenshots/Screenshot%202025-10-04%20192700.png?csf=1&web=1&e=c7jYgY'); /* Faint pattern background */
    padding: 60px 0;
    overflow: hidden;
}

.zhero-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.zhero-text {
    max-width: 40%;
}

.zhero-text h1 {
    font-size: 52px;
    font-weight: 700;
    line-height: 1.2;
    margin: 0 0 20px;
}

.zhero-text p {
    font-size: 16px;
    color: #555;
    line-height: 1.6;
}

.zhero-images {
    position: relative;
    display: flex;
    align-items: center;
    width: 50%;
    justify-content: center;
}

.zphone-mockup {
    height: 500px;
    filter: drop-shadow(0 10px 25px rgba(0,0,0,0.1));
}

.zphone-mockup.zback {
    transform: rotate(-10deg);
}
.zphone-mockup.zfront {
    position: relative;
    transform: rotate(10deg);
    margin-left: -100px; /* Overlap effect */
    z-index: 2;
}

/* Footer Section */
.zsite-footer {
    background-color: #fff;
    padding-top: 40px;
}

.zfooter-features {
    display: flex;
    justify-content: space-around;
    padding-bottom: 40px;
    border-bottom: 1px solid #eee;
}

.zfeature-item {
    display: flex;
    align-items: center;
    gap: 15px;
    max-width: 300px;
}

.zfeature-item i {
    font-size: 24px;
    color: #249B69;
    background-color: #E6F8F0;
    padding: 15px;
    border-radius: 50%;
}

.zfeature-item h3 {
    margin: 0 0 5px;
    font-size: 16px;
    font-weight: 600;
}

.zfeature-item p {
    margin: 0;
    font-size: 14px;
    color: #777;
}

/* Main Footer */
.zfooter-main {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    gap: 40px;
    padding: 40px 0;
}

.zfooter-logo {
    height: 40px;
    margin-bottom: 20px;
}

.zcontact-info {
    list-style: none;
    padding: 0;
    margin: 0;
    font-size: 14px;
}

.zcontact-info li {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
    color: #555;
}

.zcontact-info i {
    color: #249B69;
    width: 20px;
    text-align: center;
}

.zfooter-column.zlinks h4 {
    font-size: 18px;
    font-weight: 600;
    margin: 0 0 20px;
}

.zfooter-column.zlinks ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.zfooter-column.zlinks li {
    margin-bottom: 12px;
}

.zfooter-column.zlinks a {
    text-decoration: none;
    color: #555;
    font-size: 14px;
    transition: color 0.2s;
}

.zfooter-column.zlinks a:hover {
    color: #249B69;
}

/* Footer Bottom */
.zfooter-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 0;
    border-top: 1px solid #eee;
    font-size: 14px;
    color: #777;
}

.zpayment-icons {
    display: flex;
    gap: 10px;
}
.zpayment-icons img {
    height: 24px;
}

.zsocial-icons {
    display: flex;
    gap: 10px;
}
.zsocial-icons a {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 36px;
    height: 36px;
    background-color: #249B69;
    color: white;
    border-radius: 50%;
    text-decoration: none;
    transition: background-color 0.2s;
}

.zsocial-icons a:hover {
    background-color: #1e8258;
}

.user-menu {
    position: relative;
    display: inline-block;
}

.user-profile {
    display: flex;
    align-items: center;
    cursor: pointer;
    gap: 8px;
}

.user-profile img {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    border: 2px solid #249b69;
}

.dropdown-menu {
    display: none;
    position: absolute;
    right: 0;
    background-color: #fff;
    min-width: 200px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    border-radius: 8px;
    z-index: 100;
    flex-direction: column;
    padding: 10px 0;
}

.dropdown-menu a {
    display: block;
    padding: 10px 15px;
    text-decoration: none;
    color: #333;
    font-size: 14px;
}

.dropdown-menu a:hover {
    background-color: #f5f5f5;
    color: #249b69;
    transition: 0.2s;
}

.user-menu.active .dropdown-menu {
    display: flex;
}
.show {
    display: flex !important;
}
.nostyle{
	text-decoration:none;
	color:#249b69;
}
    </style>
</head>
<body>
	
	<!-- 
    <nav class="main-nav">
        <div class="container">
            <button class="browse-btn"><i class="fa-solid fa-table-cells-large"></i> Brows All Categories</button>
            <ul class="nav-links">
                <li><a href="#" class="active"><i class="fa-solid fa-house"></i> Home</a></li>
                <li><a href="#"><i class="fa-solid fa-fire"></i> Hot deals</a></li>
                <li><a href="#"><i class="fa-solid fa-percent"></i> Promotions</a></li>
                <li><a href="#"><i class="fa-solid fa-box"></i> New products</a></li>
            </ul>
            <div class="support-center">
                <i class="fa-solid fa-phone-volume"></i>
                <div>
                    <strong>1233-7777</strong>
                    <span>24/7 support center</span>
                </div>
            </div>
        </div>
    </nav>
	 -->
          <% String successMessage = (String) request.getAttribute("successMessage");
           if (successMessage != null) { %>
           <p style="color: green; text-align: center; font-weight: 500;">
               <%= successMessage %>
           </p>
        <% } %>
        
        <% String errorMessage = (String) request.getAttribute("errorMessage");
           if (errorMessage != null) { %>
           <p style="color: red; text-align: center; font-weight: 500;">
               <%= errorMessage %>
           </p>
        <% } %>

    <main>
        <section class="hero">
            <div class="container hero-content">
                <div class="hero-text">
                    <h1>Don't miss our daily amazing deals.</h1>
                    <p>Save up to 60% off on your first order</p>
                    <!-- -
						<form class="subscribe-form" method="post" action="SubscribeServlet">
                        <i class="fa-regular fa-paper-plane"></i>
                        <input type="email" name = "email" placeholder="Enter your email address">
                        <button type="submit">Subscribe</button>
                    	</form>
                     -->
                </div>
                <%
				    String msg = request.getParameter("msg");
				    if (msg != null) {
				%>
				    <p style="color: black; font-weight: bold;"><%= msg %></p>
				<%
				    }
				%>
                
            </div>
            <div class="carousel-dots">
                <span class="dot active"></span>
                <span class="dot"></span>
            </div>
        </section>
    </main>
     <div class="page-container">
        <section class="store-section">
            <header class="section-header">
                <h2>Explore Categories</h2>
                <div class="filters">
                    <a href="#" class="active">All</a>
                    <a href="#">Vegetables</a>
                    <a href="#">Fruits</a>
                    <a href="#">Coffee & teas</a>
                    <a href="#">Meat</a>
                </div>
            </header>
            <!-- 
            <div class="carousel">
                <button class="nav-arrow prev-arrow"><i class="fa-solid fa-arrow-left"></i></button>
                <div class="category-list">
                    <div class="category-card" style="background-color: #FEF0E9;">
                        <img src="https://i.imgur.com/8QpWDFV.png" alt="Peach">
                        <h3>Peach</h3>
                        <p>20 Items</p>
                    </div>
                    <div class="category-card" style="background-color: #F1F1EE;">
                        <img src="https://i.imgur.com/XnE0i3g.png" alt="Vegetables">
                        <h3>Vegetables</h3>
                        <p>220 Items</p>
                    </div>
                    <div class="category-card" style="background-color: #FEE9E9;">
                        <img src="https://i.imgur.com/tH4eF9M.png" alt="Strawberry">
                        <h3>Strawberry</h3>
                        <p>10 Items</p>
                    </div>
                    <div class="category-card" style="background-color: #FEE9E9;">
                        <img src="https://i.imgur.com/eQJ7bL0.png" alt="Apple">
                        <h3>Apple</h3>
                        <p>40 Items</p>
                    </div>
                    <div class="category-card" style="background-color: #FEF0E9;">
                        <img src="https://i.imgur.com/979xTcf.png" alt="Orange">
                        <h3>Orange</h3>
                        <p>20 Items</p>
                    </div>
                    <div class="category-card" style="background-color: #F1F1EE;">
                        <img src="https://i.imgur.com/Qk9sZq5.png" alt="Potato">
                        <h3>Potato</h3>
                        <p>5 Items</p>
                    </div>
                     <div class="category-card" style="background-color: #E9FEF3;">
                        <img src="https://i.imgur.com/4z82eY9.png" alt="Carrot">
                        <h3>Carrot</h3>
                        <p>9 Items</p>
                    </div>
                </div>
                <button class="nav-arrow next-arrow"><i class="fa-solid fa-arrow-right"></i></button>
            </div>
             -->
	<%
	    // Initialize enum values
	    Category[] categories = Category.values();
	    Map<Category, String> images = CategoryData.IMAGES;
	    Map<Category, String> colors = CategoryData.COLORS;
	%>
	<div class="carousel">
    <button class="nav-arrow prev-arrow"><i class="fa-solid fa-arrow-left"></i></button>
    <div class="category-list">
        <% for (Category category : categories) {
               String image = images.get(category);
               String color = colors.get(category);
        %>
            <a href="index.jsp?category=<%= category.name() %>" class="category-card nostyle" style="background-color: <%= color %>;">
                <img src="<%= image %>" alt="<%= category.name().replace("_"," ") %>">
                <h3><%= category.name().replace("_"," ") %></h3>
                <p>Show more</p>
            </a>
        <% } %>
    </div>
    <button class="nav-arrow next-arrow"><i class="fa-solid fa-arrow-right"></i></button>
</div>
<%
    String categoryParam = request.getParameter("category");
    List<Product> productsList = new ArrayList<>();
    if(categoryParam != null && !categoryParam.isEmpty()) {
        try {
            ProductDAO dao = new ProductDAOImpl();
            Category category = Category.valueOf(categoryParam.toUpperCase());
            productsList = dao.findByCategory(category);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>

<section class="store-section" id="category-products-section" style="<%= productsList.isEmpty() ? "display:none;" : "" %>">
    <header class="section-header">
        <h2 id="category-products-title"><%= categoryParam != null ? categoryParam.replace("_"," ") : "" %></h2>
    </header>

    <div class="carousel">
        <button class="nav-arrow prev-arrow"><i class="fa-solid fa-arrow-left"></i></button>
        <div class="product-list" id="category-product-list">
            <% for(Product p : productsList) { %>
                <div class="product-card">
                    <img src="<%= p.getImageUrl() != null ? p.getImageUrl() : "https://via.placeholder.com/150" %>" alt="<%= p.getProductName() %>">
                    <p class="product-category"><%= p.getCategory() != null ? p.getCategory().name().replace("_"," ") : "" %></p>
                    <h3><%= p.getProductName() %></h3>
                    <p class="product-seller">By Zinkit</p>
                    <div class="product-footer">
                        <p class="price"><b>₹<%= p.getPrice() %></b></p>
						<form action="AddToCartServlet" method="post">
						    <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>">
						    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
						    <input type="hidden" name="priceAtTime" value="<%= p.getPrice() %>">
						    <button type="submit" class="add-btn">
						        <i class="fa-solid fa-plus"></i> Add
						    </button>
						</form>
                    </div>
                </div>
            <% } %>
        </div>
        <button class="nav-arrow next-arrow"><i class="fa-solid fa-arrow-right"></i></button>
    </div>
</section>

        </section>
   <%
    // Always display only BAKERY category
     categoryParam = "BAKERY";
   productsList = new ArrayList<>();

    try {
        ProductDAO dao = new ProductDAOImpl();
        Category category = Category.valueOf(categoryParam.toUpperCase());
        productsList = dao.findByCategory(category);
    } catch(Exception e) {
        e.printStackTrace();
    }
	%>

<%
    // Define allowed categories
    Category[] allowedCategories = {
        Category.BAKERY,
        Category.FRUITS,
        Category.BEVERAGES,
        Category.OILS_FATS,
        Category.CLEANING_SUPPLIES,
        Category.DAIRY
    };

    ProductDAO dao = new ProductDAOImpl();
%>

<% for (Category category : allowedCategories) { 
        productsList = new ArrayList<>();
       try {
           productsList = dao.findByCategory(category);
       } catch(Exception e) {
           e.printStackTrace();
       }

       if (productsList != null && !productsList.isEmpty()) {
%>

<!-- ===== Display Section for Each Allowed Category ===== -->
<section class="store-section" id="<%= category.name().toLowerCase() %>-section">
    <header class="section-header">
        <h2><%= category.name().replace("_", " ") %></h2>
    </header>

    <div class="carousel">
        <button class="nav-arrow prev-arrow"><i class="fa-solid fa-arrow-left"></i></button>
        <div class="product-list" id="<%= category.name().toLowerCase() %>-product-list">
            <% for(Product p : productsList) { %>
                <div class="product-card">
                    <img src="<%= p.getImageUrl() != null ? p.getImageUrl() : "https://via.placeholder.com/150" %>" alt="<%= p.getProductName() %>">
                    <p class="product-category"><%= p.getCategory().name().replace("_"," ") %></p>
                    <h3><%= p.getProductName() %></h3>
                    <p class="product-seller">By Zinkit</p>
                    <div class="product-footer">
                        <p class="price"><b>₹<%= p.getPrice() %></b></p>
                        <form action="AddToCartServlet" method="post">
                            <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>">
                            <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                            <input type="hidden" name="priceAtTime" value="<%= p.getPrice() %>">
                            <button type="submit" class="add-btn">
                                <i class="fa-solid fa-plus"></i> Add
                            </button>
                        </form>
                    </div>
                </div>
            <% } %>
        </div>
        <button class="nav-arrow next-arrow"><i class="fa-solid fa-arrow-right"></i></button>
    </div>
</section>

<% 
       } // end if not empty
   } // end for loop 
%>

	
		<!-- 
        <section class="store-section">
            <header class="section-header">
                <h2>Featured Products</h2>
                 <div class="filters">
                    <a href="#">All</a>
                    <a href="#" class="active">Vegetables</a>
                    <a href="#">Fruits</a>
                    <a href="#">Coffee & teas</a>
                    <a href="#">Meat</a>
                </div>
            </header>
            <div class="carousel">
                 <button class="nav-arrow prev-arrow"><i class="fa-solid fa-arrow-left"></i></button>
                 <div class="product-list">
                    <div class="product-card">
                        <img src="https://i.imgur.com/Y1g95L5.png" alt="Radish">
                        <p class="product-category">Vegetables</p>
                        <h3>Radish 500g</h3>
                        <div class="rating">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star"></i>
                            <span>(4)</span>
                        </div>
                        <p class="product-seller">By Mr.food</p>
                        <div class="product-footer">
                            <p class="price"><b>$2</b> <s>$3.99</s></p>
                            <button class="add-btn"><i class="fa-solid fa-plus"></i> Add</button>
                        </div>
                    </div>
                    <div class="product-card">
                        <img src="https://i.imgur.com/Qk9sZq5.png" alt="Potatos">
                        <p class="product-category">Vegetables</p>
                        <h3>Potatos 1kg</h3>
                        <div class="rating">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star"></i>
                            <span>(4)</span>
                        </div>
                        <p class="product-seller">By Mr.food</p>
                        <div class="product-footer">
                            <p class="price"><b>$1</b> <s>$1.99</s></p>
                            <button class="add-btn"><i class="fa-solid fa-plus"></i> Add</button>
                        </div>
                    </div>
                    <div class="product-card">
                        <img src="https://i.imgur.com/zV8QdY2.png" alt="Tomatos">
                        <p class="product-category">Fruits</p>
                        <h3>Tomatos 200g</h3>
                        <div class="rating">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star"></i>
                            <span>(4)</span>
                        </div>
                        <p class="product-seller">By Mr.food</p>
                        <div class="product-footer">
                            <p class="price"><b>$0.30</b> <s>$0.99</s></p>
                            <button class="add-btn"><i class="fa-solid fa-plus"></i> Add</button>
                        </div>
                    </div>
                    <div class="product-card">
                        <img src="https://i.imgur.com/t335j62.png" alt="Broccoli">
                        <p class="product-category">Vegetables</p>
                        <h3>Broccoli 1kg</h3>
                        <div class="rating">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star"></i>
                            <span>(4)</span>
                        </div>
                        <p class="product-seller">By Mr.food</p>
                        <div class="product-footer">
                            <p class="price"><b>$1.50</b> <s>$2.99</s></p>
                            <button class="add-btn"><i class="fa-solid fa-plus"></i> Add</button>
                        </div>
                    </div>
                    <div class="product-card">
                        <img src="https://i.imgur.com/r63aY5k.png" alt="Green Beans">
                        <p class="product-category">Vegetables</p>
                        <h3>Green Beans 250g</h3>
                        <div class="rating">
                           <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star"></i>
                           <span>(4)</span>
                        </div>
                        <p class="product-seller">By Mr.food</p>
                        <div class="product-footer">
                            <p class="price"><b>$1</b> <s>$1.99</s></p>
                            <button class="add-btn"><i class="fa-solid fa-plus"></i> Add</button>
                        </div>
                    </div>
                 </div>
                 <button class="nav-arrow next-arrow"><i class="fa-solid fa-arrow-right"></i></button>
            </div>
			<div id="product-container" class="carousel product-list">
			</div>

        </section>
		 -->		
		 
        <section class="banners-section">
            <div class="banner-card delivery-banner">
                <div class="banner-text">
                    <span class="banner-tag delivery-tag">Free delivery</span>
                    <h3>Free delivery over &#8377;100</h3>
                    <p>Shop Rs. 100 product and get free delivery anywhere.</p>
                    <a href="#" class="banner-btn">Shop Now <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <img src="https://i.pinimg.com/1200x/f2/e3/ce/f2e3cead16317a73e6e52c4802ec873d.jpg" alt="Delivery person" class="banner-img">
            </div>
            <div class="banner-card organic-banner">
                 <div class="banner-text">
                    <span class="banner-tag organic-tag">60% off</span>
                    <h3>Organic Food</h3>
                    <p>Save up to 60% off on your first order.</p>
                    <a href="#" class="banner-btn">Order Now <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <img src="https://i.pinimg.com/736x/03/e5/80/03e580b34b87e6056c60b2aa986b9a55.jpg" alt="Organic fruits" class="banner-img">
            </div>
        </section>
    </div>

    <main class="zhero">
        <div class="zcontainer zhero-content">
            <div class="zhero-text">
                <h1>Zinkit sala <br> Crossbreed!</h1>
                <p>Liger crashed like my WiFi. Zinkit? Built different.</p>
            </div>
            <!-- 
            <div class="zhero-images">
                <img src="https://i.imgur.com/G5g25eM.png" alt="App screenshot on phone" class="zphone-mockup zback">
                <img src="https://i.imgur.com/T0a3nTm.png" alt="App cart screenshot on phone" class="zphone-mockup zfront">
            </div>
             -->
        </div>
    </main>

    <footer class="zsite-footer">
        <div class="zcontainer">
            <div class="zfooter-features">
                <div class="zfeature-item">
                    <i class="fa-solid fa-tags"></i>
                    <div>
                        <h3>Best Prices & Deals</h3>
                        <p>Don't miss our daily amazing deals and prices</p>
                    </div>
                </div>
                <div class="zfeature-item">
                    <i class="fa-solid fa-rotate-left"></i>
                    <div>
                        <h3>Refundable</h3>
                        <p>If your items have damage we agree to refund it</p>
                    </div>
                </div>
                <div class="zfeature-item">
                    <i class="fa-solid fa-truck"></i>
                    <div>
                        <h3>Free delivery</h3>
                        <p>Do purchase over $50 and get free delivery anywhere</p>
                    </div>
                </div>
            </div>

            <div class="zfooter-main">
                <div class="zfooter-column zabout">
                   <div style="display:flex;">
						<img src="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg" alt="Zinkit Logo" class="zfooter-logo">
	                    <span>
		                    <strong>Zinkit</strong>
		                    <br>GROCERY
		                </span>
                   </div>
                    <ul class="zcontact-info">
                        <li><i class="fa-solid fa-location-dot"></i> Address: 1762 School House Road</li>
                        <li><i class="fa-solid fa-phone"></i> Call Us: 1235-777</li>
                        <li><i class="fa-solid fa-envelope"></i> Email: zinkit@gmail.com</li>
                        <li><i class="fa-regular fa-clock"></i> Work hours: 8:00 - 20:00, Sunday - Thursday</li>
                    </ul>
                </div>
                <div class="zfooter-column zlinks">
                    <h4>Account</h4>
                    <ul>
                        <li><a href="#">Wishlist</a></li>
                        <li><a href="#">Cart</a></li>
                        <li><a href="#">Track Order</a></li>
                        <li><a href="#">Shipping Details</a></li>
                    </ul>
                </div>
                <div class="zfooter-column zlinks">
                    <h4>Useful links</h4>
                    <ul>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Contact</a></li>
                        <li><a href="#">Hot deals</a></li>
                        <li><a href="#">Promotions</a></li>
                        <li><a href="#">New products</a></li>
                    </ul>
                </div>
                <div class="zfooter-column zlinks">
                    <h4>Help Center</h4>
                    <ul>
                        <li><a href="#">Payments</a></li>
                        <li><a href="#">Refund</a></li>
                        <li><a href="#">Checkout</a></li>
                        <li><a href="#">Shipping</a></li>
                        <li><a href="#">Q&A</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>

            <div class="zfooter-bottom">
                <p>&copy; 2025, All rights reserved</p>
               
                <div class="zsocial-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
        </div>
    </footer>
<script>
document.addEventListener("DOMContentLoaded", () => {
    const profileBtn = document.getElementById("profile-btn");
    const dropdownMenu = document.getElementById("dropdown-menu");

    if (profileBtn && dropdownMenu) {
        profileBtn.addEventListener("click", () => {
            dropdownMenu.classList.toggle("show");
        });

        // Close dropdown if clicked outside
        window.addEventListener("click", (e) => {
            if (!profileBtn.contains(e.target) && !dropdownMenu.contains(e.target)) {
                dropdownMenu.classList.remove("show");
            }
        });
    }
});
document.addEventListener("DOMContentLoaded", function() {
    const categoryCards = document.querySelectorAll(".category-card");
    const productContainer = document.getElementById("product-container");

    categoryCards.forEach(card => {
        card.addEventListener("click", function() {
            const category = this.dataset.category;

            // Fetch products from backend (via servlet returning JSON)
            fetch(`getProducts?category=${category}`)
                .then(res => res.json())
                .then(products => {
                    productContainer.innerHTML = ""; // Clear old products

                    products.forEach(p => {
                        const cardDiv = document.createElement("div");
                        cardDiv.classList.add("product-card");
                        cardDiv.innerHTML = `
                            <img src="${p.imageUrl}" alt="${p.name}">
                            <p class="product-category">${p.category}</p>
                            <h3>${p.name} ${p.quantity}</h3>
                            <div class="rating">
                                ${"<i class='fa-solid fa-star'></i>".repeat(p.rating)}
                                ${"<i class='fa-regular fa-star'></i>".repeat(5 - p.rating)}
                                <span>(${p.ratingCount})</span>
                            </div>
                            <p class="product-seller">By ${p.seller}</p>
                            <div class="product-footer">
                                <p class="price"><b>$${p.price}</b> <s>$${p.originalPrice}</s></p>
                                <button class="add-btn"><i class="fa-solid fa-plus"></i> Add</button>
                            </div>
                        `;
                        productContainer.appendChild(cardDiv);
                    });
                });
        });
    });
});

</script>


    

</body>
</html>