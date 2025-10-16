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

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductService productService = new ProductServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form parameters
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String categoryStr = request.getParameter("category");
            String priceStr = request.getParameter("price");
            String discountStr = request.getParameter("discount");
            String quantityStr = request.getParameter("quantity");
            String unit = request.getParameter("unit");
            String imageUrl = request.getParameter("imageUrl");
            String description = request.getParameter("description");

            // Convert to proper types
            Category category = Category.valueOf(categoryStr.toUpperCase());
            double price = Double.parseDouble(priceStr);
            double discount = (discountStr == null || discountStr.isEmpty()) ? 0.0 : Double.parseDouble(discountStr);
            int quantity = Integer.parseInt(quantityStr);

            // Create Product object
            Product product = new Product();
            product.setProductId(productId); // can be null to auto-generate in DAO
            product.setProductName(productName);
            product.setCategory(category);
            product.setPrice(price);
            product.setDiscount(discount);
            product.setQuantityInStock(quantity);
            product.setUnit(unit);
            product.setImageUrl(imageUrl);
            product.setDescription(description);

            // Add product via service
            boolean success = productService.addProduct(product);

            if (success) {
                // Redirect to products list or success page
                response.sendRedirect("index.jsp?msg=Product+added+successfully");
            } else {
                response.sendRedirect("manageProducts.jsp?error=Failed+to+add+product");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addProduct.jsp?error=Invalid+input");
        }
    }
}
