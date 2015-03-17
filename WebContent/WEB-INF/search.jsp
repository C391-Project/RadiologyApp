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
<%@ include file="dbinterface.jsp" %>
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

<%@ page import="java.sql.*"%>
<%
	//When submit is hit get all of its fields 
	int ID = (Integer) session.getAttribute("id");
	if (request.getParameter("Submit") != null) {
		String keywords[] = (request.getParameter("KEYWORDS")).trim().split("\\s+");
		String dateFrom = (request.getParameter("FROM")).trim();
		String dateTo = (request.getParameter("TO")).trim();
		String orderBy = (request.getParameter("ORDER")).trim();
		//establish the connection to the underlying database
		Connection conn = null;
%>
<% //TODO //DATABASECONNECT %>
<%
	//select the names of patient,doctor and radiologist, the date and the images with the keywords and date we input.
	//the user's class will be checked and only the legal result will be displayed
	Statement stmt = null;
	ResultSet rset = null;
	//I think this will work I have no idea. I wrote it and tested it with SQLplus in mind
	//but I have not tested it on here yet
	String sql = "SELECT r.record_id, image_id, CONCAT(p1.first_name, CONCAT(' ', p1.last_name))," +
	" CONCAT(p2.first_name, CONCAT(' ', p2.last_name))," +
	" CONCAT(p3.first_name, CONCAT(' ', p3.last_name))," +
	" test_type, TO_CHAR(prescribing_date, 'DD-MON-YYYY'), TO_CHAR(test_date, 'DD-MON-YYYY'), diagnosis, description" +
	" FROM radiology_record r LEFT OUTER JOIN pacs_images i ON r.record_id = i.record_id, persons p1, persons p2, persons p3" +
	" WHERE p1.person_id = r.patient_id AND p2.person_id = r.doctor_id AND p3.person_id = r.radiologist_id";
	
	//TODO GET THE USER INFORMATION FROM THE db AND PARSE ALL OF THAT STUFF
	if (UserType.equals("r")) { sql += " AND r.radiologist_id = '" + ID + "'";}
	else if (userType.equals("d")) {sql += " AND r.doctor_id = '" + ID + "'"; }
	else if (userType.equals("p")) {sql += " AND r.patient_id = '" + ID + "'";}
	
	if (!keywords[0].isEmpty()) {
		//TODO This could wind up being very difficult
	}
	if (orderBy.equals("newest")) { sql += " test_date, record_id DESC"; }
	else if (orderBy.equals("oldest")) { sql += " test_date, record_id ASC";}
	//Ranking specification on 
	else if (keywords.length > 0) { sql += " (6*(SCORE(1)+SCORE(2)) + 3*SCORE(3) + SCORE(4)), record_id DESC"; }
	else
	//last little bit to the SQL
	sql += " record_id DESC";
	
	//Try to execute the stament
	try {
		stmt = conn.createStatement();
		rset = stmt.executeQuery(sql);
	} catch (Exception ex) {
	out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	//Close the connection
	try {
		conn.close();
	} catch (Exception ex) {
		out.println("<hr>" + ex.getMessage() + "<hr>");
	}
}
%>
</body>
</html>