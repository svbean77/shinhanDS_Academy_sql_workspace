-- 1. salary�� 10000 �̻��� ����� job_id, employee_id ��������
select employee_id, first_name, last_name, job_id, salary
from employees
where salary >= 10000
order by job_id asc, employee_id asc;


-- 2. employee_id�� email�� employee_id ��������, ���� �ҹ��� �ּ� @samsung.com
select employee_id, lower(email)||'@samsung.com' "e-mail"
from employees
order by employee_id asc;


-- 3. department_id���� ����, ��� �޿�, 5�� �̻��� �μ���, �ݿø� ����, department_id ��������
select department_id, round(avg(salary)) avg_salary
from employees
group by department_id
having count(*)  >= 5
order by department_id asc;


-- 4. 30�μ� 1.3��, 50�μ� 1.5��, 80�μ� 0.9��, ������ �״�� next_salary, department_id �������� first_name ��������
select department_id, first_name, last_name, salary, 
decode(department_id, 30, salary*1.3, 50, salary*1.5, 80, salary*0.9, salary) next_salary
from employees
order by department_id asc, first_name desc;


-- 5. salary ���� ���� ���� ����
select employee_id, first_name, last_name, department_id, salary
from employees
where salary = (select max(salary) from employees);


-- 6. job_title�� Manager ���Ե� �����鸸 employee_id ��������
select employee_id, first_name, last_name, job_title
from employees join jobs using(job_id)
where job_title like initCap('%Manager%')
order by employee_id desc;


-- 7. ������ �����ϴ� manager�� ���� ����, ��� ���, employee_id ��������
select emp.employee_id, emp.first_name, m.first_name manager_name, m.hire_date mgr_hire_date
from employees emp left outer join employees m on emp.manager_id=m.employee_id
order by employee_id desc;


-- 8. employees department_id���� ���� �μ���, ���� ���, ������, ��ձ޿� �ݿø�, ���ð� �����, ����, �������常 department_id ��������
select department_id, department_name, city, emp.employee_cnt, emp.avg_sal
from (select department_id, count(*) employee_cnt, round(avg(salary)) avg_sal
      from employees
      group by department_id) emp join departments using (department_id)
                                  join locations using(location_id)
where city in ('Toronto', 'London', 'Oxford')
order by department_id asc;


-- 9. jobs�� job_id=IT_PROG�� ������ ����, title�� Solution Programmer, maxSal�� 50000���� ������Ʈ
update jobs
set job_title='Solution Programmer', max_salary=50000
where job_id='IT_PROG';


-- 10. countries�� ���ѹα� ���� �߰�, id�� KR, name�� Korea, ������ 3
insert into countries
values ('KR', 'Korea', 3);

