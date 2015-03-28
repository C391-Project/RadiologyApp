package servlets.upload;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.util.List;

import javax.imageio.ImageIO;
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
public class ImageThumbnail extends HttpServlet {
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
		// Check security and database connection.
		Bouncer sm = new Bouncer(request, response);
		if (!sm.verifyPage()) return;
		
		Integer imageId = Integer.parseInt(request.getParameter("id"));
		
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
			
	        response.setContentType("image/jpeg");
	        response.setContentLength( (int) contentLength);
	        
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

	}
			
			

}
