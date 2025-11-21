<%@ page import="java.util.*, com.hospital.model.Patient, com.hospital.dao.PatientDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // 🔐 Session Check
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
    <title>Patient Management | Hospital Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7fb;
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

        .navbar span {
            color: #eaf3ff;
        }

        .container {
            margin-top: 60px;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            padding: 25px;
            background: white;
        }

        .table th {
            background-color: #0078d7;
            color: white;
            font-weight: 500;
        }

        .table-hover tbody tr:hover {
            background-color: #f0f8ff;
        }

        .btn {
            border-radius: 8px;
            font-weight: 500;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
        }

        .btn-success {
            background-color: #28a745;
            border: none;
        }

        .btn-warning {
            background-color: #ffc107;
            border: none;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .welcome {
            color: #555;
            font-size: 15px;
            margin-right: 15px;
        }

        .logout-btn {
            background: white;
            color: #0078d7;
            border: 1px solid #0078d7;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background-color: #0078d7;
            color: white;
        }

        .add-btn {
            background: #00b894;
            color: white;
            border: none;
            transition: 0.3s;
        }

        .add-btn:hover {
            background: #019870;
        }
    </style>
</head>

<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid px-5">
    <a class="navbar-brand" href="#"><i class="bi bi-hospital"></i> Hospital Tracker</a>
    <div class="d-flex align-items-center">
      <span class="welcome">👋 Welcome, <b><%= user.getName() %></b></span>
      <a href="LogoutServlet" class="btn logout-btn btn-sm">
        <i class="bi bi-box-arrow-right"></i> Logout
      </a>
    </div>
  </div>
</nav>

<div class="container">
    <div class="card">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="text-primary mb-0"><i class="bi bi-people-fill"></i> Patient Management</h4>
            <a href="addPatient.jsp" class="btn add-btn"><i class="bi bi-person-plus"></i> Add New Patient</a>
        </div>

        <%
            PatientDAO dao = new PatientDAO();
            List<Patient> list = dao.getAllPatients();
        %>

        <%
            if (list == null || list.isEmpty()) {
        %>
            <div class="alert alert-warning text-center mt-4">
                <i class="bi bi-info-circle"></i> No patients found. Add a new patient to get started.
            </div>
        <%
            } else {
        %>
            <div class="table-responsive">
                <table class="table table-hover text-center align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Diagnosis</th>
                            <th>Assigned Doctor</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Patient p : list) { %>
                            <tr>
                                <td><%= p.getId() %></td>
                                <td><%= p.getName() %></td>
                                <td><%= p.getAge() %></td>
                                <td><%= p.getGender() %></td>
                                <td><%= p.getDiagnosis() %></td>
                                <td><%= p.getAssignedDoctor() %></td>
                                <td>
                                    <a href="viewObservations.jsp?pid=<%= p.getId() %>" class="btn btn-sm btn-primary">
                                        <i class="bi bi-clipboard2-pulse"></i> View Observations
                                    </a>
                                    <a href="addObservation.jsp?pid=<%= p.getId() %>" class="btn btn-sm btn-success">
                                        <i class="bi bi-plus-circle"></i> Add Observation
                                    </a>
                                    <a href="editPatient.jsp?id=<%= p.getId() %>" class="btn btn-sm btn-warning">
                                        <i class="bi bi-pencil"></i> Edit
                                    </a>
                                    <a href="PatientServlet?action=delete&id=<%= p.getId() %>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Are you sure you want to delete this patient?')">
                                       <i class="bi bi-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <%
            }
        %>
    </div>
</div>

</body>
</html>
