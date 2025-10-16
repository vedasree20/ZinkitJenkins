package com.src.servlet
;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.util.Test;

@WebServlet("/SubscribeServlet")
public class SubscribeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email != null && !email.isEmpty()) {
            String subject = "Welcome to Zinkit!";
            String body = "Hello! Thank you for subscribing to Zinkit. Get ready for fresh updates and offers!";
            
            // Call your Test class method
            Test.sendEmail(email, subject, body);
            
            // Feedback to user
            response.sendRedirect("index.jsp?msg=success");
        } else {
            // Redirect to index.jsp with error message
            response.sendRedirect("index.jsp?msg=error");
        }
    }
}
