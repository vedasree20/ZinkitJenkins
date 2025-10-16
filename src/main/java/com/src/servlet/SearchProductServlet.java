package com.src.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.model.Product;
import com.src.service.ProductService;
import com.src.service.ProductServiceImpl;

@WebServlet("/SearchProductServlet")
public class SearchProductServlet extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        String query = req.getParameter("query");
        if (query == null || query.trim().isEmpty()) {
            res.sendRedirect("home.jsp"); // or any default page
            return;
        }

        List<Product> searchResults = productService.searchProducts(query.trim());

        req.setAttribute("searchResults", searchResults);
        req.setAttribute("searchQuery", query);

        RequestDispatcher rd = req.getRequestDispatcher("searchResults.jsp");
        rd.forward(req, res);
    }
}
