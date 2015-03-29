<% String pageName = "dataanalysis"; %>
<%@ page import="java.sql.*, java.util.ArrayList, database.JDBC"%>
<%
//The purpose of this file is to view the 
//datacube we created in data-analysis.jsp

Connection conn = null;
		
Statement stmt = null;
ResultSet rset = null;
String patient = request.getParameter("PATIENTID").trim();
String testType = request.getParameter("TESTTYPE").trim();
String timeStyle = request.getParameter("TIME").trim();
String year = request.getParameter("YEAR").trim();

//TEST WE GET WHAT WE NEED
out.println(patient);
out.println(testType);
out.println(timeStyle);
out.println(year);
//END TEST

conn = JDBC.connect();




JDBC.closeConnection();
%>