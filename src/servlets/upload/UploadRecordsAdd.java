package servlets.upload;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlets.UploadServlet;

/**
 * Servlet implementation class UploadImages
 */
public class UploadRecordsAdd extends UploadServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadRecordsAdd() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		// Render the add record page
		RequestDispatcher view = request.getRequestDispatcher("/Upload/records-add.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * @reference http://www.srikanthtechnologies.com/blog/java/fileupload.aspx
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
    }	
}
