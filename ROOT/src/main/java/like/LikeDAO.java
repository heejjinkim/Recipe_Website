package like;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import calendar.CalendarDTO;

public class LikeDAO {
	private Connection con;
	private ResultSet rs;
	
	public LikeDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost/eeheueklf?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "eeheueklf";
			String dbPassword = "mydbpw020306";
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int LikeChk(String userID, int boardID) {
		String SQL = "SELECT EXISTS (SELECT * FROM liketable where userID=? AND boardID=?) as isChk";
		int chk = 0; 
		try {
			PreparedStatement pst = con.prepareStatement(SQL);
			pst.setString(1, userID);
			pst.setInt(2, boardID);
			rs = pst.executeQuery();
			if(rs.next()) {
				chk = Integer.parseInt(rs.getString("isChk"));
			}
			System.out.println(chk);
			return chk;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int Like(int likeID, String userID, int boardID) {
		String SQL = "INSERT INTO liketable VALUES(?, ?, ?)";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, likeID);
			pstmt.setString(2, userID);
			pstmt.setInt(3,boardID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public void boardUp(int boardID) {
		String SQL = "update board set likes=likes+1 where boardID = ?";
		try {			
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int LikeDelete(String userID, int boardID) {
		String SQL = "DELETE FROM liketable WHERE userID = ? AND boardID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2,boardID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public void boardUpdate(int boardID) {
		String SQL = "update board set likes=likes-1 where boardID = ?";
		try {			
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getMaxLikeID() {
		int MaxCommentID = 0;
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("select max(likeID) as max_id from liketable;");
			if(rs.next()) {
				MaxCommentID = rs.getInt("max_id");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return MaxCommentID;		
	}
	
	public ArrayList<LikeDTO> getLikelist(String userID) {
		String SQL = "SELECT * FROM liketable WHERE userID = ? ORDER BY likeID ASC";
		ArrayList<LikeDTO> list = new ArrayList<LikeDTO>();
		try {			
			PreparedStatement pst = con.prepareStatement(SQL);
			pst.setString(1, userID);
			rs = pst.executeQuery();
			while (rs.next()) {
				LikeDTO like = new LikeDTO();
				like.setLikeID(rs.getInt(1));
				like.setUserID(rs.getString(2));
				like.setBoardID(rs.getInt(3));
				list.add(like);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public void deleteLike(int boardID, String userID) {
		String SQL = "DELETE FROM liketable WHERE boardID= ? and userID = ?";
		try {			
			PreparedStatement pst = con.prepareStatement(SQL);
			pst.setInt(1, boardID);
			pst.setString(2, userID);
			pst.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getLikeNum(int boardID) {
		String SQL = "SELECT COUNT(*) FROM liketable WHERE boardID = ?";
		try {			
			PreparedStatement pst = con.prepareStatement(SQL);
			pst.setInt(1, boardID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
}
