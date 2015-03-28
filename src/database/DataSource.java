package database;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.fileupload.FileItem;

import java.sql.Blob;

/**
 * Handles sending and retrieval of data objects to and from the database. 
 * 
 * Design rationale: The api for accessing the data is app-specific, however
 * the database and database communicator should be separable from the application.
 * Changing database systems (e.g. oracle to mysql) should be as simple as changing
 * out this class for a similar data source with the same methods but different
 * implementation of the methods. 
 * 
 * Limitations: This class can be refactored and cleaned through the use of java generics.
 * There is quite a bit of code reuse for similar modules with only a couple variables 
 * changed. The priority here was proper handling of closing connections through
 * try/catch/finally blocks, the implementation of which through generics is trickier than
 * time permits. 
 * 
 * @author Brett Commandeur
 *
 */
public class DataSource {
	
	public DataSource() {}
	
	/**
	 * Method to tell if the database connection has been properly configured.
	 * To be checked before a connection is opened. 
	 * 
	 * @return True on proper configuration allowing for a connection.
	 */
	public boolean isNotConfigured() {
		return (!JDBC.isConfigured());
	}
	
	/**
	 * Method for generating the next available Person ID in the person table
	 * of the database. Assumes the highest ID is the last entered ID.
	 * 
	 * @return The next available person ID
	 */
	public Integer getNextPersonId() {
		Integer lastId = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT MAX(person_id) AS id FROM persons";
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			lastId = rs.getInt("id");
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		return (lastId == null) ? 1 : lastId + 1;
	}
	
	/**
	 * Method for inserting a person object into the database.
	 * 
	 * @param person	The Java person object from which to get the SQL insert information. 
	 */
	public void submitPerson(Person person) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = person.generateInsertSql();
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, person.getPersonId());
	    		stmt.setString(2, person.getFirstName());
	    		stmt.setString(3, person.getLastName());
	    		stmt.setString(4, person.getAddress());
	    		stmt.setString(5, person.getEmail());
	    		stmt.setString(6, person.getPhone());
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	}
	
	/**
	 * Method to retrieve all rows from the persons table and turn them into
	 * a list of Java person objects.
	 * 
	 * @return	The list of java person objects generated from the persons table.
	 */
	public List<Person> getPersonList() {
		Person person = null;
		List<Person> personList = new ArrayList<Person>();
		Connection connection = JDBC.connect();
		String sql = "SELECT * FROM PERSONS";
		
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		rs = stmt.executeQuery();
	    		while (rs.next()) {
	    			person = new Person(rs);
	    			personList.add(person);
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		JDBC.closeConnection();
		return personList;
	}
	
	/**
	 * Method to retrieve a single row from the person database with the matching
	 * person ID and turn it into a single java person object. 
	 * 
	 * @param personId	The person ID of the row to be retrieved.
	 * @return			The java person object represenation of the person table row. 
	 */
	public Person getPersonById(Integer personId) {
		Person person = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT * FROM persons WHERE person_id = ?";
		
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, personId);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			person = new Person(rs);
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		JDBC.closeConnection();
		return person;
	}
	
	/**
	 * Method for updating a single person row in the database based on the information of
	 * the provided java person object. If a person row exists with a matching ID, all
	 * columns are updated to match the information of the given person object.
	 * 
	 * @param person	The java person object from which to get the sql update information.
	 */
	public void updatePerson(Person person) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = person.generateUpdateSql();
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setString(1, person.getFirstName());
	    		stmt.setString(2, person.getLastName());
	    		stmt.setString(3, person.getAddress());
	    		stmt.setString(4, person.getEmail());
	    		stmt.setString(5, person.getPhone());
	    		stmt.setInt(6, person.getPersonId());
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
		
	}
	
	/**
	 * Method for deleting a single row from the person database.
	 * 
	 * @param personId		The ID of the person row to be deleted.
	 */
	public void deletePerson(Integer personId) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = "DELETE FROM persons WHERE person_id = ?";
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, personId);
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	}
	
	/**
	 * Method for submitting a single java user object to the user database. An sql row is generated
	 * based on the information in the given java user object.
	 * 
	 * @param user		The java user object from which to generate the sql insert information.
	 */
	public void submitUser(User user) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = user.generateInsertSql();
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setString(1, user.getUserName());
	    		stmt.setString(2, user.getPassword());
	    		stmt.setString(3, user.getUserClass());
	    		stmt.setInt(4, user.getPersonId());
	    		
	    		java.sql.Date sqlDate = new java.sql.Date(user.getDateRegistered().getTime());
	    		stmt.setDate(5, sqlDate);
	    		
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	} 
	
	/**
	 * Method for retrieving a list of user objects from the user database. Converts each
	 * sql user row into a user object and populates returned list of user objects.
	 * 
	 * @return		The list of user objects generated from the sql user table. 
	 */
	public List<User> getUserList() {
		User user = null;
		List<User> userList = new ArrayList<User>();
		Connection connection = JDBC.connect();
		String sql = "SELECT * FROM USERS";
		
		if (JDBC.hasConnection()) {
			Statement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.createStatement();
	    		rs = stmt.executeQuery(sql);
	    		while (rs.next()) {
	    			user = new User(rs);
	    			userList.add(user);
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		JDBC.closeConnection();
		return userList;
	}
	
	/**
	 * Method for retrieving a single sql user row as a user object. The columns of the
	 * user row are converted into attributes of the user object. 
	 * 
	 * @param username		The username of the user row to retrieve.
	 * @return				The user object representation of the user row. 
	 */
	public User getUserByUserName(String username) {
		User user = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT * FROM users WHERE user_name = ?";
		
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setString(1, username);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			user = new User(rs);
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		JDBC.closeConnection();
		return user;
	}

	/**
	 * Method for updating a single sql user row matching the provied
	 * username based on the attributes of the provided user object. If a row 
	 * exists with the matching username, all columns will be updated to match 
	 * the attributes of the provided user. 
	 * 
	 * @param originalUsername		Username of sql row to update.
	 * @param user					User object from which to generate sql update information.
	 */
	public void updateUser(String originalUsername, User user) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = user.generateUpdateSql();
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setString(1, user.getUserName());
	    		stmt.setString(2, user.getPassword());
	    		stmt.setString(3, user.getUserClass());
	    		stmt.setInt(4, user.getPersonId());
	    		
	    		java.sql.Date sqlDate = new java.sql.Date(user.getDateRegistered().getTime());
	    		stmt.setDate(5, sqlDate);
	    		
	    		stmt.setString(6, originalUsername);
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	}	
	
	/**
	 * Method for deleting a single user row from the user table of the database.
	 * Deletes the row with the matching provided username.
	 * 
	 * @param username		Username of row to delete.
	 */
	public void deleteUser(String username) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = "DELETE FROM users WHERE user_name = ?";
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setString(1, username);
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	}
	
	/**
	 * Method for inserting a single family doctor row in the family doctor table of the 
	 * database. Converts the provided family doctor object into an sql insert statement
	 * from the attributes of the family doctor object and executes the insert.
	 * 
	 * @param fd	Family doctor object from which to generate the insert information.
	 */
	public void submitFamilyDoctor(FamilyDoctor fd) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = fd.generateInsertSql();
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, fd.getDoctorId());
	    		stmt.setInt(2, fd.getPatientId());
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	} 
	
	/**
	 * Method for retrieving all sql family doctor rows from the database and converting
	 * them to family doctor objects stored in a list. Family doctor object attibutes are
	 * generated from the columns of the result set and inserted into the returned list. 
	 * 
	 * @return	List of all family doctor objects retrieved from the retrieved sql columns.
	 */
	public List<FamilyDoctor> getFamilyDoctorList() {
		FamilyDoctor fd = null;
		List<FamilyDoctor> fdList = new ArrayList<FamilyDoctor>();
		Connection connection = JDBC.connect();
		String sql = "SELECT * FROM FAMILY_DOCTOR";
		
		if (JDBC.hasConnection()) {
			Statement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.createStatement();
	    		rs = stmt.executeQuery(sql);
	    		while (rs.next()) {
	    			fd = new FamilyDoctor(rs);
	    			fdList.add(fd);
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		JDBC.closeConnection();
		return fdList;
	}
	
	public FamilyDoctor getFamilyDoctorByIds(Integer doctor_id, Integer patient_id) {
		FamilyDoctor fd = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT * FROM family_doctor WHERE doctor_id = ? AND patient_id = ?";
		
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, doctor_id);
	    		stmt.setInt(2, patient_id);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			fd = new FamilyDoctor(rs);
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		JDBC.closeConnection();
		return fd;
	}

	public void updateFamilyDoctor(Integer originalDoctorId, Integer originalPatientId, FamilyDoctor fd) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = fd.generateUpdateSql();
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, fd.getDoctorId());
	    		stmt.setInt(2, fd.getPatientId());
	    		stmt.setInt(3, originalDoctorId);
	    		stmt.setInt(4, originalPatientId);
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	}	
	
	public void deleteFamilyDoctor(Integer doctorId, Integer patientId) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = "DELETE FROM family_doctor WHERE doctor_id = ? AND patient_id = ?";
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, doctorId);
	    		stmt.setInt(2, patientId);
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	}
	
	public Integer getNextPacsImageId() {
		Integer lastId = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT MAX(image_id) AS id FROM pacs_images";
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			lastId = rs.getInt("id");
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		return (lastId == null) ? 0 : lastId + 1;
	}

	public void submitPacsImage(PacsImage pacsImage) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = pacsImage.generateInsertSql();
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, pacsImage.getRecordId());
	    		stmt.setInt(2, pacsImage.getImageId());
	    		
	    		// Write thumbnail into prepared statement
	    		ByteArrayOutputStream os = new ByteArrayOutputStream();
	    		ImageIO.write(pacsImage.getThumbnail(), "jpg", os);
	    		byte[] imageAsBytes = os.toByteArray();
	    		InputStream is = new ByteArrayInputStream(imageAsBytes);
	    		stmt.setBinaryStream(3, is, (int) imageAsBytes.length);
	    		os.close();
	    		is.close();
	    		
	    		// Write regular size image into prepared statement
	    		os = new ByteArrayOutputStream();
	    		ImageIO.write(pacsImage.getRegularSize(), "jpg", os);
	    		imageAsBytes = os.toByteArray();
	    		is = new ByteArrayInputStream(imageAsBytes);
	    		stmt.setBinaryStream(4, is, (int) imageAsBytes.length);
	    		os.close();
	    		is.close();
	    		
	    		// Write full size image into prepared statement
	    		os = new ByteArrayOutputStream();
	    		ImageIO.write(pacsImage.getFullSize(), "jpg", os);
	    		imageAsBytes = os.toByteArray();
	    		is = new ByteArrayInputStream(imageAsBytes);
	    		stmt.setBinaryStream(5, is, (int) imageAsBytes.length);
	    		os.close();
	    		is.close();
	    		
	    		stmt.executeUpdate();
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	}

	public BufferedImage getImageThumbnailById(Integer imageId) {
		BufferedImage img = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT thumbnail FROM pacs_images WHERE image_id = ?";
		
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, imageId);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			Blob b = rs.getBlob("thumbnail");
	    			img = ImageIO.read(b.getBinaryStream());
	    		}
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    		JDBC.closeConnection();
	    	}
		}
		return img;
	}

	public Blob getImageBlobRegularById(Integer imageId) {
		Blob b = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT regular_size FROM pacs_images WHERE image_id = ?";
		
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, imageId);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			b = rs.getBlob("regular_size");
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		return b;
	}

	public Blob getImageBlobFullById(Integer imageId) {
		Blob b = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT full_size FROM pacs_images WHERE image_id = ?";
		
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, imageId);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			b = rs.getBlob("full_size");
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		return b;
	}

	public Integer getNextRecordId() {
		Integer lastId = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT MAX(record_id) AS id FROM radiology_record";
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			lastId = rs.getInt("id");
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		return (lastId == null) ? 1 : lastId + 1;
	}

	public void submitRecord(RadiologyRecord record) {
		Connection connection = JDBC.connect();
    	PreparedStatement stmt = null;
    	String sql = record.generateInsertSql();
    	if (JDBC.hasConnection()) {
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, record.getRecordId());
	    		stmt.setInt(2, record.getPatientId());
	    		stmt.setInt(3, record.getDoctorId());
	    		stmt.setInt(4, record.getRadiologistId());
	    		stmt.setString(5, record.getTestType());
	    		// Convert Java Dates to SQL dates
	    		java.sql.Date sqlDate = new java.sql.Date(record.getPrescribingDate().getTime());
	    		stmt.setDate(6, sqlDate);
	    		sqlDate = new java.sql.Date(record.getTestDate().getTime());
	    		stmt.setDate(7, sqlDate);
	    		stmt.setString(8, record.getDiagnosis());
	    		stmt.setString(9, record.getDescription());
	    		stmt.executeUpdate();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
    	}
		JDBC.closeConnection();
	}

	public RadiologyRecord getRecordById(Integer recordId) {
		RadiologyRecord record = null;
		Connection connection = JDBC.connect();
		String sql = "SELECT * FROM radiology_record WHERE record_id = ?";
		
		if (JDBC.hasConnection()) {
			PreparedStatement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.prepareStatement(sql);
	    		stmt.setInt(1, recordId);
	    		rs = stmt.executeQuery();
	    		if (rs.next()) {
	    			record = new RadiologyRecord(rs);
	    		}
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		JDBC.closeConnection();
		return record;
	}
	
}
