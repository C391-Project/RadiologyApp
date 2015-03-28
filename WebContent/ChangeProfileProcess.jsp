<HTML>
<HEAD>
<TITLE>Update personInfo Page</TITLE>
</HEAD>
<body>
	<%!
		public boolean cmp(String oldVal,String newVal){
			return oldVal.equals(newVal);
		}
	%>
	<%!
		public void updatePersons(Connection con,String tag,String person_id,String newValue){
			try{
				Statement s=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sqlStatement="SELECT "+tag+" FROM persons WHERE person_id="+person_id+" FOR UPDATE";
				ResultSet resSet=s.executeQuery(sqlStatement);
				while(resSet.next()){
					resSet.updateString(tag,newValue);
					resSet.updateRow();
				}
				s.executeUpdate("commit");
			}
			catch(Exception e){
				
			}
		}
	%>
	<%!
		public Boolean checkEmailUnique(Connection con,String newEmail,String person_id) throws SQLException{
			Statement s=con.createStatement();
			String sqlStatement="SELECT email FROM persons WHERE person_id<>"+person_id;
			ResultSet resSet=s.executeQuery(sqlStatement);
			while(resSet != null && resSet.next()){
				String email=(resSet.getString("email"));
				if(newEmail.equals(email)){
					return false;
				}
			}
			return true;
		}
	%>
	<%@ page import="java.sql.*"%>
	<%
		if(request.getParameter("UPDATE") != null){
			String oracleId = (String)session.getAttribute("dbusername");
			String oraclePassword = (String)session.getAttribute("dbpassword");
			Connection con = null;
			String driverName = "oracle.jdbc.driver.OracleDriver";
			boolean isconnectingfromlab=(Boolean)session.getAttribute("dblab");
			String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
			String dbhomestring="jdbc:oracle:thin:@localhost:1525:CRS";
			if(!isconnectingfromlab)
	        	dbstring=dbhomestring;
			Boolean canConnect = true;
			try{
				Class drvClass = Class.forName(driverName);
				DriverManager.registerDriver((Driver)drvClass.newInstance());
				con = DriverManager.getConnection(dbstring,oracleId,oraclePassword);
				con.setAutoCommit(true);
			}
			catch(Exception e){
				canConnect = false;
				out.println("<p><b>Unable to Connect Oracle DB!</b></p>");
				out.println("<p><b>Invalid UserName or Password!</b></p>");
				out.println("<p><b>Press RETURN to the previous page.</b></p>");
				out.println("<FORM NAME='ConnectFailForm' ACTION='oracle-login.html' METHOD='get'>");
				out.println("    <CENTER><INPUT TYPE='submit' NAME='CONNECTION_FAIL' VALUE='RETURN'></CENTER>");
				out.println("</FORM>");
        	}
			if(canConnect){
				String person_id=request.getParameter("person_id").trim();
				
				String oldFirstName=request.getParameter("oldFirstName").trim();
				String newFirstName=request.getParameter("newFirstName").trim();
				if(cmp(oldFirstName,newFirstName)==false){
					updatePersons(con,"first_name",person_id,newFirstName);
				}
				
				String oldLastName=request.getParameter("oldLastName").trim();
				String newLastName=request.getParameter("newLastName").trim();
				if(cmp(oldLastName,newLastName)==false){
					updatePersons(con,"last_name",person_id,newLastName);
				}
				
				String oldAddress=request.getParameter("oldAddress").trim();
				String newAddress=request.getParameter("newAddress").trim();
				if(cmp(oldAddress,newAddress)==false){
					updatePersons(con,"address",person_id,newAddress);
				}
				
				String oldEmail=request.getParameter("oldEmail").trim();
				String newEmail=request.getParameter("newEmail").trim();
				boolean abort=false;
				if(cmp(oldEmail,newEmail)==false){
					if(checkEmailUnique(con,newEmail,person_id)){
						updatePersons(con,"email",person_id,newEmail);
					}
					else{
						abort=true;
						out.println("<HR><CENTER>Email is not updated because your new email is the same as some one else's email.<CENTER></HR>");
						String userClass=((String)session.getAttribute("class")).toUpperCase();
						if(userClass.equals("A")){
							out.println("<FORM NAME='AbortForm' ACTION='Admin_Homepage.jsp' METHOD='get'>");
						}
						else if(userClass.equals("R")){
							out.println("<FORM NAME='AbortForm' ACTION='Radiologist_Homepage.jsp' METHOD='get'>"); 
						}
						else if(userClass.equals("P")){
							out.println("<FORM NAME='AbortForm' ACTION='Patient_Homepage.jsp' METHOD='get'>"); 
						}
						else{
							out.println("<FORM NAME='AbortForm' ACTION='Doctor_homepage.jsp' METHOD='get'>"); 
						}
						out.println("    <CENTER><INPUT TYPE='submit' NAME='Return' VALUE='Back'></CENTER>");
						out.println("</FORM>");
					}
				}
				
				String oldPhone=request.getParameter("oldPhone").trim();
				String newPhone=request.getParameter("newPhone").trim();
				if(cmp(oldPhone,newPhone)==false){
					updatePersons(con,"phone",person_id,newPhone);
				}
				
				String oldPassword=request.getParameter("oldPassword").trim();
				String newPassword=request.getParameter("newPassword").trim();
				if(cmp(oldPassword,newPassword)==false){
					Statement s=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sqlStatement="SELECT password FROM users WHERE user_name='"+(String)session.getAttribute("username")+"' FOR UPDATE";
					ResultSet resSet=s.executeQuery(sqlStatement);
					try{
						while(resSet != null && resSet.next()){
							resSet.updateString("password",newPassword);
							resSet.updateRow();
						}
						s.executeUpdate("commit");
					}
					catch(Exception e){
						out.println("<hr>" + e.getMessage() + "<hr>");
					}
				}
				try{
					con.close();
				}
				catch(Exception e){
					out.println("<hr>" + e.getMessage() + "<hr>");
				}
				String userClass=((String)session.getAttribute("usertype")).toUpperCase();
				if(abort==false){
					if(userClass.equals("A")){
						response.sendRedirect("Admin_Homepage.jsp"); 
					}
					else if(userClass.equals("R")){
						response.sendRedirect("Radiologist_Homepage.jsp"); 
					}
					else if(userClass.equals("P")){
						response.sendRedirect("Patient_Homepage.jsp"); 
					}
					else{
						response.sendRedirect("Doctor_Homepage.jsp"); 
					}
				}
			}
		}
		else{
			out.println("<p><b>You have no right to use this module</b></p>");
			out.println("<p><b>Press RETURN to the login page.</b></p>");
			out.println("<FORM NAME='NotAllowFrom' ACTION='login.jsp' METHOD='get'>");
			out.println("    <CENTER><INPUT TYPE='submit' NAME='NOT_ALLOW' VALUE='RETURN'></CENTER>");
			out.println("</FORM>");
		}
	%>
</body>
</HTML>