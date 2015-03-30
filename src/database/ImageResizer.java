package database;
import static org.imgscalr.Scalr.*;

import java.awt.image.BufferedImage;

/**
 * Class used to resize images.
 * 
 * @author Brett Commandeur
 *
 */
public class ImageResizer {
	
	private static int THUMBNAIL_SIZE = 125;
	private static int REGULAR_SIZE = 400;

	public ImageResizer() {}
	
	/**
	 * @reference http://www.thebuzzmedia.com/software/imgscalr-java-image-scaling-library/#usage
	 * @param img
	 * @return
	 */
	public static BufferedImage createThumbnail(BufferedImage img) {
	  return resize(img, Method.SPEED, THUMBNAIL_SIZE, null, null);
	}
	
	public static BufferedImage createRegular(BufferedImage img) {
	  return resize(img, Method.SPEED, REGULAR_SIZE, null, null);
	}
}