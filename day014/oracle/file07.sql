-- 07
-- 투플 값 중복 불가라는 것을 보기 위해 테이블 생성
create table JJ (id number primary key, name varchar2(20));
insert into JJ values(1, 'AA');
insert into JJ values(2, 'BB');

select * from JJ;

update JJ set id=100 where id=1;

-- ch.07 조인
-- 100번 직원의 부서명을 알고싶다!!!!!!!!!
-- SQL은 비절차적 언어이기 때문에 문장 두 개를 실행하게 되어버림.. 한 문장으로 만들고 싶어!! = join
select *
from employees
where employee_id=100;
select *
from departments
where department_id=90;

-- employees 카디널리티 x departments 카디널리티 (=카티션 프로덕트)
select *
from employees, departments;

-- employees 테이블이 departments 테이블을 참조 (null은 나오지 않음) -> 106건
-- where절에서 key가 같은지 확인하는 것은 vendor 문법 -> 표준 sql 문법을 사용하는 것이 좋음!
select employee_id, first_name, department_name
from employees, departments
where employees.department_id = departments.department_id -- 중복되는 속성 이름이 있다면 테이블명도 작성
order by 1;

-- 이게 표준 문법!
select employee_id, first_name, department_id, department_name
from employees
join departments
using (department_id);
-- join하고자하는 칼럼명이 일치하지 않는 경우
select employee_id, first_name, departments.department_id, department_name
from employees
join departments
on employees.department_id=departments.department_id;
-- 왼쪽 조인 사용 (왼쪽=employees의 값이 null인 경우도 나옴)
select employee_id, first_name, departments.department_id, department_name
from employees
left outer join departments
on employees.department_id=departments.department_id;

-- job_id를 통해 직원이 어떤 직급인지 알고싶다! 최대, 최소 연봉도 구하자.
-- PK(Primary Key)의 특징: null 불가, unique함
-- FK(Foreign Key=참조키)의 특징: 다른or자신 테이블의 PK 참조
-- 방법1: vendor 문법
-- 속성이 한 테이블에만 존재하는 경우 위치를 쓰지 않아도 되지만 (employees.Xxx) 찾는 속도를 빠르게 하기 위해 써주는 것이 좋음
select employees.first_name, employees.salary, jobs.job_id, job_title
from employees, jobs
where employees.job_id=jobs.job_id;
-- 방법2: ANSI 문법 (using)
select employees.first_name, employees.salary, job_id, job_title
from employees
join jobs using(job_id);
-- 방법3: ANSI 문법 (on)
select employees.first_name, employees.salary, employees.job_id, job_title
from employees
join jobs on employees.job_id=jobs.job_id;

-- 테이블 별명 지어 사용
select emp.first_name, emp.salary, j.*
from employees emp join jobs j on (emp.job_id = j.job_id)
where emp.job_id='IT_PROG';

-- seattle에 부서가 있는 사람 조회 (내 풀이)
select first_name, salary
from employees
where department_id in (select department_id from departments join locations using (location_id) where city = 'Seattle')
order by first_name;
-- seattle에 부서가 있는 사람 조회 (선생님 풀이 1. vendor 문법 사용)
select first_name, salary, employees.department_id, department_name
from employees, departments, locations
where employees.department_id=departments.department_id
and departments.location_id=locations.location_id
and city='Seattle'
order by 1;
-- seattle에 부서가 있는 사람 조회 (선생님 풀이 2. ANSI 표준 문법 사용 (using))
select first_name, salary, department_id, department_name
from employees join departments using(department_id)
join locations using (location_id)
where city='Seattle'
order by 1;
-- seattle에 부서가 있는 사람 조회 (선생님 풀이 2. ANSI 표준 문법 사용 (on))
select first_name, salary, employees.department_id, department_name
from employees join departments on(employees.department_id=departments.department_id)
join locations on (departments.location_id=locations.location_id)
where city='Seattle'
order by 1;

-- accounting 부서 소속 사원의 이름, 입사일 출력
select first_name, hire_date, department_name
from employees join departments using (department_id)
where department_name='Accounting';