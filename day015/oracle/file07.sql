-- 07
-- 10�� ���̺��� ���� �߰�, ����, �����ϴ� dml

-- sub query�� ���̺� �����ϸ� ���������� �������� ����..
create table tbl_emptest
as
select employee_id, first_name, salary, hire_date
from employees
where department_id=60;

desc tbl_emptest;

-- ��� Į���� ���� ������ ���� �߻�
insert into tbl_emptest values(1, 'AA', 1000, sysdate);
-- insert into tbl_emptest values(1, AA, 1000, sysdate); -- ���ڿ��� ''�� ���� ������ ���� �߻�
-- ��� Į���� �ְ���� ������ Į���� ����ؾ� ��
-- Į���� ���� ���� ������ �Ͻ������� null�� ��
insert into tbl_emptest(employee_id, first_name, hire_date) values(2, 'BB', sysdate);
insert into tbl_emptest(employee_id, hire_date) values(3, sysdate-1);
insert into tbl_emptest(hire_date) values(sysdate-1);
-- ��������� null ���� ���� (null, �� ���ڿ�)
insert into tbl_emptest(employee_id, first_name, hire_date) values(4, null, sysdate);
insert into tbl_emptest(employee_id, first_name, hire_date) values(5, '', sysdate);
select * from tbl_emptest;

-- ���� ������ ������ ���� (���� ����� -> ������ ����)
create table tbl_dept
as
select * from departments
where 1=0;

desc tbl_dept;
select * from tbl_dept;

insert into tbl_dept
select employee_id, first_name, 100, 1700
from employees;
select * from tbl_dept;

-- update ����
create table tbl_emp_update
as
select * from employees;

select * from tbl_emp_update;

update tbl_emp_update set salary=salary*1.1
where department_id=50;
-- rollback, commit: transaction ó���ϴ� ��ɾ�
-- transaction: �ϳ��� ������ �۾�
-- commit: �۾��� ������ db�� �ݿ��Ѵ�
-- rollback: �۾��� ������ ���� �Ϸ� �Ѵ� (�ǵ�����, db�� �ݿ� ���Ѵ�)
commit;

-- �μ�=90�� ������� Diana ������ ���� �μ�, ���� salary�� �����ϰ� �ʹ�!
select salary
from employees
where first_name='Diana';

update tbl_emp_update
set department_id=(
    select department_id
    from employees
    where first_name='Diana'),
    salary = (
    select salary
    from employees
    where first_name='Diana')
where department_id=90;
select * from tbl_emp_update;

-- delete: ���� ����
delete from tbl_emp_update
where department_id=(select department_id
        from employees
        where first_name='Diana');
        
-- p.51
drop table emp01;
drop table emp02;
create table EMP01
as
select employee_id empno, first_name ENAME, job_id JOB, manager_id MGR,
          hire_date HIREDATE, salary SAL, commission_pct COMM, department_id DEPTNO
from employees
where department_id = 60;
create table EMP02
as
select employee_id empno, first_name ENAME, job_id JOB, manager_id MGR,
          hire_date HIREDATE, salary SAL, commission_pct COMM, department_id DEPTNO
from employees
where department_id = 60;
commit;
--EMP02�� �ִ� 1�� �����ϱ�
select * from emp02;
select * from emp01;
update emp02 set  job='aa' , SAL = 9999, comm = 0.1, deptno=88
where empno=103;
--EMP02�� �űԸ� �����ϱ�
insert into emp02 values(111,'jj','bb',100, sysdate, 8888,0.2, 77);
-- ��Ī�Ǵ� ���� �ִ�: 103 Alexander, ��Ī�Ǵ� ���� ����: 111 jj
MERGE INTO EMP01
USING EMP02 ON(EMP01.EMPNO=EMP02.EMPNO)
WHEN MATCHED THEN
        UPDATE SET
        EMP01.ENAME=EMP02.ENAME,
        EMP01.JOB=EMP02.JOB,
        EMP01.MGR=EMP02.MGR,
        EMP01.HIREDATE=EMP02.HIREDATE,
        EMP01.SAL=EMP02.SAL,
        EMP01.COMM=EMP02.COMM,
        EMP01.DEPTNO=EMP02.DEPTNO
WHEN NOT MATCHED THEN
        INSERT VALUES(EMP02.EMPNO, EMP02.ENAME, EMP02.JOB,
        EMP02.MGR, EMP02.HIREDATE, EMP02.SAL,
        EMP02.COMM, EMP02.DEPTNO);
select * from EMP01; -- 103 alexander�� 2������ �ٲ�(��Ī O), 111 jj�� ���� ����(��Ī X)
