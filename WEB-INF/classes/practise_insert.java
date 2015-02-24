import java.util.*;
import java.sql.*;

public class practise_insert {

public static void main(String args[]) {

       String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
       String m_driverName = "oracle.jdbc.driver.OracleDriver";

       String m_userName = "commande";
       String m_password = "Alexsq2015";

       Connection m_con;
       String queryString;
       String insertString1;
       String insertString2;

	queryString = "select T_NAME, SUP_ID, PRICE, SALES, TOTAL  from  TOFFEES";
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

              stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
              ResultSet rset = stmt.executeQuery(queryString);

	      rset.moveToInsertRow();
	      rset.updateString(1,"TRIADBURY");
	      rset.updateInt(2,2000);
	      rset.updateDouble(3,8.00);
	      rset.updateInt(4,9999);
	      rset.updateInt(5 ,6666);

	      rset.insertRow(); /**************** Necessary ************/


              ResultSet rset1 = stmt.executeQuery(queryString);



	      while(rset1.next())
 	      {
     		System.out.println(rset1.getString(1) + "   " +
          	rset1.getInt(2) + "   " +
          	rset1.getDouble(3) + "   " +
          	rset1.getInt(4) + "  " +
          	rset1.getInt(5));
 	      }

              stmt.close();
              m_con.close();

       } catch(SQLException ex) {

              System.err.println("SQLException: " +
              ex.getMessage());

       }

}
}


