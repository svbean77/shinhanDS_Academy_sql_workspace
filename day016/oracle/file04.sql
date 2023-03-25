-- 04
-- ch15 시퀀스
create sequence seq_board; -- 아무 테이블에서나 사용 가능

create table tbl_board(bno number primary key, title varchar2(50) not null, 
             contents varchar2(2000), writer varchar2(30) not null);
insert into tbl_board(bno, title, contents, writer) values (seq_board.nextval, '수요일', 'sql 배우기', 'ee');
insert into tbl_board(bno, title, contents, writer) values (seq_board.nextval, '수요일', 'sql 배우기', 'ee');
insert into tbl_board(bno, title, contents, writer) values (seq_board.nextval, '수요일', 'sql 배우기', 'ee');
-- 실패했어도 접근만 했다면 번호가 증가
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '수요일', 'sql 배우기');
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '수요일', 'sql 배우기');
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '수요일', 'sql 배우기');
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '수요일', 'sql 배우기');
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '수요일', 'sql 배우기');
-- 중간에 5개의 번호는 존재하지 않음 -> 순서가 중요할 때는 쓸 수 없군
insert into tbl_board(bno, title, contents, writer) values (seq_board.nextval, '수요일', 'sql 배우기', 'ee');

select * from tbl_board;