package com.KoreaIT.example.JAM.service;

import java.sql.Connection;

import com.KoreaIT.example.JAM.dao.MemberDao;

public class MemberService {
	
	private MemberDao memberDao;
	
	public MemberService(Connection conn) {
		this.memberDao = new MemberDao(conn);
	}

	public boolean isLoginIdDup(String loginId) {
		// TODO Auto-generated method stub
		return memberDao.isLoginDup(loginId);
	}

	public int doJoin(String loginId, String loginPw, String name) {
		// TODO Auto-generated method stub
		return memberDao.doJoin(loginId, loginPw, name);
	}

}
