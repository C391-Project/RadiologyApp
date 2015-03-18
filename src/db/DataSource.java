package db;

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
			Statement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.createStatement();
	    		rs = stmt.executeQuery(sql);
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
		
		return personList;
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
		
		return userList;
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
		
		return fdList;
	}
	
	
}
