package com.src.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.dao.DiscountDao;
import com.src.dao.DiscountDaoImpl;
import com.src.model.Discount;
import com.src.service.DiscountService;
import com.src.service.DiscountServiceImpl;

@WebServlet("/searchDiscounts")
public class searchDiscounts extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private DiscountService discountService;

    @Override
    public void init() throws ServletException {
        DiscountDao dao = new DiscountDaoImpl();
        discountService = new DiscountServiceImpl(dao);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<Discount> discounts;

        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                discounts = discountService.search(keyword.trim());
            } else {
                discounts = discountService.getAllActiveDiscounts();
            }

            // Attach data back to JSP for display
            request.setAttribute("discounts", discounts);
            request.setAttribute("searchKeyword", keyword);

            // Forward to same manageDiscounts.jsp
            request.getRequestDispatcher("manageDiscounts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error searching discounts: " + e.getMessage());
            request.getRequestDispatcher("manageDiscounts.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
