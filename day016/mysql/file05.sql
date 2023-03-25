-- 05 file04의 시퀀스랑 비교
use hr;

-- mysql에는 auto_increment를 사용하면 알아서 증가
create table tbl_board(bno integer auto_increment primary key, title varchar(50) not null, 
             contents varchar(2000), writer varchar(30) not null);
insert into tbl_board(title, contents, writer) values ('수요일', 'sql 배우기', 'ee');
insert into tbl_board(title, contents, writer) values ('수요일', 'sql 배우기', 'ee');
insert into tbl_board(title, contents, writer) values ('수요일', 'sql 배우기', 'ee');
-- 중간에 오류가 발생하면 번호가 증가하지 않음 -> 다음 값은 4가 됨
insert into tbl_board(title, contents) values ('수요일', 'sql 배우기');
insert into tbl_board(title, contents) values ('수요일', 'sql 배우기');
insert into tbl_board(title, contents) values ('수요일', 'sql 배우기');
insert into tbl_board(title, contents) values ('수요일', 'sql 배우기');
insert into tbl_board(title, contents) values ('수요일', 'sql 배우기');
insert into tbl_board(title, contents, writer) values ('수요일', 'sql 배우기', 'ee');
-- 삭제된 번호는 채우지 않고 다음 번호인 5번으로 들어감
delete from tbl_board where bno=4;
insert into tbl_board(title, contents, writer) values ('수요일', 'sql 배우기', 'ee');
select * from tbl_board;