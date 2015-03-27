package servlets.upload;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import security.Bouncer;
import database.DataSource;
import database.JDBC;
import database.Person;
import database.User;

/**
 * Servlet implementation class ImageThumbnail Servlet
 */
public class ImageFullSize extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DataSource dataSource = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageFullSize() {
        super();
        this.dataSource = new DataSource();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		// Check security and database connection.
		Bouncer sm = new Bouncer(request, response);
		if (!sm.verifyPage()) return;
		
		Integer imageId = Integer.parseInt(request.getParameter("id"));
		
		try {
			// Reference http://www.srikanthtechnologies.com/blog/java/fileupload.aspx on March 26, 2015
			Blob b = dataSource.getImageBlobFullById(imageId);
	        response.setContentType("image/jpeg");
	        response.setContentLength( (int) b.length());
	        InputStream is = b.getBinaryStream();
	        OutputStream os = response.getOutputStream();
	        byte buf[] = new byte[(int) b.length()];
	        is.read(buf);
	        os.write(buf);
	        os.close();
	        // End Reference
	        
	        // Connection must stay open to write image onto page, once done: close.
	        JDBC.closeConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
			
			

}
