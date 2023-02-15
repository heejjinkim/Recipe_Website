package step;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import bbs.BbsDTO;

public class StepDAO {

	private Connection con;
	private ResultSet rs;
	
	public StepDAO() {
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
	
	public int getMaxStep(int boardID) {
		int MaxID = 0;
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("select max(stepID) as max_id from step where boardID="+ boardID);
			if(rs.next()) {
				MaxID = rs.getInt("max_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return MaxID;		
	}
	
	public int getPx() {
		int pk = 0;
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("select max(pk) as max_id from step");
			if(rs.next()) {
				pk = rs.getInt("max_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pk;
	}
	
	public void setStep(String[] contents, ArrayList<String> imgs, int boardID) {
		String SQL = "insert into step values(?, ?, ?, ?, ?)";
		int pk = getPx();
		try {
			for(int i = 0; i < contents.length; i++) {
				pk++;
				PreparedStatement pstmt = con.prepareStatement(SQL);
				pstmt.setInt(1, i + 1); 
				pstmt.setInt(2, boardID); 
				pstmt.setString(3, contents[i]);
				pstmt.setString(4, imgs.get(i));
				pstmt.setInt(5, pk);
				pstmt.executeUpdate();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<StepDTO> getStepList(int boardID) {
		String SQL = "select * from step where boardID=" + boardID;
		ArrayList<StepDTO> list = new ArrayList<StepDTO>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				StepDTO step = new StepDTO();
				step.setStepID(rs.getInt(1));
				step.setBoardID(rs.getInt(2));
				step.setStepContent(rs.getString(3));
				step.setImageFile(rs.getString(4));
				step.setPk(rs.getInt(5));
				list.add(step);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public StepDTO getStep(int boardID, int stepID) {
		String SQL = "select * from step where boardID=? and stepID=?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.setInt(2, stepID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				StepDTO step = new StepDTO();
				step.setStepID(rs.getInt(1));
				step.setBoardID(rs.getInt(2));
				step.setStepContent(rs.getString(3));
				step.setImageFile(rs.getString(4));
				step.setPk(rs.getInt(5));
				return step;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void deleteStep(int boardID) {
		String SQL = "delete from step where boardID = " + boardID;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
