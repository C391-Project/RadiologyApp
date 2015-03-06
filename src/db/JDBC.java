package db;
/**
 * Singleton for connecting to a database through JDBC
 * 
 * @author Maks (original)
 * @author Brett Commandeur (modified by)
 * @source https://github.com/MaksJS/jdbc-singleton/blob/master/JDBC.java
 **/

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC {
    
    private static Connection connection = null;
    private static String username = null;
    private static String password = null;
    //private final static String URL = "jdbc:oracle:thin:@localhost:1525:CRS"; // Work from Home
    private final static String URL = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS"; // Lab Machines		
    private final static String DRIVER   = "oracle.jdbc.driver.OracleDriver";
    
    /**
     * Method that loads the specified driver
     * 
     * @return void
     **/
    
    private static void loadDriver() {
        try {
            Class drvClass = Class.forName(DRIVER);
			DriverManager.registerDriver((Driver)drvClass.newInstance());
        }
        catch (Exception e) {
            errorHandler("Failed to load the driver " + DRIVER, e);
        }
    }

    /**
     * Method that loads the connection into the right property
     * 
     * @return void
     **/
    
    private static void loadConnection() {
    	if (username == null || password == null) {
    		errorHandler("Please set login (username and password)", null);
    	} else {
	        try {
	            connection = DriverManager.getConnection(URL, username, password);
	        }
	        catch (SQLException e) {
	            errorHandler("Failed to connect to the database " + URL, e);         
	        }
    	}
    }
    
    /**
     * Method that shows the errors thrown by the singleton
     * 
     * @param  {String}    Message
     * @option {Exception} e
     * @return  void
     **/
    
    private static void errorHandler(String message, Exception e) {
        System.out.println(message);  
        if (e != null) System.out.println(e.getMessage());   
    }
    
    /**
     * Method that sets the user and password for the connection
     * 
     * @param newUser
     * @param newPassword
     * @return void
     */
    public static void setLogin(String newUsername, String newPassword) {
    	username = newUsername;
    	password = newPassword;
    }
    
    /**
     * Static method that returns the instance for the singleton
     * 
     * @return {Connection} connection
     **/
    
    public static Connection connect() {
        if (connection == null) {
            loadDriver();
            loadConnection();
        }
        return connection;
    }
    
    /**
     * Static method that close the connection to the database
     * 
     * @return void
     **/
    
    public static void closeConnection() {
        if (connection == null) {
            errorHandler("No connection found", null);
        }
        else {
            try {
                connection.close();
                connection = null;
            }
            catch (SQLException e) {
                errorHandler("Failed to close the connection", e);
            }
        }
    }
    
    /**
     * Method to execute a given SQL update on the connection
     * 
     * @param sql
     * @return void
     **/
    
    public static void executeUpdate(String sql) {
    	Statement stmt = null;
    	try {
    		stmt = connection.createStatement();
    		stmt.executeUpdate(sql);
    	} catch (SQLException e) {
    		errorHandler("Could not execute update", e);
    	} finally {
    		if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					errorHandler("Could not close statement", e);
				}
    		}
    	}
    }
    
    public static ResultSet executeQuery(String sql) {
    	Statement stmt = null;
    	ResultSet rset = null;
    	try {
    		stmt = connection.createStatement();
    		rset = stmt.executeQuery(sql);
    	} catch (SQLException e) {
    		errorHandler("Could not execute update", e);
    	} finally {
    		if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					errorHandler("Could not close statement", e);
				}
    		}
    	}
    	return rset;
    }

	public static boolean hasConnection() {
		boolean valid = false;
		if (connection != null) {
			valid = true;
		}
		return valid;
	}
}