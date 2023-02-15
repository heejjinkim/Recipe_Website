package calendar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class CalendarDAO {
	private Connection conn;
	private ResultSet rs;
	
	public CalendarDAO() {
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
	public CalendarDTO getCal(int pk) {
		try {			
			PreparedStatement pst = conn.prepareStatement("SELECT * FROM calendar WHERE pk = ?");
			pst.setInt(1, pk);
			rs = pst.executeQuery();
			if (rs.next()) {
				CalendarDTO calDTO = new CalendarDTO();
				calDTO.setPk(rs.getInt(1));
				calDTO.setUserID(rs.getString(2));
				calDTO.setDate(rs.getString(3));
				calDTO.setBreakfast(rs.getInt(4));
				calDTO.setLunch(rs.getInt(5));
				calDTO.setDinner(rs.getInt(6));
				return calDTO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getToday() {
		String SQL = "SELECT CURDATE()";
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
	
	public int calNum(String userID) {
		String SQL = "SELECT COUNT(*) FROM calendar INNER JOIN user ON calendar.userID = user.userID where calendar.userID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int getKey(String userID, String date) {
		try {			
			PreparedStatement pstmt = conn.prepareStatement("SELECT calendar.pk FROM calendar "
					+"WHERE calendar.userID = ? AND calendar.date=?");
			pstmt.setString(1, userID);
			pstmt.setString(2, date);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int getMaxpk() {
		int MaxCommentID = 0;
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery("select max(pk) as max_pk from calendar");
			if(rs.next()) {
				MaxCommentID = rs.getInt("max_pk");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return MaxCommentID;
	}
	
	public String getTitle(String userID, String date, String meal) {
		try {			
			PreparedStatement pstmt = conn.prepareStatement("SELECT board.title, board.theme FROM calendar "
					+ "INNER JOIN board ON calendar."+meal+"= board.boardID WHERE calendar.userID = ? AND calendar.date=?");
			pstmt.setString(1, userID);
			pstmt.setString(2, date);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	

	public String getBoardID(String userID, String date, String meal) {
		try {			
			PreparedStatement pstmt = conn.prepareStatement("SELECT board.boardID, board.theme FROM calendar "
					+ "INNER JOIN board ON calendar."+meal+"= board.boardID WHERE calendar.userID = ? AND calendar.date=?");
			pstmt.setString(1, userID);
			pstmt.setString(2, date);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int chkCal(String userID) {
		try {			
			PreparedStatement pstmt = conn.prepareStatement("SELECT pk FROM calendar WHERE userID=? AND date =?");
			pstmt.setString(1, userID);
			pstmt.setString(2, getToday());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}	

	public int add(int pk, String userID, String meal, int boardID) {
		String SQL = "INSERT INTO calendar VALUES(?, ?, ?, ?, ?, ?)";
		if(meal.equals("breakfast")) {
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, pk);
				pstmt.setString(2, userID);
				pstmt.setString(3, getToday());
				pstmt.setInt(4, boardID);
				pstmt.setString(5, null);
				pstmt.setString(6, null);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(meal.equals("lunch")) {
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, pk);
					pstmt.setString(2, userID);
					pstmt.setString(3, getToday());
					pstmt.setString(4, null);
					pstmt.setInt(5, boardID);
					pstmt.setString(6, null);
					return pstmt.executeUpdate();
				}catch(Exception e) {
					e.printStackTrace();
				}
		}
		if(meal.equals("dinner")) {
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, pk);
				pstmt.setString(2, userID);
				pstmt.setString(3, getToday());
				pstmt.setString(4, null);
				pstmt.setString(5, null);
				pstmt.setInt(6, boardID);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
	}
		
		return -1;
	}

	public int update(CalendarDTO calDTO, String meal, int boardID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE calendar SET "+ meal +" =? WHERE pk = ?");
			pstmt.setInt(1, boardID);
			pstmt.setInt(2, calDTO.getPk());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public int delete(CalendarDTO calDTO, String meal) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE calendar SET "+ meal +" =null WHERE pk = ?");
			pstmt.setInt(1, calDTO.getPk());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public int count(int pk) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(breakfast)+COUNT(lunch)+COUNT(dinner) FROM calendar where pk=?");
			pstmt.setInt(1, pk);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int vanish(int pk) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("delete FROM calendar where pk=?");
			pstmt.setInt(1, pk);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
