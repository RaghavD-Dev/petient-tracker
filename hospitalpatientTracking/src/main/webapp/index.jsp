<%@ page import="java.util.*, com.hospital.model.Patient, com.hospital.dao.PatientDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    com.hospital.model.User user = (com.hospital.model.User) session.getAttribute("user");
    PatientDAO pdao = new PatientDAO();
    List<Patient> patients = pdao.getAllPatients();
    int totalPatients = patients.size();

    // Calculate unique doctors and recent admissions
    Set<String> doctors = new HashSet<>();
    int recentAdmissions = 0;
    java.util.Date now = new java.util.Date();

    for (Patient p : patients) {
        if (p.getAssignedDoctor() != null) doctors.add(p.getAssignedDoctor());
        if (p.getAdmissionDate() != null && (now.getTime() - p.getAdmissionDate().getTime()) < (7L * 24 * 60 * 60 * 1000)) {
            recentAdmissions++;
        }
    }

    int totalDoctors = doctors.size();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hospital Patient Tracking System</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            font-family: 'Poppins', sans-serif;
            color: #333;
            min-height: 100vh;
        }

        .navbar {
            background-color: #0078d7;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 600;
            color: white !important;
        }

        .btn-light, .btn-outline-light {
            border-radius: 8px;
            font-weight: 500;
        }

        .hero {
            height: calc(100vh - 80px);
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: #333;
        }

        .hero-card {
            background: #fff;
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            transition: 0.3s ease-in-out;
            width: 500px;
        }

        .hero-card:hover {
            transform: translateY(-5px);
        }

        .hero-card h1 {
            color: #0078d7;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .hero-card p {
            color: #555;
            font-size: 15px;
            margin-bottom: 25px;
        }

        .dashboard {
            margin-top: 100px;
            color: #333;
        }

        .card-dashboard {
            background: #fff;
            border: none;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease-in-out;
        }

        .card-dashboard:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }

        .card-dashboard i {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: #0078d7;
        }

        footer {
            text-align: center;
            color: #666;
            padding: 15px;
            position: fixed;
            bottom: 0;
            width: 100%;
            font-size: 0.9rem;
        }

        footer b {
            color: #0078d7;
        }

        .btn-custom {
            border-radius: 10px;
            font-weight: 500;
            transition: 0.3s;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
        }
    </style>
</head>

<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid px-5">
    <a class="navbar-brand fw-bold" href="#"><i class="bi bi-hospital"></i> Hospital Tracker</a>
    <div class="d-flex">
      <% if (user == null) { %>
          <a href="login.jsp" class="btn btn-light btn-sm me-2">Login</a>
          <a href="register.jsp" class="btn btn-outline-light btn-sm">Register</a>
      <% } else { %>
          <span class="text-light me-3">👋 Welcome, <b><%= user.getName() %></b></span>
          <a href="viewPatients.jsp" class="btn btn-success btn-sm me-2"><i class="bi bi-person-lines-fill"></i> Manage Patients</a>
          <a href="LogoutServlet" class="btn btn-danger btn-sm"><i class="bi bi-box-arrow-right"></i> Logout</a>
      <% } %>
    </div>
  </div>
</nav>

<!-- ✅ Main Section -->
<% if (user == null) { %>
  <!-- 🔹 Public Welcome Page -->
  <div class="hero">
    <div class="hero-card">
      <h1><i class="bi bi-heart-pulse-fill text-danger"></i> Hospital Patient Tracking System</h1>
      <p>Effortlessly manage patients, record vital observations, and monitor progress — securely and efficiently.</p>

      <div class="mt-3">
        <a href="login.jsp" class="btn btn-primary btn-custom px-4 me-2"><i class="bi bi-box-arrow-in-right"></i> Login</a>
        <a href="register.jsp" class="btn btn-outline-primary btn-custom px-4"><i class="bi bi-person-plus"></i> Create Account</a>
      </div>
    </div>
  </div>

<% } else { %>
  <!-- 🔹 Logged-in Dashboard Preview -->
  <div class="container dashboard text-center">
    <h2 class="mb-4 text-primary"><i class="bi bi-speedometer2"></i> Quick Hospital Overview</h2>

    <div class="row justify-content-center g-4">
      <div class="col-md-3">
        <div class="card-dashboard">
          <i class="bi bi-people-fill"></i>
          <h4><%= totalPatients %></h4>
          <p>Total Patients</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card-dashboard">
          <i class="bi bi-calendar-week"></i>
          <h4><%= recentAdmissions %></h4>
          <p>Recent Admissions (7 Days)</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card-dashboard">
          <i class="bi bi-person-badge"></i>
          <h4><%= totalDoctors %></h4>
          <p>Assigned Doctors</p>
        </div>
      </div>
    </div>

    <div class="mt-5">
      <a href="viewPatients.jsp" class="btn btn-primary btn-custom px-4 py-2">
        <i class="bi bi-clipboard-data"></i> Go to Dashboard
      </a>
    </div>
  </div>
<% } %>

<!-- ✅ Footer -->
<footer>
  &copy; <%= java.time.Year.now() %> Hospital Patient Tracking System | Designed by <b>Raghav Dornal</b>
</footer>

</body>
</html>
