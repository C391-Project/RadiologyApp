package servlets.upload;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlets.UploadServlet;
import database.DataSource;

/**
 * Servlet implementation class ImageThumbnail Servlet
 */
public class ImageThumbnail extends UploadServlet {
	private static final long serialVersionUID = 1L;
	DataSource dataSource = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageThumbnail() {
        super();
        this.dataSource = new DataSource();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		// Get the id of thumbnail size image to retrieve.
		Integer imageId = Integer.parseInt(request.getParameter("id"));
		
		// Retrieve image from the database and write it to the page.
		try {
			// Reference http://www.srikanthtechnologies.com/blog/java/fileupload.aspx on March 26, 2015
			BufferedImage img = dataSource.getImageThumbnailById(imageId);
			
			// Get size of Image
			// Reference http://stackoverflow.com/questions/632229/how-to-calculate-java-bufferedimage-filesize user petr on March 27,2015
			ByteArrayOutputStream tmp = new ByteArrayOutputStream();
		    ImageIO.write(img, "png", tmp);
		    tmp.close();
		    Integer contentLength = tmp.size();
		    // end reference
			
		    // Prepare page for image.
	        response.setContentType("image/jpeg");
	        response.setContentLength( (int) contentLength);
	        
	        // Write image onto the page.
	        OutputStream os = response.getOutputStream();
	        ImageIO.write(img, "jpg", os);
	        os.close();
	        // End Reference
	        
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
