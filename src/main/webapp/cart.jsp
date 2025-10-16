<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.src.model.*" %>
<%@ page import="com.src.service.*" %>
<%@ page import="java.util.List" %>
<%
    com.src.model.User loggedUser = (com.src.model.User) session.getAttribute("loggedInUser");
    if (loggedUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Cart> cartList = (List<Cart>) request.getAttribute("cartList"); // You need to set this in servlet
%>

<section class="store-section" id="cart-section">
    <header class="section-header">
        <h2>My Cart</h2>
    </header>

    <div class="product-list" id="cart-product-list">
        <% if (cartList != null && !cartList.isEmpty()) {
            for (Cart c : cartList) { 
                ProductService ps = new ProductServiceImpl();
                Product p = ps.getProductById(c.getProductId());
            %>
                <div class="product-card" id="cart-item-<%= c.getCartItemId() %>">
                    <img src="<%= p.getImageUrl() != null ? p.getImageUrl() : "https://via.placeholder.com/150" %>" 
                         alt="<%= p.getProductName() %>">
                    <p class="product-category"><%= p.getCategory().name().replace("_"," ") %></p>
                    <h3><%= p.getProductName() %></h3>
                    <p class="product-seller">By Zinkit</p>
                    <div class="product-footer">
                        <p class="price"><b>₹<span id="price-<%= c.getCartItemId() %>"><%= c.getPriceAtTime() * c.getQuantity() %></span></b></p>
                        
                        <div class="quantity-controls">
                            <button class="decrement-btn" data-id="<%= c.getCartItemId() %>">-</button>
                            <span id="qty-<%= c.getCartItemId() %>"><%= c.getQuantity() %></span>
                            <button class="increment-btn" data-id="<%= c.getCartItemId() %>">+</button>
                        </div>
                    </div>
                </div>
        <%   } 
           } else { %>
            <p>Your cart is empty!</p>
        <% } %>
    </div>
</section>

<script>
document.querySelectorAll(".increment-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        const cartItemId = btn.dataset.id;
        updateCart(cartItemId, "increment");
    });
});

document.querySelectorAll(".decrement-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        const cartItemId = btn.dataset.id;
        const qtySpan = document.getElementById("qty-" + cartItemId);
        let qty = parseInt(qtySpan.innerText);
        if (qty === 1) {
            if (confirm("Quantity is 1. Remove this item from cart?")) {
                updateCart(cartItemId, "remove");
            }
        } else {
            updateCart(cartItemId, "decrement");
        }
    });
});

function updateCart(cartItemId, action) {
    fetch("CartActionServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `cartItemId=${cartItemId}&action=${action}`
    })
    .then(response => response.json())
    .then(data => {
        if(data.success) {
            const qtySpan = document.getElementById("qty-" + cartItemId);
            const priceSpan = document.getElementById("price-" + cartItemId);
            if (data.action === "remove") {
                document.getElementById("cart-item-" + cartItemId).remove();
            } else {
                qtySpan.innerText = data.quantity;
                priceSpan.innerText = data.totalPrice;
            }
        } else {
            alert("Failed to update cart.");
        }
    });
}
</script>
