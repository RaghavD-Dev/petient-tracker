package com.hospital.dao;

import com.hospital.model.Patient;
import com.hospital.util.DBConnection;
import java.sql.*;
import java.util.*;

public class PatientDAO {

    // Method to add a new patient
    public void addPatient(Patient p) {
        String sql = "INSERT INTO patients(name, age, gender, admission_date, diagnosis, assigned_doctor) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setDate(4, new java.sql.Date(p.getAdmissionDate().getTime()));
            ps.setString(5, p.getDiagnosis());
            ps.setString(6, p.getAssignedDoctor());
            ps.executeUpdate();

            System.out.println("✅ Patient added successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to retrieve all patients
    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patients ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAge(rs.getInt("age"));
                p.setGender(rs.getString("gender"));
                p.setAdmissionDate(rs.getDate("admission_date"));
                p.setDiagnosis(rs.getString("diagnosis"));
                p.setAssignedDoctor(rs.getString("assigned_doctor"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
