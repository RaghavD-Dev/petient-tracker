<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.User" %>

<%
    // 🔒 Ensure User is Logged In
    User loggedUser = (User) session.getAttribute("user");
    if (loggedUser == null) {
        response.sendRedirect("login.jsp?error=login_required");
        return;
    }

    // Get patient ID from query parameter
    String pid = request.getParameter("pid");
    int patientId = (pid == null || pid.isEmpty()) ? 0 : Integer.parseInt(pid);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add Observation</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    body {
      background: linear-gradient(135deg, #89f7fe, #66a6ff);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      font-family: 'Poppins', sans-serif;
    }
    .card {
      width: 520px;
      border-radius: 20px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.2);
      padding: 30px;
      background: #fff;
    }
    h3 {
      color: #007bff;
      text-align: center;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

<div class="card">
  <h3>Add New Observation</h3>

  <form action="ObservationServlet" method="post">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="patientId" value="<%= patientId %>">

    <!-- Temperature -->
    <div class="mb-3">
      <label class="form-label">Temperature (°C)</label>
      <input type="number" step="0.1" name="temperature" class="form-control" placeholder="e.g. 37.5" required>
    </div>

    <!-- Blood Pressure -->
    <div class="row mb-3">
      <div class="col">
        <label class="form-label">Systolic BP (mmHg)</label>
        <input type="number" name="systolic_bp" class="form-control" placeholder="e.g. 120" required>
      </div>
      <div class="col">
        <label class="form-label">Diastolic BP (mmHg)</label>
        <input type="number" name="diastolic_bp" class="form-control" placeholder="e.g. 80" required>
      </div>
    </div>

    <!-- Heart Rate -->
    <div class="mb-3">
      <label class="form-label">Heart Rate (bpm)</label>
      <input type="number" name="heartRate" class="form-control" placeholder="e.g. 75" required>
    </div>

    <!-- Notes -->
    <div class="mb-3">
      <label class="form-label">Notes</label>
      <textarea name="notes" class="form-control" rows="3" placeholder="Additional observations..."></textarea>
    </div>

    <!-- Buttons -->
    <button type="submit" class="btn btn-primary w-100 mb-2">💾 Save Observation</button>
    <a href="viewObservations.jsp?pid=<%= patientId %>" class="btn btn-secondary w-100">⬅ Back to Observations</a>
  </form>
</div>

<!-- ✅ Optional: SweetAlert on Success -->
<%
  String msg = request.getParameter("msg");
  if (msg != null && msg.equals("added")) {
%>
  <script>
    Swal.fire("✅ Success!", "Observation added successfully!", "success");
  </script>
<%
  }
%>

</body>
</html>
