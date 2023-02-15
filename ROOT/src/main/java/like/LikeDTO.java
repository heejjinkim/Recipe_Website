package like;

public class LikeDTO {
	int likeID;
	String userID;
	int boardID;
	
	public int getLikeID() {
		return likeID;
	}
	public void setLikeID(int likeID) {
		this.likeID = likeID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getBoardID() {
		return boardID;
	}
	public void setBoardID(int boardID) {
		this.boardID = boardID;
	}
}
