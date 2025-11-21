<%
  com.hospital.model.User user = (com.hospital.model.User) session.getAttribute("user");
  if (user == null) {
      response.sendRedirect("login.jsp?error=login_required");
      return;
  }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>