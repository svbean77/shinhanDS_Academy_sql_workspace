-- 01 ����
-- PL/SQL: ����Ŭ�� �����ϴ� ������ ���α׷��� ���
-- �� ��? -> SQL(Structured Query Languate)�� �������� ����̱� ������ ������ �ִ�, ������ �ִ� ������ ������� ����
-- PL/SQL �ȿ� Procedure, Function, Trigger, Package�� �������!

-- ���ν��� ������: ������ ������ ������, �Ǽ��� ���� �����͸� �������� ������ �ӵ� ������ �ϴ� �� (������ ������ �ƴ�)
set serveroutput on;

create or replace procedure sp_salary(v_empid in employees.employee_id%type,
                                      v_salary out employees.salary%type,
                                      v_firstname out employees.first_name%type)
is
    v_message varchar2(50):='������ �޿��� ��ȸ�Ѵ�.';
begin
    select salary, first_name
    into v_salary, v_firstname
    from employees
    where employee_id=v_empid;
    dbms_output.put_line(v_message||': '||v_salary);
end;
/
variable sal number;
variable fname varchar2(20);
execute sp_salary(101, :sal, :fname);
print sal;
print fname;

-- ���� �Լ� ����
-- Function: return�� ���� ���� ����!
-- lower(), upper(), substr() ���� �Լ��� ���ϴ� ��!
select lower('ORACLE') from dual;

select first_name, substr(first_name, 1, 3) "�̸� �� 3�ڸ�"
from employees
where department_id=60;

-- � �Լ��� ����������? -> �޿��� �ش��ϴ� ���� ���
create or replace function f_tax(v_salary in employees.salary%type)
    return employees.salary%type
is
    v_tax employees.salary%type;
begin
    v_tax:=v_salary * 0.1;
    return v_tax;
end;
/

select f_tax(1000) from dual;
select first_name, salary, f_tax(salary) ����
from employees;

-- Ŀ��: ������ select�� �ݵ�� ����ؾ� ��!
-- ����� Ŀ�� (declare, open, fetch, close �� �ʿ�)
create or replace procedure sp_dept
is
    v_dept_record departments%rowtype;
    cursor cur_dept 
    is select department_id, department_name from departments where manager_id is not null;
    -- �� ������� �൵ ��! ���ڵ� ��� ���ϰ�! into ����!
    v_deptid departments.department_id%type;
    v_deptname departments.department_name%type;
begin
    open cur_dept;
    loop
        fetch cur_dept into v_deptid, v_deptname;
        exit when cur_dept%notfound;
        dbms_output.put_line(v_deptid||' '||v_deptname);
    end loop;
    close cur_dept;
end;
/
execute sp_dept;

-- �Ͻ����� Ŀ�� ���
create or replace procedure sp_dept2
is
begin
    for v_dept_record in (select * from departments where manager_id is not null) loop  
        dbms_output.put_line(v_dept_record.department_id||' '||v_dept_record.department_name);
    end loop;
end;
/
execute sp_dept2;


-- 22�� ��Ű��
-- ��Ű�� ���� (�����)
create or replace package pkg_emp
is
    procedure sp_dept;
    procedure sp_dept2;
end;
/
-- ��Ű�� ���� (����)
create or replace package body pkg_emp
is
    procedure sp_dept
    is
        cursor cur_dept 
        is select department_id, department_name from departments where manager_id is not null;
        v_deptid departments.department_id%type;
        v_deptname departments.department_name%type;
    begin
        open cur_dept;
        loop
            fetch cur_dept into v_deptid, v_deptname;
            exit when cur_dept%notfound;
            dbms_output.put_line(v_deptid||' '||v_deptname);
        end loop;
        close cur_dept;
    end; -- sp_dept
    
    procedure sp_dept2
    is
    begin
        for v_dept_record in (select * from departments where manager_id is not null) loop  
            dbms_output.put_line(v_dept_record.department_id||' '||v_dept_record.department_name);
        end loop;
    end; -- sp_dept2
end;
/
execute pkg_emp.sp_dept;

-- Ʈ����: � ���̺� ��� �߻� �� �ڵ����� ����ǵ��� �ϴ� ���ν���
delete from job_history;
commit;
select * from job_history;

select * from employees where employee_id=100; -- ���� �μ��� 90��
update employees set department_id=110 where employee_id=100;
select * from job_history; -- ���� ������ ��� -> �̰� Ʈ����! �ڵ����� �����!
rollback;
select * from job_history; -- rollback�� �ϴ� ���� ������ �����! ������ ���� �ʾҾ����ϱ�!

-- Ʈ���� ������
-- insert�� �ٸ� ���̺� �߰�!
create or replace trigger trigger_dept1
after insert on departments
begin
    dbms_output.put_line('�μ��� ���ԵǾ����ϴ�.');
end;
/
insert into departments(department_id, department_name) 
values(1, 'aa');
insert into departments(department_id, department_name) 
values(3, 'cc');
select * from departments order by department_id;

-- departmet�� ���ԵǸ� �ٸ� ���̺� ������ ��
create sequence seq_sales;
create table sales_dept(salno number primary key, price number,
                        department_id number references departments(department_id));

create or replace trigger trigger_dept2
after insert on departments
for each row
begin
    dbms_output.put_line('sales_dept�� insert �ȴ�');
    insert into sales_dept values (seq_sales.nextval, 1000, :new.department_id);
end;
/
insert into departments(department_id, department_name) 
values(4, '���ߺ�');
insert into departments(department_id, department_name) 
values(5, '�Τ̺κֺ֤����Τ�');
select * from sales_dept;

create or replace trigger trigger_dept3
after delete on departments
for each row
begin
    dbms_output.put_line('sales_dept���� delete �ȴ�');
    delete from sales_dept where department_id=:old.department_id;
end;
/

delete from departments where department_id<=5;
select * from sales_dept;


-- ppt 22�� p.27 �����غ���
CREATE TABLE ��ǰ(
��ǰ�ڵ� CHAR(6) PRIMARY KEY,
��ǰ�� VARCHAR2(12) NOT NULL,
������ VARCHAR(12),
�Һ��ڰ��� NUMBER(8),
������ NUMBER DEFAULT 0
);

CREATE TABLE �԰�(
�԰��ȣ NUMBER(6) PRIMARY KEY,
��ǰ�ڵ� CHAR(6) REFERENCES ��ǰ(��ǰ�ڵ�),
�԰����� DATE DEFAULT SYSDATE,
�԰���� NUMBER(6),
�԰�ܰ� NUMBER(8),
�԰�ݾ� NUMBER(8)
);

INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���)
VALUES('A00001','��Ź��', 'LG', 500); 
INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���)
VALUES('A00002','��ǻ��', 'LG', 700);
INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���)
VALUES('A00003','�����', '�Ｚ', 600);

select * from ��ǰ;
select * from �԰�;

-- �԰� Ʈ����: �԰� �Ǹ� ��ǰ �������� �ڵ����� �þ����
CREATE OR REPLACE TRIGGER TRG_04
AFTER INSERT ON �԰�
FOR EACH ROW
BEGIN
    UPDATE ��ǰ
    SET ������ = ������ + :NEW.�԰����
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
END;
/ 

insert into �԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�) values(1, 'A00003', 10, 200);
insert into �԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�) values(2, 'A00003', 20, 200);
select * from �԰�;
select * from ��ǰ;

-- 2~16������� �˾Ƶΰ� �� ���Ĵ� ���������� �˾Ƶ� �ȴ�
-- PL/SQL �̷��� ���� ���������� �˾Ƶ� ��~~~~~~~~~~~~~