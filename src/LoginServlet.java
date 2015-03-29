import java.io.IOException;
import java.lang.ProcessBuilder.Redirect;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DataSource;
import security.Bouncer;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
        
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        
    	
		
        if(request.getParameter("Submit") != null)
        {
        
    		HttpSession session = request.getSession();
    
	        //get the user input from the login page
        	
	        String DBusername =null;
	        String DBpassword = null;
	        Boolean isConnectingFromLab =false;
	        // if a user haven't login into the database before login into the system
	        //redirect him to the database login page
	        
	        if(session.getAttribute("dbusername")==null)
	        {
	        	session.setAttribute("error", "Please login to the databse first.");
	        	response.sendRedirect("oracle-login");
	        }
	        else
	        {
	        	DBusername=session.getAttribute("dbusername").toString();
				DBpassword=session.getAttribute("dbpassword").toString();
				isConnectingFromLab=(Boolean)session.getAttribute("dblab");
	        }
	        
        	String userName = (request.getParameter("USERID")).trim();
	        String passwd = (request.getParameter("PASSWD")).trim();
	        session.setAttribute("username", userName);
	        session.setAttribute("password", passwd);
	        String truepwd="";
	        String truetype="";
	        String fulltype="";
	        //String usertype=(request.getParameter("usertype")).trim();
        	System.out.println("<p>Your input User Name is: "+userName+"</p>");
        	System.out.println("<p>Your input password is: "+passwd+"</p>");
        	//System.out.println("<p>Your input usertype is: "+usertype+"</p>");
        	//session.setAttribute("dblab", 
    		//		(request.getParameter("labconnection") != null && request.getParameter("labconnection").equals("yes")));
        	
        	
        	
        	
        
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
		        System.out.println("<hr>" + ex.getMessage() + "<hr>");
	
	        }
	
        	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,DBusername,DBpassword);
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
		        System.out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	
	        //select the user table from the underlying db and validate the user name and password
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql = "select password from users where user_name = '"+userName+"'";
	        //System.out.println(sql);
        	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        	}
	
	        catch(Exception ex){
		        System.out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	
        	try {
				while(rset != null && rset.next())
					truepwd = (rset.getString(1)).trim();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	
			//select usertype from the table
        	Statement stmt1 = null;
	        ResultSet rset1 = null;
        	String sql1 = "select class from users where user_name = '"+userName+"'";
	        //System.out.println(sql1);
        	try{
	        	stmt1 = conn.createStatement();
		        rset1 = stmt1.executeQuery(sql1);
        	}
	
	        catch(Exception ex){
		        System.out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	
        	try {
				while(rset1 != null && rset1.next())
					truetype = (rset1.getString(1)).trim();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	
        	System.out.println("<p><b>Your usertype is: "+truetype+"</b></p>");
        	session.setAttribute("usertype",truetype);
        	//request.getSession().setAttribute("id",10 );
        	//display the result
	        if(!userName.equals(null)&&!passwd.equals(null)&&passwd.equals(truepwd))
	        {
		        System.out.println("<p><b>Login Successful!</b></p>");
		        //get the full usertype
		        if(truetype.equals("a"))
		        	fulltype="Admin";
		        else if(truetype.equals("p"))
		        	fulltype="Patient";
		        else if(truetype.equals("r"))
		        	fulltype="Radiologist";
		        else if(truetype.equals("d"))
		        	fulltype="Doctor";
		        else fulltype="Error";
		        		
		        //store user info in cookies
		        Cookie loginCookie = new Cookie("user",userName);
		        Cookie loginCookie1 = new Cookie("usertype",fulltype);
	            //setting cookie to expiry in 30 mins
	            loginCookie.setMaxAge(30*60);
	            response.addCookie(loginCookie);
	            loginCookie1.setMaxAge(30*60);
	            response.addCookie(loginCookie1);
	            //response.sendRedirect("LoginSuccess.jsp");
		        
	        	if(truetype.equals("a"))
        		{
        		System.out.println("Redirecting to Admin Homepage...");
        		response.setHeader("Refresh", "0; URL=Admin_Homepage.jsp");
        		//response.sendRedirect("Admin_Homepage.html");
        		}
        		else if (truetype.equals("p"))
        		{	
        		System.out.println("Redirecting to Patient Homepage...");
        		response.setHeader("Refresh", "0; URL=Patient_Homepage.jsp");
        		//response.sendRedirect("User_Homepage.html");
        		}	
        		else if (truetype.equals("r"))
        		{
        		System.out.println("Redirecting to Radiologist Homepage...");
            	response.setHeader("Refresh", "0; URL=Radiologist_Homepage.jsp");
        		}
        		else if(truetype.equals("d"))
        		{
        		System.out.println("Redirecting to Doctor Homepage ...");
                response.setHeader("Refresh", "0; URL=Doctor_Homepage.jsp");	
        		}
	        }
        	
        	else
        		{
        			System.out.println("<p><b>Invalid combination of username, password!</b></p>");
        			System.out.println("Redirecting to Login page ...");
        			session.setAttribute("error", "Invalid combination of username, password!");
        			response.setHeader("Refresh", "0; URL=login.jsp");
        		}
	        	
        	
                try{
                        conn.close();
                }
                catch(Exception ex){
                        System.out.println("<hr>" + ex.getMessage() + "<hr>");
                }
        }
        else
        {
        		response.sendRedirect("login.jsp");

        }      
    }
 
}
