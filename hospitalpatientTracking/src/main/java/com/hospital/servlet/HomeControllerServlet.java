package com.hospital.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/HomeControllerServlet")
public class HomeControllerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("role") != null) {
            String role = session.getAttribute("role").toString();

            switch (role) {
                case "Admin":
                    res.sendRedirect("adminDashboard.jsp");
                    break;
                case "Doctor":
                    res.sendRedirect("doctorDashboard.jsp");
                    break;
                case "Nurse":
                    res.sendRedirect("nurseDashboard.jsp");
                    break;
                default:
                    res.sendRedirect("login.jsp");
            }
        } else {
            res.sendRedirect("login.jsp");
        }
    }
}
