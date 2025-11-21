<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register | Hospital Tracker</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <style>
    body {
      background: linear-gradient(135deg, #e3f2fd, #bbdefb);
      font-family: 'Poppins', sans-serif;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0;
    }

    .register-card {
      background: #fff;
      border-radius: 20px;
      padding: 40px;
      width: 420px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.1);
      animation: fadeIn 0.8s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .register-card h2 {
      text-align: center;
      font-weight: 600;
      margin-bottom: 25px;
      color: #0078d7;
    }

    .form-control, .form-select {
      border-radius: 10px;
      border: 1px solid #ccc;
      padding: 10px;
      transition: 0.3s;
    }

    .form-control:focus, .form-select:focus {
      border-color: #0078d7;
      box-shadow: 0 0 5px rgba(0,120,215,0.3);
    }

    .btn-register {
      background-color: #0078d7;
      color: white;
      border-radius: 10px;
      width: 100%;
      font-weight: 500;
      padding: 10px;
      transition: 0.3s;
      border: none;
    }

    .btn-register:hover {
      background-color: #005bb5;
      transform: translateY(-2px);
    }

    .text-center p {
      font-size: 14px;
      color: #555;
    }

    .text-center a {
      color: #0078d7;
      font-weight: 500;
      text-decoration: none;
    }

    .text-center a:hover {
      text-decoration: underline;
    }

    .icon {
      font-size: 3rem;
      display: block;
      text-align: center;
      color: #0078d7;
      margin-bottom: 10px;
    }

  </style>
</head>
<body>

<div class="register-card">
  <i class="bi bi-person-plus-fill icon"></i>
  <h2>Create Account</h2>

  <!-- ✅ Registration Form -->
  <form action="RegisterServlet" method="post">
    <div class="mb-3">
      <input type="text" name="username" class="form-control" placeholder="👤 Full Name" required>
    </div>
    <div class="mb-3">
      <input type="email" name="email" class="form-control" placeholder="📧 Email Address" required>
    </div>
    <div class="mb-3">
      <input type="password" name="password" id="password" class="form-control" placeholder="🔒 Password" required>
    </div>
    <div class="mb-3">
      <select name="role" class="form-select">
        <option value="Doctor">Doctor</option>
        <option value="Nurse">Nurse</option>
        <option value="Admin">Admin</option>
      </select>
    </div>
    <button type="submit" class="btn btn-register">Register</button>
  </form>

  <div class="text-center mt-3">
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
  </div>
</div>

<!-- ✅ SweetAlert Feedback -->
<%
  String msg = request.getParameter("msg");
  if ("success".equals(msg)) {
%>
  <script>
    Swal.fire({
      icon: 'success',
      title: '🎉 Registration Successful!',
      text: 'You can now log in to your account.',
      timer: 1800,
      showConfirmButton: false
    }).then(() => {
      window.location.href = 'login.jsp?msg=registered';
    });
  </script>
<%
  } else if ("exists".equals(msg)) {
%>
  <script>
    Swal.fire({
      icon: 'warning',
      title: 'Username Already Exists 😕',
      text: 'Please choose a different email or username.',
      confirmButtonColor: '#ffc107'
    });
  </script>
<%
  } else if ("error".equals(msg)) {
%>
  <script>
    Swal.fire({
      icon: 'error',
      title: 'Registration Failed ❌',
      text: 'Something went wrong. Please try again later.'
    });
  </script>
<%
  }
%>

</body>
</html>
