-- 10
-- 6�� 3�� LAB6
-- sub query
-- 1. �������� �̸�, �Ի���, �μ����� ��ȸ�Ͻÿ�.
-- ��, �μ��� ���� ������ �ִٸ� �� ���������� ��°���� ���Խ�Ų��.
-- �׸��� �μ��� ���� ������ ���ؼ��� '<�μ�����>' �� ��µǵ��� �Ѵ�.
-- (outer-join , nvl() )
select first_name, hire_date, nvl(department_name, '<�μ�����>') �μ���
from employees left outer join departments using (department_id);





-- 2. ������ ��å�� ���� ������ �ٸ��� �����Ϸ��� �Ѵ�.
-- ��å�� 'Manager'�� ���Ե� ������ �޿��� 0.5�� ���ϰ�
-- ������ �����鿡 ���ؼ��� ������ �޿��� �����ϵ��� �Ѵ�. 
-- �����ϰ� ��ȸ�Ͻÿ�. (decode)
select first_name, job_title, salary �����޿�, decode(substr(job_title, -7), 'Manager', salary*0.5, salary) �ٲ�޿�
from employees join jobs using(job_id);




-- 3. �� �μ����� �����޿��� �޴� ������ �̸��� �μ�id, �޿��� ��ȸ�Ͻÿ�.
select first_name, department_id, salary
from employees
where (department_id, salary) in (
    select department_id, min(salary)
    from employees
    group by department_id)
order by department_id;


-- 4. �� ���޺�(job_title) �ο����� ��ȸ�ϵ� ������ ���� ������ �ִٸ� �ش� ���޵�
-- ��°���� ���Խ�Ű�ÿ�. �׸��� ���޺� �ο����� 3�� �̻��� ���޸� ��°���� ���Խ�Ű�ÿ�.
select count(*)
from employees ;





-- 5. �� �μ��� �ִ�޿��� �޴� ������ �̸�, �μ���, �޿��� ��ȸ�Ͻÿ�.







-- 6. ������ �̸�, �μ�id, �޿��� ��ȸ�Ͻÿ�. �׸��� ������ ���� �ش� �μ��� 
-- �ּұ޿��� �������� ���Խ��� ��� �Ͻÿ�.

			

