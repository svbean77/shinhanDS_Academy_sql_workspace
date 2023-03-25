-- 01 ����: ����

-- subquery�� where ������ ��� ����
-- ���� ���� ��� �� �����ڷ� =, <>, >. >=, <, <= ���
-- ���� ���� ��� in, >any, <all, exists ��� ����
-- from ������ ���Ǵ� subquery: inline view
-- ����� subquery: from�� ������ ���̺��� subquery������ �ٽ� ��� -> inline view�� �̿��ϸ� �� �� ���� (�츮ppt p.67)
-- top-n query: ���� n�Ǹ� ��ȸ

-- 1. 'IT'�μ����� �ٹ��ϴ� �������� �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
select first_name, salary, hire_date
from employees
where department_id=(
    select department_id
    from departments
    where department_name='IT');
    
-- join���� �ذ�!
-- using�� ����ϸ� �� key�� ���̺�.Į������ �ۼ��� �� ����! departments.department_id ��� �Ұ�!
select first_name, salary, hire_date
from employees join departments using(department_id)
where department_name='IT';
    
-- 2��
-- 'Alexander' �� ���� �μ����� �ٹ��ϴ� ������ �̸��� �μ�id�� ��ȸ�Ͻÿ�.
select first_name, department_id
from employees
where department_id in(
    select department_id
    from employees
    where first_name = 'Alexander');
?
select first_name, department_id
from employees
where department_id = any(
    select department_id
    from employees
    where first_name = 'Alexander');
    
-- 3��
-- 80���μ��� ��ձ޿����� ���� �޿��� �޴� ������ �̸�, �μ�id, �޿��� ��ȸ�Ͻÿ�. 
select first_name, department_id, salary
from employees
where salary > (
    select avg(salary)
    from employees
    where department_id = 80);

-- ++ �������� �߰�: ��� �޿��� �����
-- select ������ subquery�� ����Ѵ� = ��Į�� subquery
select first_name, department_id, salary, (select avg(salary)
                                           from employees
                                           where department_id = 80)
from employees
where salary > (
    select avg(salary)
    from employees
    where department_id = 80);
-- inline view: from ������ �������� ���: ������ ���� �� �ٸ� ��� ���忡�� ��� ����! (from�� �ؼ� 1���̴ϱ�)
select first_name, department_id, salary, dept80.sal80
from employees, (select avg(salary) sal80
                from employees
                where department_id = 80) dept80
where salary > dept80.sal80;

?
-- 4��
-- 'South San Francisco'�� �ٹ��ϴ� ������ �ּұ޿����� �޿��� ���� �����鼭 
-- 50 ���μ��� ��ձ޿����� ���� �޿��� �޴� ������ �̸�, �޿�, �μ���, �μ�id�� ��ȸ�Ͻÿ�.
-- ���� ��ü�� �μ����� null�� ����� ���;� �ϱ� ������ �ܺ� ������ �����!!!!!!!!
select first_name, salary, department_name, department_id
from employees left outer join departments using(department_id)
where salary > (
    select min(salary)
    from employees join departments using(department_id)
    join locations using(location_id)
    where city = 'South San Francisco')
and salary > (
    select avg(salary)
    from employees
    where department_id = 50);
-- �� �ٸ� ����� Ǯ��: salary > all�� �� �� subquery 2���� �����ش�.
-- ��ȣ�� ���� �������� ���� �� ��� ����
select first_name, salary, department_name, department_id
from employees left outer join departments using(department_id)
where salary > all (
    (select min(salary)
    from employees join departments using(department_id)
    join locations using(location_id)
    where city = 'South San Francisco'),
    (select avg(salary)
    from employees
    where department_id = 50)
);?

-- LAB5
-- 1��
-- ������ �̸��� ������ �̸��� ��ȸ�Ͻÿ�.
select ����.first_name, �Ŵ���.first_name
from employees ����, employees �Ŵ���
where ����.manager_id = �Ŵ���.employee_id;

-- 2��
-- ������ �̸��� ������ �̸��� ��ȸ�Ͻÿ�.�����ڰ� ���� ���������� ��� ����Ͻÿ�.
select ����.employee_id, ����.first_name, �Ŵ���.employee_id, �Ŵ���.first_name
from employees ����, employees �Ŵ���
where ����.manager_id = �Ŵ���.employee_id(+);

select ����.first_name, �Ŵ���.first_name
from employees ���� left outer join employees �Ŵ��� on ����.manager_id = �Ŵ���.employee_id;
?
-- 3��
-- ������ �̸��� �����ڰ� �����ϴ� ������ ���� ��ȸ�Ͻÿ�. ��, ������������ 3�� �̻��� �����ڸ� ��µǵ��� �Ͻÿ�.
select �Ŵ���.employee_id, �Ŵ���.first_name, count(*)
from employees ����, employees �Ŵ���
where ����.manager_id = �Ŵ���.employee_id
-- ���������� ���� �� �ֱ� ������ ���� ��ȣ�� �Բ� �׷�ȭ
-- �ٵ� ������ join���� ���̵� ������ ������ �� ���� �� ���� �ѵ� �׷��� Ȯ���� �ϱ� ���� ���� ��ȣ�� �׷�ȭ
group by �Ŵ���.employee_id, �Ŵ���.first_name
having count(*)>=3
order by 1;
?
-- LAB6
--  1��
-- �������� �̸�, �Ի���, �μ����� ��ȸ�Ͻÿ�. ��, �μ��� ���� ������ �ִٸ� �� ���������� ��°���� ���Խ�Ų��.
-- �׸��� �μ��� ���� ������ ���ؼ��� '<�μ�����>' �� ��µǵ��� �Ѵ�.(outer-join , nvl() )
select first_name, hire_date, nvl(department_name, '<�μ�����>') �μ���, 
nvl(to_char(department_id), '<�μ�����>') �μ���ȣ1, nvl2(department_id, to_char(department_id), '<�μ�����>') �μ���ȣ2
from employees left join departments using(department_id);
?
-- 2��
-- ������ ��å�� ���� ������ �ٸ��� �����Ϸ��� �Ѵ�.��å�� 'Manager'�� ���Ե� ������ �޿��� 0.5�� ���ϰ�
-- ������ �����鿡 ���ؼ��� ������ �޿��� �����ϵ��� �Ѵ�. �����ϰ� ��ȸ�Ͻÿ�. (decode)
select first_name, job_title, salary, decode(substr(job_title,-7), 'Manager', salary*0.5, salary)salary2
from employees join jobs using(job_id);
-- case�ε� Ǯ���
select first_name, job_title, salary �����޿�,
    case when job_title like '%Manager' then salary*0.5 else salary  end �ٲ�޿�
from employees join jobs using(job_id);


-- ���� �谨 ��ȸ�� �ƴϰ� �����̾��ٸ�?! 
-- ���̺� �����ؼ� �����غ���
create table empBackup
as
select * from employees;

select first_name, job_title, salary from empBackup join jobs using (job_id);
update empBackup
set salary = salary * 0.5
where employee_id in (
    select employee_id
    from empBackup join jobs using(job_id)
    where substr(job_title, -7) = 'Manager');
?
-- 3��
-- �� �μ����� �����޿��� �޴� ������ �̸��� �μ�id, �޿��� ��ȸ�Ͻÿ�.
select first_name, department_id, salary
from employees
where (department_id, salary) in ( 
select department_id, min(salary)
from employees
group by department_id);

-- ����� Ǯ������ Ȯ��!
select * from employees where department_id=100 and salary=6900;
select * from employees where department_id=90 and salary=17000;
?
-- 4��
-- �� ���޺�(job_title) �ο����� ��ȸ�ϵ� ������ ���� ������ �ִٸ� �ش� ���޵� ��°���� ���Խ�Ű�ÿ�. 
-- �׸��� ���޺� �ο����� 3�� �̻��� ���޸� ��°���� ���Խ�Ű�ÿ�.
select job_title, count(*)�ο���
from employees right outer join jobs using(job_id) -- �ܺ� ������ ����ϸ� null�� ����
group by job_title
having count(*) >= 3;
?
?
-- 5��
-- �� �μ��� �ִ�޿��� �޴� ������ �̸�, �μ���, �޿��� ��ȸ�Ͻÿ�.
select first_name, department_name, salary
from employees join departments using(department_id)
where (department_id, salary) in ( 
    select department_id, max(salary)
    from employees
    group by department_id);
-- �´��� Ȯ������!
select count(distinct department_id) from employees;
-- inline view�� Ǯ���!
select first_name, department_name, salary
from employees, departments, (select department_id, max(salary) maxSal
                              from employees
                              group by department_id) deptsalMax
where employees.department_id=departments.department_id
and employees.department_id=deptsalMax.department_id
and employees.salary=deptsalMax.maxSal;
?
-- 6��
-- ������ �̸�, �μ�id, �޿��� ��ȸ�Ͻÿ�. �׸��� ������ ���� �ش� �μ��� �ּұ޿��� �������� ���Խ��� ��� �Ͻÿ�.
-- ������ Ǯ�� 1: ��Į�� ��������
-- ��(mainEmp)�� ��(��������)�� �����ִ� = ����� ���� ����
select first_name, department_id, salary, (select min(salary)
                                           from employees
                                           where department_id=mainEmp.department_id) �μ��ּұ޿�
from employees mainEmp;
-- ������ Ǯ�� 2: �ζ��κ�
select first_name, department_id, salary, minSal
from employees join (select department_id, min(salary) minSal
                     from employees
                     group by department_id) deptminsal
               using (department_id);
                 



-- �ٸ� �л� Ǯ��
select first_name, department_id, salary, (
select min(salary) from employees emp2
where emp2.department_id = emp1.department_id) �ּұ޿�
from employees emp1;

-- �� Ǯ��
select first_name, employees.department_id, salary, minSal
from employees, (
    select department_id, min(salary) minSal
    from employees
    group by department_id) dept
where employees.department_id=dept.department_id;

-- 6�� 4�� LAB7
-- 1. �޿��� ���� ���� �޴� ���� 5���� ���� ������ ��ȸ�Ͻÿ�.
-- pseudo Į��(���� Į���� �ƴѵ� Į���� �� ó�� �ൿ�ϴ� ��ü)
-- top-n�� ������� �ʴ´ٸ�?! 1. �������� ���� 2. �װ��� select�� rownum ���� 3. where������ ����ϵ��� �ٽ� select
select rownum, sorted.*
from (select first_name, salary
      from employees
    order by salary desc) sorted
where rownum <= 5; -- 1�� ���Ե��� ���� ��쿡�� �ƹ� ����� ������ ����
-- ���߿� ������������ ����¡ ó���� �� �� �̷� ����� ����ؾ� ��!
select *
from (select rownum rr, sorted.*
      from (select first_name, salary
            from employees
            order by salary desc) sorted
      )
where rr=5; -- 1�� ���Ե��� ���� ��� �ٽ� select�� ������� ��
-- mysql������ ���� �����ѵ�: limit
select first_name, salary
from employees
order by salary desc limit 5;



-- 2. Ŀ�̼��� ���� ���� �޴� ���� 3���� ���� ������ ��ȸ�Ͻÿ�.
select * 
from (select *
      from employees
      order by commission_pct desc nulls last, salary desc)
where rownum <= 3;
-- 3��° ��� ������� ������ �ٲ㺻�ٸ�?!
select *
from (select rownum rr, sorted.* 
      from (select *
            from employees
            order by commission_pct desc nulls last, salary desc) sorted
     )
where rr=3;     

-- 3. ���� �Ի��� ���� ��ȸ�ϵ�, �Ի��� ���� 5�� �̻��� ���� ����Ͻÿ�.
select to_char(hire_date, 'mm') ��, count(*) "���� �Ի���"
from employees
group by to_char(hire_date, 'mm')
having count(*) >= 5
order by ��;

-- 4. �⵵�� �Ի��� ���� ��ȸ�Ͻÿ�. 
-- ��, �Ի��ڼ��� ���� �⵵���� ��µǵ��� �մϴ�.
select to_char(hire_date, 'yyyy') ��, count (*) "�Ի��� ��"
from employees
group by to_char(hire_date, 'yyyy')
order by 2 desc;

