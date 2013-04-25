package entities;

import java.util.Date;

public class Fault {

	private long id;
	private Date date;
	private boolean isAmorization;
	private WorkError error;

	public WorkError getError() {
		return error;
	}
	public void setError(WorkError error) {
		this.error = error;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public boolean isAmorization() {
		return isAmorization;
	}
	public void setAmorization(boolean isAmorization) {
		this.isAmorization = isAmorization;
	}
	
}
