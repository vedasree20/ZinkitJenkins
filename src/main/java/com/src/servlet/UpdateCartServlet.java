package com.src.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.src.dao.CartDAO;
import com.src.dao.CartDAOImpl;
import com.src.dao.DiscountDaoImpl;
import com.src.model.Cart;
import com.src.service.CartService;
import com.src.service.CartServiceImpl;
import com.src.service.DiscountService;
import com.src.service.DiscountServiceImpl;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CartService cartService;
    private DiscountService discountService;

    @Override
    public void init() throws ServletException {
        CartDAO cartDAO = new CartDAOImpl(CartDAO.getConnection());
        cartService = new CartServiceImpl(cartDAO);
        discountService = new DiscountServiceImpl(new DiscountDaoImpl());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        String productId = request.getParameter("productId");
        String action = request.getParameter("action");

        if (userId == null || productId == null || action == null) {
            response.sendRedirect("CartNew.jsp");
            return;
        }

        // 1. Update cart quantity
        Cart cartItem = cartService.getCartItemByUserAndProduct(userId, productId);
        if (cartItem == null) {
            response.sendRedirect("CartNew.jsp");
            return;
        }

        int currentQty = cartItem.getQuantity();
        int newQty = currentQty;

        if ("increase".equals(action)) newQty++;
        else if ("decrease".equals(action) && currentQty > 1) newQty--;

        cartItem.setQuantity(newQty);
        cartService.updateCartItem(cartItem);

        // 2. Recalculate subtotal
        List<Cart> cartItems = cartService.getCartItemsByUserId(userId);
        double subtotal = 0.0;
        for (Cart c : cartItems) {
            subtotal += c.getPriceAtTime() * c.getQuantity();
        }

        session.setAttribute("cartItems", cartItems);
        session.setAttribute("subtotal", subtotal);

        // 3. Forward to ApplyCouponServlet to recalc discount automatically
        request.getRequestDispatcher("ApplyCouponServlet").forward(request, response);
    }

}
