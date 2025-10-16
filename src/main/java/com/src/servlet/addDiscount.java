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

@WebServlet("/addDiscount")
public class addDiscount extends HttpServlet {
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

        try {
            // ✅ Read form data
            String discountName = request.getParameter("discountName");
            String discountTypeStr = request.getParameter("discountType");
            String discountValueStr = request.getParameter("discountValue");
            String isPercentageStr = request.getParameter("isPercentage");
            String minCartValueStr = request.getParameter("minCartValue");
            String activeStr = request.getParameter("active");

            // ✅ Convert values
            DiscountType discountType = DiscountType.valueOf(discountTypeStr.toUpperCase());
            double discountValue = Double.parseDouble(discountValueStr);
            boolean isPercentage = Boolean.parseBoolean(isPercentageStr);
            double minCartValue = Double.parseDouble(minCartValueStr);
            boolean isActive = Boolean.parseBoolean(activeStr);

            // ✅ Create Discount object
            Discount discount = new Discount();
            discount.setId(discountName.replace(" ","").toUpperCase());
            discount.setName(discountName);
            discount.setType(discountType);
            discount.setValue(discountValue);
            discount.setPercentage(isPercentage);
            discount.setMinCartValue(minCartValue);
            discount.setActive(isActive);

            // ✅ Save using service
            boolean added = discountService.createDiscount(discount);

            if (added) {
                request.setAttribute("successMessage", "Discount added successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to add discount. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }

        // ✅ Forward back to addDiscount.jsp (with message)
        request.getRequestDispatcher("addDiscount.jsp").forward(request, response);
    }
}
