

import java.io.IOException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class dblogin
 */
public class dblogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dblogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("login");
		String password = request.getParameter("password");
		
		JDBC.setLogin(username, password);
		JDBC.getConnection();

		String dropString = "drop table TOFFEES;";
		String createString = "create table TOFFEES " +

              "(T_NAME VARCHAR(32), " +
              "SUP_ID INTEGER, " +
              "PRICE FLOAT, " +
              "SALES INTEGER, " +
              "TOTAL INTEGER)";
		
		JDBC.executeUpdate(dropString);
		JDBC.executeUpdate(createString);
		
		JDBC.closeConnection();

	} // END doPost

}
