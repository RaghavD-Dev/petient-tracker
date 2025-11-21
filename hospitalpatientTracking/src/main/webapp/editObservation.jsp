<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.dao.ObservationDAO, com.hospital.model.Observation" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Observation</title>
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
    }
  </style>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ObservationDAO dao = new ObservationDAO();
    Observation o = dao.getById(id);
%>

<div class="card">
  <h3 class="text-center text-primary mb-4">✏️ Edit Observation</h3>

  <form action="ObservationServlet" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="<%= o.getId() %>">
    <input type="hidden" name="patientId" value="<%= o.getPatientId() %>">

    <!-- Temperature -->
    <div class="mb-3">
      <label class="form-label">Temperature (°C)</label>
      <input type="number" step="0.1" name="temperature" value="<%= o.getTemperature() %>" class="form-control" required>
    </div>

    <!-- Blood Pressure -->
    <div class="row mb-3">
      <div class="col">
        <label class="form-label">Systolic BP (mmHg)</label>
        <input type="number" name="systolic_bp" value="<%= o.getSystolicBp() %>" class="form-control" required>
      </div>
      <div class="col">
        <label class="form-label">Diastolic BP (mmHg)</label>
        <input type="number" name="diastolic_bp" value="<%= o.getDiastolicBp() %>" class="form-control" required>
      </div>
    </div>

    <!-- Heart Rate -->
    <div class="mb-3">
      <label class="form-label">Heart Rate (bpm)</label>
      <input type="number" name="heartRate" value="<%= o.getHeartRate() %>" class="form-control" required>
    </div>

    <!-- Notes -->
    <div class="mb-3">
      <label class="form-label">Notes</label>
      <textarea name="notes" class="form-control" rows="3"><%= o.getNotes() %></textarea>
    </div>

    <!-- Buttons -->
    <button type="submit" class="btn btn-primary w-100 mb-2">💾 Update Observation</button>
    <a href="viewObservations.jsp?pid=<%= o.getPatientId() %>" class="btn btn-secondary w-100">⬅ Back to List</a>
  </form>
</div>

</body>
</html>
