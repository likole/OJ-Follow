package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Neglet;
import util.DBUtil;

public class NegletDAO {
	public static List<Neglet> get(String username) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM `neglet` WHERE `username` = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		rs = stmt.executeQuery();

		List<Neglet> neglets = new ArrayList<Neglet>();
		while (rs.next()) {
			Neglet neglet=new Neglet();
			neglet.setPid(rs.getInt("pid"));
			neglet.setNid(rs.getInt("nid"));
			neglets.add(neglet);
		}
		return neglets;
	}
	
	public static void add(Neglet neglet) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql="INSERT INTO `neglet` (`nid`, `username`, `pid`) VALUES (NULL, ?, ?)";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, neglet.getUsername());
		stmt.setInt(2, neglet.getPid());
		stmt.execute();
	}
	
	public static void delete(int nid) throws SQLException {
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql="DELETE FROM `neglet` WHERE `nid` = ?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, nid);
		stmt.execute();
	}
}
