package com.src.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.src.dao.DiscountDaoImpl;
import com.src.model.Discount;
import com.src.service.DiscountService;
import com.src.service.DiscountServiceImpl;

/**
 * Servlet implementation class ApplyCouponServlet
 */
@WebServlet("/ApplyCouponServlet")
public class ApplyCouponServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private DiscountService discountService;

    @Override
    public void init() throws ServletException {
        // Initialize the service layer (assuming you have a way to inject dependencies)
        // You'll need to pass a valid database connection/configuration to the DAO.
        // For simplicity here, we instantiate the Impl directly.
        // Replace 'new DiscountDaoImpl()' with your actual instantiation logic.
        discountService = new DiscountServiceImpl(new DiscountDaoImpl()); 
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // 1. Get user input (coupon code)
        String couponCode = request.getParameter("couponCode");
        
        // 2. Get current cart subtotal from session
        Double subtotal = (Double) session.getAttribute("subtotal");
        
        // Safety check for subtotal
        if (subtotal == null || subtotal <= 0.0) {
            session.setAttribute("couponStatus", "error");
            session.setAttribute("discountAmount", 0.0);
            session.setAttribute("couponError", "Your cart is empty.");
            response.sendRedirect("CartNew.jsp");
            return;
        }

        double discountValue = 0.0;
        String status = "error";
        
        if (couponCode != null && !couponCode.trim().isEmpty()) {
            
            // 3. Look up the discount in the database
            Discount discount = discountService.getDiscountById(couponCode.trim());

            if (discount != null && discount.isActive()) {
                
                // 4. Check min cart value requirement
                if (subtotal >= discount.getMinCartValue()) {
                    
                    // 5. Calculate the discount
                    if (discount.isPercentage()) {
                        // Percentage discount: e.g., 10%
                        discountValue = subtotal * (discount.getValue() / 100.0);
                    } else {
                        // Fixed discount: e.g., $5 off
                        discountValue = discount.getValue();
                    }
                    
                    // Ensure discount doesn't exceed subtotal
                    if (discountValue > subtotal) {
                        discountValue = subtotal; 
                    }
                    
                    status = "success";
                    
                } else {
                    // Min cart value not met
                    session.setAttribute("couponError", "Minimum cart value of " + discount.getMinCartValue() + " not met.");
                }
            } else {
                // Discount code not found or inactive
                session.setAttribute("couponError", "Invalid or expired coupon code.");
            }
        }
        
        // 6. Store results in session and redirect
        session.setAttribute("couponStatus", status);
        session.setAttribute("discountAmount", discountValue);
        
        // This is important: clear the coupon code so the input is empty on refresh
        session.removeAttribute("couponCode"); 

        // Redirect back to the cart page to display updated total and status message
        response.sendRedirect("CartNew.jsp");
    }
}