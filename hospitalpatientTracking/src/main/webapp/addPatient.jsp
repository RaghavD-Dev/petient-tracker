<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admit Patient | Hospital Tracker</title>

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    body {
      background-color: #f4f8ff;
      font-family: 'Poppins', sans-serif;
    }

    .page-title {
      font-size: 28px;
      font-weight: 600;
      text-align: center;
      color: #0066ff;
      margin-top: 40px;
    }

    .form-card {
      width: 680px;
      margin: 40px auto;
      background: #ffffff;
      padding: 35px;
      border-radius: 20px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.08);
      animation: fadeIn 0.5s ease-in-out;
    }

    .form-label {
      font-weight: 500;
      color: #333;
    }

    .form-control, .form-select {
      border-radius: 12px;
      height: 46px;
      font-size: 15px;
    }

    .btn-submit {
      background-color: #0066ff;
      color: white;
      border-radius: 12px;
      padding: 12px;
      font-size: 16px;
      font-weight: 600;
      width: 100%;
      border: none;
    }

    .btn-submit:hover {
      background-color: #004bcc;
    }

    .back-btn {
      margin-top: 15px;
      display: block;
      text-align: center;
      color: #0066ff;
      text-decoration: none;
      font-weight: 500;
    }

    .back-btn:hover {
      text-decoration: underline;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>

<body>

  <div class="page-title">
      <i class="bi bi-person-plus-fill"></i> Admit New Patient
  </div>

  <div class="form-card">

    <form action="PatientServlet" method="post">

      <div class="mb-3">
        <label class="form-label"><i class="bi bi-person"></i> Patient Name</label>
        <input type="text" name="name" class="form-control" placeholder="Enter patient name" required>
      </div>

      <div class="mb-3">
        <label class="form-label"><i class="bi bi-calendar"></i> Age</label>
        <input type="number" name="age" class="form-control" placeholder="Enter age" required>
      </div>

      <div class="mb-3">
        <label class="form-label"><i class="bi bi-gender-ambiguous"></i> Gender</label>
        <select name="gender" class="form-select" required>
          <option disabled selected>Select gender</option>
          <option>Male</option>
          <option>Female</option>
          <option>Other</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label"><i class="bi bi-clipboard2-pulse"></i> Diagnosis</label>
        <input type="text" name="diagnosis" class="form-control" placeholder="Enter diagnosis" required>
      </div>

      <div class="mb-3">
        <label class="form-label"><i class="bi bi-person-badge"></i> Assigned Doctor</label>
        <input type="text" name="doctor" class="form-control" placeholder="Enter doctor name" required>
      </div>

      <button type="submit" class="btn-submit">
        <i class="bi bi-check-circle-fill"></i> Admit Patient
      </button>

    </form>

    <a href="viewPatients.jsp" class="back-btn">
      <i class="bi bi-arrow-left-circle"></i> Back to Patient List
    </a>

  </div>

</body>
</html>
