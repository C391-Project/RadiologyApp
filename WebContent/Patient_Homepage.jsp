
<html>
<head>
<meta charset="UTF-8">
<title>Patient's Home-page</title>
</head>
<body>
	<h1>Patient's Homepage </h1>
	
	<%
	String userName = null;
	String usertype=null;
	Cookie[] cookies = request.getCookies();
	if(cookies !=null)
	{
		for(Cookie cookie : cookies)
		{
    		if(cookie.getName().equals("user")) 
    			userName = cookie.getValue();
    		if(cookie.getName().equals("usertype")) 
    			usertype = cookie.getValue();
		}
	}
	%>
	
	<h3>Hi <%=userName %>.</h3>
	<h3>Your usertype is <%=usertype %>.</h3>
	
	<%
	//user power contronl, only admin can get access to this page
		if(userName == null)
		{
			out.println("Username error, redireting to login page.");
			response.setHeader("Refresh", "3; URL=login.jsp");	
		}
			
			//response.sendRedirect("login.html");
		if(usertype.equals("Patient"))
		{
			out.println("<h3>Login successful!</h3>");
		}
		else
		{
			out.println("<t1><b>Access denied, redireting to login page.</b></t1>");
			response.setHeader("Refresh", "3; URL=login.jsp");	
		}
			
	%>
	
	<form action="/RadiologyApp/search.jsp">
    		<input type="submit" value="Search">
	</form>
		
	<form action="LogoutServlet" method="post">
		<input type="submit" value="Logout" >
	</form>
</body>
</html>