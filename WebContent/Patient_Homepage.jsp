
<html>
<head>
<meta charset="UTF-8">
<title>Patient's Home-page</title>
</head>
<body>
	<h1>Patient's Homepage </h1>
	
		<%@include file="header.html" %>
	
	<%
	
	String userName = null;
	String usertype=null;
	String fulltype=null;
	Integer person_id=0;
	
	person_id=(Integer)session.getAttribute("person_id");
	userName=session.getAttribute("username").toString().trim();
	usertype=session.getAttribute("usertype").toString().trim();
	fulltype=session.getAttribute("fulltype").toString().trim();
	
	out.println("Your person ID:"+person_id);
	%>
	
	<h3>Hi <%=userName %>.</h3>
	<h3>Your usertype is <%=fulltype %>.</h3>
	
	<%
	//user power contronl, only admin can get access to this page
		if(userName == null)
		{
			session.setAttribute("error", "Username Error, redireted to login page.");
			response.sendRedirect("login.jsp");
		}

		if(usertype.equals("p"))
		{
			//out.println("<h3>Login successful!</h3>");
		}
		else
		{
			session.setAttribute("error", "Access denied, redireted to login page.");
			response.sendRedirect("login.jsp");

		}
			
	%>
	
	
</body>
</html>