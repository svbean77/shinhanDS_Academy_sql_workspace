-- 04
-- 08장. 서브 쿼리

-- Neena과 같은 직급을 가진 사원 출력 (Nenna는 한 명만 존재하기 때문에 = 비교연산자 가능!)
-- 서브쿼리의 결과가 단일행인지, 다중행인지 주의! (비교 연산자가 달라진다)
select *
from employees
where job_id = (select job_id
                from employees
                where first_name='Neena');
                
-- 다중행 연산자
select *
from employees
where job_id in (select job_id
                from employees
                where first_name='David');
                
select *
from employees
where job_id = Any(select job_id
                   from employees
                   where first_name='Alexander');
                
-- p.7 Neena의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여
select first_name, salary
from employees
where salary >= (select salary
                 from employees
                 where first_name='Neena');
                 
-- 서브 쿼리의 결과가 다중행인데 이 전부를 만족시키고 싶다면 
-- sub query의 결과가 1건이면 단일행 연산자 사용: =, >, >, <>
-- sub query의 결과가 1건 이상이면 다중행 연산자 사용: in, >=all, <any
select first_name, salary
from employees
where salary >= All(select salary
                    from employees
                    where first_name='Alexander');
                    
-- p.7 Seattle에서 근무하는 사원의 이름과 부서 번호
-- 선생님 풀이 - sub query 사용
select first_name, department_id
from employees
where department_id=any(
    select department_id
    from departments
    where location_id=(
        select location_id
        from locations
        where city='Seattle'));
-- 선생님 풀이 - join 이용한 풀이
select first_name, last_name, salary, department_id
from employees join departments using(department_id)
               join locations using(location_id)
where city='Seattle';

-- p.8 IT 부서에서 근무하는 사원의 이름과 급여
select first_name, salary
from employees
where department_id=(
    select department_id
    from departments
    where department_name='IT');

select first_name, salary
from employees join departments using(department_id)
where department_name='IT';

-- p. 8 직속상관이 Steven king인 사원의 이름과 급여
select first_name, salary
from employees
where manager_id =(
    select employee_id
    from employees
    where first_name='Steven' and last_name=initCap('KING'));
    
select first_name, salary
from employees
where manager_id = any(
    select employee_id
    from employees
    where last_name=initCap('KING'));
    
-- 평균 급여보다 많은 급여를 받는 사원 검색
select *
from employees
where salary >= (
    select avg(salary)
    from employees);

-- 다중칼럼 서브쿼리
-- p.12 부서별로 가장 많은 급여를 받는 사원의 정보 (in 연산자 이용)
select *
from employees
where (department_id, salary) in (
    select department_id, max(salary)
    from employees
    group by department_id);

-- p. 12 직급이 manager인 사람이 속한 부서의 부서 번호, 부서명, 지역
select first_name, department_id, department_name, city
from employees join departments using(department_id)
join locations using(location_id)
where job_id in (
    select job_id
    from jobs
    where substr(job_title, -7)=initCap('MANAGER'));
    
