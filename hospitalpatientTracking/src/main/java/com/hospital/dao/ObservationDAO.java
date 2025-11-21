package com.hospital.dao;

import com.hospital.model.Observation;
import com.hospital.util.DBConnection;
import java.sql.*;
import java.util.*;

public class ObservationDAO {

    public void addObservation(Observation o) {
        String sql = "INSERT INTO observations (patient_id, temperature, systolic_bp, diastolic_bp, heart_rate, notes, created_by, observed_at) "
                   + "VALUES (?,?,?,?,?,?,?,NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, o.getPatientId());
            ps.setDouble(2, o.getTemperature());
            ps.setInt(3, o.getSystolicBp());
            ps.setInt(4, o.getDiastolicBp());
            ps.setInt(5, o.getHeartRate());
            ps.setString(6, o.getNotes());
            ps.setString(7, o.getCreatedBy());
            ps.executeUpdate();

            System.out.println("✅ Observation added for Patient ID: " + o.getPatientId());

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateObservation(Observation o) {
        String sql = "UPDATE observations SET temperature=?, systolic_bp=?, diastolic_bp=?, heart_rate=?, notes=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, o.getTemperature());
            ps.setInt(2, o.getSystolicBp());
            ps.setInt(3, o.getDiastolicBp());
            ps.setInt(4, o.getHeartRate());
            ps.setString(5, o.getNotes());
            ps.setInt(6, o.getId());
            ps.executeUpdate();

            System.out.println("✅ Observation updated: " + o.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteObservation(int id) {
        String sql = "DELETE FROM observations WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("🗑️ Observation deleted ID: " + id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Observation> getByPatient(int patientId) {
        List<Observation> list = new ArrayList<>();
        String sql = "SELECT * FROM observations WHERE patient_id=? ORDER BY observed_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Observation o = new Observation();
                o.setId(rs.getInt("id"));
                o.setPatientId(rs.getInt("patient_id"));
                o.setTemperature(rs.getDouble("temperature"));
                o.setSystolicBp(rs.getInt("systolic_bp"));
                o.setDiastolicBp(rs.getInt("diastolic_bp"));
                o.setHeartRate(rs.getInt("heart_rate"));
                o.setNotes(rs.getString("notes"));
                o.setObservedAt(rs.getTimestamp("observed_at"));
                o.setCreatedBy(rs.getString("created_by"));
                list.add(o);
            }

            System.out.println("🔍 Fetched " + list.size() + " observations for patient " + patientId);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Observation getById(int id) {
        Observation o = null;
        String sql = "SELECT * FROM observations WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                o = new Observation();
                o.setId(rs.getInt("id"));
                o.setPatientId(rs.getInt("patient_id"));
                o.setTemperature(rs.getDouble("temperature"));
                o.setSystolicBp(rs.getInt("systolic_bp"));
                o.setDiastolicBp(rs.getInt("diastolic_bp"));
                o.setHeartRate(rs.getInt("heart_rate"));
                o.setNotes(rs.getString("notes"));
                o.setObservedAt(rs.getTimestamp("observed_at"));
                o.setCreatedBy(rs.getString("created_by"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return o;
    }
}
