-- 05
-- ch.06 �׷� �Լ�
-- group by ���� ������� ������ ��ü�� ���� ����
-- �����Լ��� null�� �����ϰ� ��� (�Ϲ� ������ ���� ����� null)
select sum(salary), sum(commission_pct), avg(salary), sum(salary)/count(salary)
from employees;
-- null�� ������ ������� ����
select count(salary), count(commission_pct) null����, count(*) ��ü�Ǽ�, count(manager_id)
from employees;

-- ppt 6�� p.9: ���� �ֱ� �Ի�, ���� �� �Ի� 
-- ��¥�� ������ ����� ������ �۱� ������ min, ������ ������ ũ�� ������ max
select min(hire_date) �����ƾ�, max(hire_date) �����̳�
from employees;

-- ppt 6�� p.12 80�� �μ� �� Ŀ�̼� �޴� ����� ��
-- ���1
select count(commission_pct) "Ŀ�̼� �޴� �����", count(*) "80�� �μ� �����"
from employees
where department_id=80;
-- ���2
select count(*) "Ŀ�̼� �޴� �����"
from employees
where department_id=80
and commission_pct is not null;

-- �ߺ� ������ count ����
select count(distinct job_id) as ������, count(distinct department_id) as "�μ���"
from employees;
-- �� ���� ���� ����� ����!
select distinct department_id
from employees
where department_id is not null;

-- group by: �μ��� ���� ���
-- �μ��� null�� ����� ������ salary�� null�� ����� ���� ������ ��� ������ �� ������ ��!
select department_id, avg(salary) "�μ��� ���� ���"
from employees
group by department_id
order by department_id;
-- where ������ ���� null ����
-- select ���� �����Լ��� ������� �ʴ� Į���� �ִٸ� �ݵ�� group by ���� �����ؾ� ��!
select department_id, avg(salary) "�μ��� ���� ���", max(job_id) -- , job_id -- ���� �߻�!
from employees
where department_id is not null
group by department_id
order by department_id;

select department_id, job_id , avg(salary) "�μ��� ���� ���"
from employees
where department_id is not null
group by department_id, job_id
order by department_id;

-- having: ���� �Լ��� ���� �׷� ���� ���͸�
select department_id, job_id , avg(salary) "�μ��� ���� ���"
from employees
where department_id is not null
group by department_id, job_id having(avg(salary) >= 10000)
order by department_id;

-- ���ݱ����� �ۼ� ������ �ؼ� ����!!
select department_id, avg(salary) "��� ����" -- 5
from employees -- 1
where department_id is not null -- 2
group by department_id -- 3
having avg(salary)>=10000 -- 4
order by department_id; -- 6

-- p.22 �ְ� ������ �� �̻��� �μ��� �ְ�, ���� ���� ���
select department_id, max(salary) "�ִ� �޿�", min(salary) "���� �޿�"
from employees
group by department_id;
