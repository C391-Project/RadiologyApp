<% String pageName = "dataanalysis"; %>
<%@ page import="java.sql.*, database.JDBC"%>
<%
//The purpose of this file is to view the 
//datacube we created in data-analysis.jsp

Connection conn = null;
		
Statement stmt = null;
ResultSet rset = null;

conn = JDBC.connect();



JDBC.closeConnection();
%>