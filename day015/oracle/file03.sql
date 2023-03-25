-- 03
-- 07�� ���� (p.17~)

-- Non-Equi join: = �̿��� �����ڸ� �̿��� ����
-- �̸� ���� ���̺� �ϳ� ������~
create table salgrade(grade char(1) primary key, minsal number, maxsal number);
insert into salgrade values('A', 0, 5000);
insert into salgrade values('B', 5001, 15000);
insert into salgrade values('C', 15001, 20000);
insert into salgrade values('D', 20001, 30000);
commit;
select * from salgrade;

-- ���� �̸�, �޿�, �޿��� ��� ���
select first_name, salary, grade
from employees join salgrade
on salary between minsal and maxsal;

select e.first_name, e.salary, s.grade
from employees e, salgrade s
where e.salary between s.minsal and s.maxsal;

-- self join
select * from employees;
-- 101�� ������ �Ŵ����� �̸��� �˰�ʹ�!
-- 106���� ����� ����! (�Ŵ����� ���� �� ���� �־�)
select ����.employee_id ����, ����.first_name, �Ŵ���.employee_id �Ŵ���, �Ŵ���.first_name
from employees ����, employees �Ŵ���
where ����.manager_id=�Ŵ���.employee_id
order by 1;
select ����.employee_id ����, ����.first_name, �Ŵ���.employee_id �Ŵ���, �Ŵ���.first_name
from employees ����
join employees �Ŵ���
on ����.manager_id=�Ŵ���.employee_id
order by 1;
-- �Ŵ����� ���� ������ �������� ���ھ�!
select ����.employee_id ����, ����.first_name, �Ŵ���.employee_id �Ŵ���, �Ŵ���.first_name
from employees ����, employees �Ŵ���
where ����.manager_id=�Ŵ���.employee_id(+) -- oracle ������..
order by 1;
select ����.employee_id ����, ����.first_name, �Ŵ���.employee_id �Ŵ���, �Ŵ���.first_name
from employees ����
left outer join employees �Ŵ���
on ����.manager_id=�Ŵ���.employee_id
order by 1;

-- p.23 �Ŵ����� king�� ����� �̸��� ����
select emp.employee_id, emp.first_name, emp.last_name, jobs.job_title
from employees emp, employees m , jobs
where emp.manager_id=m.employee_id
and emp.job_id=jobs.job_id
and m.last_name='King'
order by emp.employee_id;
-- self join�� ������� �ʰ� ���� ������ ����ϸ� �ȵ�?
select employee_id, first_name 
from employees
where manager_id=(select employee_id
                  from employees
                  where first_name='Steven' and last_name='King');

-- p.23 steven king�� ������ �μ����� �ٹ��ϴ� ����� �̸� ���
-- self join
select emp.employee_id, emp.first_name, emp.last_name
from employees king
join employees emp on king.department_id=emp.department_id
where king.first_name='Steven' and king.last_name='King';

select emp.employee_id, emp.first_name, emp.last_name
from employees king, employees emp
where king.department_id=emp.department_id
and king.first_name='Steven' and king.last_name='King';
-- sub query
select employee_id, first_name, last_name
from employees
where department_id=(select department_id
                     from employees
                     where first_name='Steven' and last_name='King');
                     
-- outer join
-- �μ� ���� ���, manager_id�� �μ����� �ǹ�, �μ����� ���� �� �� ��
-- �μ��� ������ ���� -> �μ� ����ŭ ����� ���;� ��
-- ��� �׳� join�̱� ������ �μ����� ���� �μ��� ��µ��� ����
select departments.*, first_name, salary, hire_date
from employees
join departments on employees.employee_id=departments.manager_id;
-- �μ����� ���� �μ��� ����ϰ� ������? -> outer join ���
-- ANSI ǥ��
select departments.*, first_name, salary, hire_date
from employees
right outer join departments on employees.employee_id=departments.manager_id;
-- oracle sql
select departments.*, first_name, salary, hire_date
from employees, departments
where employees.employee_id(+)=departments.manager_id;

-- �μ��� ���� ����, ������ ���� �μ��� ��� ����ʹ� -> full outer join ���!
select first_name, salary, department_name
from employees
full outer join departments using(department_id);
