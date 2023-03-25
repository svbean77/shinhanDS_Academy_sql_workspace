-- 06
-- ch16 �ε���

-- �����뿡 �ִ� ���̺��� ��ȸ
show recyclebin; 
-- ������ ���̺��� ����
-- flashback table ���̺�� to before drop;       
-- �����뿡 ������ �ʰ� ���� ����
-- drop table ���̺�� purge;     
 -- �����뿡 �ִ� ���̺� ���� ����
-- purge table ���̺��;     
purge recyclebin;      -- ������ ����

-- �ε��� Ȯ��
select *
from user_ind_columns
where table_name='EMPLOYEES';

select *
from user_ind_columns
where table_name='TBL_BOARD';

-- �ε����� ź��, Ÿ�� �ʴ´�?! -> �����ȹ�� ���� �� (�巡�� �� f10)
-- Į���� �״�� ����� ��� �����ȹ�� range scan, by index rowid -> �ε����� Ÿ�� ����!
select *
from employees
where first_name = 'Steven' and last_name = 'King';
-- Į���� ������ ���(lower) �����ȹ�� full (cost�� �����!)
select *
from employees
where lower(first_name) = 'steven' and lower(last_name) = 'king';
-- �׷��ϱ� ���� �����϶�!!!! (range scan, by index rowid �� �� �ε��� Ÿ�°�!)
select *
from employees
where first_name = initCap('steven') and last_name = initCap('king');
-- ������ ������ �ε����� Ÿ�� ���� ������ �ƴϾ�! (full Ž���� �ߴµ� ù ����� ���� �� ���ݾ�?! ��Ȳ�� ���� �ٸ�~)

-- �ε��� ����
select * from tbl_board
where bno=1; -- ��� �ε����� Ÿ��! (pk)
select * from tbl_board
where title='������'; -- �굵 �ε����� Ÿ���� �����ʹ� -> title�� �ε����� ������ָ� ��!
create index idx_tbl_board_title
on tbl_board(title);