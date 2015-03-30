package database;

import java.awt.image.BufferedImage;

/**
 * Class for working with and storing information from a single row of the
 * pacs_image table. Generates the thumbnail and regular size images 
 * from the full sized image provided to the constructor. 
 * 
 * @author Brett Commandeur
 *
 */
public class PacsImage implements TableRow {
	
	Integer recordId = null;
	Integer imageId = null;
	BufferedImage thumbnail = null;
	BufferedImage regularSize = null;
	BufferedImage fullSize = null;
	
	boolean isValid = false;
	
	/**
	 * Constructor for creating a submittable PACS image object from the upload module.
	 * 
	 * @param imageId		The ID for the image in the database
	 * @param recordId		The record ID for the image's radiology record.
	 * @param fullSizeImage	The image uploaded from the upload module.
	 */
	public PacsImage(Integer imageId, String recordId, BufferedImage fullSizeImage) {
		this.imageId = imageId;
		this.recordId = Integer.parseInt(recordId);
		this.fullSize = fullSizeImage;
		this.regularSize = ImageResizer.createRegular(fullSizeImage);
		this.thumbnail = ImageResizer.createThumbnail(fullSizeImage);
	}
	
	/**
	 * Method for determining if the obect is ready for submission.
	 */
	@Override
	public boolean isValid() {
		// TODO Figure out better validity check.
		return true;
	}

	/**
	 * Method for generating an SQL insert statement for the pacs_image table.
	 */
	@Override
	public String generateInsertSql() {
		return "insert into pacs_images values(?,?,?,?,?)";
	}
	
	/**
	 * Unused method for generating an SQL update statement for the pacs_image table.
	 */
	public String generateUpdateSql() {
		return null;
	}

	/** 
	 * Getter for the recordId attribute.
	 * 
	 * @return  The record ID of the pacs image.
	 */
	public Integer getRecordId() {
		return recordId;
	}

	/**
	 * Getter for the imageId attribute
	 * 
	 * @return The image ID of the pacs image.
	 */
	public Integer getImageId() {
		return imageId;
	}

	/**
	 * Getter for the generated thumbnail image
	 * 
	 * @return	The thumbnail sized image.
	 */
	public BufferedImage getThumbnail() {
		return thumbnail;
	}
	
	/**
	 * Getter for the generated regular size image.
	 * 
	 * @return The regular sized image.
	 */
	public BufferedImage getRegularSize() {
		return regularSize;
	}

	/**
	 * Getter for the provided full sized image.
	 * 
	 * @return The full sized image.
	 */
	public BufferedImage getFullSize() {
		return fullSize;
	}

}
