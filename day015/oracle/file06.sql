-- 06
-- 09장. 테이블 구조 생성, 변경 및 삭제하는 DDL

-- 찍힌 데이터의 rowid 보기 (행의 위치를 지정하는 논리적인 주소값)
select employee_id, first_name, rowid -- rowid는 내부적으로만 사용하기 때문에 우리는 알 필요가 없어, 알 수도 없어
from employees;

-- p.13
create table tbl_test1(id number, name varchar2(20), gender char(1), year01 interval year(3) to month);
insert into tbl_test1 values(1, 'abc', 'M', interval '36' month(3)); -- 3년 후
insert into tbl_test1 values(2, 'def', 'W', interval '12' month(3)); -- 1년 후

select id, name, gender, year01, sysdate+year01
from tbl_test1;

-- 가변 길이(varchar2)는 뒤에 공백이 붙으면 다른 문자열로 안다.
select *
from tbl_test1
where name='abc  '; 
-- 고정 길이(char)는 뒤에 공백이 붙어도 고정적이다.
select *
from tbl_test1
where gender = 'M         ';

-- 서브 쿼리로 테이블 생성(create table)
-- 완전 똑같음
create table tbl_emp
as
select * from employees;
-- 특정 데이터만 
create table tbl_emp2
as
select * from employees where department_id=60;
-- 데이터는 아니고 구조만
create table tbl_emp3
as
select * from employees where 1=0;
-- 몇몇 칼럼 구조만
create table tbl_emp4
as
select employee_id, first_name
from employees where 1=0;

select * from tbl_emp;
select * from tbl_emp2;
select * from tbl_emp3;
select * from tbl_emp4;

-- 테이블 수정 (alter table)
alter table tbl_emp4 add (job_id varchar2(50));
desc tbl_emp4;
alter table tbl_emp4 modify (job_id varchar2(100));
insert into tbl_emp4 values(1, '1234567890123467890', 'ABC');
select * from tbl_emp4;
-- 20자리인 데이터가 있는데 길이를 줄이고 싶다
-- 에러 발생! 더 작게 줄이는 것은 X, 더 크게는 바꿀 수 있어!
-- alter table tbl_emp4 modify (first_name varchar2(10));
alter table tbl_emp4 modify (first_name varchar2(30));
desc tbl_emp4;
-- 데이터가 있는데 칼럼 삭제: 가능함 -> 아주 위험하니 주의해!
alter table tbl_emp4 drop column first_name;
desc tbl_emp4;
drop table tbl_emp4;

-- 데이터 삭제: truncate(복구 불가능), delete(rollback으로 복구 가능)
desc tbl_emp2;
select * from tbl_emp2;
truncate table tbl_emp2;
select * from tbl_emp;
delete from tbl_emp;
rollback; -- 원상복구 가능

-- 이름 변경
rename tbl_emp to tbl_employee;
select * from tbl_emp; -- 이름을 바꿨기 때문에 오류
select * from tbl_employee;

-- 딕셔너리 뷰
select * from user_tables;
select * from all_tables;
select * from dba_tables; -- dba가 아니기 때문에 접근 불가능

