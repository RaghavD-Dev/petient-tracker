package com.hospital.servlet;

import com.hospital.dao.UserDAO;
import com.hospital.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html;charset=UTF-8");

        // ✅ Get email & password from form
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            // ✅ Validate credentials from DB
            User user = dao.validateUser(email, password);

            if (user != null) {
                // ✅ Create session and store user
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole());

                // ✅ Redirect user by role
                switch (user.getRole().toLowerCase()) {
                    case "admin":
                        res.sendRedirect("adminDashboard.jsp");
                        break;
                    case "doctor":
                        res.sendRedirect("doctorDashboard.jsp");
                        break;
                    case "nurse":
                        res.sendRedirect("nurseDashboard.jsp");
                        break;
                    default:
                        res.sendRedirect("dashboard.jsp");
                        break;
                }

            } else {
                // ❌ Invalid credentials
                res.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("login.jsp?error=server");
        }
    }
}
