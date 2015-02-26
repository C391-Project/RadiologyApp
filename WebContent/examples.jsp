<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test</title>
</head>
<body>
	<!-- Playing with Dates -->
	<% java.util.Date date = new java.util.Date(); %>
	<p>Hello! The time is now <%= date %></p>
	<p>The time is also now <% out.println(String.valueOf(date)); %>
	
	<!-- Java iterators -->
	<p>Let's iterate a list:</p>
	<ul>
		<% for(int i = 1; i <= 10; i++) { %>
			<li><%= i %></li>
		<% } %>
	</ul>
	
	<!-- Function declarations (note the "!") -->
	<%! 
		Date getDate() {
			return new Date();
		}
	%>
	<p>The date is now <%= getDate() %></p>
</body>
</html>