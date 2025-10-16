package com.src.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.service.ProductService;
import com.src.service.ProductServiceImpl;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the productId from the request parameter
        String productId = request.getParameter("productId");

        if (productId == null || productId.trim().isEmpty()) {
            response.sendRedirect("manageProducts.jsp?error=Invalid product ID");
            return;
        }

        try {
            // Call service layer
            ProductService productService = new ProductServiceImpl();
            boolean isDeleted = productService.deleteProduct(productId);

            // Redirect with message
            if (isDeleted) {
                response.sendRedirect("manageProducts.jsp?msg=Product deleted successfully");
            } else {
                response.sendRedirect("manageProducts.jsp?error=Failed to delete product");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageProducts.jsp?error=An unexpected error occurred");
        }
    }
}
