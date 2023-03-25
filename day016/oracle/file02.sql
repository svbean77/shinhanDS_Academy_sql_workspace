-- 02 ���Ἲ ���� ����
-- ch 13 ���Ἲ ���� ����

-- ���� ������ Ȯ��
select * from user_constraints; -- ��ü ���̺�
select * from user_constraints
where table_name='EMPLOYEES'; -- ������ ������ �빮�ڷ� ���ֱ� ������ �빮�ڷ� �ۼ�!

-- ���� ���̺� ����� Ȯ���غ���
drop table tbl_test1;
-- constraint�� �̿��� �������ǿ� �̸� �ο� ���� (Į���� �ϳ��� ��, Į�� �������� ����)
create table tbl_test1 (id number constraint pk_tbl_test1_id primary key, 
                        name varchar2(20) not null, 
                        phone_number varchar2(13) constraint u_phone unique);
select * from user_constraints
where table_name='TBL_TEST1';

select * from tbl_test1;

insert into tbl_test1(id, name) values(1, 'aa');
insert into tbl_test1 values(1, 'bb'); -- �� �� �����ϸ� ���� �߻�! (�⺻Ű�� �ߺ��Ǿ����ϱ�!)
insert into tbl_test1 values(2); -- null�̱� ������ ���� �߻�! (not null�� �������ݾ�)
insert into tbl_test1(id, name, phone_number) values(2, 'bb', '13-1234-5432');
insert into tbl_test1(id, name, phone_number) values(3, 'cc', '13-1234-5432'); -- unique�̱� ������ ����

-- Į���� ���� �������� ����
select * from user_cons_columns
where table_name='TBL_TEST1';
-- ���̺� ���ǵ�, Į�� ���ǵ� �� ����ʹ�: �� ���� ����

-- pk�� �� ���� ��� ��� �̸��� ��?! (���̺� �������� �������� ��)
-- �ֹ�(��, ��ǰ, ����, ����) pk�� ��+��ǰ
create table tbl_order (�� number, ��ǰ number, order_date date, price number,
                        constraint pk_order primary key(��, ��ǰ));
insert into tbl_order values(1, 100, sysdate, 1000);
insert into tbl_order values(1, 100, sysdate-1, 1200); -- �� �� �����ϸ� ���� �߻�: ��, ��ǰ ��� pk��: not null + unique

select * from user_constraints
where table_name='TBL_ORDER';
select * from user_cons_columns
where table_name='TBL_ORDER';

-- ���� ���Ἲ
select * from departments;
select * from employees;
-- ���� ������ �����ϴ��� �̸����� �� ã�ƺ���
select * from user_constraints
where table_name='DEPARTMENTS';
select * from user_constraints
where table_name='EMPLOYEES';
select * from user_cons_columns
where table_name='EMPLOYEES';

alter trigger UPDATE_JOB_HISTORY disable; -- ���� ���Ἲ �ɸ����� ���� ���� Ʈ���� �Ͻ�����
update employees set department_id=1; -- parent key not found: ���� ���Ἲ ���ѿ� �ɸ�

-- ���� ���� ���̺�� �غ���
create table tbl_parent (deptid number primary key, deptname varchar2(20));
create table tbl_child(empid number primary key, empname varchar2(20), 
                       deptid number constraint tbl_parent_deptid_FK references tbl_parent(deptid));
insert into tbl_child(empid, empname, deptid) values (1, 'aa', 10); -- tbl_parent�� �������� �ʴ� deptid�� �־� ����: �θ� ����!
-- �θ� ���̺� ���� �־�� �ڽ� ���̺� ���� ����!
insert into tbl_parent(deptid, deptname) values(10, '���ߺ�');
insert into tbl_parent(deptid, deptname) values(20, '������');
insert into tbl_parent(deptid, deptname) values(30, '�ѹ���');
insert into tbl_child(empid, empname, deptid) values (1, 'aa', 10);
-- Į���� ������ �� �������� ������� �ְ� Į���� ���� ����
-- ���� ������ �ٲٰ�ʹٸ� ������ ����ؾ� ��
insert into tbl_child values (2, 'bb', 20); 
insert into tbl_child(empid, deptid, empname) values (3, 30, 'cc'); 
insert into tbl_child(empid, empname) values (4, 'dd'); 
select * from tbl_child;

drop table tbl_parent; -- �����ϴ� �ڽ��� �ִµ� �θ� ����� ���� �߻� - �ɼ� ���� (���� ����, null, �⺻��)

-- check ���� ����
drop table tbl_child;
create table tbl_child(empid number primary key, empname varchar2(20) not null, 
                       deptid number constraint tbl_parent_deptid_FK references tbl_parent(deptid),
                       salary number constraint tbl_child_salary_check check(salary between 1000 and 2000),
                       gender char(1) constraint tbl_child_gender_check check(gender in ('M', 'F')),
                       phone_number char(13) unique
                       );
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (1, 'aa', 10, null, null, null);
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (2, 'bb', 10, 500, null, null); -- 1000<=salary<=2000�� �ƴϱ� ������ �������ǿ� �ɸ�
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (2, 'aa', 10, 1500, 'W', null); -- M, F�� �ƴϱ� ������ �������ǿ� �ɸ�
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (2, 'aa', 10, 1500, 'M', null);            
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (3, 'cc', 10, 1500, 'F', '2345');            
select * from tbl_child;            

-- default ���� ����
drop table tbl_child;
create table tbl_child(empid number primary key, empname varchar2(20) not null, 
                       deptid number constraint tbl_parent_deptid_FK references tbl_parent(deptid),
                       salary number constraint tbl_child_salary_check check(salary between 1000 and 2000),
                       gender char(1) constraint tbl_child_gender_check check(gender in ('M', 'F')),
                       phone_number char(13) unique,
                       nation varchar2(30) default '�ѱ�'
                       );
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (1, 'aa', 10, 1500, 'M', null);            
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number, nation) 
            values (2, 'bb', 10, 1500, 'F', '2345', '���ѹα�'); 
select * from tbl_child;

-- subquery�� �̿��� ���̺� ���� -> not null�� ����Ǳ� ������ �ٸ� ���������� �߰��غ���!
create table tbl_emp_backup
as
select * from employees
where department_id=60;
select * from tbl_emp_backup;
select * from user_constraints where table_name='TBL_EMP_BACKUP';
-- not null�� ����Ǿ��� ������ �̻��� ���浵 ������ �Ǿ����! -> ���������� �߰��ؾ� ��!
update tbl_emp_backup
set department_id=1;
rollback;
-- �������� �߰�
alter table tbl_emp_backup
add constraint tbl_emp_backup_PK primary key (employee_id);
alter table tbl_emp_backup
add constraint tbl_emp_backup_FK foreign key (department_id) references departments(department_id);


-- �츮 å(mysql)�� ���뵵 �����Ѵ�!!!!