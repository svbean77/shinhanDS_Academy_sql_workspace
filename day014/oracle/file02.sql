-- 02
-- 5장 주요함수 p.41
-- ppt p.44: 사원들의 현재까지의 근무 일수 계산
-- 날짜 함수
select  sysdate, hire_date, floor((sysdate-hire_date)/365) "근무년수(정확X)", add_months(sysdate, 10) "10개월 후",
floor(MONTHS_BETWEEN(SYSDATE,hire_date)/12) "근무년수(정확O)", first_name, salary, add_months(hire_date, 4) "입사 4개월 후",
last_day(hire_date) "마지막 일", NEXT_DAY(hire_date, '수요일')
from employees; 

-- 날짜 반올림 ROUND, 버림 TRUNC
select hire_date, round(hire_date, 'month') "반올림(ROUND)", trunc(hire_date, 'month') "버림(TRUNC)"
from employees;

-- 형 변환 함수
-- to_char (날짜 -> 문자)
select sysdate, to_char(sysdate, 'yyyy/mm/dd'), to_char(sysdate, 'hh:mi:ss'), to_char(sysdate, 'DAY DY MON AM/PM')
from dual;

-- to_char (숫자 -> 문자)
select to_char(10000000, 'L999,999,999')
from dual;

-- to_date (문자 -> 날짜)
select to_date(20000101, 'yyyymmdd') YYYYMMDD, to_date(220101, 'yymmdd') as "YYMMDD"
from dual;

select first_name, hire_date
from employees
where hire_date = to_date('030617', 'rrmmdd');

select first_name, hire_date
from employees
where hire_date='030617'; -- rr 형식으로 쓰지 않는 것도 가능하네

select first_name, hire_date
from employees
where hire_date='03/06/17'; -- rr 형식으로 쓰기 (rr 형식: 50 이상이면 19Xx, 미만이면 20Xx년)

select first_name, hire_date
from employees
where hire_date='20030617'; -- 연도를 완전히 쓰는 것도 간단해!
-- nls_date_format 설정을 바꿀 수 있음. alter session set nls_date_format='';
-- 따라서 문자열로 쓰는 것보다는 양쪽 형식을 to_date로 맞추는 것이 좋다

-- 형식들을 볼 수 있음
select * from v$nls_parameters;

-- nvl: null을 다른 값으로
select first_name, hire_date, commission_pct, nvl(commission_pct, 0), salary, salary+salary*nvl(commission_pct, 0) 실수령액
from employees
order by commission_pct nulls first;

-- 추가) null이면 어떻게, not null이면 어떻게 하고 싶다! -> nlv2 (값, not null, null)
select salary, salary+salary*nvl2(commission_pct, commission_pct, 0) 실수령액, 
nvl2(commission_pct, '있다', '없다'), commission_pct
from employees
order by commission_pct;

-- ppt p.71manager이 null인 사람을 CEO로 출력
-- 하나의 타입을 두 개로 사용할 수 없음 (id는 숫자, ceo는 문자) -> 타입을 하나로 통일시켜야 함
select employee_id, first_name, manager_id, nvl(to_char(manager_id), 'CEO')
from employees;
select employee_id, first_name, manager_id, nvl2(manager_id, to_char(manager_id), 'CEO')
from employees;

select first_name, department_id, nvl(to_char(department_id), '부서 없음')
from employees;

-- DECODE
select department_id, decode(department_id, 10, 'A', 60, 'B', 90, 'C', 'D') 부서
from employees;

-- CASE
select salary, case 
when salary>=10000 then '매우많음'
when salary>=7000 then '많음'
when salary>=5000 then '보통'
else '적다'
end "case 사용"
from employees;

select first_name, case when first_name like 'A%' then 'A로 시작' else 'A가 아님' end "문자열로 비교"
from employees;

select first_name, case when first_name like '%a' then 'a로 끝' else '아니야' end "문자열2"
from employees;