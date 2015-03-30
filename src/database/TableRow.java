package database;

/**
 * Interface for objects used to store and work with information from the database.
 * 
 * @author Brett Commandeur
 *
 */
public interface TableRow {

	public abstract boolean isValid();

	public abstract String generateInsertSql();
	
	public abstract String generateUpdateSql();

}