-- 1. salary가 10000 이상인 사람을 job_id, employee_id 오름차순
select employee_id, first_name, last_name, job_id, salary
from employees
where salary >= 10000
order by job_id asc, employee_id asc;


-- 2. employee_id와 email을 employee_id 오름차순, 메일 소문자 주소 @samsung.com
select employee_id, lower(email)||'@samsung.com' "e-mail"
from employees
order by employee_id asc;


-- 3. department_id별로 구분, 평균 급여, 5명 이상인 부서만, 반올림 정수, department_id 오름차순
select department_id, round(avg(salary)) avg_salary
from employees
group by department_id
having count(*)  >= 5
order by department_id asc;


-- 4. 30부서 1.3배, 50부서 1.5배, 80부서 0.9배, 나머지 그대로 next_salary, department_id 오름차순 first_name 내림차순
select department_id, first_name, last_name, salary, 
decode(department_id, 30, salary*1.3, 50, salary*1.5, 80, salary*0.9, salary) next_salary
from employees
order by department_id asc, first_name desc;


-- 5. salary 가장 높은 직원 정보
select employee_id, first_name, last_name, department_id, salary
from employees
where salary = (select max(salary) from employees);


-- 6. job_title에 Manager 포함된 직원들만 employee_id 내림차순
select employee_id, first_name, last_name, job_title
from employees join jobs using(job_id)
where job_title like initCap('%Manager%')
order by employee_id desc;


-- 7. 직원을 관리하는 manager에 대한 정보, 없어도 출력, employee_id 내림차순
select emp.employee_id, emp.first_name, m.first_name manager_name, m.hire_date mgr_hire_date
from employees emp left outer join employees m on emp.manager_id=m.employee_id
order by employee_id desc;


-- 8. employees department_id별로 나눠 부서명, 도시 출력, 직원수, 평균급여 반올림, 도시가 토론토, 런던, 옥스포드만 department_id 오름차순
select department_id, department_name, city, emp.employee_cnt, emp.avg_sal
from (select department_id, count(*) employee_cnt, round(avg(salary)) avg_sal
      from employees
      group by department_id) emp join departments using (department_id)
                                  join locations using(location_id)
where city in ('Toronto', 'London', 'Oxford')
order by department_id asc;


-- 9. jobs의 job_id=IT_PROG인 데이터 수정, title을 Solution Programmer, maxSal을 50000으로 업데이트
update jobs
set job_title='Solution Programmer', max_salary=50000
where job_id='IT_PROG';


-- 10. countries에 대한민국 정보 추가, id는 KR, name은 Korea, 지역은 3
insert into countries
values ('KR', 'Korea', 3);

