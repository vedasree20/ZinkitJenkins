package com.src.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.dao.ProductDAO;
import com.src.dao.ProductDAOImpl;
import com.src.model.Product;

@WebServlet("/searchProductsServlet")
public class searchProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        try {
            List<Product> products;

            if (keyword != null && !keyword.trim().isEmpty()) {
                products = productDAO.searchProducts(keyword.trim());
            } else {
                products = productDAO.findAll(); // show all if no keyword
            }

            request.setAttribute("products", products);
            request.setAttribute("searchKeyword", keyword);
            request.getRequestDispatcher("manageProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred while searching for products.");
            request.getRequestDispatcher("manageProducts.jsp").forward(request, response);
        }
    }
}
