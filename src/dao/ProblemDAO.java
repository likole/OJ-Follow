package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBUtil;

public class ProblemDAO {
	public static String getTitle(String idString) throws SQLException {
		//
		int id = Integer.parseInt(idString);
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt;
		ResultSet rs;
		//
		String sql = "SELECT * FROM `problem` WHERE `pid` = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, id);
		rs = stmt.executeQuery();
		while (rs.next()) {
			return rs.getString("title");
		}
		return "";
	}

	public static String getTitle(int id) throws SQLException {
		//
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt;
		ResultSet rs;
		//
		String sql = "SELECT title FROM problem WHERE pid=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, id);
		rs = stmt.executeQuery();
		while (rs.next()) {
			return rs.getString("title");
		}
		return "";
	}
}
