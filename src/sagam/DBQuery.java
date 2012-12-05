package sagam;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBQuery {
	
	private Connection connection;
	private PreparedStatement preparedStatement;
	private ResultSet resultSet;
	
	
	public ResultSet runQuery(String sql){
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			connection = DriverManager.getConnection("jdbc:mysql://localhost/sagam", "root", "218445");
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();			
			return resultSet;
		} catch (SQLException | InstantiationException | IllegalAccessException | ClassNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		}		
	}
	
	public void close(){
		try {
			resultSet.close();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			//Do nothing
		}
		
	}

}
