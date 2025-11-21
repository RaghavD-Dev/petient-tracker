<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hospital.dao.ObservationDAO, com.hospital.model.Observation" %>
<%
    String pid = request.getParameter("pid");
    int patientId = (pid == null || pid.isEmpty()) ? 0 : Integer.parseInt(pid);

    ObservationDAO dao = new ObservationDAO();
    List<Observation> list = dao.getByPatient(patientId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Patient Observations | Hospital Tracker</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <style>
    body {
      background-color: #f4f7fb;
      font-family: 'Poppins', sans-serif;
    }

    .navbar {
      background-color: #0078d7;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .navbar-brand {
      color: white !important;
      font-weight: 600;
    }

    .container {
      margin-top: 80px;
    }

    .card {
      background: #fff;
      border: none;
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    }

    h2 {
      color: #0078d7;
      font-weight: 600;
      text-align: center;
      margin-bottom: 25px;
    }

    .table th {
      background-color: #0078d7;
      color: white;
      font-weight: 500;
      text-align: center;
    }

    .table-hover tbody tr:hover {
      background-color: #e9f3ff;
    }

    .btn {
      border-radius: 8px;
      font-weight: 500;
      transition: 0.3s;
    }

    .btn-primary {
      background-color: #0078d7;
      border: none;
    }

    .btn-primary:hover {
      background-color: #005bb5;
    }

    .btn-add {
      background-color: #28a745;
      color: white;
      border: none;
    }

    .btn-add:hover {
      background-color: #218838;
    }

    .btn-warning {
      background-color: #ffc107;
      border: none;
      color: black;
    }

    .btn-danger {
      background-color: #dc3545;
      border: none;
    }

    .top-actions {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .footer {
      text-align: center;
      margin-top: 40px;
      color: #999;
      font-size: 14px;
    }

  </style>
</head>
<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid px-5">
    <a class="navbar-brand" href="dashboard.jsp"><i class="bi bi-hospital"></i> Hospital Tracker</a>
    <div>
      <a href="viewPatients.jsp" class="btn btn-light btn-sm">
        <i class="bi bi-arrow-left-circle"></i> Back to Patients
      </a>
    </div>
  </div>
</nav>

<!-- ✅ Main Card -->
<div class="container">
  <div class="card">
    <div class="top-actions">
      <h2><i class="bi bi-clipboard2-pulse"></i> Patient Daily Observations</h2>
      <a href="addObservation.jsp?pid=<%= patientId %>" class="btn btn-add">
        <i class="bi bi-plus-circle"></i> Add Observation
      </a>
    </div>

    <!-- ✅ Table -->
    <div class="table-responsive">
      <table class="table table-hover table-bordered align-middle text-center">
        <thead>
          <tr>
            <th>ID</th>
            <th>Observed At</th>
            <th>Temperature (°C)</th>
            <th>Systolic BP</th>
            <th>Diastolic BP</th>
            <th>Heart Rate</th>
            <th>Notes</th>
            <th>Created By</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <%
            if (list == null || list.isEmpty()) {
          %>
              <tr><td colspan="9" class="text-muted py-3">No observations recorded yet.</td></tr>
          <%
            } else {
              for (Observation o : list) {
          %>
              <tr>
                <td><%= o.getId() %></td>
                <td><%= o.getObservedAt() %></td>
                <td><%= o.getTemperature() %></td>
                <td><%= o.getSystolicBp() %></td>
                <td><%= o.getDiastolicBp() %></td>
                <td><%= o.getHeartRate() %></td>
                <td><%= o.getNotes() %></td>
                <td><%= o.getCreatedBy() %></td>
                <td>
                  <a href="editObservation.jsp?id=<%= o.getId() %>" class="btn btn-warning btn-sm">
                    <i class="bi bi-pencil"></i> Edit
                  </a>
                  <a href="#" onclick="confirmDelete(<%= o.getId() %>, <%= patientId %>)" class="btn btn-danger btn-sm">
                    <i class="bi bi-trash"></i> Delete
                  </a>
                </td>
              </tr>
          <%
              }
            }
          %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- ✅ Delete Confirmation -->
<script>
function confirmDelete(id, patientId) {
  Swal.fire({
    title: 'Are you sure?',
    text: "This observation will be deleted permanently!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, delete it!'
  }).then((result) => {
    if (result.isConfirmed) {
      window.location.href = 'ObservationServlet?action=delete&id=' + id + '&patientId=' + patientId;
    }
  });
}
</script>

<div class="footer">
  © <%= java.time.Year.now() %> Hospital Patient Tracking System — All Rights Reserved
</div>

</body>
</html>
