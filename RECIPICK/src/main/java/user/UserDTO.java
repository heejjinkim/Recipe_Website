package user;

public class UserDTO {
	private String userID;
	private String userPassword;
	private String userEmail;
	private String userName;
	private String userImg = "images/기본프로필.png";
	private String userPr = "한줄 소개를 작성해주세요.";
	private String userEmailAD;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserImg() {
		return userImg;
	}
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}
	public String getUserPr() {
		return userPr;
	}
	public void setUserPr(String userPr) {
		this.userPr = userPr;
	}
	public String getUserEmailAD() {
		return userEmailAD;
	}
	public void setUserEmailAD(String userEmailAD) {
		this.userEmailAD = userEmailAD;
	}
}
