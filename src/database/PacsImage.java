package database;

import java.awt.image.BufferedImage;
import java.sql.Blob;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import servlets.upload.ImageResizer;

/**
 * @reference http://www.srikanthtechnologies.com/blog/java/fileupload.aspx on March 26, 2015
 * @author Brett Commandeur
 *
 */
public class PacsImage implements Table {
	
	Integer recordId = null;
	Integer imageId = null;
	BufferedImage thumbnail = null;
	BufferedImage regularSize = null;
	BufferedImage fullSize = null;
	
	boolean isValid = false;
	
	public PacsImage(Integer imageId, String recordId, BufferedImage fullSizeImage) {
		this.imageId = imageId;
		this.recordId = Integer.parseInt(recordId);
		this.fullSize = fullSizeImage;
		this.regularSize = ImageResizer.createRegular(fullSizeImage);
		this.thumbnail = ImageResizer.createThumbnail(fullSizeImage);
	}
	
	@Override
	public boolean isValid() {
		// TODO Figure out better validity check.
		return true;
	}

	@Override
	public String generateInsertSql() {
		return "insert into pacs_images values(?,?,?,?,?)";
	}
	
	public String generateUpdateSql() {
		return null;
	}

	public Integer getRecordId() {
		return recordId;
	}

	public Integer getImageId() {
		return imageId;
	}

	public BufferedImage getThumbnail() {
		return thumbnail;
	}

	public BufferedImage getRegularSize() {
		return regularSize;
	}

	public BufferedImage getFullSize() {
		return fullSize;
	}

}
