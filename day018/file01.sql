-- 01 복습
-- PL/SQL: 오라클이 제공하는 절차적 프로그래밍 언어
-- 왜 써? -> SQL(Structured Query Languate)은 비절차적 언어이기 때문에 로직이 있는, 절차가 있는 문장을 사용하지 못함
-- PL/SQL 안에 Procedure, Function, Trigger, Package가 들어있음!

-- 프로시저 만들어보자: 원래의 목적은 복잡한, 건수가 많은 데이터를 서버에서 실행해 속도 빠르게 하는 것 (리턴이 목적이 아님)
set serveroutput on;

create or replace procedure sp_salary(v_empid in employees.employee_id%type,
                                      v_salary out employees.salary%type,
                                      v_firstname out employees.first_name%type)
is
    v_message varchar2(50):='직원의 급여를 조회한다.';
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

-- 저장 함수 생성
-- Function: return이 있을 수도 있음!
-- lower(), upper(), substr() 등의 함수를 말하는 것!
select lower('ORACLE') from dual;

select first_name, substr(first_name, 1, 3) "이름 앞 3자리"
from employees
where department_id=60;

-- 어떤 함수를 만들고싶은데? -> 급여에 해당하는 세금 계산
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
select first_name, salary, f_tax(salary) 세금
from employees;

-- 커서: 여러건 select시 반드시 사용해야 함!
-- 명시적 커서 (declare, open, fetch, close 다 필요)
create or replace procedure sp_dept
is
    v_dept_record departments%rowtype;
    cursor cur_dept 
    is select department_id, department_name from departments where manager_id is not null;
    -- 이 방법으로 줘도 됨! 레코드 사용 안하고! into 옆에!
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

-- 암시적인 커서 사용
create or replace procedure sp_dept2
is
begin
    for v_dept_record in (select * from departments where manager_id is not null) loop  
        dbms_output.put_line(v_dept_record.department_id||' '||v_dept_record.department_name);
    end loop;
end;
/
execute sp_dept2;


-- 22장 패키지
-- 패키지 생성 (선언부)
create or replace package pkg_emp
is
    procedure sp_dept;
    procedure sp_dept2;
end;
/
-- 패키지 생성 (몸통)
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

-- 트리거: 어떤 테이블에 사건 발생 시 자동으로 실행되도록 하는 프로시저
delete from job_history;
commit;
select * from job_history;

select * from employees where employee_id=100; -- 현재 부서는 90번
update employees set department_id=110 where employee_id=100;
select * from job_history; -- 변경 내용이 백업 -> 이게 트리거! 자동으로 변경됨!
rollback;
select * from job_history; -- rollback을 하니 변경 내용이 사라짐! 저장을 하지 않았었으니까!

-- 트리거 만들어보자
-- insert시 다른 테이블에 추가!
create or replace trigger trigger_dept1
after insert on departments
begin
    dbms_output.put_line('부서가 삽입되었습니다.');
end;
/
insert into departments(department_id, department_name) 
values(1, 'aa');
insert into departments(department_id, department_name) 
values(3, 'cc');
select * from departments order by department_id;

-- departmet에 삽입되면 다른 테이블에 정보가 들어감
create sequence seq_sales;
create table sales_dept(salno number primary key, price number,
                        department_id number references departments(department_id));

create or replace trigger trigger_dept2
after insert on departments
for each row
begin
    dbms_output.put_line('sales_dept에 insert 된다');
    insert into sales_dept values (seq_sales.nextval, 1000, :new.department_id);
end;
/
insert into departments(department_id, department_name) 
values(4, '개발부');
insert into departments(department_id, department_name) 
values(5, '부ㅜ부붑붑ㅂㅂ부ㅜ');
select * from sales_dept;

create or replace trigger trigger_dept3
after delete on departments
for each row
begin
    dbms_output.put_line('sales_dept에서 delete 된다');
    delete from sales_dept where department_id=:old.department_id;
end;
/

delete from departments where department_id<=5;
select * from sales_dept;


-- ppt 22장 p.27 따라해보기
CREATE TABLE 상품(
상품코드 CHAR(6) PRIMARY KEY,
상품명 VARCHAR2(12) NOT NULL,
제조사 VARCHAR(12),
소비자가격 NUMBER(8),
재고수량 NUMBER DEFAULT 0
);

CREATE TABLE 입고(
입고번호 NUMBER(6) PRIMARY KEY,
상품코드 CHAR(6) REFERENCES 상품(상품코드),
입고일자 DATE DEFAULT SYSDATE,
입고수량 NUMBER(6),
입고단가 NUMBER(8),
입고금액 NUMBER(8)
);

INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격)
VALUES('A00001','세탁기', 'LG', 500); 
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격)
VALUES('A00002','컴퓨터', 'LG', 700);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격)
VALUES('A00003','냉장고', '삼성', 600);

select * from 상품;
select * from 입고;

-- 입고 트리거: 입고가 되면 상품 재고수량이 자동으로 늘어나도록
CREATE OR REPLACE TRIGGER TRG_04
AFTER INSERT ON 입고
FOR EACH ROW
BEGIN
    UPDATE 상품
    SET 재고수량 = 재고수량 + :NEW.입고수량
    WHERE 상품코드 = :NEW.상품코드;
END;
/ 

insert into 입고(입고번호, 상품코드, 입고수량, 입고단가) values(1, 'A00003', 10, 200);
insert into 입고(입고번호, 상품코드, 입고수량, 입고단가) values(2, 'A00003', 20, 200);
select * from 입고;
select * from 상품;

-- 2~16장까지만 알아두고 그 이후는 개념정도만 알아도 된다
-- PL/SQL 이런거 오늘 수업까지만 알아도 돼~~~~~~~~~~~~~