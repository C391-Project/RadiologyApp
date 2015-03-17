package db;

public interface Table {

	public abstract boolean isValid();

	public abstract String generateInsertSql();

}