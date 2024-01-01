package com.KoreaIT.example.JAM;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

import com.KoreaIT.example.JAM.container.Container;
import com.KoreaIT.example.JAM.controller.ArticleController;
import com.KoreaIT.example.JAM.controller.MemberController;


public class App {

	public void run() {
		
		Container.sc = new Scanner(System.in);
		Container.init();
	
		while(true) {
			System.out.printf("명령어) ");
			String cmd = Container.sc.nextLine().trim();
			
			Connection conn = null;
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e ) {
				
				System.out.println("드라이버 로딩 실패");
				break;
			}
			
			String url = "jdbc:mysql://127.0.0.1:3306/jdbc_article_manager?useUniCode=true&characterEncoding=utf8&autoReconnect=true&serverTimezone=Asia/Seoul&useOldAliasMetadataBehavior=true&zeroDateTimeNehavior=convertToNull";
			
			try {
				conn = DriverManager.getConnection(url, "root", "1234");
				Container.conn = conn;
				doAction(cmd);
				
				if(cmd.equals("exit")) {
					System.out.println("프로그램을 종료합니다.");
					break;
				}
				
			}  catch (SQLException e) {
				System.out.println("에러: " +  e);
				break;			
			} finally {
				try {							
					if (conn != null && !conn.isClosed()) {
						conn.close();					
					}
				} catch (SQLException e) {					
					e.printStackTrace();
				}				
			}			
		}	
		Container.sc.close();		
	}

	private void doAction(String cmd) {		

		MemberController memberController = Container.memberController;
		ArticleController articleController = Container.articleController;

		if (cmd.equals("member join")) {
			memberController.doJoin(cmd);
		} else if (cmd.equals("member logout")) {
			memberController.logout(cmd);
		} else if (cmd.equals("member login")) {
			memberController.login(cmd);
		} else if (cmd.equals("member profile")) {
			memberController.showProfile(cmd);
		} else if (cmd.equals("article write")) {
			articleController.doWrite(cmd);
		} else if (cmd.startsWith("article list")) {
			articleController.showList(cmd);
		} else if (cmd.startsWith("article detail ")) {
			articleController.showDetail(cmd);
		} else if (cmd.startsWith("article modify ")) {
			articleController.doModify(cmd);
		} else if (cmd.startsWith("article delete ")) {
			articleController.doDelete(cmd);
		} else {
			System.out.println("존재하지 않는 명령어 입니다");
		}
	}
}
