package com.src.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.model.Category;
import com.src.model.Product;
import com.src.service.ProductService;
import com.src.service.ProductServiceImpl;

@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1️⃣ Retrieve form data
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String unit = request.getParameter("unit");
            String imageUrl = request.getParameter("imageUrl");
            String description = request.getParameter("description");

            // 2️⃣ Create Product object
            Product product = new Product();
            product.setProductId(productId);
            product.setProductName(productName);
            product.setCategory(Category.valueOf(category));
            product.setPrice(price);
            product.setDiscount(discount);
            product.setQuantityInStock(quantity);
            product.setUnit(unit);
            product.setImageUrl(imageUrl);
            product.setDescription(description);

            // 3️⃣ Call Service Layer
            ProductService productService = new ProductServiceImpl();
            boolean success = productService.updateProduct(product);

            // 4️⃣ Redirect accordingly
            if (success) {
                response.sendRedirect("manageProducts.jsp?msg=Product updated successfully");
            } else {
                response.sendRedirect("manageProducts.jsp?error=Failed to update product");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageProducts.jsp?error=Exception occurred");
        }
    }
}
