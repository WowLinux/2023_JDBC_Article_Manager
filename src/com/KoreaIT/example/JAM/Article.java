package com.KoreaIT.example.JAM;

import java.time.LocalDateTime;
import java.util.Map;

public class Article extends Object{
	public int id;
	public LocalDateTime regDate;
	public LocalDateTime updateDate;
	public int memberId;
	public String title;
	public String body;
	public String writerName;
	public int hit;
	
	public Article(Map<String, Object> articleMap) {
		this.id = (int) articleMap.get("id");
		this.regDate = (LocalDateTime) articleMap.get("regDate");
		this.updateDate = (LocalDateTime) articleMap.get("updateDate");
		this.memberId = (int) articleMap.get("memberId");
		this.title = (String) articleMap.get("title");
		this.body = (String) articleMap.get("body");
		this.writerName = (String) articleMap.get("writerName");
		this.hit = (int) articleMap.get("hit");
		
	}

	@Override
	public String toString() {
		return "Article [id=" + id + ", regDate=" + regDate + ", updateDate=" + updateDate + ", memberId=" + memberId
				+ ", title=" + title + ", body=" + body + ", writerName=" + writerName + ", hit=" + hit + "]";
	}	
}
