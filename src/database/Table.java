package database;

public interface Table {

	public abstract boolean isValid();

	public abstract String generateInsertSql();
	
	public abstract String generateUpdateSql();

}