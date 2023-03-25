-- 04
-- 20장 PL/SQL
-- Procedure
set serveroutput on; -- 이거를 하지 않으면 결과는 출력하지 않고 성공적으로 완료했다는 말만 나와

declare
begin
    dbms_output.put_line('Hello');
end;
/

-- 변수 선언: declare과 begin 사이
declare
    v_empid number:=100;
    v_empname varchar2(20);
begin
    v_empname:='Steven';
    dbms_output.put_line('아이디: '||v_empid);
    dbms_output.put_line('이름: '||v_empname);
end;
/

-- 저장한 문서를 실행? (sql plus에서 실행)
-- 메모장에서 저장할 때 .sql 파일로, 인코딩은 ANSI! (한글이 안되더라고)
-- @경로\파일명.sql
-- @C:\SWacademy\database\code\day017\oracle\file04_save.sql


-- 스칼라, 레퍼런스
declare
    -- 스칼라 타입
    v_empid number:=100;
    v_empname varchar2(20);
    -- 레퍼런스 타입
    v_salary employees.salary%type; -- employees 테이블의 salary 컬럼과 타입이 같아 -> salary가 바뀌어도 변경 안해도 됨!
    v_email employees.email%type;
begin
    v_empname:='Steven';
    v_salary:=3000;
    v_email:='이메일 입니다!';
    dbms_output.put_line('아이디: '||v_empid);
    dbms_output.put_line('이름: '||v_empname);
    dbms_output.put_line('급여: '||v_salary);
    dbms_output.put_line('이메일: '||v_email);
end;
/

-- 한 건 담기 (레코드)
declare
    v_emp employees%rowtype;
    v_empemail employees.email%type;
begin
    select *
    into v_emp
    from employees
    where employee_id=100;
    
    dbms_output.put_line('직원번호: '||v_emp.employee_id);
    dbms_output.put_line('직원이름: '||v_emp.first_name);
    dbms_output.put_line('직원이름: '||v_emp.last_name);
    dbms_output.put_line('직원급여: '||v_emp.salary);
    
    select email
    into v_empemail
    from employees
    where employee_id=100;
    
    dbms_output.put_line('특정 칼럼 이메일: '||v_empemail);
end;
/

-- table 변수 사용
declare
    type firstname_type is table of employees.first_name%type -- 배열 생성
    index by binary_integer;
    
    type job_table_type is table of employees.job_id%type
    index by binary_integer;
    -- 순서를 나타내기 위해 사용
    seq binary_integer:=0;
    first_arr firstname_type;
    job_arr job_table_type;
begin
    for empROW in (select first_name, job_id from employees where department_id=60) loop
        seq:=seq+1; -- 우리 자바에서 i 늘리는 것처럼 생각해
        first_arr(seq):=empROW.first_name;
        job_arr(seq):=empROW.job_id;
        dbms_output.put_line('읽음: '||empROW.first_name||' '||empROW.job_id||', 저장: '||first_arr(seq)||' '||job_arr(seq));
    end loop;
end;
/

-- table 변수 사용 다시 (어려우니까 두 번째 예제)
declare
    -- 1건 조회
    v_fname employees.first_name%type;
    v_empid number:=100;
    -- 2건 조회
    v_salary employees.salary%type;
    -- 반복문 여러건 조회
begin
    -- 1건 조회
    select first_name into v_fname from employees where employee_id=v_empid;
    dbms_output.put_line('직원번호 '||v_empid||'번의 이름은 '||v_fname);
    
    -- 2건 조회
    select first_name, salary into v_fname, v_salary from employees where employee_id=v_empid;
    dbms_output.put_line('직원번호 '||v_empid||'번의 이름은 '||v_fname||', 급여는 '||v_salary);
    
    -- 반복문 여러건 조회 (배열 X, 바로 출력)
    for emp_record in (select * from employees where department_id=60) loop
        dbms_output.put_line('직원번호: '||emp_record.employee_id||', 이름: '||emp_record.first_name||', 급여: '||emp_record.salary);
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

-- 20장 저장 프로시저
-- 바로 위의 문제를 저장 프로시저로 만들기
create or replace PROCEDURE sp_print10
is 
    su number:=100;
begin
   for i in reverse 1..10 loop
        dbms_output.put_line(i);
   end loop;
end;
/
execute sp_print10; -- 자주 사용하는 것은 프로시저로 만들어 여러 번 실행 가능!

-- 저장된 프로시저 확인
desc user_source;
select * from user_source; -- 코드가 한 줄씩 저장되어있음!

-- 변수가 있는 프로시저 (in, out)
create or replace procedure sp_emp1(v_empid in employees.employee_id%type,
                                    v_salary out employees.salary%type,
                                    v_jobid out employees.job_id%type) -- 들어오면 in, 나가면 out, 들어왔다 나가면 inout
is
    v_record employees%rowtype;
begin
    select * 
    into v_record
    from employees
    where employee_id=v_empid;
    
    dbms_output.put_line('번호:'||v_record.employee_id);
    dbms_output.put_line('이름:'||v_record.first_name);
    dbms_output.put_line('급여:'||v_record.salary);
    dbms_output.put_line('입사일:'||v_record.hire_date);
    
    v_salary:=v_record.salary;
    v_jobid:=v_record.job_id;
end;
/
-- in만 있었을 때
-- execute sp_emp1(100);
-- in, out이 있을 때
variable a number;
variable b varchar2(30);
execute sp_emp1(107,:a,:b);