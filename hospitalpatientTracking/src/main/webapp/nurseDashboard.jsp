<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  com.hospital.model.User user = (com.hospital.model.User) session.getAttribute("user");
  if (user == null || !"Nurse".equalsIgnoreCase(user.getRole())) {
      response.sendRedirect("login.jsp?error=unauthorized");
      return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Nurse Dashboard | Hospital Tracker</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(135deg, #e3f2fd, #bbdefb);
      font-family: 'Poppins', sans-serif;
      min-height: 100vh;
      margin: 0;
      color: #333;
    }

    .navbar {
      background-color: #0078d7;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .navbar-brand {
      font-weight: 600;
      color: #fff !important;
    }

    .dashboard-container {
      margin-top: 100px;
    }

    .card-dashboard {
      background: #fff;
      border: none;
      border-radius: 15px;
      padding: 25px;
      text-align: center;
      box-shadow: 0 6px 15px rgba(0,0,0,0.1);
      transition: all 0.3s ease-in-out;
    }

    .card-dashboard:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.12);
    }

    .card-dashboard i {
      font-size: 2.5rem;
      color: #0078d7;
      margin-bottom: 10px;
    }

    h2 {
      color: #0078d7;
      font-weight: 600;
    }

    .btn-custom {
      border-radius: 10px;
      font-weight: 500;
      transition: 0.3s;
    }

    .btn-custom:hover {
      transform: translateY(-2px);
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
  </style>
</head>

<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid px-5">
    <a class="navbar-brand" href="#"><i class="bi bi-heart-pulse"></i> Nurse Dashboard</a>
    <div class="d-flex align-items-center">
      <span class="text-light me-3">👩‍⚕️ Nurse <b><%= user.getName() %></b></span>
      <a href="LogoutServlet" class="btn btn-danger btn-sm">
        <i class="bi bi-box-arrow-right"></i> Logout
      </a>
    </div>
  </div>
</nav>

<!-- ✅ Main Content -->
<div class="container dashboard-container text-center">
  <h2 class="mb-4">Welcome, Nurse <%= user.getName() %></h2>
  <p class="text-muted">Manage daily patient observations and support the healthcare team.</p>

  <div class="row justify-content-center g-4 mt-4">
    <div class="col-md-4">
      <div class="card-dashboard">
        <i class="bi bi-clipboard-plus"></i>
        <h5>Record Observations</h5>
        <p class="text-muted">Add or update patient daily vitals</p>
        <a href="viewObservations.jsp?pid=1" class="btn btn-success btn-custom">Open</a>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card-dashboard">
        <i class="bi bi-person-lines-fill"></i>
        <h5>View Patients</h5>
        <p class="text-muted">Access current admitted patients list</p>
        <a href="viewPatients.jsp" class="btn btn-primary btn-custom">Go</a>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card-dashboard">
        <i class="bi bi-calendar-heart"></i>
        <h5>Reminders</h5>
        <p class="text-muted">View medicine schedules and notes</p>
        <a href="#" class="btn btn-warning btn-custom text-white">View</a>
      </div>
    </div>
  </div>
</div>

<!-- ✅ Footer -->
<footer>
  &copy; <%= java.time.Year.now() %> Hospital Patient Tracking System | Designed by <b>Raghav Dornal</b>
</footer>

</body>
</html>
