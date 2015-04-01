
<html>
<head>
<meta charset="UTF-8">
<title>Administrator Homepage</title>
</head>
<body>
	<h1>Administrator's Homepage </h1>
	
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
	
	//get the cookies to check the user privilege 
/* 	out.println("Your username:"+userName+"/n");
	out.println("Your usertype:"+usertype+"/n"); */
 /* 	Cookie[] cookies = request.getCookies();
	if(cookies !=null)
	{
		for(Cookie cookie : cookies)
		{
    		if(cookie.getName().equals("user")) 
    			userName = cookie.getValue();
    		if(cookie.getName().equals("usertype")) 
    			usertype = cookie.getValue();
		}
	}  */
	%>
	
	<h3>Hi <%=userName%></h3>
	<h3>Your usertype is <%=fulltype%></h3>
	
<%
 	//user power contronl, only admin can get access to this page
	
		if(userName == null)
		{
			session.setAttribute("error", "Username Error.");
			response.sendRedirect("login.jsp");
			//out.println("Username error, redireting to login page.");
			//response.setHeader("Refresh", "3; URL=login.jsp");	
		}
	
		else if(usertype.equals("a"))
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
		<a href="/RadiologyApp/usermanage"><button>Manage Users</button></a>
	</p>	
	
	<p>
		<a href="/RadiologyApp/report.jsp"><button>Generate Report</button></a>
	</p>
	<p>
		<a href="/RadiologyApp/data-analysis.jsp"><button>Data Analysis</button></a>
	</p>

</body>
</html>