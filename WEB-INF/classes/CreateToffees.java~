import java.util.*;
import java.sql.*;

public class CreateToffees {

public static void main(String args[]) {

       String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
       String m_driverName = "oracle.jdbc.driver.OracleDriver";

       String m_userName = "username";
       String m_password = "passwd";

       Connection m_con;
       String createString;
       createString = "create table TOFFEES " +

              "(T_NAME VARCHAR(32), " +
              "SUP_ID INTEGER, " +
              "PRICE FLOAT, " +
              "SALES INTEGER, " +
              "TOTAL INTEGER)";

       Statement stmt;

       try
       {

              Class drvClass = Class.forName(m_driverName);
              DriverManager.registerDriver((Driver)
              drvClass.newInstance());

       } catch(Exception e)
       {

              System.err.print("ClassNotFoundException: ");
              System.err.println(e.getMessage());

       }

       try
       {

              m_con = DriverManager.getConnection(m_url, m_userName,
              m_password);

              stmt = m_con.createStatement();
              stmt.executeUpdate(createString);
              stmt.close();
              m_con.close();

       } catch(SQLException ex) {

              System.err.println("SQLException: " +
              ex.getMessage());

       }

}
}

