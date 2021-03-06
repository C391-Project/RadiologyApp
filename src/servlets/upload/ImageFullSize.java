package servlets.upload;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlets.UploadServlet;
import database.DataSource;
import database.JDBC;

/**
 * Servlet implementation class ImageFullSize
 */
public class ImageFullSize extends UploadServlet {
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
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		// Get the id of full size image to retrieve.
		Integer imageId = Integer.parseInt(request.getParameter("id"));
		
		// Write the binary data of the SQL blob directly into the page as an image.
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
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
	}
			
			

}
