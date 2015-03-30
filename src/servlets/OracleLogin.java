package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.JDBC;

/**
 * Servlet implementation class dblogin
 */
public class OracleLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OracleLogin() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Render the oracle login page.
		RequestDispatcher view = request.getRequestDispatcher("/oracle-login.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		
		// Store database login info to the session in case later needed.
		session.setAttribute("dbusername", request.getParameter("username"));
		session.setAttribute("dbpassword", request.getParameter("password"));
		session.setAttribute("dblab", 
				(request.getParameter("labconnection") != null && request.getParameter("labconnection").equals("yes"))
		);
		
		// Get database login info from the session
		String username = session.getAttribute("dbusername").toString();
		String password = session.getAttribute("dbpassword").toString();
		Boolean isConnectingFromLab = (Boolean)session.getAttribute("dblab");
		
		// Test Connection and redirect
		JDBC.configure(username, password, isConnectingFromLab);
		JDBC.connect();
		if (JDBC.hasConnection()) {
			String returnPage = (String) session.getAttribute("returnPage");
			// Redirect to the accessed page or homepage on success.
			if ( returnPage != null) {
				session.setAttribute("returnPage", null);
				response.sendRedirect(returnPage);
			} else {
				response.sendRedirect("/RadiologyApp");
			}
		} else {
			// Redirect back to oracle login page on failure.
			session.setAttribute("error", "Could not connect to database.");
			response.sendRedirect("/RadiologyApp/oracle-login");
		}
		JDBC.closeConnection();
		
	}

}
