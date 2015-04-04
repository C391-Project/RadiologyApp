<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.JDBC"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>report generating</title>
<!--Adapted from http://jqueryui.com/datepicker/#date-range-->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<style>
.from {
	
}

.to {
	
}
</style>
<script>
	$(function() {
		$(".from").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			changeYear : true,
			onClose : function(selectedDate) {
				$(".to").datepicker("option", "minDate", selectedDate);
			}
		});
		$(".to").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			changeYear : true,
			onClose : function(selectedDate) {
				$(".from").datepicker("option", "maxDate", selectedDate);
			}
		});
	});
</script>
</HEAD>
<BODY>
 
	<%!
		public Connection getConnection(String oracleId,String oraclePassword){
			return JDBC.connect();
		}
	%>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.*"%>

	<H1>Report generating module</H1>
	
	<a href="/RadiologyApp/user-manual.jsp#report-generating-module"><button>View Help</button></a>

	<FORM NAME="report_generate_form" ACTION="report.jsp" METHOD="post">
		<TABLE>
			<TR>
				<TD>Diagnosis: </TD>
				<TD><INPUT TYPE="text" NAME="diagnosis" VALUE=""></TD>
			</TR>
			<TR>
				<TD>Time period(MM-DD-YYYY): </TD>
				<TD><label for="from">From</label> <INPUT TYPE="text"
					class="from" NAME="from" /></TD>
				<TD><label for="to">To</label> <INPUT TYPE="text" class="to"
					NAME="to" /></TD>

			</TR>

		</TABLE>
		
			<input TYPE="submit" NAME="CommitGenerate" VALUE="Generate"><br>
		

		<%
          Connection con=null;
          if (request.getParameter("CommitGenerate") != null) {

            if(!(request.getParameter("diagnosis").equals("") ||
              		request.getParameter("from").equals("") ||
              		request.getParameter("to").equals(""))) {
				String oracleId=(String)session.getAttribute("dbusername");
				String oraclePassword=(String)session.getAttribute("dbpassword");
				String from = (String)request.getParameter("from");
				String to = (String)request.getParameter("to");
				String diagnosis = (String)request.getParameter("diagnosis");
				try {
					con = getConnection(oracleId,oraclePassword);
					if(con==null) {
						out.println("<p><b>Unable to Connect Oracle DB!</b></p>");
						out.println("<p><b>Invalid UserName or Password!</b></p>");
						out.println("<p><b>Press RETURN to the previous page.</b></p>");
						out.println("<FORM NAME='ConnectFailForm' ACTION='Connector.html' METHOD='get'>");
						out.println("    <CENTER><INPUT TYPE='submit' NAME='CONNECTION_FAIL' VALUE='RETURN'></CENTER>");
						out.println("</FORM>");
					} else {
						try {
							PreparedStatement setTimeFormat = con.prepareStatement("alter SESSION set NLS_DATE_FORMAT = 'MM/DD/YYYY'");
							setTimeFormat.executeQuery();
							PreparedStatement doGenerate = con.prepareStatement("SELECT first_name, last_name, address, phone, min(test_date) FROM persons p, radiology_record r WHERE r.patient_id = p.person_id AND r.diagnosis = ? AND r.test_date >= to_date(?,'MM/DD/YYYY') AND r.test_date <= to_date(?,'MM/DD/YYYY') Group by patient_id, first_name, last_name, address, phone");
							doGenerate.setString(1, diagnosis);
							doGenerate.setString(2, from);
							doGenerate.setString(3, to);
							ResultSet rset2 = doGenerate.executeQuery();
						  	out.println("<br>");
						  	out.println("The Report is:");
						  	out.println("<br>");
							out.println("All patients with "+diagnosis+" diagnosis during "+from+" and "+to+":");
							out.println("<table border=1>");
							out.println("<tr>");
							out.println("<th>Patient Name</th>");
							out.println("<th>Address</th>");
							out.println("<th>Phone</th>");
							out.println("<th>Test Date</th>");
							out.println("</tr>");
							while(rset2.next()){
								out.println("<tr>");
								out.println("<td>"); 
								out.println(rset2.getString(1)+" "+rset2.getString(2));
								out.println("</td>");
								out.println("<td>"); 
								out.println(rset2.getString(3)); 
								out.println("</td>");
								out.println("<td>");
								out.println(rset2.getString(4));
								out.println("</td>");
								out.println("<td>");
								out.println(rset2.getDate(5));
								out.println("</td>");
								out.println("</tr>");
							}
							out.println("</table>");
						} catch(SQLException e) {
							out.println("SQLException: " +
							e.getMessage());
							con.rollback();
						}
					}
				} catch (SQLException e) {
					out.println("SQLException: " +
							e.getMessage());
				} finally {
					if (con != null) {
						con.close();
					}
				}
			} else {
              out.println("<br><b>Please fill ALL information</b>");
          	}
		}
      %>
	<p>
		<a href="Admin_Homepage.jsp"><button>Return</button></a>
	</p>
</BODY>
</HTML>
