


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.JDBC;


@SuppressWarnings("serial")
public class OracleLogout extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher view = request.getRequestDispatcher("/oracle-login.jsp");
		view.forward(request, response);
	}

	 @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		 //invalidate the session to logout
		 request.getSession().invalidate();
		 JDBC.configure(null, null, false);
		 //reset JDBC.configure in order to logout
	     response.sendRedirect("/RadiologyApp/oracle-login");
	}

}
