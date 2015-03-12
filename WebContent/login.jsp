<HTML>
<HEAD>


<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*" %>
<% 

        if(request.getParameter("Submit") != null)
        {

	        //get the user input from the login page
        	String userName = (request.getParameter("USERID")).trim();
	        String passwd = (request.getParameter("PASSWD")).trim();
	        String usertype=(request.getParameter("usertype")).trim();
        	out.println("<p>Your input User Name is: "+userName+"</p>");
        	out.println("<p>Your input password is: "+passwd+"</p>");
        	out.println("<p>Your input usertype is: "+usertype+"</p>");
        	session.setAttribute("dblab", 
    				(request.getParameter("labconnection") != null && request.getParameter("labconnection").equals("yes"))
    		);
        	Boolean isConnectingFromLab = (Boolean)session.getAttribute("dblab");

	        //establish the connection to the underlying database
        	Connection conn = null;
	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
	        String dbhomestring="jdbc:oracle:thin:@localhost:1525:CRS"; //working from home
	        String dblabstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS"; //working form school
			String dbstring="jdbc:oracle:thin:@localhost:1525:CRS";
	        if(isConnectingFromLab)
	        	dbstring=dblabstring;
	        //if(((request.getParameter("labconnection")).trim()).equals("yes"))
			//	dbstring=dblabstring;
	        //	dbstring=dbhomestring;
	        
	        try{
		        //load and register the driver
        		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
        	}
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
	
	        }
	
        	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"cheng10","DB1993izo8");
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	

	        //select the user table from the underlying db and validate the user name and password
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql = "select password from users where user_name = '"+userName+"'";
	        out.println(sql);
        	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}

	        String truepwd = "";
	
        	while(rset != null && rset.next())
	        	truepwd = (rset.getString(1)).trim();
        	
			//select usertype from the table
        	Statement stmt1 = null;
	        ResultSet rset1 = null;
        	String sql1 = "select class from users where user_name = '"+userName+"'";
	        out.println(sql1);
        	try{
	        	stmt1 = conn.createStatement();
		        rset1 = stmt.executeQuery(sql1);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}

	        String truetype = "";
	
        	while(rset1 != null && rset1.next())
	        	truetype = (rset1.getString(1)).trim();
        	
        	//display the result
	        if(passwd.equals(truepwd)&&usertype.equals(truetype))
	        {
		        out.println("<p><b>Your Login is Successful!</b></p>");
        	
	        	if(usertype.equals("a"))
        			{
        		out.println("Redirecting to Admin Homepage in 5 seconeds...");
        		response.setHeader("Refresh", "5; URL=Admin_Homepage.html");
        		//response.sendRedirect("Admin_Homepage.html");
        			}
        		else
        			{	
        		out.println("Redirecting to User Homepage in 5 seconeds...");
        		response.setHeader("Refresh", "5; URL=User_Homepage.html");
        		//response.sendRedirect("User_Homepage.html");
        			}	
	        }
        	
        	else
        		{
        			out.println("<p><b>Invalid combination of username, password and usertype!</b></p>");
        			out.println("Redirecting to Login page in 5 seconeds...");
        			response.setHeader("Refresh", "5; URL=login.html");
        		}
	        	

        	
                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
        }
        else
        {
                out.println("<form method=post action=login.jsp>");
                out.println("UserName: <input type=text name=USERID maxlength=20><br>");
                out.println("Password: <input type=password name=PASSWD maxlength=20><br>");
                out.println("<input type=submit name=Submit value=Submit>");
                out.println("</form>");
        }      
%>



</BODY>
</HTML>

