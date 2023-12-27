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



