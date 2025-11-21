package com.hospital.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.hospital.dao.ObservationDAO;
import com.hospital.model.Observation;

@WebServlet("/ObservationListServlet")
public class ObservationListServlet extends HttpServlet {
    private ObservationDAO dao = new ObservationDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String pid = req.getParameter("id");
        if (pid == null || pid.isEmpty()) {
            res.sendRedirect("viewPatients.jsp?error=Invalid+Patient+ID");
            return;
        }

        int patientId = Integer.parseInt(pid);
        List<Observation> list = dao.getByPatient(patientId);

        req.setAttribute("patientId", patientId);
        req.setAttribute("list", list);

        RequestDispatcher rd = req.getRequestDispatcher("viewObservations.jsp");
        rd.forward(req, res);
    }
}
