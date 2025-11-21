package com.hospital.servlet;

import com.hospital.dao.UserDAO;
import com.hospital.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO dao = new UserDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html;charset=UTF-8");

        String name = req.getParameter("username"); // From register.jsp input name="username"
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        try {
            if (dao.userExists(email)) {
                res.sendRedirect("register.jsp?msg=exists");
                return;
            }

            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            if (dao.addUser(user)) {
                res.sendRedirect("login.jsp?msg=registered");
            } else {
                res.sendRedirect("register.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("register.jsp?msg=error");
        }
    }
}
