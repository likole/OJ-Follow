package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Mapping;
import util.DBUtil;

public class MappingDAO {
	public static List<Mapping> get(String username) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM `mapping` WHERE `username` = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		rs = stmt.executeQuery();

		List<Mapping> mappings = new ArrayList<Mapping>();
		while (rs.next()) {
			Mapping mapping = new Mapping();
			mapping.setAlias(rs.getString("alias"));
			mapping.setTargetid(rs.getString("targetid"));
			mapping.setMid(rs.getInt("mid"));
			mappings.add(mapping);
		}
		return mappings;
	}
	
	public static void add(Mapping mapping) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql="INSERT INTO `mapping` (`mid`, `username`, `targetid`, `alias`) VALUES (NULL, ?, ?, ?)";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, mapping.getusername());
		stmt.setString(2, mapping.getTargetid());
		stmt.setString(3, mapping.getAlias());
		stmt.execute();
	}
	
	public static void delete(int mid) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql="DELETE FROM `mapping` WHERE `mid` = ?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, mid);
		stmt.execute();
	}
}
