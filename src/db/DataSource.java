package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DataSource {
	
	public DataSource() {}
	
	public void submitPerson(Person person) {
		JDBC.connect();
		String sql = person.generateSqlInsert();
		if (JDBC.hasConnection()) {
			JDBC.executeUpdate(sql);
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
}
