-- 07
-- ���� �� �ߺ� �Ұ���� ���� ���� ���� ���̺� ����
create table JJ (id number primary key, name varchar2(20));
insert into JJ values(1, 'AA');
insert into JJ values(2, 'BB');

select * from JJ;

update JJ set id=100 where id=1;

-- ch.07 ����
-- 100�� ������ �μ����� �˰�ʹ�!!!!!!!!!
-- SQL�� �������� ����̱� ������ ���� �� ���� �����ϰ� �Ǿ����.. �� �������� ����� �;�!! = join
select *
from employees
where employee_id=100;
select *
from departments
where department_id=90;

-- employees ī��θ�Ƽ x departments ī��θ�Ƽ (=īƼ�� ���δ�Ʈ)
select *
from employees, departments;

-- employees ���̺��� departments ���̺��� ���� (null�� ������ ����) -> 106��
-- where������ key�� ������ Ȯ���ϴ� ���� vendor ���� -> ǥ�� sql ������ ����ϴ� ���� ����!
select employee_id, first_name, department_name
from employees, departments
where employees.department_id = departments.department_id -- �ߺ��Ǵ� �Ӽ� �̸��� �ִٸ� ���̺�� �ۼ�
order by 1;

-- �̰� ǥ�� ����!
select employee_id, first_name, department_id, department_name
from employees
join departments
using (department_id);
-- join�ϰ����ϴ� Į������ ��ġ���� �ʴ� ���
select employee_id, first_name, departments.department_id, department_name
from employees
join departments
on employees.department_id=departments.department_id;
-- ���� ���� ��� (����=employees�� ���� null�� ��쵵 ����)
select employee_id, first_name, departments.department_id, department_name
from employees
left outer join departments
on employees.department_id=departments.department_id;

-- job_id�� ���� ������ � �������� �˰�ʹ�! �ִ�, �ּ� ������ ������.
-- PK(Primary Key)�� Ư¡: null �Ұ�, unique��
-- FK(Foreign Key=����Ű)�� Ư¡: �ٸ�or�ڽ� ���̺��� PK ����
-- ���1: vendor ����
-- �Ӽ��� �� ���̺��� �����ϴ� ��� ��ġ�� ���� �ʾƵ� ������ (employees.Xxx) ã�� �ӵ��� ������ �ϱ� ���� ���ִ� ���� ����
select employees.first_name, employees.salary, jobs.job_id, job_title
from employees, jobs
where employees.job_id=jobs.job_id;
-- ���2: ANSI ���� (using)
select employees.first_name, employees.salary, job_id, job_title
from employees
join jobs using(job_id);
-- ���3: ANSI ���� (on)
select employees.first_name, employees.salary, employees.job_id, job_title
from employees
join jobs on employees.job_id=jobs.job_id;

-- ���̺� ���� ���� ���
select emp.first_name, emp.salary, j.*
from employees emp join jobs j on (emp.job_id = j.job_id)
where emp.job_id='IT_PROG';

-- seattle�� �μ��� �ִ� ��� ��ȸ (�� Ǯ��)
select first_name, salary
from employees
where department_id in (select department_id from departments join locations using (location_id) where city = 'Seattle')
order by first_name;
-- seattle�� �μ��� �ִ� ��� ��ȸ (������ Ǯ�� 1. vendor ���� ���)
select first_name, salary, employees.department_id, department_name
from employees, departments, locations
where employees.department_id=departments.department_id
and departments.location_id=locations.location_id
and city='Seattle'
order by 1;
-- seattle�� �μ��� �ִ� ��� ��ȸ (������ Ǯ�� 2. ANSI ǥ�� ���� ��� (using))
select first_name, salary, department_id, department_name
from employees join departments using(department_id)
join locations using (location_id)
where city='Seattle'
order by 1;
-- seattle�� �μ��� �ִ� ��� ��ȸ (������ Ǯ�� 2. ANSI ǥ�� ���� ��� (on))
select first_name, salary, employees.department_id, department_name
from employees join departments on(employees.department_id=departments.department_id)
join locations on (departments.location_id=locations.location_id)
where city='Seattle'
order by 1;

-- accounting �μ� �Ҽ� ����� �̸�, �Ի��� ���
select first_name, hire_date, department_name
from employees join departments using (department_id)
where department_name='Accounting';