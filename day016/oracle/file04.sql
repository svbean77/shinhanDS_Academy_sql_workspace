-- 04
-- ch15 ������
create sequence seq_board; -- �ƹ� ���̺����� ��� ����

create table tbl_board(bno number primary key, title varchar2(50) not null, 
             contents varchar2(2000), writer varchar2(30) not null);
insert into tbl_board(bno, title, contents, writer) values (seq_board.nextval, '������', 'sql ����', 'ee');
insert into tbl_board(bno, title, contents, writer) values (seq_board.nextval, '������', 'sql ����', 'ee');
insert into tbl_board(bno, title, contents, writer) values (seq_board.nextval, '������', 'sql ����', 'ee');
-- �����߾ ���ٸ� �ߴٸ� ��ȣ�� ����
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '������', 'sql ����');
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '������', 'sql ����');
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '������', 'sql ����');
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '������', 'sql ����');
insert into tbl_board(bno, title, contents) values (seq_board.nextval, '������', 'sql ����');
-- �߰��� 5���� ��ȣ�� �������� ���� -> ������ �߿��� ���� �� �� ����
insert into tbl_board(bno, title, contents, writer) values (seq_board.nextval, '������', 'sql ����', 'ee');

select * from tbl_board;