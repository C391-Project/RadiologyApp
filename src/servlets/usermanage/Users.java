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

import security.Bouncer;
import servlets.UserManageServlet;
import database.DataSource;
import database.JDBC;
import database.Person;
import database.User;

/**
 * Servlet implementation class Users Servlet
 */
public class Users extends UserManageServlet {
	private static final long serialVersionUID = 1L;
	private DataSource dataSource = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Users() {
        super();
        this.dataSource = new DataSource();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		List<User> userList = dataSource.getUserList();
		request.setAttribute("userList", userList);
		RequestDispatcher view = request.getRequestDispatcher("/UserManage/users.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		HttpSession session = request.getSession();
		
		// Add User
		boolean isUserSubmit = (request.getParameter("user_submit") != null);
		if (isUserSubmit) {
			User userToSubmit = new User(request);
			if (userToSubmit.isValid()) {
				dataSource.submitUser(userToSubmit);
			} else {
				session.setAttribute("error", "User Information Not Valid");
			}
		}
		
		// Edit User
		boolean isUserEdit = (request.getParameter("user_edit") != null);
		if (isUserEdit) {
			User userToEdit = new User(request);
			if (userToEdit.isValid()) {
				dataSource.updateUser(request.getParameter("u_original_user_name"), userToEdit);
			} else {
				session.setAttribute("error", "User Information Not Valid");
			}
		}
		
		boolean isUserDelete = (request.getParameter("user_delete") != null);
		if (isUserDelete) {
			String username = request.getParameter("u_user_name");
			dataSource.deleteUser(username);
		}
		
		// Submit a GET request to this servlet to view results.
		response.sendRedirect("/RadiologyApp/usermanage/users");
	}
	
}
