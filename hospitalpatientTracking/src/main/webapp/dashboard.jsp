<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  com.hospital.model.User user = (com.hospital.model.User) session.getAttribute("user");
  if (user == null) {
      response.sendRedirect("login.jsp?error=login_required");
      return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard | Hospital Tracker</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body {
      background-color: #f5f8fb;
      font-family: 'Poppins', sans-serif;
    }

    .navbar {
      background-color: #0078d7;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .navbar-brand {
      font-weight: 600;
      color: white !important;
      font-size: 1.3rem;
    }

    .navbar .btn {
      border-radius: 8px;
      font-weight: 500;
    }

    .logout-btn {
      background: white;
      color: #0078d7;
      border: 1px solid white;
      transition: 0.3s;
    }

    .logout-btn:hover {
      background-color: #005bb5;
      color: white;
      border-color: #005bb5;
    }

    .container {
      margin-top: 80px;
    }

    .welcome-text {
      text-align: center;
      margin-bottom: 30px;
    }

    .welcome-text h3 {
      font-weight: 600;
      color: #333;
    }

    .welcome-text span {
      color: #0078d7;
      font-weight: 600;
    }

    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
      transition: 0.3s;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }

    .card i {
      font-size: 2.5rem;
      color: #0078d7;
    }

    .card-title {
      font-weight: 600;
      color: #333;
    }

    .footer {
      text-align: center;
      margin-top: 40px;
      color: #888;
      font-size: 14px;
    }
  </style>
</head>

<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid px-5">
    <a class="navbar-brand" href="#"><i class="bi bi-hospital"></i> Hospital Tracker</a>
    <div class="d-flex align-items-center">
      <span class="text-white me-3">👋 Welcome, <b><%= user.getName() %></b> (<%= user.getRole() %>)</span>
      <a href="LogoutServlet" class="btn logout-btn btn-sm">
        <i class="bi bi-box-arrow-right"></i> Logout
      </a>
    </div>
  </div>
</nav>

<!-- ✅ Dashboard Cards -->
<div class="container">
  <div class="welcome-text">
    <h3>Welcome back, <span><%= user.getName() %></span>!</h3>
    <p>Manage hospital operations efficiently from this dashboard.</p>
  </div>

  <div class="row g-4 justify-content-center">

    <!-- Manage Patients -->
    <div class="col-md-3">
      <div class="card text-center p-4">
        <i class="bi bi-people-fill mb-3"></i>
        <h5 class="card-title">Manage Patients</h5>
        <p class="text-muted small">View, add, or edit patient details.</p>
        <a href="viewPatients.jsp" class="btn btn-primary w-100">Open</a>
      </div>
    </div>

    <!-- Observations -->
    <div class="col-md-3">
      <div class="card text-center p-4">
        <i class="bi bi-clipboard2-pulse mb-3"></i>
        <h5 class="card-title">Daily Observations</h5>
        <p class="text-muted small">Track vitals and patient progress.</p>
        <a href="viewObservations.jsp?pid=1" class="btn btn-success w-100">Open</a>
      </div>
    </div>

    <!-- Reports -->
    <div class="col-md-3">
      <div class="card text-center p-4">
        <i class="bi bi-bar-chart-fill mb-3"></i>
        <h5 class="card-title">Reports</h5>
        <p class="text-muted small">View insights and CSV exports.</p>
        <a href="reports.jsp" class="btn btn-warning w-100">Open</a>
      </div>
    </div>

    <!-- Alerts -->
    <div class="col-md-3">
      <div class="card text-center p-4">
        <i class="bi bi-bell-fill mb-3"></i>
        <h5 class="card-title">Alerts</h5>
        <p class="text-muted small">Check critical vitals and notifications.</p>
        <a href="alerts.jsp" class="btn btn-danger w-100">View</a>
      </div>
    </div>

  </div>
</div>

<!-- ✅ Footer -->
<div class="footer">
  © <%= java.time.Year.now() %> Hospital Patient Tracking System — All Rights Reserved
</div>

</body>
</html>
