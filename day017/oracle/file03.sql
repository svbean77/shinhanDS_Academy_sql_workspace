-- 03
-- 17�� ����� ����

-- dba �������� �������� �� (sql plus���� ����)
-- ����� ����
create user user01 identified by 1234;
-- db ���� ���� �ο�
grant create session user01;
-- select ���� �ο�
grant select on employees to user01;

-- user01�� ���� �� �˻��� �����Ϸ���
select * from hr.employees; -- �� ���̺��� �ƴϴϱ�!

-- �̰� ���� ������ ����
-- ���� ����ڰ� �ٸ� ����ڿ��� �ο��� ���� ��ȸ
select * from user_tab_privs_made;
-- �ڽſ��� �ο��� ���� ��ȸ
select * from user_tab_privs_recd;

-- 18�� ��
-- dba ���� (sql plus���� ����)
grant connect, resource to user01;

-- 19�� ���Ǿ�
-- dba ���� (sql plus)
grant synonym to user01;
-- user01 ����
create synonym hr_emp for hr.employees;
select * from hr_emp; -- ���Ǿ� ���� �� ������.���̺������ �ۼ����� �ʾƵ� ��!