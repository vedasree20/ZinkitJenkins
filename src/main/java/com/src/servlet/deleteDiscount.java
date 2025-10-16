package com.src.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.dao.DiscountDao;
import com.src.dao.DiscountDaoImpl;
import com.src.service.DiscountService;
import com.src.service.DiscountServiceImpl;

/**
 * Servlet implementation class deleteDiscount
 */
@WebServlet("/deleteDiscount")
public class deleteDiscount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteDiscount() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String discountId = request.getParameter("discountId");

        if (discountId != null && !discountId.trim().isEmpty()) {
            DiscountDao dao = new DiscountDaoImpl();
            DiscountService service = new DiscountServiceImpl(dao);

            boolean deleted = service.deleteDiscount(discountId);

            if (deleted) {
                // Pass success message via query string
                response.sendRedirect("manageDiscounts.jsp?msg=Discount+deleted+successfully");
            } else {
                response.sendRedirect("manageDiscounts.jsp?msg=Failed+to+delete+discount");
            }
        } else {
            response.sendRedirect("manageDiscounts.jsp?msg=Invalid+discount+ID");
        }

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
