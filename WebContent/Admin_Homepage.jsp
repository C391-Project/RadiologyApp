
<html>
<head>
<meta charset="UTF-8">
<title>Administrator Homepage</title>
</head>
<body>
	<h1>Administrator's Homepage </h1>
	
	<%
	//get the cookies to check the user privilege 
	
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
			session.setAttribute("error", "Username Error.");
			response.sendRedirect("login.jsp");
			//out.println("Username error, redireting to login page.");
			//response.setHeader("Refresh", "3; URL=login.jsp");	
		}
	
		else if(usertype.equals("Admin"))
			{
				/* out.println("<h3>Login successful!</h3>"); */
			}
			else
			{
				session.setAttribute("error", "Access denied, redireted to login page.");
				response.sendRedirect("login.jsp");
				//out.println("<t1><b>Access denied, redireting to login page.</b></t1>");
				//response.setHeader("Refresh", "1; URL=login.jsp");	
			}
		
			
			//response.sendRedirect("login.html");
		
			
	%>
	<p>
		<a href="editprofilepass.jsp"><button>Edit My Profile and Password</button></a>
	</p>
	<p>
		<a href="/RadiologyApp/usermanage"><button>Manage Users</button></a>
	</p>	
	<p>
		<a href="/RadiologyApp/search.jsp"><button>Search</button></a>
	</p>
	<p>
		<a href="/RadiologyApp/report.jsp"><button>Generate Report</button></a>
	</p>
	<p>
		<a href="/RadiologyApp/LogoutServlet"><button>Logout</button></a>
	</p>
</body>
</html>