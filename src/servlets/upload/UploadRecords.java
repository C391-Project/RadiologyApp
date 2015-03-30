package servlets.upload;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import servlets.UploadServlet;
import database.DataSource;
import database.RadiologyRecord;

/**
 * Servlet implementation class UploadRecords
 */
public class UploadRecords extends UploadServlet {
	private static final long serialVersionUID = 1L;
	private DataSource dataSource = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadRecords() {
        super();
        this.dataSource = new DataSource();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		HttpSession session = request.getSession();
		
		// Add Radiology Record
		boolean isRecordSubmit = (request.getParameter("record_submit") != null);
		if (isRecordSubmit) {
			Integer nextRecordId = dataSource.getNextRecordId();
			RadiologyRecord recordToSubmit = new RadiologyRecord(nextRecordId, request);
			if (recordToSubmit.isValid()) {
				dataSource.submitRecord(recordToSubmit);
				// Prepare results to display to user
				RadiologyRecord retrievedRecord = dataSource.getRecordById(recordToSubmit.getRecordId());
				request.setAttribute("record", retrievedRecord);
			} else {
				session.setAttribute("error", "Radiology Record Information Not Valid");
			}
			
			// Display Results to User
			RequestDispatcher view = request.getRequestDispatcher("/Upload/records-result.jsp");
			view.forward(request, response);
		}
		
	}

}
