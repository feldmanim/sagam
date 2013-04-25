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
	
	public int runUpdate(String sql){
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection("jdbc:mysql://localhost/sagam", "root", "218445");
			preparedStatement = connection.prepareStatement(sql);
			return preparedStatement.executeUpdate();	
		} catch (InstantiationException | IllegalAccessException
				| ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return 0;
						
	}
	
	public void close(){
		try {
			if (resultSet!=null)
			resultSet.close();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			//Do nothing
		}
		
	}

}
