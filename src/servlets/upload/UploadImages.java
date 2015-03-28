package servlets.upload;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import database.PacsImage;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UploadImages
 */
public class UploadImages extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource dataSource = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadImages() {
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
	 * @reference http://www.srikanthtechnologies.com/blog/java/fileupload.aspx
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and Database Connection
		Bouncer sm = new Bouncer(request, response);
		if (!sm.verifyPage()) return;
		
		// For sending messages to other pages.
		HttpSession session = request.getSession();
		
		try {
			// Apache Commons-Fileupload library classes.
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        ServletFileUpload sfu  = new ServletFileUpload(factory);
	
	        // Make sure form is of correct type.
	        if (! ServletFileUpload.isMultipartContent(request)) {
	            System.out.println("sorry. No file uploaded");
	            return;
	        }
	
	        // Get uploaded file
	        List items = sfu.parseRequest(request);
	        FileItem id = (FileItem) items.get(0);
	        String recordId = id.getString();
	        
	        FileItem file = (FileItem) items.get(1);
	        
	        // Convert raw file to image
	        // reference: http://webdocs.cs.ualberta.ca/~yuan/servlets/UploadImage.java on March 26, 2015
		    InputStream instream = file.getInputStream();
		    BufferedImage fullSizeImage = ImageIO.read(instream);
		    
		    Integer imageId = dataSource.getNextPacsImageId();
	        
	        // Generate PACS image
			PacsImage pacsImage = new PacsImage(imageId, recordId, fullSizeImage);
			
			// Submit PACS image to data source.
			if (pacsImage.isValid()){
				dataSource.submitPacsImage(pacsImage);
			} else {
				session.setAttribute("error", "PACS image information not valid.");
			}
			
			// Display the result to the user.
			request.setAttribute("id", imageId);
			request.setAttribute("record_id", recordId);
			RequestDispatcher view = request.getRequestDispatcher("/Upload/images-result.jsp");
			view.forward(request, response);
		
		} catch (Exception ex) {
			ex.printStackTrace();
        }
		
    }	
}
