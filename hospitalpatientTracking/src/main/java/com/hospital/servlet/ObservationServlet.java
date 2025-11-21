package com.hospital.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.hospital.dao.ObservationDAO;
import com.hospital.model.Observation;

@WebServlet("/ObservationServlet")
public class ObservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ObservationDAO dao = new ObservationDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ✅ Ensure encoding
        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html;charset=UTF-8");

        String action = req.getParameter("action");
        System.out.println("🔹 Received action: " + action);

        try {
            int patientId = parseInt(req.getParameter("patientId"));
            double temp = parseDouble(req.getParameter("temperature"));
            int systolic = parseInt(req.getParameter("systolic_bp"));
            int diastolic = parseInt(req.getParameter("diastolic_bp"));
            int hr = parseInt(req.getParameter("heartRate"));
            String notes = req.getParameter("notes");

            System.out.println("📥 Patient ID: " + patientId);
            System.out.println("Temp: " + temp + ", Sys: " + systolic + ", Dia: " + diastolic + ", HR: " + hr);
            System.out.println("Notes: " + notes);

            Observation o = new Observation();
            o.setPatientId(patientId);
            o.setTemperature(temp);
            o.setSystolicBp(systolic);
            o.setDiastolicBp(diastolic);
            o.setHeartRate(hr);
            o.setNotes(notes);

            // ✅ Set created_by from session
            HttpSession session = req.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                com.hospital.model.User loggedUser = (com.hospital.model.User) session.getAttribute("user");
                o.setCreatedBy(loggedUser.getName());
                System.out.println("👤 Created By: " + loggedUser.getName());
            } else {
                o.setCreatedBy("System");
                System.out.println("⚠️ No logged user found, using 'System'");
            }

            // ✅ Perform CRUD action
            switch (action.toLowerCase()) {
                case "add":
                    dao.addObservation(o);
                    res.sendRedirect("viewObservations.jsp?pid=" + patientId + "&msg=added");
                    break;
                case "update":
                    o.setId(parseInt(req.getParameter("id")));
                    dao.updateObservation(o);
                    res.sendRedirect("viewObservations.jsp?pid=" + patientId + "&msg=updated");
                    break;
                case "delete":
                    int id = parseInt(req.getParameter("id"));
                    dao.deleteObservation(id);
                    res.sendRedirect("viewObservations.jsp?pid=" + patientId + "&msg=deleted");
                    break;
                default:
                    System.err.println("⚠️ Invalid action value: " + action);
                    res.sendRedirect("error.jsp?msg=InvalidAction");
                    break;
            }

        } catch (Exception e) {
            System.err.println("❌ Exception in ObservationServlet:");
            e.printStackTrace();
            req.setAttribute("errorMessage", e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher("error.jsp");
            rd.forward(req, res);
        }
    }

    // ✅ Helper Methods
    private int parseInt(String value) {
        try {
            return Integer.parseInt(value.trim());
        } catch (Exception e) {
            return 0;
        }
    }

    private double parseDouble(String value) {
        try {
            return Double.parseDouble(value.trim());
        } catch (Exception e) {
            return 0.0;
        }
    }
}
