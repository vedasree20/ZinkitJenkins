package com.src.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.dao.DiscountDao;
import com.src.dao.DiscountDaoImpl;
import com.src.model.Discount;
import com.src.model.DiscountType;
import com.src.service.DiscountService;
import com.src.service.DiscountServiceImpl;

@WebServlet("/editDiscount")
public class editDiscount extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private DiscountService discountService;

    @Override
    public void init() throws ServletException {
        DiscountDao dao = new DiscountDaoImpl();
        discountService = new DiscountServiceImpl(dao);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch parameters from the form
        String discountId = request.getParameter("discountId");
        String discountName = request.getParameter("discountName");
        String discountType = request.getParameter("discountType");
        String discountValueStr = request.getParameter("discountValue");
        String isPercentageStr = request.getParameter("isPercentage");
        String minCartValueStr = request.getParameter("minCartValue");
        String activeStr = request.getParameter("active");

        try {
            // Get the existing discount
            Discount existingDiscount = discountService.getDiscountById(discountId);

            if (existingDiscount == null) {
                request.getSession().setAttribute("msg", "Discount not found.");
                response.sendRedirect("manageDiscounts.jsp");
                return;
            }

            // Parse and set updated fields
            existingDiscount.setName(discountName);
            existingDiscount.setType(DiscountType.valueOf(discountType));
            existingDiscount.setValue(Double.parseDouble(discountValueStr));
            existingDiscount.setPercentage(Boolean.parseBoolean(isPercentageStr));
            existingDiscount.setMinCartValue(Double.parseDouble(minCartValueStr));
            existingDiscount.setActive(Boolean.parseBoolean(activeStr));

            // Update in database
            boolean updated = discountService.updateDiscount(existingDiscount);

            if (updated) {
                request.getSession().setAttribute("msg", "✅ Discount updated successfully!");
            } else {
                request.getSession().setAttribute("msg", "❌ Failed to update discount.");
            }

            // Redirect back to manage discounts page
            response.sendRedirect("manageDiscounts.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "❌ Error updating discount: " + e.getMessage());
            response.sendRedirect("manageDiscounts.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("manageDiscounts.jsp");
    }
}
