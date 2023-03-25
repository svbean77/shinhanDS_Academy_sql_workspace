-- 01  

-- 대소문자 구별 없음
-- 여러 문장으로 작성 가능
-- 문장의 끝은 ;


-- 2장 
-- 테이블의 정보를 보여줌
desc employees;

-- 모든 테이블을 가져옴
select * from tab;

-- 해당 테이블의 모든 칼럼을 가져옴
select * from employees;

-- 해당 테이블의 특정 칼럼을 가져옴
select employee_id, first_name
from employees;

-- 숫자, 문자도 가져올 수 있음 
-- invalid identifier: 식별자 오류 (식별자: 칼럼 이름, 테이블 이름) -> 문자 값은 반드시 ''를 써야 함
-- oracle은 데이터 사전이 있다. (테이블 이름을 '대문자로'저장해둠) -> ""로 묶을 때는 대소문자 구분!
-- from의 테이블을 소문자로 썼는데 ""로 묶으면 'table or view does not exist' 에러 발생
select employee_id, first_name, 1+2, 'SQL배우기'
from "EMPLOYEES";

-- distinct: 중복 제거
select distinct department_id
from EMPLOYEES;

-- 해석 순서는 from -> select (어떤 테이블을 사용하는지를 먼저 해석)
select * from employees; 

-- sql에서 산술 연산이 가능!
-- 값이 없다: null -> null이면 계산 결과도 null -> null을 대체해야 함!
-- 칼럼의 별칭을 지어줄 수 있음 -> 특수문자 포함된 식별자 이름은 ""로 감싸야 함!
-- 별칭 줄 때 as 생략 가능
select employee_id as 직원번호, first_name 이름, salary, commission_pct, salary+salary*nvl(commission_pct, 0) "커미션 적용 급여"
from employees;

-- 연결 연산자는 oracle: ||, concat(2개만 가능), mysql: concat
select employee_id as 직원번호, first_name||' '||last_name 이름, salary, 
commission_pct, salary+salary*nvl(commission_pct, 0) "커미션 적용 급여", hire_date
from employees;
select employee_id as 직원번호, concat(concat(first_name,' '),last_name) 이름, salary, 
commission_pct, salary+salary*nvl(commission_pct, 0) "커미션 적용 급여", hire_date
from employees;

-- distinct에 여러 개: 여러 개 조합의 중복 제거 (두 개가 모두 같으면 제거)
select distinct department_id, job_id
from employees;


-- 3장은 패스~
-- 4장
-- 조건절
-- 해석 순서는 from - where - select
select employee_id 직원번호, first_name||' '||last_name 이름, salary 급여
from employees
where salary >= 10000;

-- 순서대로 나왔으면 좋겠다: order by
-- from - where - select - order by (순서를 아는 방법은 식별자를 다른 절에 넣어줘보면 됨!!!!
select employee_id 직원번호, first_name||' '||last_name 이름, salary 급여
from employees
where salary >= 10000
order by 급여 desc;

-- order by 옆은 칼럼 이름, 별명, select 순서 적기 가능! (순서는 1부터 시작)
select employee_id 직원번호, first_name||' '||last_name 이름, salary 급여
from employees
where salary >= 10000
order by 3 desc;

-- 강사HR 실행 후
-- select * from student order by 1; -- 내 db에는 만들지 않았기 때문에 오류 발생!

-- select 칼럼이름들 -- 해석순서 3
-- from 테이블이름들 -- 해석순서 1
-- where 조건절 -- 해석순서 2
-- order by 칼럼들; -- 해석순서 4

-- 날짜가 19XX인지 20XX인지 어떻게 알아?! -> RR형식
-- 50을 기준으로 작으면 20, 크면 19 붙임 ex) 20 -> 2020년, 61 -> 1961년
select employee_id, first_name, salary, hire_date
from employees
where salary >= 10000
order by hire_date asc;
-- yyyy로 정확하게 보고싶다면? -> to_char(칼럼, 'yyyy/mm/dd hh:mi:ss')로 형식을 넣어줌
select employee_id, first_name, salary, to_char(hire_date, 'yyyy/mm/dd hh:mi:ss')
from employees
where salary >= 10000
order by hire_date asc;

-- 비교 연산자
select employee_id, first_name, salary, to_char(hire_date, 'yyyy/mm/dd hh:mi:ss') 입사일, department_id
from employees
where salary >= 10000 and department_id=80
order by hire_date asc;

-- 문자 데이터 조회 (대소문자 구분 함)
select employee_id, first_name, salary, to_char(hire_date, 'yyyy/mm/dd hh:mi:ss') 입사일, department_id
from employees
where salary >= 10000 and department_id=80 and first_name='Lisa'
order by hire_date asc;

-- 5장
-- dual table은 oracle에서 제공하는 dumy table
desc dual;
select * from dual;

-- 수행 결과가 하나의 row로 나오게 하기 위해 만든 테이블이다 (다른 테이블들로 하면 데이터 수만큼 행이 나와버려!)
select 1+2 from employees; -- 다른 테이블
select 1+2, sysdate from dual; -- dual 테이블 이용

-- 숫자 함수
select 10/3, floor(10/3), floor(10.9) from dual; -- floor: 내림
select 10/1, ceil(10/3), floor(10.01) from dual; -- ceil: 올림
select round(35.67), round(35.67, 1), round(35.67, -1) from dual; -- round: 소숫점을 위치만큼 옮겨 뒤에서 반올림 실행

-- 다른ppt 5장 p.14 사번이 홀수인 사람 검색
select * from employees where mod(employee_id, 2)=1;

-- 문자 처리 함수
select first_name, upper(first_name) 대문자, lower(first_name) 소문자, email, initCap(email) 캐멀
from employees;

-- 퀴즈! first_name이 david인 사람을 검색하고싶다! (칼럼은 initCap 형식임)
-- 방법1이 제일 좋은 방식임: 인덱스(칼럼)을 바꾸지 않는 것이기 때문에! 인덱스가 깨지면 속도가 느려질 수 있어..
-- db는 변형하지 않는 것이 가장 좋은 방법이다.
-- ex) first_name 칼럼으로 색인(index)이 구성되어 있었다면 함수를 이용했을 때 인덱스는 깨진다.. (= 인덱스 사용 불가)
select * from employees where first_name=initCap('david'); -- 방법1: 입력을 첫 대문자로 올린다
select * from employees where lower(first_name)='david'; -- 방법2: 칼럼을 소문자로 내린다
select * from employees where upper(first_name)=upper('david'); -- 방법3: 다 대문자로 올린다

-- 문자열의 길이를 구하라
select first_name, length(first_name) 이름길이, '김철수', length('김철수') 이름길이, lengthb('김철수')
from employees;

-- 파라미터의 형식을 볼 수 있음
select * from v$nls_parameters;
select lengthb('oracle'), lengthb('오라클') -- nls characterset이 al32utf8로 되어 있기 때문에 한글이 3바이트로 됨
from dual;

-- 다른 ppt 5장 p.28
-- 05년도에 입사한 직원, substr 함수를 이용해 고용날짜 2글자 추출해 05인지 체크
select *
from employees
where substr(hire_date, 1, 2)='05';

select *
from employees
where to_char(hire_date, 'RR')='05'; -- 연도를 RR로 뽑기 (rr형식!)

-- 이름이 E로 끝나는 직원, substr 이용해 마지막 한 글자만 추출해서 확인
select *
from employees
where substr(first_name, -1)=lower('E');

-- 특정 문자의 인덱스 찾기 (대상, 찾을 문자, 시작 위치, 몇 번째)
select first_name, instr(first_name, 'a'), instr(first_name, 'a', 2, 2)
from employees;

-- 다른 ppt 5장 p.34 이름 3번째 자리가 r인 사원
-- _: 임의의 문자 1자, %: 임의의 문자 0자 이상
select first_name
from employees
where first_name like '__r%';

-- null은 오름차순시 나중에 나옴
-- nulls Xxx를 통해 위치 조정 가능
select *
from employees
order by commission_pct asc nulls first;
select *
from employees
order by commission_pct desc nulls last;

-- lpad, rpad
select lpad(first_name, 10, '#'), rpad(first_name, 20, '*')
from employees;

-- trim
select '!'||ltrim('      Oracle       ')||'!' as "LTRIM",'!'||rtrim('      Oracle       ')||'!' as "RTRIM",
'!'||trim('      Oracle       ')||'!' as "TRIM", '!'||trim('^' from '^^^^^^Oracle^^^^^')||'!' as "word TRIM"
from dual;