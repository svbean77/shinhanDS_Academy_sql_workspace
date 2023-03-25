-- 03 
-- ch.14 ���� ���̺��� ��
desc employees;

create or replace view empView1
as select employee_id, first_name, last_name, email, hire_date, job_id
from employees
where department_id=60;
select * from user_views; -- ������ ���̺��� ��������� ���� �ƴϰ� select ���� ����Ǵ� ��!
-- view�� ����� join�� ����!
select empView1.*, jobs.job_title
from empView1 join jobs on empView1.job_id=jobs.job_id; -- using�� ���� empView1.*������ ��ȣ�ؼ� X (job_id�� ���ݾ�)

-- view�� �����غ��� (103�� email�� ���� (AHUNOLD)
update empView1
set email='email@naver.com'
where employee_id=103;
commit;

select * from empView1;
select * from employees where employee_id=103; -- view�� ���� ������ ���� ���� ���̺����� ������!

-- join�� ������ ģ���� view�� ������
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