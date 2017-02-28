package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	private static final String url = "jdbc:mysql://localhost:3306/oj_follow?useUnicode=true&characterEncoding=UTF-8";
	private static final String username = "root";
	private static final String password = "5vm8bIopZKVXX1d";
	private static Connection conn = null;

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("无法加载数据库驱动");
			e.printStackTrace();
		}
		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			System.out.println("数据库连接失败");
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		if (conn == null) {
			conn = DriverManager.getConnection(url, username, password);
		}
		return conn;
	}
}
