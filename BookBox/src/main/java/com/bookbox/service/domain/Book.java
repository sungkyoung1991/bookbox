package com.bookbox.service.domain;

import java.text.ParseException;
import java.util.List;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.Tag;

/**
 * @file com.bookbox.service.domain.Book.java
 * @brief Book domain
 * @detail
 * @author JJ
 * @date 2017.10.12
 */

public class Book {

	/// Field
	private String isbn;
	private String title;
	private List<String> authors;
	private String publisher;
	private String datetime;
	private String thumbnail;
	private long price;
	private String contents;
	private String url;
	private List<String> translators;
	private Grade grade;
	private Like like;
	private List<Reply> replyList;
	private Tag tag;

	public Book() {
		// TODO Auto-generated constructor stub
	}
	
	public Tag getTag() {
		return tag;
	}
	
	public void setTag(Tag tag) {
		this.tag = tag;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn.substring(isbn.length() - 13, isbn.length());
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<String> getAuthors() {
		return authors;
	}

	public void setAuthors(List<String> authors) {
		this.authors = authors;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getDatetime() throws ParseException {
		if(datetime == null) {
			return null;
		}
		return datetime.substring(0, 10);
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public long getPrice() {
		return price;
	}

	public void setPrice(long price) {
		this.price = price;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<String> getTranslators() {
		return translators;
	}

	public void setTranslators(List<String> translators) {
		this.translators = translators;
	}

	public Grade getGrade() {
		return grade;
	}

	public void setGrade(Grade grade) {
		this.grade = grade;
	}

	public Like getLike() {
		return like;
	}

	public void setLike(Like like) {
		this.like = like;
	}

	public List<Reply> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}

	@Override
	public String toString() {
		return "Book [isbn=" + isbn + ", title=" + title + ", authors=" + authors + ", publisher=" + publisher
				+ ", datetime=" + datetime + ", thumbnail=" + thumbnail + ", price=" + price + ", contents=" + contents
				+ ", url=" + url + ", translators=" + translators + ", grade=" + grade + ", like=" + like
				+ ", replyList=" + replyList + ", tag=" + tag + "]";
	}
}
