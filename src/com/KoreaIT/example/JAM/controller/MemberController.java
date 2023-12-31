package com.KoreaIT.example.JAM.controller;

import com.KoreaIT.example.JAM.Member;
import com.KoreaIT.example.JAM.container.Container;
import com.KoreaIT.example.JAM.service.MemberService;

public class MemberController extends Controller {

	private MemberService memberService;

	public MemberController() {
		this.memberService = Container.memberService;
	}

	public void doJoin(String cmd) {
		String loginId = null;
		String loginPw = null;
		String loginPwChk = null;
		String name = null;

		System.out.println("==== 회원가입 ===");

		while (true) {
			System.out.printf("아이디 : ");
			loginId = sc.nextLine().trim();

			if (loginId.length() == 0) {
				System.out.println("아이디를 입력해주세요.");
				continue;
			}

			boolean isLoginIdDup = memberService.isLoginIdDup(loginId);

			if (isLoginIdDup) {
				System.out.printf("%s은(는) 이미 사용중인 아이디 입니다\n", loginId);
				continue;
			}

			break;
		}
		while (true) {
			System.out.printf("비밀번호 : ");
			loginPw = sc.nextLine().trim();

			if (loginPw.length() == 0) {
				System.out.println("비밀번호를 입력해주세요.");
				continue;
			}

			boolean loginPwCheck = true;

			while (true) {
				System.out.printf("비밀번호 확인: ");
				loginPwChk = sc.nextLine().trim();

				if (loginPwChk.length() == 0) {
					System.out.println("비밀번호 확인을 입력해주세요.");
					continue;
				}
				if (loginPw.equals(loginPwChk) == false) {
					System.out.println("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
					loginPwCheck = false;
				}
				break;
			}
			if (loginPwCheck) {
				break;
			}
		}
		while (true) {
			System.out.printf("이름 : ");
			name = sc.nextLine().trim();

			if (name.length() == 0) {
				System.out.println("이름을 입력해주세요.");
				continue;
			}
			break;
		}

		memberService.doJoin(loginId, loginPw, name);

		System.out.printf("%s회원님, 가입 되었습니다.\n", name);

	}

	public void logout(String cmd) {
		Container.session.logout();
		System.out.println("로그아웃 되었습니다.");
	}

	public void login(String cmd) {
		String loginId = null;
		String loginPw = null;

		System.out.println("== 로그인 ==");
		while (true) {
			System.out.printf("아이디 : ");
			loginId = sc.nextLine().trim();

			if (loginId.length() == 0) {
				System.out.println("아이디를 입력해 주세요.");
				continue;
			}

			boolean isLoginIdDup = memberService.isLoginIdDup(loginId);

			if (isLoginIdDup == false) {
				System.out.printf("%s은(는) 존재하지 않는 아이디입니다\n", loginId);
				continue;
			}

			break;
		}

		Member member = memberService.getMemberByLoginId(loginId);

		int tryCount = 0;
		int tryMaxCount = 3;

		while (true) {
			if (tryCount >= tryMaxCount) {
				System.out.println("비밀번호를 확인하고 다시 시도해 주세요");
				break;
			}
			System.out.printf("비밀번호 : ");
			loginPw = sc.nextLine().trim();

			if (loginPw.length() == 0) {
				tryCount++;
				System.out.println("비밀번호를 입력해 주세요.");
				continue;
			}
			if (member.loginPw.equals(loginPw) == false) {
				// if (member.loginPw.equals(loginPw) == false) {
				tryCount++;
				System.out.println("비밀번호가 일치하지 않습니다.");
				continue;
			}
			System.out.printf("%s님 환영합니다.\n", member.name);
			Container.session.login(member);
			break;
		}

	}

	public void showProfile(String cmd) {
		if (Container.session.loginedMemberId == -1) {
			System.out.println("로그인 상태가 아닙니다.");
			return;
		}

		System.out.println("아이디 : " + Container.session.loginedMember.loginId);
		System.out.println("가입일 : " + Container.session.loginedMember.regDate);
		System.out.println("이  름 : " + Container.session.loginedMember.name);
	}

}
