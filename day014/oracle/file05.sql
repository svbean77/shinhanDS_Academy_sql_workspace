-- 05
-- ch.06 그룹 함수
-- group by 절을 사용하지 않으면 전체에 대한 집계
-- 집계함수는 null을 제외하고 계산 (일반 연산은 연산 결과가 null)
select sum(salary), sum(commission_pct), avg(salary), sum(salary)/count(salary)
from employees;
-- null이 있으면 집계되지 않음
select count(salary), count(commission_pct) null없어, count(*) 전체건수, count(manager_id)
from employees;

-- ppt 6장 p.9: 가장 최근 입사, 오래 전 입사 
-- 날짜는 오래된 사람이 연도가 작기 때문에 min, 신입이 연도가 크기 때문에 max
select min(hire_date) 오래됐어, max(hire_date) 신입이네
from employees;

-- ppt 6장 p.12 80번 부서 중 커미션 받는 사원의 수
-- 방법1
select count(commission_pct) "커미션 받는 사원수", count(*) "80번 부서 사원수"
from employees
where department_id=80;
-- 방법2
select count(*) "커미션 받는 사원수"
from employees
where department_id=80
and commission_pct is not null;

-- 중복 제거한 count 집계
select count(distinct job_id) as 업무수, count(distinct department_id) as "부서수"
from employees;
-- 두 개는 같은 결과를 보임!
select distinct department_id
from employees
where department_id is not null;

-- group by: 부서별 연봉 평균
-- 부서가 null인 사람은 있지만 salary가 null인 사람은 없기 때문에 평균 연봉은 다 나오는 것!
select department_id, avg(salary) "부서별 연봉 평균"
from employees
group by department_id
order by department_id;
-- where 조건을 통해 null 제거
-- select 절에 집계함수를 사용하지 않는 칼럼이 있다면 반드시 group by 절에 참여해야 함!
select department_id, avg(salary) "부서별 연봉 평균", max(job_id) -- , job_id -- 오류 발생!
from employees
where department_id is not null
group by department_id
order by department_id;

select department_id, job_id , avg(salary) "부서별 연봉 평균"
from employees
where department_id is not null
group by department_id, job_id
order by department_id;

-- having: 집계 함수를 통해 그룹 조건 필터링
select department_id, job_id , avg(salary) "부서별 연봉 평균"
from employees
where department_id is not null
group by department_id, job_id having(avg(salary) >= 10000)
order by department_id;

-- 지금까지의 작성 순서와 해석 순서!!
select department_id, avg(salary) "평균 연봉" -- 5
from employees -- 1
where department_id is not null -- 2
group by department_id -- 3
having avg(salary)>=10000 -- 4
order by department_id; -- 6

-- p.22 최고 연봉이 얼마 이상인 부서의 최고, 최저 연봉 출력
select department_id, max(salary) "최대 급여", min(salary) "최저 급여"
from employees
group by department_id;
