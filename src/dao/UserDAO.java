package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entity.User;
import util.DBUtil;

public class UserDAO {
	public static boolean exist(String username) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM `user` WHERE `username`=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		rs = stmt.executeQuery();
		while (rs.next()) {
			return true;
		}
		return false;
	}

	public static void add(User user) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		String sql = "INSERT INTO `user` (`uid`, `username`, `password`, `oid`, `email`, `email_valid`) VALUES (NULL, ? , MD5(?),'','', '0')";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, user.getUsername());
		stmt.setString(2, user.getPassword());
		stmt.execute();
	}

	public static User get(String username) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs;

		String sql = "SELECT * FROM `user` WHERE `username`=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		rs = stmt.executeQuery();

		while (rs.next()) {
			User user = new User();
			user.setEmail(rs.getString("email"));
			user.setUsername(rs.getString("username"));
			user.setOid(rs.getString("oid"));
			user.setEmail_valid(rs.getBoolean("email_valid"));
			return user;
		}
		return null;
	}

	public static void changeEmail(String username, String email) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		String sql = "UPDATE `user` SET `email` = ? WHERE `user`.`username` = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, email);
		stmt.setString(2, username);
		stmt.execute();
	}

	public static void changeOid(String username, String oid) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		String sql = "UPDATE `user` SET `oid` = ? WHERE `user`.`username` = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, oid);
		stmt.setString(2, username);
		stmt.execute();
	}

	public static boolean login(String username, String password) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM `user` WHERE `username`=? AND`password`=MD5(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		stmt.setString(2, password);
		rs = stmt.executeQuery();
		while (rs.next()) {
			return true;
		}
		return false;
	}
}
