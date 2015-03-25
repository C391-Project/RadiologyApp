package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DataSource {
	
	public DataSource() {}
	
	public boolean isNotConfigured() {
		return (!JDBC.isConfigured());
	}
	
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
		return lastId + 1;
	}
	
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
	    		stmt.setInt(4, originalDoctorId);
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
	
}
