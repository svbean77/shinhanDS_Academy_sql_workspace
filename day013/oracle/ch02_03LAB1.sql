-- 04 2장 3절 LAB1 
desc employees;
-- 1. 급여가 15000 이상인 직원들의 이름, 급여, 부서id를 조회하시오.
select first_name, salary, department_id
from employees
where salary >= 15000;

-- 2. 직원 중에서 연봉이 170000 이상인 직원들의 이름, 연봉을 조회하시오.
--    연봉은 급여(salary)에 12를 곱한 값입니다.
select first_name, salary*12 연봉
from employees
where salary*12 >= 170000;

-- 3. 직원 중에서 부서id가 없는 직원의 이름과 급여를 조회하시오.
select first_name, salary
from employees
where department_id is null; -- null은 값이 없기 때문에 값=null로 비교할 수 없음!

-- 4. 2004년 이전에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
-- where hire_date<='041231';
where hire_date<='2004/12/31'; -- 오라클은 자동 형 변환 제공 -> 날짜형 문자는 날짜로 변환해줌 따라서 비교 연산자 사용 가능

-- 추가 문제! 2004년 입사자만 찾고 싶다
select first_name, salary, hire_date
from employees
where to_char(hire_date, 'yyyy')='2004';


-- 논리연산자 -- 
-- 1. 80, 50 번 부서에 속해있으면서 급여가 13000 이상인 직원의 이름, 급여, 부서id
-- 를 조회하시오.
select first_name, salary, department_id
from employees
-- and, or의 우선순위는 and가 우선! 따라서 괄호로 감싸기
where (department_id = 80 or department_id = 50) and salary >= 13000;

select first_name, salary, department_id
from employees
-- 연산자를 여러 개 쓰는거 싫으니까 in 사용!
where department_id in(80, 50) and salary >= 13000;

-- 2. 2005년 이후에 입사한 직원들 중에서 급여가 1300 이상 20000 이하인 직원들의 
-- 이름, 급여, 부서id, 입사일을 조회하시오.
select first_name, salary, department_id, hire_date
from employees
where hire_date >= '050101' and salary >= 1300 and salary <= 20000;

select first_name, salary, department_id, hire_date
from employees
-- 이상, 이하를 함께 쓰고 싶다면 between!
where hire_date >= '050101' and salary between 1300 and 20000;


-- SQL 비교연산자 --
-- 1. 80, 50 번 부서에 속해있으면서 급여가 13000 이상인 직원의 이름, 급여, 부서id
-- 를 조회하시오.
select first_name, salary, department_id
from employees
where department_id in(50, 80) and salary >= 13000;

-- 2. 2005년 이후에 입사한 직원들 중에서 급여가 1300 이상 30000 이하인 직원들의 
-- 이름, 급여, 부서id, 입사일을 조회하시오.
select first_name, salary, department_id, hire_date
from employees
where hire_date >= '05/01/01' and salary between 1300 and 30000;



-- 3. 2005년도 입사한 직원의 정보만 출력하시오.
select *
from employees
where to_char(hire_date, 'yyyy')=2005; -- 왼쪽은 문자, 오른쪽은 숫자이지만 자동 형 변환이 일어남



-- 4. 이름이 D로 시작하는 직원의 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
where first_name like 'D%';

select first_name, salary, hire_date
from employees
where substr(first_name, 1, 1)='D';

-- 5. 12월에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
where to_char(hire_date, 'mm')='12';
-- yy/mm/dd이기 때문에 4번 인덱스부터 2개!
select first_name, salary, hire_date
from employees
where substr(hire_date, 4, 2)='12';


-- 6. 이름에 le 가 들어간 직원의 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
where first_name like '%le%';



-- 7. 이름이 m으로 끝나는 직원의 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
where first_name like '%m';



-- 8. 이름의 세번째 글자가 r인 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
where first_name like '__r%';

select first_name, salary, hire_date
from employees
where substr(first_name, 3, 1)='r';


-- 9. 커미션을 받는 직원의 이름, 커미션, 급여를 조회하시오.
select first_name, commission_pct, salary
from employees
where commission_pct is not null;



-- 10. 커미션을 받지 않는 직원의 이름, 커미션, 급여를 조회하시오.
select first_name, commission_pct, salary
from employees
where commission_pct is null;



-- 11. 2000년대에 입사해서 30, 50, 80 번 부서에 속해있으면서, 
-- 급여를 5000 이상 17000 이하를 받는 직원을 조회하시오. 
-- 단, 커미션을 받지 않는 직원들은 검색 대상에서 제외시키며, 먼저 입사한 직원이 
-- 먼저 출력되어야 하며 입사일이 같은 경우 급여가 많은 직원이 먼저 출력되록 하시오.
select *
from employees
where to_char(hire_date, 'yyyy') >= '2000' and department_id in(30, 50, 80) 
and salary between 5000 and 17000 and commission_pct is not null
order by hire_date asc, salary desc;

select *
from employees
where to_char(hire_date, 'rr') >= '00' and department_id in(30, 50, 80) 
and salary between 5000 and 17000 and commission_pct is not null
order by hire_date asc, salary desc;

select *
from employees
where substr(to_char(hire_date, 'yyyy'), 1, 1) = '2' and department_id in(30, 50, 80) 
and salary between 5000 and 17000 and commission_pct is not null
order by hire_date asc, salary desc;