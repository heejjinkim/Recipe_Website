package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class BbsDAO {
	private Connection con;
	private ResultSet rs;
	
	public BbsDAO() {
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
	
	public int post(BbsDTO bbsInfo) {
		String SQL = "INSERT INTO board VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, bbsInfo.getBoardID());
			pstmt.setString(2, bbsInfo.getUserID());
			pstmt.setString(3, bbsInfo.getTitle());
			pstmt.setString(4, bbsInfo.getIntro());
			pstmt.setString(5, bbsInfo.getTheme());
			pstmt.setString(6, bbsInfo.getSort());
			pstmt.setString(7, bbsInfo.getIngredient());
			pstmt.setString(8, bbsInfo.getIngList());
			pstmt.setString(9, bbsInfo.getThumb());
			pstmt.setString(10, getDate());
			pstmt.setInt(11, bbsInfo.getLikes());
			pstmt.setInt(12, bbsInfo.getViews());
			pstmt.executeUpdate();
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.print(e);
		}
		return -1; //데이터베이스 오류
	}
	
	public BbsDTO getBbs(int boardID) {
		try {			
			PreparedStatement pst = con.prepareStatement("SELECT * FROM board WHERE boardID = ?");
			pst.setInt(1, boardID);
			rs = pst.executeQuery();
			if (rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBoardID(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setIntro(rs.getString(4));
				bbs.setTheme(rs.getString(5));
				bbs.setSort(rs.getString(6));
				bbs.setIngredient(rs.getString(7));
				bbs.setIngList(rs.getString(8));
				bbs.setThumb(rs.getString(9));
				bbs.setDate(rs.getString(10));
				bbs.setLikes(rs.getInt(11));
				bbs.setViews(rs.getInt(12));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int getMaxID() {
		int MaxID = 0;
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("select max(boardID) as max_id from board;");
			if(rs.next()) {
				MaxID = rs.getInt("max_id");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return MaxID;		
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "SELECT boardID FROM board ORDER BY boardID DESC";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	public ArrayList<BbsDTO> getList(int startRow, int pageSize){
		String SQL = "SELECT * FROM board ORDER BY boardID DESC LIMIT ?, ?"; 
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, startRow-1); //시작행-1 (시작 row 인덱스 번호)
			pstmt.setInt(2, pageSize); // 페이지크기 (한번에 출력되는 수)
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBoardID(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setIntro(rs.getString(4));
				bbs.setTheme(rs.getString(5));
				bbs.setSort(rs.getString(6));
				bbs.setIngredient(rs.getString(7));
				bbs.setIngList(rs.getString(8));
				bbs.setThumb(rs.getString(9));
				bbs.setDate(rs.getString(10));
				bbs.setLikes(rs.getInt(11));
				bbs.setViews(rs.getInt(12));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<BbsDTO> getByUser(String userID){
		String SQL = "SELECT * FROM board WHERE userID = ?"; 
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBoardID(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setIntro(rs.getString(4));
				bbs.setTheme(rs.getString(5));
				bbs.setSort(rs.getString(6));
				bbs.setIngredient(rs.getString(7));
				bbs.setIngList(rs.getString(8));
				bbs.setThumb(rs.getString(9));
				bbs.setDate(rs.getString(10));
				bbs.setLikes(rs.getInt(11));
				bbs.setViews(rs.getInt(12));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<BbsDTO> getCategory(String name, String value, int startRow, int pageSize) {
		String SQL = "SELECT * FROM board WHERE " + name  + " = ? ORDER BY boardID DESC LIMIT ?, ?";
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1,  value);
			pstmt.setInt(2, startRow-1); //시작행-1 (시작 row 인덱스 번호)
			pstmt.setInt(3, pageSize); // 페이지크기 (한번에 출력되는 수)

			rs = pstmt.executeQuery();
			while (rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBoardID(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setIntro(rs.getString(4));
				bbs.setTheme(rs.getString(5));
				bbs.setSort(rs.getString(6));
				bbs.setIngredient(rs.getString(7));
				bbs.setIngList(rs.getString(8));
				bbs.setThumb(rs.getString(9));
				bbs.setDate(rs.getString(10));
				bbs.setLikes(rs.getInt(11));
				bbs.setViews(rs.getInt(12));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public BbsDTO getRandom(String theme, String sort, String ingredient) {
		String SQL = "SELECT * FROM board WHERE theme LIKE ? and sort LIKE ? and ingredient LIKE ? ORDER BY rand() LIMIT 1";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			if(theme.equals("--주제별--")) pstmt.setString(1, "%");
			else pstmt.setString(1, theme);				

			if(sort.equals("--종류별--")) pstmt.setString(2, "%");
			else pstmt.setString(2, sort);	

			if(ingredient.equals("--재료별--")) pstmt.setString(3, "%");
			else pstmt.setString(3, ingredient);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				BbsDTO bbs = this.getBbs(rs.getInt(1));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<BbsDTO> getRanking(int startRow, int pageSize) {
		String SQL = "SELECT * FROM board ORDER BY views DESC LIMIT ?, ?";
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, startRow-1); //시작행-1 (시작 row 인덱스 번호)
			pstmt.setInt(2, pageSize); // 페이지크기 (한번에 출력되는 수)
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBoardID(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setIntro(rs.getString(4));
				bbs.setTheme(rs.getString(5));
				bbs.setSort(rs.getString(6));
				bbs.setIngredient(rs.getString(7));
				bbs.setIngList(rs.getString(8));
				bbs.setThumb(rs.getString(9));
				bbs.setDate(rs.getString(10));
				bbs.setLikes(rs.getInt(11));
				bbs.setViews(rs.getInt(12));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int boardNum() {
		String SQL = "SELECT COUNT(*) FROM board";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public ArrayList<BbsDTO> getSearch(String searchText){
		String SQL = "SELECT * FROM board WHERE TITLE"; 
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		try {
			if(searchText != null && !searchText.equals("") ){
                SQL +=" LIKE '%"+searchText.trim()+"%' order by boardID desc limit 10";
            }
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBoardID(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setIntro(rs.getString(4));
				bbs.setTheme(rs.getString(5));
				bbs.setSort(rs.getString(6));
				bbs.setIngredient(rs.getString(7));
				bbs.setIngList(rs.getString(8));
				bbs.setThumb(rs.getString(9));
				bbs.setDate(rs.getString(10));
				bbs.setLikes(rs.getInt(11));
				bbs.setViews(rs.getInt(12));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int delete(int boardID) {
		String SQL = "DELETE FROM board WHERE boardID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public void update(int boardID, String field, String value) {
		String SQL = "UPDATE board SET " + field +"= '" + value + "' WHERE boardID=?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update(int boardID, String field, int value) {
		String SQL = "UPDATE board SET " + field +"= '" + value + "' WHERE boardID=?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void viewUpdate(int boardID) {
		String SQL = "update board set views=views+1 where boardID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int userGetLikes(String userID) {
		String SQL = "SELECT * FROM board WHERE userID = ?";
		int likes = 0;
		try {			
			PreparedStatement pst = con.prepareStatement(SQL);
			pst.setString(1, userID);
			rs = pst.executeQuery();
			while(rs.next()) {
				likes += rs.getInt(11);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return likes;
	}
	
	public int getUserBbsNum(String userID) {
		String SQL = "SELECT * FROM board WHERE userID = ?";
		int num = 0;
		try {			
			PreparedStatement pst = con.prepareStatement(SQL);
			pst.setString(1, userID);
			rs = pst.executeQuery();
			while(rs.next()) {
				num++;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return num;
	}
	
}
