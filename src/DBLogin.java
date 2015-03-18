

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.JDBC;

/**
 * Servlet implementation class dblogin
 */
public class DBLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DBLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<h1>DBLogin</h1>");
		out.println("<p>Post here to test db connection<p>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		session.setAttribute("dbusername", request.getParameter("username"));
		session.setAttribute("dbpassword", request.getParameter("password"));
		session.setAttribute("dblab", 
				(request.getParameter("labconnection") != null && request.getParameter("labconnection").equals("yes"))
		);
		
		String username = session.getAttribute("dbusername").toString();
		String password = session.getAttribute("dbpassword").toString();
		Boolean isConnectingFromLab = (Boolean)session.getAttribute("dblab");
		
		JDBC.configure(username, password, isConnectingFromLab);
		JDBC.connect();
		
		String returnPage = (String) session.getAttribute("returnPage");
		if ( returnPage != null) {
			session.setAttribute("returnPage", null);
			response.sendRedirect(returnPage);
		}
		
		if (JDBC.hasConnection()) {
			out.println("<p>Login Successful</p>");
			out.println("<a href=\"/RadiologyApp/dbinterface.jsp\">dbinterface.jsp</a>");
		} else {
			out.println("<p>Login Failed.</p>");
		}
			
		JDBC.closeConnection();

	} // END doPost

}
