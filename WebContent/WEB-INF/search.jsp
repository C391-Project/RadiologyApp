<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>

<% String pageName = "search"; %>
<%@ include file="menu.jsp" %>
<div class="container">
	<form name="searchForm" method="post" role="form">
	<h1>Search</h1>
	<input type="text" name="KEYWORDS" size="100" placeholder="Keywords...">
	<BR>
		From: <input type="text" name="FROM" size="12" maxlength="11" placeholder="DD-MMM-YYYY">
		To: <input type="text" name="TO" size="12" maxlength="11" placeholder="DD-MMM-YYYY">
	<BR>
		Ordered by: <select name="ORDER">
		<option value="newest">Newest</option>
		<option value="oldest">Oldest</option>
		<option value="rank">Rank</option>
	</select>
	<BR>
		<button type="submit" name="Submit">Fetch</button>
	</form>
</div>