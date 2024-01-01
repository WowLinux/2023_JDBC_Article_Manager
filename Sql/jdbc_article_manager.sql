#DB 삭제/생성/선택
#https://github.com/devCJH/2022_JDBC_Article_Manager/blob/master/src/com/KoreaIT/example/JAM/session/Session.java
#https://github.com/devCJH/2023_JDBC_Article_Manager/blob/master/src/com/KoreaIT/example/JAM/controller/MemberController.java//

DROP DATABASE IF EXISTS jdbc_article_manager;
CREATE DATABASE jdbc_article_manager;
USE jdbc_article_manager;

# article 테이블 생성
CREATE TABLE article(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	title VARCHAR(200) NOT NULL,
	`body` TEXT NOT NULL
);

DESC article;
SELECT * FROM article;

#member 테이블생성

CREATE TABLE `member` (
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
loginId VARCHAR(20) NOT NULL UNIQUE,
loginPw VARCHAR(50) NOT NULL,
`name` VARCHAR(50) NOT NULL
);


# article 데이터 추가
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = CONCAT('제목', RAND()),
`body` = CONCAT('내용', RAND());

# member 데이터 추가

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = CONCAT('TestId', RAND()),
loginPw = CONCAT('TestPw', RAND()),
`name` = CONCAT('TestName', RAND());

# article 테이블 조회
SELECT * FROM article;

# member 테이블 조회
SELECT * FROM `member`;


#=========================================20231231=============
#DB 삭제/생성/선택
DROP DATABASE IF EXISTS jdbc_article_manager;
CREATE DATABASE jdbc_article_manager;
USE jdbc_article_manager;

# article 테이블 생성
CREATE TABLE article(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	title VARCHAR(200) NOT NULL,
	`body` TEXT NOT NULL
);

DESC article;
SELECT * FROM article;

#member 테이블생성

CREATE TABLE `member` (
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
loginId VARCHAR(20) NOT NULL UNIQUE,
loginPw VARCHAR(50) NOT NULL,
`name` VARCHAR(50) NOT NULL
);

ALTER TABLE article ADD COLUMN memberId INT UNSIGNED NOT NULL AFTER updateDate;

# article 데이터 추가
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'test1',
`body` = 'test1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
title = 'test2',
`body` = 'test2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
title = 'test3',
`body` = 'test3';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'test4',
`body` = 'test4';

# member 데이터 추가

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '김철수';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '김영희';

# article 테이블 조회
SELECT * FROM article;

# member 테이블 조회
SELECT * FROM `member`;

#==========================================================================20231231==============
#DB 삭제/생성/선택
DROP DATABASE IF EXISTS jdbc_article_manager;
CREATE DATABASE jdbc_article_manager;
USE jdbc_article_manager;

# article 테이블 생성
CREATE TABLE article(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	title VARCHAR(200) NOT NULL,
	`body` TEXT NOT NULL
);

DESC article;
SELECT * FROM article;

#member 테이블생성

CREATE TABLE `member` (
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
loginId VARCHAR(20) NOT NULL UNIQUE,
loginPw VARCHAR(50) NOT NULL,
`name` VARCHAR(50) NOT NULL
);

#article 테이블에 회원번호 컬럼 추가
ALTER TABLE article ADD COLUMN memberId INT UNSIGNED NOT NULL AFTER updateDate;

#article 테이블에 조회수 컬럼 추가
ALTER TABLE article ADD COLUMN hit INT UNSIGNED NOT NULL 

# article 데이터 추가
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'test1',
`body` = 'test1',
hit = 5;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
title = 'test2',
`body` = 'test2',
hit = 15;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
title = 'test3',
`body` = 'test3',
hit = 17;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'test4',
`body` = 'test5',
hit = 20;

# member 데이터 추가

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '김철수';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '김영희';

# article 테이블 조회
SELECT * FROM article;

# member 테이블 조회
SELECT * FROM `member`;

SELECT A.*, M.name AS writerName
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id

UPDATE article
SET hit=hit +1

SELECT A.*, M.name AS writerName
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
WHERE A.id = 2;


#+++++++++++++++++++++조건에 맞는것을 먼저 join을 걸고 걸린 조건에서 데이터 테이블(A)을 만들고  필요조건을 다시 건다. 
select a.*, m.name as writerName
from article as a
inner join `member` as m
on a.title like "%a%"
order by a.id desc
limit 10,10;



select * 
from ( select a.*, m.name as writeName
		from article as a
		inner join `member` as m
		on a.memberId = m.id
		order by a.id desc
		limit 10,10
	) A
	where title like "%a%";
