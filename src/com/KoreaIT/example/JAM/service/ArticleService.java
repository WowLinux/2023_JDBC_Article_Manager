package com.KoreaIT.example.JAM.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.KoreaIT.example.JAM.Article;
import com.KoreaIT.example.JAM.container.Container;
import com.KoreaIT.example.JAM.dao.ArticleDao;

public class ArticleService {

	private ArticleDao articleDao;

	public ArticleService() {
		articleDao = Container.articleDao;
	}

	public int doWrite(int memberId, String title, String body) {
		return articleDao.doWrite(memberId, title, body);
	}

	public int doModify(int id, String title, String body) {
		return articleDao.doModify(id, title, body);
	}

	public void doDelete(int id) {
		articleDao.doDelete(id);
	}

	public boolean isArticleExists(int id) {
		return articleDao.isArticleExists(id);
	}

	public Article getArticle(int id) {
		return articleDao.getArticle(id);
	}

	public List<Article> getArticles() {
		return articleDao.getArticles();
	}

	public void increaseHit(int id) {
		ArticleDao.increaseHit(id);

	}

	public List<Article> getForPrintArticles(int page, int itemsInAPage, String searchKeyword) {
		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;
		
		Map<String, Object> args = new HashMap<>();
		args.put("searchKeyword", searchKeyword); //Key값은 임의로 지정해서 상용할 수 있으나 나중에 했갈릴 수 있기 때문에 key와 value를 동일하게 사용하는 것이 좋다.
		args.put("limitFrom", limitFrom); 
		args.put("limitTake", limitTake); 
		return articleDao.getForPrintArticles(args); 
	}
}
