package sagam;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MainTest {

	public static void main(String[] args) throws SQLException {
		DBQuery dbQuery = new DBQuery();
		ResultSet runQuery = dbQuery.runQuery("select * from faults");
		while (runQuery.next()){
		System.out.println(runQuery.getInt(1));
		System.out.println(runQuery.getTimestamp(3));
		}
	}
}
