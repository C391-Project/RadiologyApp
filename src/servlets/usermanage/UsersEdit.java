package servlets.usermanage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlets.UserManageServlet;
import database.DataSource;
import database.User;

/**
 * Servlet implementation class UsersEdit
 */
public class UsersEdit extends UserManageServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsersEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		// Get the username of the user to edit from the request
		String username = request.getParameter("username");
		
		// Get the user from the database
		DataSource dataSource = new DataSource();
		User user = dataSource.getUserByUserName(username);
		
		// Render edit user page with information from the database
		request.setAttribute("user", user);
		RequestDispatcher view = request.getRequestDispatcher("/UserManage/users-edit.jsp");
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
