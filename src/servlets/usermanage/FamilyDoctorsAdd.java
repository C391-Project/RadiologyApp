package servlets.usermanage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import servlets.UserManageServlet;
import database.DataSource;
import database.JDBC;
import database.Person;

/**
 * Servlet implementation class FamilyDoctorsAdd
 */
public class FamilyDoctorsAdd extends UserManageServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FamilyDoctorsAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		// Render Add Family Doctor page
		RequestDispatcher view = request.getRequestDispatcher("/UserManage/family-doctors-add.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
	}
			
			

}
