-- 06
-- 09��. ���̺� ���� ����, ���� �� �����ϴ� DDL

-- ���� �������� rowid ���� (���� ��ġ�� �����ϴ� ������ �ּҰ�)
select employee_id, first_name, rowid -- rowid�� ���������θ� ����ϱ� ������ �츮�� �� �ʿ䰡 ����, �� ���� ����
from employees;

-- p.13
create table tbl_test1(id number, name varchar2(20), gender char(1), year01 interval year(3) to month);
insert into tbl_test1 values(1, 'abc', 'M', interval '36' month(3)); -- 3�� ��
insert into tbl_test1 values(2, 'def', 'W', interval '12' month(3)); -- 1�� ��

select id, name, gender, year01, sysdate+year01
from tbl_test1;

-- ���� ����(varchar2)�� �ڿ� ������ ������ �ٸ� ���ڿ��� �ȴ�.
select *
from tbl_test1
where name='abc  '; 
-- ���� ����(char)�� �ڿ� ������ �پ �������̴�.
select *
from tbl_test1
where gender = 'M         ';

-- ���� ������ ���̺� ����(create table)
-- ���� �Ȱ���
create table tbl_emp
as
select * from employees;
-- Ư�� �����͸� 
create table tbl_emp2
as
select * from employees where department_id=60;
-- �����ʹ� �ƴϰ� ������
create table tbl_emp3
as
select * from employees where 1=0;
-- ��� Į�� ������
create table tbl_emp4
as
select employee_id, first_name
from employees where 1=0;

select * from tbl_emp;
select * from tbl_emp2;
select * from tbl_emp3;
select * from tbl_emp4;

-- ���̺� ���� (alter table)
alter table tbl_emp4 add (job_id varchar2(50));
desc tbl_emp4;
alter table tbl_emp4 modify (job_id varchar2(100));
insert into tbl_emp4 values(1, '1234567890123467890', 'ABC');
select * from tbl_emp4;
-- 20�ڸ��� �����Ͱ� �ִµ� ���̸� ���̰� �ʹ�
-- ���� �߻�! �� �۰� ���̴� ���� X, �� ũ�Դ� �ٲ� �� �־�!
-- alter table tbl_emp4 modify (first_name varchar2(10));
alter table tbl_emp4 modify (first_name varchar2(30));
desc tbl_emp4;
-- �����Ͱ� �ִµ� Į�� ����: ������ -> ���� �����ϴ� ������!
alter table tbl_emp4 drop column first_name;
desc tbl_emp4;
drop table tbl_emp4;

-- ������ ����: truncate(���� �Ұ���), delete(rollback���� ���� ����)
desc tbl_emp2;
select * from tbl_emp2;
truncate table tbl_emp2;
select * from tbl_emp;
delete from tbl_emp;
rollback; -- ���󺹱� ����

-- �̸� ����
rename tbl_emp to tbl_employee;
select * from tbl_emp; -- �̸��� �ٲ�� ������ ����
select * from tbl_employee;

-- ��ųʸ� ��
select * from user_tables;
select * from all_tables;
select * from dba_tables; -- dba�� �ƴϱ� ������ ���� �Ұ���

