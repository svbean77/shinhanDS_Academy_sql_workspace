-- 03 
-- ch.14 가상 테이블인 뷰
desc employees;

create or replace view empView1
as select employee_id, first_name, last_name, email, hire_date, job_id
from employees
where department_id=60;
select * from user_views; -- 실제로 테이블이 만들어지는 것이 아니고 select 문이 저장되는 것!
-- view를 사용해 join도 가능!
select empView1.*, jobs.job_title
from empView1 join jobs on empView1.job_id=jobs.job_id; -- using을 쓰면 empView1.*때문에 모호해서 X (job_id가 있잖아)

-- view를 수정해보자 (103의 email을 수정 (AHUNOLD)
update empView1
set email='email@naver.com'
where employee_id=103;
commit;

select * from empView1;
select * from employees where employee_id=103; -- view를 통해 수정한 값이 실제 테이블에서도 수정됨!

-- join이 복잡한 친구를 view로 만들어보자
create or replace view view_join4
as
select first_name, department_name, city, country_name
from employees join departments using (department_id)
               join locations using (location_id)
               join countries using (country_id);
               
select * from view_join4;

-- force
create or replace force view view_join4
as
select first_name, department_name, city, country_name
from employees join departments using (department_id)
               join locations using (location_id)
               join countries using (country_id);
               
-- with check option
create or replace view empView1
as select employee_id, first_name, last_name, email, hire_date, job_id, department_id
from employees
where department_id=60 with check option;

select * from empView1;
update empView1
set department_id=100;