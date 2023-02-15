package bbs;

public class BbsDTO {
	private int boardID;
	private String userID;
	private String title;
	private String intro;
	private String theme;
	private String sort;
	private String ingredient;
	private String ingList;
	private String thumb;
	private String date;
	private int likes;
	private int views = 0;
	
	public int getBoardID() {
		return boardID;
	}
	public void setBoardID(int boardID) {
		this.boardID = boardID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String bbsTitle) {
		this.title = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getIngredient() {
		return ingredient;
	}
	public void setIngredient(String ingList) {
		this.ingredient = ingList;
	}
	public String getIngList() {
		return ingList;
	}
	public void setIngList(String ingList) {
		this.ingList = ingList;
	}
	public String getThumb() {
		return thumb;
	}
	public void setThumb(String thumb) {
		this.thumb = thumb;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}	
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
}
