-- 04
-- 08��. ���� ����

-- Neena�� ���� ������ ���� ��� ��� (Nenna�� �� �� �����ϱ� ������ = �񱳿����� ����!)
-- ���������� ����� ����������, ���������� ����! (�� �����ڰ� �޶�����)
select *
from employees
where job_id = (select job_id
                from employees
                where first_name='Neena');
                
-- ������ ������
select *
from employees
where job_id in (select job_id
                from employees
                where first_name='David');
                
select *
from employees
where job_id = Any(select job_id
                   from employees
                   where first_name='Alexander');
                
-- p.7 Neena�� �޿��� �����ϰų� �� ���� �޴� ����� �̸��� �޿�
select first_name, salary
from employees
where salary >= (select salary
                 from employees
                 where first_name='Neena');
                 
-- ���� ������ ����� �������ε� �� ���θ� ������Ű�� �ʹٸ� 
-- sub query�� ����� 1���̸� ������ ������ ���: =, >, >, <>
-- sub query�� ����� 1�� �̻��̸� ������ ������ ���: in, >=all, <any
select first_name, salary
from employees
where salary >= All(select salary
                    from employees
                    where first_name='Alexander');
                    
-- p.7 Seattle���� �ٹ��ϴ� ����� �̸��� �μ� ��ȣ
-- ������ Ǯ�� - sub query ���
select first_name, department_id
from employees
where department_id=any(
    select department_id
    from departments
    where location_id=(
        select location_id
        from locations
        where city='Seattle'));
-- ������ Ǯ�� - join �̿��� Ǯ��
select first_name, last_name, salary, department_id
from employees join departments using(department_id)
               join locations using(location_id)
where city='Seattle';

-- p.8 IT �μ����� �ٹ��ϴ� ����� �̸��� �޿�
select first_name, salary
from employees
where department_id=(
    select department_id
    from departments
    where department_name='IT');

select first_name, salary
from employees join departments using(department_id)
where department_name='IT';

-- p. 8 ���ӻ���� Steven king�� ����� �̸��� �޿�
select first_name, salary
from employees
where manager_id =(
    select employee_id
    from employees
    where first_name='Steven' and last_name=initCap('KING'));
    
select first_name, salary
from employees
where manager_id = any(
    select employee_id
    from employees
    where last_name=initCap('KING'));
    
-- ��� �޿����� ���� �޿��� �޴� ��� �˻�
select *
from employees
where salary >= (
    select avg(salary)
    from employees);

-- ����Į�� ��������
-- p.12 �μ����� ���� ���� �޿��� �޴� ����� ���� (in ������ �̿�)
select *
from employees
where (department_id, salary) in (
    select department_id, max(salary)
    from employees
    group by department_id);

-- p. 12 ������ manager�� ����� ���� �μ��� �μ� ��ȣ, �μ���, ����
select first_name, department_id, department_name, city
from employees join departments using(department_id)
join locations using(location_id)
where job_id in (
    select job_id
    from jobs
    where substr(job_title, -7)=initCap('MANAGER'));
    
