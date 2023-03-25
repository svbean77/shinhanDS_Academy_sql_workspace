-- 04
-- 20�� PL/SQL
-- Procedure
set serveroutput on; -- �̰Ÿ� ���� ������ ����� ������� �ʰ� ���������� �Ϸ��ߴٴ� ���� ����

declare
begin
    dbms_output.put_line('Hello');
end;
/

-- ���� ����: declare�� begin ����
declare
    v_empid number:=100;
    v_empname varchar2(20);
begin
    v_empname:='Steven';
    dbms_output.put_line('���̵�: '||v_empid);
    dbms_output.put_line('�̸�: '||v_empname);
end;
/

-- ������ ������ ����? (sql plus���� ����)
-- �޸��忡�� ������ �� .sql ���Ϸ�, ���ڵ��� ANSI! (�ѱ��� �ȵǴ����)
-- @���\���ϸ�.sql
-- @C:\SWacademy\database\code\day017\oracle\file04_save.sql


-- ��Į��, ���۷���
declare
    -- ��Į�� Ÿ��
    v_empid number:=100;
    v_empname varchar2(20);
    -- ���۷��� Ÿ��
    v_salary employees.salary%type; -- employees ���̺��� salary �÷��� Ÿ���� ���� -> salary�� �ٲ� ���� ���ص� ��!
    v_email employees.email%type;
begin
    v_empname:='Steven';
    v_salary:=3000;
    v_email:='�̸��� �Դϴ�!';
    dbms_output.put_line('���̵�: '||v_empid);
    dbms_output.put_line('�̸�: '||v_empname);
    dbms_output.put_line('�޿�: '||v_salary);
    dbms_output.put_line('�̸���: '||v_email);
end;
/

-- �� �� ��� (���ڵ�)
declare
    v_emp employees%rowtype;
    v_empemail employees.email%type;
begin
    select *
    into v_emp
    from employees
    where employee_id=100;
    
    dbms_output.put_line('������ȣ: '||v_emp.employee_id);
    dbms_output.put_line('�����̸�: '||v_emp.first_name);
    dbms_output.put_line('�����̸�: '||v_emp.last_name);
    dbms_output.put_line('�����޿�: '||v_emp.salary);
    
    select email
    into v_empemail
    from employees
    where employee_id=100;
    
    dbms_output.put_line('Ư�� Į�� �̸���: '||v_empemail);
end;
/

-- table ���� ���
declare
    type firstname_type is table of employees.first_name%type -- �迭 ����
    index by binary_integer;
    
    type job_table_type is table of employees.job_id%type
    index by binary_integer;
    -- ������ ��Ÿ���� ���� ���
    seq binary_integer:=0;
    first_arr firstname_type;
    job_arr job_table_type;
begin
    for empROW in (select first_name, job_id from employees where department_id=60) loop
        seq:=seq+1; -- �츮 �ڹٿ��� i �ø��� ��ó�� ������
        first_arr(seq):=empROW.first_name;
        job_arr(seq):=empROW.job_id;
        dbms_output.put_line('����: '||empROW.first_name||' '||empROW.job_id||', ����: '||first_arr(seq)||' '||job_arr(seq));
    end loop;
end;
/

-- table ���� ��� �ٽ� (�����ϱ� �� ��° ����)
declare
    -- 1�� ��ȸ
    v_fname employees.first_name%type;
    v_empid number:=100;
    -- 2�� ��ȸ
    v_salary employees.salary%type;
    -- �ݺ��� ������ ��ȸ
begin
    -- 1�� ��ȸ
    select first_name into v_fname from employees where employee_id=v_empid;
    dbms_output.put_line('������ȣ '||v_empid||'���� �̸��� '||v_fname);
    
    -- 2�� ��ȸ
    select first_name, salary into v_fname, v_salary from employees where employee_id=v_empid;
    dbms_output.put_line('������ȣ '||v_empid||'���� �̸��� '||v_fname||', �޿��� '||v_salary);
    
    -- �ݺ��� ������ ��ȸ (�迭 X, �ٷ� ���)
    for emp_record in (select * from employees where department_id=60) loop
        dbms_output.put_line('������ȣ: '||emp_record.employee_id||', �̸�: '||emp_record.first_name||', �޿�: '||emp_record.salary);
    end loop;
end;
/

-- record type
DECLARE
  TYPE emp_record_type IS RECORD(
    v_empno    employees.employee_id%TYPE,
    v_ename    employees.first_name%TYPE,
    v_job    employees.job_id%TYPE,
    v_deptno  employees.department_id%TYPE);
    
    v_emprecord emp_record_type;
begin
    select employee_id, first_name, job_id, department_id
    into v_emprecord
    from employees
    where employee_id=101;
    
    dbms_output.put_line(v_emprecord.v_empno||' '||v_emprecord.v_ename||' '||v_emprecord.v_job||' '||v_emprecord.v_deptno);
end;
/

-- basic loop
declare
    su number:=0;
begin
    loop
        su:=su+1;
        if su > 5 then
            exit;
        end if;
        dbms_output.put_line(su);
    end loop;
end;
/

-- for loop
declare
begin
   for i in reverse 1..10 loop
        dbms_output.put_line(i);
   end loop;
end;
/

-- 20�� ���� ���ν���
-- �ٷ� ���� ������ ���� ���ν����� �����
create or replace PROCEDURE sp_print10
is 
    su number:=100;
begin
   for i in reverse 1..10 loop
        dbms_output.put_line(i);
   end loop;
end;
/
execute sp_print10; -- ���� ����ϴ� ���� ���ν����� ����� ���� �� ���� ����!

-- ����� ���ν��� Ȯ��
desc user_source;
select * from user_source; -- �ڵ尡 �� �پ� ����Ǿ�����!

-- ������ �ִ� ���ν��� (in, out)
create or replace procedure sp_emp1(v_empid in employees.employee_id%type,
                                    v_salary out employees.salary%type,
                                    v_jobid out employees.job_id%type) -- ������ in, ������ out, ���Դ� ������ inout
is
    v_record employees%rowtype;
begin
    select * 
    into v_record
    from employees
    where employee_id=v_empid;
    
    dbms_output.put_line('��ȣ:'||v_record.employee_id);
    dbms_output.put_line('�̸�:'||v_record.first_name);
    dbms_output.put_line('�޿�:'||v_record.salary);
    dbms_output.put_line('�Ի���:'||v_record.hire_date);
    
    v_salary:=v_record.salary;
    v_jobid:=v_record.job_id;
end;
/
-- in�� �־��� ��
-- execute sp_emp1(100);
-- in, out�� ���� ��
variable a number;
variable b varchar2(30);
execute sp_emp1(107,:a,:b);