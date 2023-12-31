#새 데이터베이스 생성
CREATE DATABASE db_test2;
#새 데이터베이스(`db_test2`) 선택
USE db_test2;
#article 테이블 생성(id, regDate,title,body)
CREATE TABLE article(
id INT ,
regDate DATETIME,
title VARCHAR(100),
`body` TEXT
);
#article 테이블 조회
SELECT * FROM article;
#article 테이블에 data insert (regDate = now(), title = '제목', body = '내용')
INSERT INTO article
SET regDate = NOW(),
title ='제목',
BODY = '내용';
#article 테이블에 data insert (regDate = now(), title = '제목', body = '내용')
INSERT INTO article
SET regDate = NOW(),
title ='제목',
BODY = '내용';
#id 데이터는 꼭 필 수 이기 때문에 NULL을 허용하지 않게 바꾼다.(alter table, not null)
ALTER TABLE article MODIFY COLUMN id INT NOT NULL;
UPDATE article
SET id =0;
#생각해보면 모든 행(row)의 id값은 유니크 해야한다.(add primary key(id))
ALTER TABLE article ADD PRIMARY KEY(id);
#왜나하면 기존의 데이터 중에서 중복되는 것이 있기 때문에
#id가 0인 것중에서 1개를 id 1로 바꾼다.
UPDATE article 
SET id =1
LIMIT 1; 
UPDATE article 
SET id =2
where id=0; 

desc article;

alter table article modify column id int not null;
#생각해보면 모든 행(row)의 id값은 유니크 해야한다.(add primary key(id))
alter table article add primary key(id);
#이제 적용이 잘된다.
#id 컬럼에 auto_increment를  건다.
alter table article modify column id int not null auto_increment;
#auto_increment를 걸기전에 해당 컬럼은 무조건 key여야 한다.
#나머지 테이블 컬럼에도 not null을 적용해 주세요. 
alter table article modify column regDate datetime not null;
ALTER TABLE article MODIFY COLUMN title varchar(100) NOT NULL;
ALTER TABLE article MODIFY COLUMN `body` text NOT NULL;
#id 컬럼에 unsigned 속성을 추가하세요.
alter table article modify column id int  UNSIGNED  not null auto_increment;
#작성자(writer) 컬럼을 title컬럼 다음에 추가해 주세요.
alter table article add column writer varchar(100) not null after title;
#작성자(writer)의 컬럼의 이름을 nickname으로 변경해 주세요.
alter table article change writer nickname varchar(100) not null;
select * from article;
#nickname컬럼의 위치를 body 밑으로 보내주세요.
ALTER TABLE article modify COLUMN nickname VARCHAR(100) NOT NULL AFTER `body`;
#hit조회수 컬럼을 추가
alter table article add column hit int unsigned not null;
desc article;
update article set nickname ='무명'
where nickname='';
#article 테이블에 데이터 추가
INSERT INTO article
SET regDate = NOW(),
title ='제목6',
`body` = '내용6',
nickname = '임꺽정',
hit = 100;
#조회수 가장 많은 게시물 3개만 보여주세요. 힌트 order by, limit
select * from article order by hit desc limit 3;
#작성자가 '홍길'로 시작하는 게시물만 보여주세요 힌트 like '홍길%'
select * from article where nickname like'홍길%';
#조회수가 10 이상 55 이한 인것만 보여주세요. where 조건 1 and 조건2
select * from article where hit >10 and hit < 100;
#작성자가 '무명'이 아니고 조회수가 50 이하인 것만 보여주세요. 힌트 !=
select * from article where nickname != '무명' and hit <= 50;
#작성자가 '무명'이거나 조회수가 55 이상인 것만 보여주세요. 힌트 or
select * from article where nickname ='무명' or hit > 55;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
#a5 데이터베이스 삭제/생성/선택

DROP DATABASE IF EXISTS a5;
CREATE DATABASE a5;
USE a5;


#부서(dept) 테이블 생성 및 홍보부서 기획부서 추가

CREATE TABLE dept(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	`name` VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO dept
SET regDate = NOW(),
`name` = '홍보';

INSERT INTO dept
SET regDate = NOW(),
`name` = '기획';

SELECT * FROM dept ORDER BY id DESC;

#사원(emp) 테이블 생성 및 홍길동사원(홍보부서), 홍길순사원(홍보부서), 임꺽정사원(기획부서) 추가

CREATE TABLE emp(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
`name` VARCHAR(100) NOT NULL,
deptName VARCHAR(100) NOT NULL
);

DESC emp;

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길동',
deptName = '홍보';

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길순',
deptName = '홍보';

INSERT INTO emp
SET regDate = NOW(),
`name` = '임꺽정',
deptName = '기획';

SELECT * FROM emp ORDER BY id DESC;

#홍보를 마케팅으로 변경

UPDATE dept
SET `name` = '마케팅'
WHERE `name` = '홍보';

UPDATE emp
SET deptName = '마케팅'
WHERE deptName = '홍보';

#마케팅을 홍보로 변경

UPDATE dept
SET `name` = '홍보'
WHERE `name` = '마케팅';

UPDATE emp
SET deptName = '홍보'
WHERE deptName = '마케팅';

SELECT * FROM emp ORDER BY id DESC;
SELECT * FROM dept ORDER BY id DESC;

#구조를 변경하기로 결정(사원 테이블에서, 이제는 부서를 이름이 아닌 번호로 기억)

ALTER TABLE emp ADD COLUMN deptId INT UNSIGNED NOT NULL;
ALTER TABLE emp DROP COLUMN deptName;

UPDATE emp
SET deptId = 2
WHERE id = 3;

#사장님께 드릴 인명록을 생성
#사장님께서 부서번호가 아니라 부서명을 알고 싶어하신다.
#그래서 dept 테이블 조회법을 알려드리고 혼이 났다.
#이상한 데이터가 생성되어 혼남

SELECT * FROM emp,dept;
SELECT emp.*, dept.* FROM emp INNER JOIN dept;

SELECT emp.*, dept.name FROM emp INNER JOIN dept;

SELECT e.*,d.name AS '부서명'
FROM emp AS e INNER JOIN dept AS d;

#사장님께 드릴 인명록을 생성(v3, 부서명푸함, 올바른 조인 룰(ON) 적용)

SELECT e.*, d.name AS '부서명'
FROM emp AS e INNER JOIN dept AS d
ON e.deptId = d.id;

#보고용으로 좀 더  편하게 보여지도록 고쳐야 한다고 지적을 받음
SELECT e.id AS '사원번호', 
e.regDate AS '입사일',
e.name AS '사원명',
e.name AS '부서명'
FROM emp AS e INNER JOIN dept AS d
ON e.deptId = d.id
ORDER BY e.id, d.`name` DESC;


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//


# 집게함수와 GROUP BY 는 한 쌍이다

# a6 DB 삭제/생성/선택
DROP DATABASE IF EXISTS a6;
CREATE DATABASE a6;
USE a6;

#부서(홍보/기획)

INSERT INTO dept
SET regDate = NOW(),
`name` = '홍보';

INSERT INTO dept
SET regDate = NOW(),
`name` = '기획';

CREATE TABLE dept(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
`name` VARCHAR(100) NOT NULL UNIQUE
);

#사원(홍길동/홍보/5000만원, 홍길순/홍보/6000만원, 임꺽정/기획/4000만원)

CREATE TABLE emp(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
`name` VARCHAR(100) NOT NULL,
deptId INT UNSIGNED NOT NULL,
salary INT UNSIGNED NOT NULL
);

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길동',
deptId = 1,
salary = 5000;

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길순',
deptId = 1,
salary = 6000;

INSERT INTO emp
SET regDate = NOW(),
`name` = '임꺽정',
deptId = 2,
salary = 4000;

SELECT * FROM emp;

#사원수 출력
SELECT COUNT(*) FROM emp;
`a6`
#가장 큰 사원 번호 출력
SELECT MAX(id)
FROM emp;

#가장 고액 년봉
SELECT MAX(salary)
FROM emp;

#가장 소액 년봉
SELECT MIN(salary)
FROM emp;

#회사에서 1년  고정지출 인건비
SELECT SUM(salary)
FROM emp;

#부서별, 1년 고정 지출(인건비)

SELECT deptId,SUM(salary)
FROM emp
GROUP BY deptId
ORDER BY deptId;

#부서별 최고연봉

SELECT deptId,MAX(salary)
FROM emp
GROUP BY deptId;

#부서별 최저연봉
SELECT deptId, MIN(salary)
FROM emp
GROUP BY deptId;

#부서별 평균 연봉
SELECT deptId, AVG(salary)
FROM emp 
GROUP BY deptId;

#부서별,부서명,사원리스트,평균연봉,최고연봉,최소연봉,사원수
##V1(조인안한버전)

SELECT e.deptId AS 부서번호,
GROUP_CONCAT(e.name) AS 사원리스트,
TRUNCATE(AVG(e.salary),0) AS 평균연봉,
MAX(e.salary) AS 최고연봉,
MIN(e.salary) AS 초소연봉,
COUNT(*) AS 사원수
FROM emp AS e
GROUP BY e.deptId;
#SELECT절 뒤에 오는 걸럼명이 여러개일 때 집계합수가 사용된 컬럼을 제외한 모든 컬럼은 GROUP BY에 언급을 해주야 한다.
#예를 들면
# SELECT 컬럼1,컬럼2,컬럼3,AVG(컬럼4),MAX(컬럼5)
# FROM 테이블
# GROUP BY 컬럼1,컬럼2,컬럼3;
#이렇게 되어야 한다.
#그런데 특수한 경우 즉 한 컬럼에 여러개의 리스트를 보여 주어야 할 겅우 GROUP_CONCAT같을 것을 쓴다.


#V2(조인해서 부서명까지 나오는 버전)
#GROUP BY에 언급된 컬럼은 SELECT절에 존재해야 한다.

SELECT e.deptId AS 부서번호, d.`name` AS 부서명,
GROUP_CONCAT(e.name) AS 사원리스트,
TRUNCATE(AVG(e.salary),0) AS 평균연봉,
MAX(e.salary) AS 최고연봉,
MIN(e.salary) AS 초소연봉,
COUNT(*) AS 사원수
FROM emp AS e INNER JOIN dept AS d
ON e.deptId = d.id
GROUP BY e.deptId, d.`name`;

#V3(V2에서 평균연봉이 5000이상인 부서로 추리기)
#HAVING -> GROUP BY뒤에 오는 조건절 -> 그룹화하고 난 후에 적용하는 조건

SELECT d.`name` AS 부서,
GROUP_CONCAT(e.name) AS 사원리스트,
TRUNCATE(AVG(e.salary),0) AS 평균연봉,
MAX(e.salary) AS 최고연봉,
MIN(e.salary) AS 초소연봉,
COUNT(*) AS 사원수
FROM emp AS e INNER JOIN dept AS d
ON e.deptId = d.id
GROUP BY e.deptId
HAVING `평균연봉` >= 5000;

#V4(V3에서 HAVING없이 서브쿼리로 수행)
## HINT, UNION 을 이용한 서브쿼리
# SELECT *
# FROM (
#       SELECT 1 AS id
#       UNION
#       SELECT 2
#       UNION 
#       SELECT 3
# ) AS A

SELECT * 
FROM (
	   SELECT d.`name` AS 부서,
       GROUP_CONCAT(e.name) AS 사원리스트,
       TRUNCATE(AVG(e.salary),0) AS 평균연봉,
       MAX(e.salary) AS 최고연봉,
       MIN(e.salary) AS 초소연봉,
       COUNT(*) AS 사원수
       FROM emp AS e 
       INNER JOIN dept AS d
       ON e.deptId = d.id
       WHERE 1
       GROUP BY e.deptId
      ) AS F
      WHERE F.`평균연봉` >= 5000;  
      
      
##======================================================================================
#데이터 베이스 db_test가 존재하면 삭제
DROP DATABASE IF EXISTS db_test;

#데이터 베이스 db_test 생성
CREATE DATABASE db_test;

#데이터 베이스 db_test 선택
USE db_test;

#회원 테이블 생성, loginId, loginPw, `name`
##조건 : loginId 컬럼에 UNIQUE INDEX 없이
CREATE TABLE `member` (
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
loginId VARCHAR(50) NOT NULL,
loginPw VARCHAR(100) NOT NULL,
`name` VARCHAR(50) NOT NULL
);

#회원 2명 생성 
##조건 : (loginId = `user1`, loginPw = `user1`, `name`='홍길동')
##조건 : (loginId = `user2`, loginPw = `user2`, `name`='홍길순')

INSERT INTO `member`
SET regDate = NOW(),
loginId = 'user1',
loginPw =  'user1',
`name` = '홍길동';

INSERT INTO `member`
SET regDate = NOW(),
loginId = 'user2',
loginPw =  'user2',
`name` = '홍길순';

SELECT COUNT(*) FROM `member`;

#회원 2배 증가 쿼리만들고 회원이 만명이 넘을때 까지 반복실행
##힌트1 : INSERT INTO `tableName` (col1, col2, col3, col4)
##힌트2 : SELECT NOW(), UUID(), `pw`, '아무개' 

INSERT INTO `member` (regDate, loginId, loginPw, `name`)
SELECT NOW(), UUID(),'pw', '아무개' 
FROM `member`; 

#회원수 확인
#검색속도 확인
## 힌트 : SQL_NO_CACHE
SELECT SQL_NO_CACHE * 
FROM `member`

ALTER TABLE `member` ADD UNIQUE INDEX (`loginId`);
ALTER TABLE `member` DROP INDEX `loginId`;

SHOW INDEX FROM `member`;

#유니크 인덱스를 loginId 컬럼에 걸기
## 설명 : mysql이 loginId 의 고속검색을 위한 부가데이터를 자동으로 관리(생성/수정/삭제) 한다.
## 설명 : 이게 있고 없고가, 특성상황에 어마어마한 성능차이를 가져온다.
## 설명 : 생성된 인덱스의 이름은 기본적으로 컬럼명과 동일하다.

#검색속도 확인, loginId가 'user1'인 회원검색
#인덱스 삭제, `loginId` 이라는 이름의 인데스 삭제
#회원 테이블 삭제

DROP TABLE `member`;

#회원 테이블을 생성하는데 , loginId에 unique Index까지 걸어준다.

CREATE TABLE `member` (
id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
PRIMARY KEY(id),
regDate DATETIME NOT NULL,
loginId VARCHAR(50) UNIQUE NOT NULL,
loginPw VARCHAR(100) NOT NULL,
`name` VARCHAR(100) NOT NULL
);

#회원 2명 생성

INSERT INTO `member`
SET regDate = NOW(),
loginId = 'user1',
loginPw =  'user1',
`name` = '홍길동';

INSERT INTO `member`
SET regDate = NOW(),
loginId = 'user2',
loginPw =  'user2',
`name` = '홍길순';

#인텍스 쓰는지 확인 
## 힌트 : explain selecct sql_no_cache * ~
EXPLAIN SELECT SQL_NO_CACHE *
FROM `member`
WHERE loginId = 'user1';

DROP TABLE `article`;

#게시물 테이블 생성(title, body, writerName, memberId)
CREATE TABLE `article` (
id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
PRIMARY KEY(id),
regDate DATETIME NOT NULL,
title VARCHAR(200) NOT NULL,
`body` TEXT NOT NULL,
`writerName` VARCHAR(100) NOT NULL,
memberId INT(10) UNSIGNED NOT NULL
);

SELECT * FROM article;

#1번 회원이 글1 작성(title = '글 1 제목', `body` = '글 1 내용')
INSERT INTO article
SET regDate = NOW(),
title ='글 1 제목',
`body` = '글 1 내용',
writerName = '홍길동',
memberId =1;

#2번 회원이 글2 작성(title = '글 2 제목', `body` = '글 2 내용')
INSERT INTO article
SET regDate = NOW(),
title ='글 2 제목',
`body` = '글 2 내용',
writerName = '홍길순',
memberId = 2;

#1번 회원이 글3 작성(title = '글 3 제목', `body` = '글 3 내용')
INSERT INTO article
SET regDate = NOW(),
title ='글 3 제목',
`body` = '글 3 내용',
writerName = '홍길동',
memberId = 1;

#전체글 조호ㅣ
SELECT * FROM article;

#1번 회원의 이름을  홍길동 -> 홍길동2
UPDATE `member`
SET `name` = '홍길동2'
WHERE id =1;

#전체글 조회, 여전히 게시물 테이블에는 이전 이름이 남아 있음.
SELECT * 
FROM article;

#게시물 테이블에서 writerName 삭제
ALTER TABLE article DROP COLUMN writerName;

#INNER JOIN 을 통해 두 테이블을 조회한 결과를 합침, on없이
SELECT * FROM article
INNER JOIN `member`
ON article.memberId = `member`.id;

SELECT a.id, a.regDate, a.title, a.body, m.`name` FROM article AS a
INNER JOIN `member` AS m
ON a.memberId = m.id;

#INNER JOIN을 통해서 두 테이블을 조회한 결과를 합침, 올바른 조인 조건
#힌트 : 이걸로 조인조건을 걸 컬럼 조사
SELECT article.id, article.memberId, member.id AS "회원테이블_번호"
FROM article
INNER JOIN `member`;

#조인 완성, ON 까지 추가
SELECT A.*, M.name AS writerName
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id; 

#여기서 문제 
# 문제 - 상황에 맞는 SQL을 작성해 주세요. INNER JOIN , INDEX, UNIQUE INDEX, SQL_NO_CACHE, EXPLAIN, UUID
#상황 : 커뮤니티 사이트 DB를 구축해야 합니다.
#조건 : member(회원), article(게시물) 테이블을 구현해 주세요.
#조건 : 비회원은 글을 쓸수 없습니다.
#조건 : 게시물 상세페이지에서는 제목,내용,작성날짜, 작성자가 보여야 합니다.
#조건 : 특정 게시물을 어떤회원이 작성했는지 알 수 있어야 합니다.
#조건 : 회원이 자신의 이름을 바꾸면, 그회원이 예전에 쓴 글에서도 작성자가 자동으로 변경되어야 합니다.
#조건 : 회원 아이디의 비번의 컬럼명은 loginId와 loginPw로 해주세요.
#조건 : loginId에는 unique 인덱스를 걸어주세요.
#조건 : 회원2명이 가입을 했습니다.
#조건 : 1번 회원은 글을 2개(글1,글3), 2번 회원은 글을 1개(2번) 썻습니다.       