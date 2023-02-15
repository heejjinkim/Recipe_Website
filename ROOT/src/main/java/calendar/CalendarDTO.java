package calendar;

public class CalendarDTO {
	private int pk;
	private String userID;
	private String date;
	private int breakfast=0;
	private int lunch=0;
	private int dinner=0;
	
	public int getPk() {
		return pk;
	}
	public void setPk(int pk) {
		this.pk = pk;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getBreakfast() {
		return breakfast;
	}
	public void setBreakfast(int breakfast) {
		this.breakfast = breakfast;
	}
	public int getLunch() {
		return lunch;
	}
	public void setLunch(int lunch) {
		this.lunch = lunch;
	}
	public int getDinner() {
		return dinner;
	}
	public void setDinner(int dinner) {
		this.dinner = dinner;
	}
}
