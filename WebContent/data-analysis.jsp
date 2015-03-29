<% String pageName = "dataanalysis"; %>
<%@ page import="java.sql.*,java.util.ArrayList, database.JDBC"%>
<%
// TODO : ONLY THE ADMIN CAN SEE THIS PAGE
// TODO : VIEW THE CRAP THAT I SPAT OUT THAT PROBABLY DOESNT WORK AND WILL
//		  NEED 20 YEARS OF DEBUGGING
//This part is only to create the data cube
//The user may select none or all for the images on testtype and patient
//as well as the user can select a time style 
Connection conn = null;
		
Statement stmt = null;
ResultSet rset = null;
ResultSet rsetPIDS = null;
ResultSet rsetTEST_TYPES = null;
//These lists are for our menu
ArrayList patientIDs = new ArrayList();
ArrayList patientNames = new ArrayList();
ArrayList testTypes = new ArrayList();

conn = JDBC.connect();
//I recieved help on the SQL portion from these sources 
//LAB TA
//http://www.w3schools.com/sql/sql_view.asp - Basic info on views 
//http://luscar.cs.ualberta.ca:8080/yuan/servlet/SimpleQuery - A uselful tool to quickly test sql
//Reminder to dig out the rest of my sources

//A view of the patient
String sqlCreatePatientView = "CREATE OR REPLACE FORCE VIEW PATIENT (PATIENT_ID) AS SELECT distinct patient_id FROM radiology_record";
//A view of the testtypes
String sqlCreateTestTypeView = "CREATE OR REPLACE FORCE VIEW TEST_TYPE (TEST_TYPE) AS SELECT distinct TEST_TYPE FROM radiology_record ";
//A view of times
String sqlCreateTimeView = "create or replace VIEW time_id as SELECT ROW_NUMBER() OVER (ORDER BY year) as time_id,week,month,year as year"
				+ " FROM (select distinct to_char(TEST_DATE, 'IW') as week,to_char(TEST_DATE, 'MON') as month,to_char(TEST_DATE, 'YYYY')" 
				+ "as year from radiology_record) ";
//A view of the images
String sqlCreateImageView = "create or replace view patient_number_image as select distinct p.PATIENT_ID,t.TEST_TYPE,COUNT(pi.image_id) as num,ti.time_id "
				+ "FROM PATIENT p, TEST_TYPE t,RADIOLOGY_RECORD rr, PACS_IMAGES pi,TIME_ID ti where p.PATIENT_ID = rr.PATIENT_ID AND t.TEST_TYPE"
				+ "= rr.TEST_TYPE AND pi.record_id = rr.record_id AND ti.week = to_char(rr.TEST_DATE,'IW') AND ti.year = to_char(rr.TEST_DATE,'YYYY')"
				+ "GROUP BY p.PATIENT_ID,t.TEST_TYPE,ti.time_id ";

//Create a table for images
String sqlDropImageTable = "DROP TABLE PATIENT_NUM_IMAGE_TABLE ";
String sqlCreateImageTable = "CREATE TABLE PATIENT_NUM_IMAGE_TABLE(PATIENT_ID varchar(24),TEST_TYPE varchar(24),TIME_ID int, NUM int default 0) ";
String sqlInsertImageData = "INSERT INTO PATIENT_NUM_IMAGE_TABLE (PATIENT_ID,TEST_TYPE,TIME_ID) "
							+ "SELECT p.PATIENT_ID,t.TEST_TYPE,ti.TIME_ID FROM PATIENT p,TEST_TYPE t,TIME_ID ti ";
//Merge the view into our table 
String sqlMergeTables = "Merge into PATIENT_NUM_IMAGE_TABLE p2 USING PATIENT_NUMBER_IMAGE p1 ON "
					+ "(p2.TEST_TYPE = p1.TEST_TYPE AND p2.PATIENT_ID = p1.PATIENT_ID AND p2.TIME_ID = p1.TIME_ID) "
					+ " WHEN MATCHED THEN UPDATE SET NUM = P1.NUM";
//get the list of patients and testtype
//These are for the selection menu
String sqlpersonIDs = "SELECT p.person_id, CONCAT(p.first_name, CONCAT(' ', p.last_name))" 
				+ " FROM persons p, PATIENT p2" 
				+ " WHERE p.person_id = p2.PATIENT_ID";
String sqltesttypes = "SELECT t.TEST_TYPE FROM TEST_TYPE t";
		
//Try to do all the statements 
try {
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sqlCreatePatientView);
	rset = stmt.executeQuery(sqlCreateTestTypeView);
	rset = stmt.executeQuery(sqlCreateTimeView);
	rset = stmt.executeQuery(sqlCreateImageView);
	try {
		rset = stmt.executeQuery(sqlDropImageTable);
	} catch (Exception ex) { 
		out.println("<hr>" + ex.getMessage() + "<hr>");
		//do nothing this only means the table didn't exist
	}
	rset = stmt.executeQuery(sqlCreateImageTable);
	//rset = stmt.executeQuery(sqlInsertImageData);
	//rset = stmt.executeQuery(sqlMergeTables);
	rsetPIDS = stmt.executeQuery(sqlpersonIDs);
	//Parse the results into lists for our menu
	while(rsetPIDS != null && rsetPIDS.next()) {
		patientIDs.add(rsetPIDS.getInt("person_id"));
		patientNames.add(rsetPIDS.getString(2));
		//out.println(rsetPIDS.getString("person_id"));
	}
	
	stmt.executeQuery("commit");
	rsetTEST_TYPES = stmt.executeQuery(sqltesttypes);
	//Parse the results of the test types for our menu
	while (rsetTEST_TYPES != null && rsetTEST_TYPES.next()) {
		testTypes.add(rsetTEST_TYPES.getString("TEST_TYPE"));
	}

} catch (Exception ex) {
	out.println("<hr>" + ex.getMessage() + "<hr>");
} 
//Done, Close the connection
JDBC.closeConnection();
%>
<div class="container">
	<form name="personForm" action="viewDataCube.jsp" method="post" role="form">
	<h1>Data Analysis</h1>
	PATIENT :
	<br>
	<select name="PATIENTID" style="width:220px">
		<option value = "NONE"> NONE </option>
		<option value = "ALL"> ALL </option>
	<%
		//Read the list of patients 
		for (int i = 0; i < patientIDs.size()-1; i++) {
			out.println("<option value = " + patientIDs.get(i) + ">" + patientNames.get(i) + "</option>");
		}
	%>
	</select>
	<br>
	TEST TYPE :
	<br>
	<select name="TESTTYPE" style="width:220px">
		<option value = "NONE"> NONE </option>
		<option value = "ALL"> ALL </option>
	<%
		//Read the list of test types
		for (int i = 0; i < testTypes.size(); i++) {
			out.println("<option value = " + testTypes.get(i) + ">" + testTypes.get(i) + "</option>");
		}
	%>
	</select>
	<br>
	TIME :
	<br>
	<select name="TIME" style="width:220px">
		<option value = "WEEK"> WEEKLY </option>
		<option value = "MONTH"> MONTHLY </option>
		<option value = "YEAR"> YEARLY </option>
	</select>
	Year:
	<select id="YEAR" name="YEAR" />
		<option value = "ALL">ALL</option>
	<%String year = "";
	for(int i=1900;i<2200;i++) {
		year = Integer.toString(i);
		out.println("<option value = \""+ year +"\">"+i+"</option>");
	}
	%>
	</select>
	<br>
	<br>
	<br>
	<button type="submit" name="Submit">START</button>
</form>
</div>
</body>
</html>