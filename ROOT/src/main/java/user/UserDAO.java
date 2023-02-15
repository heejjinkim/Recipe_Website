package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.BbsDTO;
import user.UserDTO;

public class UserDAO {

	private Connection con;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT userPassword FROM user WHERE userID = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getString(1).equals(userPassword) ? 1 : 0;
			} else {
				return -2;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	public int changePassword(UserDTO userDTO) {
		if(!ID_Check(userDTO.getUserID())) { 
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE user SET userPassword =? WHERE userID = ?");
				pst.setString(1, userDTO.getUserPassword());
				pst.setString(2, userDTO.getUserID());
				return pst.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				return -1;
			}
		}
		else return 0;
	}
	
	// 중복여부 확인
	public boolean ID_Check(String userID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE userID = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int join(UserDTO userDTO) {
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO user VALUES (?,?,?,?,?,?,?)");
			pst.setString(1, userDTO.getUserID());
			pst.setString(2, userDTO.getUserPassword());
			pst.setString(3, userDTO.getUserEmail());
			pst.setString(4, userDTO.getUserName());
			pst.setString(5, userDTO.getUserImg());
			pst.setString(6, userDTO.getUserPr());
			pst.setString(7, userDTO.getUserEmailAD());
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 유저 데이터 가져오기
	public UserDTO getUser(String userID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE userID = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				UserDTO userDTO = new UserDTO();
				userDTO.setUserID(rs.getString(1));
				userDTO.setUserPassword(rs.getString(2));
				userDTO.setUserEmail(rs.getString(3));
				userDTO.setUserName(rs.getString(4));
				userDTO.setUserImg(rs.getString(5));
				userDTO.setUserPr(rs.getString(6));
				userDTO.setUserEmailAD(rs.getString(7));
				return userDTO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	public ArrayList<UserDTO> getUserList(){
		String SQL = "SELECT * FROM user"; 
		ArrayList<UserDTO> list = new ArrayList<UserDTO>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserDTO user = new UserDTO();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserEmail(rs.getString(3));
				user.setUserName(rs.getString(4));
				user.setUserImg(rs.getString(5));
				user.setUserPr(rs.getString(6));
				user.setUserEmailAD(rs.getString(7));
				list.add(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int delete(String userID) {
		String SQL = "DELETE FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public void update(String userID, String field, String value) {
		String SQL = "UPDATE user SET " + field +"= '" + value + "' WHERE userID=?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}