package servlets.usermanage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlets.UserManageServlet;
import database.DataSource;
import database.Person;

/**
 * Servlet implementation class dblogin
 */
public class PersonsEdit extends UserManageServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PersonsEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		// Get the person ID from the request of the person to edit.
		Integer personId = Integer.parseInt(request.getParameter("id"));
		
		// Retrieve the person information from the database
		DataSource dataSource = new DataSource();
		Person person = dataSource.getPersonById(personId);
		
		// Render person edit page with person info from the database
		request.setAttribute("person", person);
		RequestDispatcher view = request.getRequestDispatcher("/UserManage/persons-edit.jsp");
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
