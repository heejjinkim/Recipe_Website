package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class CommentDAO {	
	private Connection conn;
	private ResultSet rs;
	
	public CommentDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost/eeheueklf?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "eeheueklf";
			String dbPassword = "mydbpw020306";
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getCommentDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public ArrayList<CommentDTO> getList(int boardID){
		String SQL = "SELECT * FROM comment WHERE boardID = ? ORDER BY commentID DESC"; 
		ArrayList<CommentDTO> list = new ArrayList<CommentDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentDTO cmt = new CommentDTO();
				cmt.setCommentID(rs.getInt(1));
				cmt.setBoardID(rs.getInt(2));
				cmt.setContent(rs.getString(3));
				cmt.setDate(rs.getString(4));
				cmt.setUserID(rs.getString(5));
				list.add(cmt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getNext() {
		String SQL = "SELECT commentID FROM comment ORDER BY commentID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getInt(1));
				return rs.getInt(1)+1; 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1; 
	}
	public int write(int commentID, int boardID, String content, String userID) {
		String SQL = "INSERT INTO comment VALUES(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			pstmt.setInt(2, boardID);
			pstmt.setString(3, content);
			pstmt.setString(4, getCommentDate());
			pstmt.setString(5, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public CommentDTO getComment(int commentID) {
		String SQL = "SELECT * FROM comment WHERE commentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  commentID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				CommentDTO cmt = new CommentDTO();
				cmt.setCommentID(rs.getInt(1));
				cmt.setBoardID(rs.getInt(2));
				cmt.setContent(rs.getString(3));
				cmt.setDate(rs.getString(4));
				cmt.setUserID(rs.getString(5));
				return cmt;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int delete(int commentID) {
		String SQL = "DELETE FROM comment WHERE commentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	
	public int getMaxCommentID() {
		int MaxCommentID = 0;
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery("select max(commentID) as max_id from comment;");
			if(rs.next()) {
				MaxCommentID = rs.getInt("max_id");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return MaxCommentID;		
	}	
}
