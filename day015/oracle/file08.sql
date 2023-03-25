-- 08
-- 3�� 3�� LAB4
-- subquery
-- 1. 'IT'�μ����� �ٹ��ϴ� �������� �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
select first_name, salary, hire_date
from employees
where department_id = (
    select department_id
    from departments
    where department_name='IT');
    

-- 2. 'Alexander' �� ���� �μ����� �ٹ��ϴ� ������ �̸��� �μ�id�� ��ȸ�Ͻÿ�.
select first_name, department_id
from employees
where department_id in (
    select department_id
    from employees
    where first_name='Alexander');
    


-- 3. 80���μ��� ��ձ޿����� ���� �޿��� �޴� ������ �̸�, �μ�id, �޿��� ��ȸ�Ͻÿ�.
select first_name, department_id, salary
from employees
where salary >= (
    select avg(salary)
    from employees
    where department_id=80
    group by department_id);
    


-- 4. 'South San Francisco'�� �ٹ��ϴ� ������ �ּұ޿����� �޿��� ���� �����鼭 
-- 50 ���μ��� ��ձ޿����� ���� �޿��� �޴� ������ �̸�, �޿�, �μ���, 
-- �μ�id�� ��ȸ�Ͻÿ�.
select first_name, salary, department_name, department_id
from employees join departments using (department_id)
where salary > (
    select avg(salary)
    from employees
    where department_id=50)
and salary > (
    select min(salary)
    from employees join departments using (department_id)
    join locations using (location_id)
    where city='South San Francisco');
    
    
