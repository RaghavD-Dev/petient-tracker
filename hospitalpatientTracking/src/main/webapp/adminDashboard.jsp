<%@ page import="java.util.*, com.hospital.model.Patient, com.hospital.dao.PatientDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    com.hospital.model.User user = (com.hospital.model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Load quick stats
    PatientDAO pdao = new PatientDAO();
    List<Patient> patients = pdao.getAllPatients();
    int totalPatients = patients.size();

    Set<String> doctors = new HashSet<>();
    for (Patient p : patients) {
        if (p.getAssignedDoctor() != null) doctors.add(p.getAssignedDoctor());
    }
    int totalDoctors = doctors.size();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Hospital Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            background-color: #f5f8fb;
            font-family: 'Poppins', sans-serif;
            color: #333;
        }

        .navbar {
            background-color: #0078d7;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            color: white !important;
            font-weight: 600;
            font-size: 1.3rem;
        }

        .navbar .btn {
            border-radius: 8px;
            font-weight: 500;
        }

        .logout-btn {
            background: white;
            color: #0078d7;
            border: none;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background-color: #005bb5;
            color: white;
        }

        .container {
            margin-top: 80px;
        }

        .dashboard-header {
            text-align: center;
            color: #0078d7;
            font-weight: 600;
            margin-bottom: 40px;
        }

        .card-dashboard {
            background: white;
            border: none;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease-in-out;
        }

        .card-dashboard:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .card-dashboard i {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .card-dashboard h4 {
            color: #0078d7;
            font-weight: 600;
            margin: 10px 0;
        }

        .card-dashboard p {
            color: #666;
            font-size: 15px;
        }

        .btn-action {
            border-radius: 10px;
            font-weight: 500;
            transition: 0.3s;
        }

        .btn-action i {
            margin-right: 5px;
        }

        .btn-primary {
            background-color: #0078d7;
            border: none;
        }

        .btn-primary:hover {
            background-color: #005bb5;
        }

        .btn-warning {
            background-color: #ffc107;
            border: none;
            color: #333;
        }

        .btn-info {
            background-color: #17a2b8;
            border: none;
        }

        .footer {
            text-align: center;
            color: #666;
            padding: 15px;
            margin-top: 50px;
            font-size: 0.9rem;
        }

        .footer b {
            color: #0078d7;
        }
    </style>
</head>

<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid px-5">
    <a class="navbar-brand" href="#">
      <i class="bi bi-hospital"></i> Hospital Tracker
    </a>
    <div class="d-flex align-items-center">
      <span class="text-white me-3">👋 Welcome, <b><%= user.getName() %></b> (Admin)</span>
      <a href="LogoutServlet" class="btn logout-btn btn-sm">
        <i class="bi bi-box-arrow-right"></i> Logout
      </a>
    </div>
  </div>
</nav>

<!-- ✅ Dashboard Content -->
<div class="container">
    <h2 class="dashboard-header"><i class="bi bi-speedometer2"></i> Admin Dashboard Overview</h2>

    <div class="row text-center justify-content-center g-4">
        <div class="col-md-3">
            <div class="card-dashboard">
                <i class="bi bi-person-lines-fill text-primary"></i>
                <h4><%= totalPatients %></h4>
                <p>Total Patients</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card-dashboard">
                <i class="bi bi-person-badge text-success"></i>
                <h4><%= totalDoctors %></h4>
                <p>Registered Doctors</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card-dashboard">
                <i class="bi bi-calendar-check text-warning"></i>
                <h4><%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></h4>
                <p>Current Date</p>
            </div>
        </div>
    </div>

    <div class="mt-5 text-center">
        <a href="viewPatients.jsp" class="btn btn-primary btn-action px-4 me-2">
            <i class="bi bi-people"></i> Manage Patients
        </a>
        <a href="manageUsers.jsp" class="btn btn-warning btn-action px-4 me-2">
            <i class="bi bi-person-gear"></i> Manage Users
        </a>
        <a href="viewObservations.jsp" class="btn btn-info btn-action px-4">
            <i class="bi bi-clipboard-data"></i> View Observations
        </a>
    </div>
</div>

<!-- ✅ Footer -->
<div class="footer">
  &copy; <%= java.time.Year.now() %> Hospital Patient Tracking | Designed by <b>Raghav Dornal</b>
</div>

</body>
</html>
