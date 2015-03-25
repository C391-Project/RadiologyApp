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

import utilities.StateManager;
import database.DataSource;
import database.JDBC;
import database.Person;
import database.User;

/**
 * Servlet implementation class UsersEdit
 */
public class UsersEdit extends HttpServlet {
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
		StateManager sm = new StateManager(request, response);
		if (!sm.verifyPage()) return;
		
		String username = request.getParameter("username");
		
		DataSource dataSource = new DataSource();
		User user = dataSource.getUserByUserName(username);
		
		request.setAttribute("user", user);
		RequestDispatcher view = request.getRequestDispatcher("/UserManage/users-edit.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
			
			

}
