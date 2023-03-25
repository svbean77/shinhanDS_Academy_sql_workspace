-- 09
-- 6장 2절 LAB5
-- self join
-- 1. 직원의 이름과 관리자 이름을 조회하시오.
select emp.first_name 직원이름, m.first_name 관리자이름
from employees emp 
join employees m on emp.manager_id=m.employee_id;



-- 2. 직원의 이름과 관리자 이름을 조회하시오.
-- 관리자가 없는 직원정보도 모두 출력하시오.
select emp.first_name 직원이름, m.first_name 관리자이름
from employees emp 
left outer join employees m on emp.manager_id=m.employee_id;



-- 3. 관리자 이름과 관리자가 관리하는 직원의 수를 조회하시오.
-- 단, 관리직원수가 3명 이상인 관리자만 출력되도록 하시오.
select m.first_name 관리자명, count(*) 관리직원수
from employees emp
join employees m on emp.manager_id=m.employee_id 
group by m.first_name
having count(*) >= 3;

