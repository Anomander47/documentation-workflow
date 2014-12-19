package pl.student.dwf.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class History {

	@Id
	@GeneratedValue
	private Integer id;
	
	private String sentPost;
	
	private String editPost;
	
	private String deletePost;
	
	private Date date;

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSentPost() {
		return sentPost;
	}

	public void setSentPost(String sentPost) {
		this.sentPost = sentPost;
	}

	public String getEditPost() {
		return editPost;
	}

	public void setEditPost(String editPost) {
		this.editPost = editPost;
	}

	public String getDeletePost() {
		return deletePost;
	}

	public void setDeletePost(String deletePost) {
		this.deletePost = deletePost;
	}
}
