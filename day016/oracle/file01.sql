-- 01 복습: 과제

-- subquery는 where 절에서 사용 가능
-- 단일 행인 경우 비교 연산자로 =, <>, >. >=, <, <= 사용
-- 다중 행인 경우 in, >any, <all, exists 사용 가능
-- from 절에서 사용되는 subquery: inline view
-- 상관형 subquery: from에 나오는 테이블을 subquery절에서 다시 사용 -> inline view를 이용하면 좀 더 쉬움 (우리ppt p.67)
-- top-n query: 상위 n건만 조회

-- 1. 'IT'부서에서 근무하는 직원들의 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
where department_id=(
    select department_id
    from departments
    where department_name='IT');
    
-- join으로 해결!
-- using을 사용하면 그 key는 테이블.칼럼으로 작성할 수 없음! departments.department_id 사용 불가!
select first_name, salary, hire_date
from employees join departments using(department_id)
where department_name='IT';
    
-- 2번
-- 'Alexander' 와 같은 부서에서 근무하는 직원의 이름과 부서id를 조회하시오.
select first_name, department_id
from employees
where department_id in(
    select department_id
    from employees
    where first_name = 'Alexander');
?
select first_name, department_id
from employees
where department_id = any(
    select department_id
    from employees
    where first_name = 'Alexander');
    
-- 3번
-- 80번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 부서id, 급여를 조회하시오. 
select first_name, department_id, salary
from employees
where salary > (
    select avg(salary)
    from employees
    where department_id = 80);

-- ++ 복습에서 추가: 평균 급여도 찍어줘
-- select 문에서 subquery를 사용한다 = 스칼라 subquery
select first_name, department_id, salary, (select avg(salary)
                                           from employees
                                           where department_id = 80)
from employees
where salary > (
    select avg(salary)
    from employees
    where department_id = 80);
-- inline view: from 문에서 서브쿼리 사용: 별명을 지은 후 다른 모든 문장에서 사용 가능! (from이 해석 1등이니까)
select first_name, department_id, salary, dept80.sal80
from employees, (select avg(salary) sal80
                from employees
                where department_id = 80) dept80
where salary > dept80.sal80;

?
-- 4번
-- 'South San Francisco'에 근무하는 직원의 최소급여보다 급여를 많이 받으면서 
-- 50 번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 급여, 부서명, 부서id를 조회하시오.
-- 문제 자체가 부서명이 null인 사람도 나와야 하기 때문에 외부 조인을 사용해!!!!!!!!
select first_name, salary, department_name, department_id
from employees left outer join departments using(department_id)
where salary > (
    select min(salary)
    from employees join departments using(department_id)
    join locations using(location_id)
    where city = 'South San Francisco')
and salary > (
    select avg(salary)
    from employees
    where department_id = 50);
-- 또 다른 사람의 풀이: salary > all로 한 후 subquery 2개를 적어준다.
-- 괄호로 묶어 서브쿼리 여러 개 사용 가능
select first_name, salary, department_name, department_id
from employees left outer join departments using(department_id)
where salary > all (
    (select min(salary)
    from employees join departments using(department_id)
    join locations using(location_id)
    where city = 'South San Francisco'),
    (select avg(salary)
    from employees
    where department_id = 50)
);?

-- LAB5
-- 1번
-- 직원의 이름과 관리자 이름을 조회하시오.
select 직원.first_name, 매니저.first_name
from employees 직원, employees 매니저
where 직원.manager_id = 매니저.employee_id;

-- 2번
-- 직원의 이름과 관리자 이름을 조회하시오.관리자가 없는 직원정보도 모두 출력하시오.
select 직원.employee_id, 직원.first_name, 매니저.employee_id, 매니저.first_name
from employees 직원, employees 매니저
where 직원.manager_id = 매니저.employee_id(+);

select 직원.first_name, 매니저.first_name
from employees 직원 left outer join employees 매니저 on 직원.manager_id = 매니저.employee_id;
?
-- 3번
-- 관리자 이름과 관리자가 관리하는 직원의 수를 조회하시오. 단, 관리직원수가 3명 이상인 관리자만 출력되도록 하시오.
select 매니저.employee_id, 매니저.first_name, count(*)
from employees 직원, employees 매니저
where 직원.manager_id = 매니저.employee_id
-- 동명이인이 있을 수 있기 때문에 직원 번호도 함께 그룹화
-- 근데 어차피 join에서 아이디를 묶었기 때문에 잘 나올 것 같긴 한데 그래도 확실히 하기 위해 직원 번호도 그룹화
group by 매니저.employee_id, 매니저.first_name
having count(*)>=3
order by 1;
?
-- LAB6
--  1번
-- 직원들의 이름, 입사일, 부서명을 조회하시오. 단, 부서가 없는 직원이 있다면 그 직원정보도 출력결과에 포함시킨다.
-- 그리고 부서가 없는 직원에 대해서는 '<부서없음>' 이 출력되도록 한다.(outer-join , nvl() )
select first_name, hire_date, nvl(department_name, '<부서없음>') 부서명, 
nvl(to_char(department_id), '<부서없음>') 부서번호1, nvl2(department_id, to_char(department_id), '<부서없음>') 부서번호2
from employees left join departments using(department_id);
?
-- 2번
-- 직원의 직책에 따라 월급을 다르게 지급하려고 한다.직책에 'Manager'가 포함된 직원은 급여에 0.5를 곱하고
-- 나머지 직원들에 대해서는 원래의 급여를 지급하도록 한다. 적절하게 조회하시오. (decode)
select first_name, job_title, salary, decode(substr(job_title,-7), 'Manager', salary*0.5, salary)salary2
from employees join jobs using(job_id);
-- case로도 풀어보자
select first_name, job_title, salary 원래급여,
    case when job_title like '%Manager' then salary*0.5 else salary  end 바뀐급여
from employees join jobs using(job_id);


-- 만약 삭감 조회가 아니고 수정이었다면?! 
-- 테이블 복제해서 실험해보자
create table empBackup
as
select * from employees;

select first_name, job_title, salary from empBackup join jobs using (job_id);
update empBackup
set salary = salary * 0.5
where employee_id in (
    select employee_id
    from empBackup join jobs using(job_id)
    where substr(job_title, -7) = 'Manager');
?
-- 3번
-- 각 부서별로 최저급여를 받는 직원의 이름과 부서id, 급여를 조회하시오.
select first_name, department_id, salary
from employees
where (department_id, salary) in ( 
select department_id, min(salary)
from employees
group by department_id);

-- 제대로 풀었는지 확인!
select * from employees where department_id=100 and salary=6900;
select * from employees where department_id=90 and salary=17000;
?
-- 4번
-- 각 직급별(job_title) 인원수를 조회하되 사용되지 않은 직급이 있다면 해당 직급도 출력결과에 포함시키시오. 
-- 그리고 직급별 인원수가 3명 이상인 직급만 출력결과에 포함시키시오.
select job_title, count(*)인원수
from employees right outer join jobs using(job_id) -- 외부 조인을 사용하면 null도 나와
group by job_title
having count(*) >= 3;
?
?
-- 5번
-- 각 부서별 최대급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
select first_name, department_name, salary
from employees join departments using(department_id)
where (department_id, salary) in ( 
    select department_id, max(salary)
    from employees
    group by department_id);
-- 맞는지 확인하자!
select count(distinct department_id) from employees;
-- inline view로 풀어보자!
select first_name, department_name, salary
from employees, departments, (select department_id, max(salary) maxSal
                              from employees
                              group by department_id) deptsalMax
where employees.department_id=departments.department_id
and employees.department_id=deptsalMax.department_id
and employees.salary=deptsalMax.maxSal;
?
-- 6번
-- 직원의 이름, 부서id, 급여를 조회하시오. 그리고 직원이 속한 해당 부서의 최소급여를 마지막에 포함시켜 출력 하시오.
-- 선생님 풀이 1: 스칼라 서브쿼리
-- 밖(mainEmp)과 안(서브쿼리)가 엮여있다 = 상관형 서브 쿼리
select first_name, department_id, salary, (select min(salary)
                                           from employees
                                           where department_id=mainEmp.department_id) 부서최소급여
from employees mainEmp;
-- 선생님 풀이 2: 인라인뷰
select first_name, department_id, salary, minSal
from employees join (select department_id, min(salary) minSal
                     from employees
                     group by department_id) deptminsal
               using (department_id);
                 



-- 다른 학생 풀이
select first_name, department_id, salary, (
select min(salary) from employees emp2
where emp2.department_id = emp1.department_id) 최소급여
from employees emp1;

-- 내 풀이
select first_name, employees.department_id, salary, minSal
from employees, (
    select department_id, min(salary) minSal
    from employees
    group by department_id) dept
where employees.department_id=dept.department_id;

-- 6장 4절 LAB7
-- 1. 급여를 가장 많이 받는 상위 5명의 직원 정보를 조회하시오.
-- pseudo 칼럼(실제 칼럼이 아닌데 칼럼인 것 처럼 행동하는 객체)
-- top-n을 사용하지 않는다면?! 1. 연봉으로 정렬 2. 그것을 select해 rownum 붙임 3. where절에서 사용하도록 다시 select
select rownum, sorted.*
from (select first_name, salary
      from employees
    order by salary desc) sorted
where rownum <= 5; -- 1이 포함되지 않은 경우에는 아무 결과도 나오지 않음
-- 나중에 웹페이지에서 페이징 처리를 할 때 이런 방식을 사용해야 함!
select *
from (select rownum rr, sorted.*
      from (select first_name, salary
            from employees
            order by salary desc) sorted
      )
where rr=5; -- 1이 포함되지 않은 경우 다시 select로 감싸줘야 함
-- mysql에서는 아주 간단한데: limit
select first_name, salary
from employees
order by salary desc limit 5;



-- 2. 커미션을 가장 많이 받는 상위 3명의 직원 정보를 조회하시오.
select * 
from (select *
      from employees
      order by commission_pct desc nulls last, salary desc)
where rownum <= 3;
-- 3번째 사람 출력으로 문제를 바꿔본다면?!
select *
from (select rownum rr, sorted.* 
      from (select *
            from employees
            order by commission_pct desc nulls last, salary desc) sorted
     )
where rr=3;     

-- 3. 월별 입사자 수를 조회하되, 입사자 수가 5명 이상인 월만 출력하시오.
select to_char(hire_date, 'mm') 월, count(*) "월별 입사자"
from employees
group by to_char(hire_date, 'mm')
having count(*) >= 5
order by 월;

-- 4. 년도별 입사자 수를 조회하시오. 
-- 단, 입사자수가 많은 년도부터 출력되도록 합니다.
select to_char(hire_date, 'yyyy') 년, count (*) "입사자 수"
from employees
group by to_char(hire_date, 'yyyy')
order by 2 desc;

