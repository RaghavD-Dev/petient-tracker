package com.hospital.servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hospital.dao.PatientDAO;
import com.hospital.model.Patient;
 
public class PatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private PatientDAO dao = new PatientDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String name = req.getParameter("name");
        int age = Integer.parseInt(req.getParameter("age"));
        String gender = req.getParameter("gender");
        String diagnosis = req.getParameter("diagnosis");
        String doctor = req.getParameter("doctor");

        Patient p = new Patient();
        p.setName(name);
        p.setAge(age);
        p.setGender(gender);
        p.setDiagnosis(diagnosis);
        p.setAssignedDoctor(doctor);
        p.setAdmissionDate(new Date());

        dao.addPatient(p);
        res.sendRedirect("viewPatients.jsp");
    }
}
