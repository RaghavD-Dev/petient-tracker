<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login | Hospital Tracker</title>
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

    .login-card {
      background: #fff;
      border-radius: 20px;
      padding: 40px;
      width: 400px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.1);
      animation: fadeIn 0.8s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .login-card h2 {
      text-align: center;
      font-weight: 600;
      margin-bottom: 25px;
      color: #0078d7;
    }

    .form-control {
      border-radius: 10px;
      border: 1px solid #ccc;
      padding: 10px;
      transition: 0.3s;
    }

    .form-control:focus {
      border-color: #0078d7;
      box-shadow: 0 0 5px rgba(0,120,215,0.3);
    }

    .btn-login {
      background-color: #0078d7;
      color: white;
      border-radius: 10px;
      width: 100%;
      font-weight: 500;
      padding: 10px;
      transition: 0.3s;
      border: none;
    }

    .btn-login:hover {
      background-color: #005bb5;
      transform: translateY(-2px);
    }

    .register-text {
      text-align: center;
      margin-top: 15px;
      color: #555;
    }

    .register-text a {
      color: #0078d7;
      font-weight: 500;
      text-decoration: none;
    }

    .register-text a:hover {
      text-decoration: underline;
    }

    .footer {
      margin-top: 10px;
      font-size: 13px;
      text-align: center;
      color: #888;
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

<div class="login-card">
  <i class="bi bi-hospital icon"></i>
  <h2>Hospital Login</h2>

  <!-- ✅ FORM that calls LoginServlet -->
  <form action="LoginServlet" method="post">
    <div class="mb-3">
      <input type="email" name="email" class="form-control" placeholder="📧 Email Address" required>
    </div>
    <div class="mb-3">
      <input type="password" name="password" class="form-control" placeholder="🔒 Password" required>
    </div>
    <button type="submit" class="btn btn-login">Login</button>
  </form>

  <div class="register-text">
    <p>Don’t have an account? <a href="register.jsp">Register here</a></p>
  </div>
</div>

<%
  // Handle feedback messages
  String msg = request.getParameter("msg");
  String error = request.getParameter("error");

  if ("invalid".equals(error)) {
%>
  <script>
    Swal.fire({
      icon: 'error',
      title: 'Invalid Login!',
      text: 'Email or password is incorrect.',
      confirmButtonColor: '#0078d7'
    });
  </script>
<%
  } else if ("logout".equals(msg)) {
%>
  <script>
    Swal.fire({
      icon: 'info',
      title: 'Logged Out',
      text: 'You have successfully logged out.',
      timer: 1500,
      showConfirmButton: false
    });
  </script>
<%
  } else if ("registered".equals(msg)) {
%>
  <script>
    Swal.fire({
      icon: 'success',
      title: 'Registration Successful!',
      text: 'You can now login with your credentials.',
      timer: 2000,
      showConfirmButton: false
    });
  </script>
<%
  }
%>

</body>
</html>
