
<html>
<head>
<meta charset="UTF-8">
<title>Doctor's Home-page</title>
</head>
<body>
	<h1>Doctor's Homepage </h1>
	
		<%@include file="header.html" %>
	
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
			session.setAttribute("error", "Username Error, redireted to login page.");
			response.sendRedirect("login.jsp");
			/* out.println("Username error, redireting to login page.");
			response.setHeader("Refresh", "3; URL=login.jsp");	 */
		}
			
			//response.sendRedirect("login.html");
		if(usertype.equals("Doctor"))
		{
			//out.println("<h3>Login successful!</h3>");
		}
		else
		{
			session.setAttribute("error", "Access denied, redireted to login page.");
			response.sendRedirect("login.jsp");
			/* out.println("<t1><b>Access denied, redireting to login page.</b></t1>");
			response.setHeader("Refresh", "3; URL=login.jsp");	
 */		}
			
	%>

	
	
</body>
</html>