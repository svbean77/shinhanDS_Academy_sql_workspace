-- 07
-- 10장 테이블의 내용 추가, 수정, 삭제하는 dml

-- sub query로 테이블 생성하면 제약조건은 복제되지 않음..
create table tbl_emptest
as
select employee_id, first_name, salary, hire_date
from employees
where department_id=60;

desc tbl_emptest;

-- 모든 칼럼을 넣지 않으면 오류 발생
insert into tbl_emptest values(1, 'AA', 1000, sysdate);
-- insert into tbl_emptest values(1, AA, 1000, sysdate); -- 문자열을 ''로 묶지 않으면 오류 발생
-- 모든 칼럼을 넣고싶지 않으면 칼럼을 명시해야 함
-- 칼럼의 값을 넣지 않으면 암시적으로 null이 들어감
insert into tbl_emptest(employee_id, first_name, hire_date) values(2, 'BB', sysdate);
insert into tbl_emptest(employee_id, hire_date) values(3, sysdate-1);
insert into tbl_emptest(hire_date) values(sysdate-1);
-- 명시적으로 null 대입 가능 (null, 빈 문자열)
insert into tbl_emptest(employee_id, first_name, hire_date) values(4, null, sysdate);
insert into tbl_emptest(employee_id, first_name, hire_date) values(5, '', sysdate);
select * from tbl_emptest;

-- 서브 쿼리로 데이터 삽입 (구조 만들기 -> 데이터 삽입)
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

-- update 연습
create table tbl_emp_update
as
select * from employees;

select * from tbl_emp_update;

update tbl_emp_update set salary=salary*1.1
where department_id=50;
-- rollback, commit: transaction 처리하는 명령어
-- transaction: 하나의 논리적인 작업
-- commit: 작업을 끝내고 db에 반영한다
-- rollback: 작업을 끝내고 없던 일로 한다 (되돌린다, db에 반영 안한다)
commit;

-- 부서=90인 사람들을 Diana 직원과 같은 부서, 같은 salary로 변경하고 싶다!
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

-- delete: 서브 쿼리
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
--EMP02에 있는 1건 수정하기
select * from emp02;
select * from emp01;
update emp02 set  job='aa' , SAL = 9999, comm = 0.1, deptno=88
where empno=103;
--EMP02에 신규를 삽입하기
insert into emp02 values(111,'jj','bb',100, sysdate, 8888,0.2, 77);
-- 매칭되는 것이 있다: 103 Alexander, 매칭되는 것이 없다: 111 jj
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
select * from EMP01; -- 103 alexander는 2번으로 바꿈(매칭 O), 111 jj는 새로 넣음(매칭 X)
