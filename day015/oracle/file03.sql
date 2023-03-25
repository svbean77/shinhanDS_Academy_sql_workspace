-- 03
-- 07장 조인 (p.17~)

-- Non-Equi join: = 이외의 연산자를 이용해 조인
-- 이를 위해 테이블 하나 만들자~
create table salgrade(grade char(1) primary key, minsal number, maxsal number);
insert into salgrade values('A', 0, 5000);
insert into salgrade values('B', 5001, 15000);
insert into salgrade values('C', 15001, 20000);
insert into salgrade values('D', 20001, 30000);
commit;
select * from salgrade;

-- 직원 이름, 급여, 급여의 등급 출력
select first_name, salary, grade
from employees join salgrade
on salary between minsal and maxsal;

select e.first_name, e.salary, s.grade
from employees e, salgrade s
where e.salary between s.minsal and s.maxsal;

-- self join
select * from employees;
-- 101번 직원의 매니저의 이름을 알고싶다!
-- 106건의 결과가 나옴! (매니저가 업슨 한 명이 있어)
select 직원.employee_id 직원, 직원.first_name, 매니저.employee_id 매니저, 매니저.first_name
from employees 직원, employees 매니저
where 직원.manager_id=매니저.employee_id
order by 1;
select 직원.employee_id 직원, 직원.first_name, 매니저.employee_id 매니저, 매니저.first_name
from employees 직원
join employees 매니저
on 직원.manager_id=매니저.employee_id
order by 1;
-- 매니저가 없는 직원도 나왔으면 좋겠어!
select 직원.employee_id 직원, 직원.first_name, 매니저.employee_id 매니저, 매니저.first_name
from employees 직원, employees 매니저
where 직원.manager_id=매니저.employee_id(+) -- oracle 문법임..
order by 1;
select 직원.employee_id 직원, 직원.first_name, 매니저.employee_id 매니저, 매니저.first_name
from employees 직원
left outer join employees 매니저
on 직원.manager_id=매니저.employee_id
order by 1;

-- p.23 매니저가 king인 사원의 이름과 직급
select emp.employee_id, emp.first_name, emp.last_name, jobs.job_title
from employees emp, employees m , jobs
where emp.manager_id=m.employee_id
and emp.job_id=jobs.job_id
and m.last_name='King'
order by emp.employee_id;
-- self join을 사용하지 않고 서브 쿼리를 사용하면 안돼?
select employee_id, first_name 
from employees
where manager_id=(select employee_id
                  from employees
                  where first_name='Steven' and last_name='King');

-- p.23 steven king과 동일한 부서에서 근무하는 사원의 이름 출력
-- self join
select emp.employee_id, emp.first_name, emp.last_name
from employees king
join employees emp on king.department_id=emp.department_id
where king.first_name='Steven' and king.last_name='King';

select emp.employee_id, emp.first_name, emp.last_name
from employees king, employees emp
where king.department_id=emp.department_id
and king.first_name='Steven' and king.last_name='King';
-- sub query
select employee_id, first_name, last_name
from employees
where department_id=(select department_id
                     from employees
                     where first_name='Steven' and last_name='King');
                     
-- outer join
-- 부서 정보 출력, manager_id는 부서장을 의미, 부서장은 직원 중 한 명
-- 부서가 직원을 참조 -> 부서 수만큼 결과가 나와야 함
-- 얘는 그냥 join이기 때문에 부서장이 없는 부서는 출력되지 않음
select departments.*, first_name, salary, hire_date
from employees
join departments on employees.employee_id=departments.manager_id;
-- 부서장이 없는 부서도 출력하고 싶은데? -> outer join 사용
-- ANSI 표준
select departments.*, first_name, salary, hire_date
from employees
right outer join departments on employees.employee_id=departments.manager_id;
-- oracle sql
select departments.*, first_name, salary, hire_date
from employees, departments
where employees.employee_id(+)=departments.manager_id;

-- 부서가 없는 직원, 직원이 없는 부서를 모두 보고싶다 -> full outer join 사용!
select first_name, salary, department_name
from employees
full outer join departments using(department_id);
