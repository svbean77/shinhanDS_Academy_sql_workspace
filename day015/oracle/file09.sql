-- 09
-- 6�� 2�� LAB5
-- self join
-- 1. ������ �̸��� ������ �̸��� ��ȸ�Ͻÿ�.
select emp.first_name �����̸�, m.first_name �������̸�
from employees emp 
join employees m on emp.manager_id=m.employee_id;



-- 2. ������ �̸��� ������ �̸��� ��ȸ�Ͻÿ�.
-- �����ڰ� ���� ���������� ��� ����Ͻÿ�.
select emp.first_name �����̸�, m.first_name �������̸�
from employees emp 
left outer join employees m on emp.manager_id=m.employee_id;



-- 3. ������ �̸��� �����ڰ� �����ϴ� ������ ���� ��ȸ�Ͻÿ�.
-- ��, ������������ 3�� �̻��� �����ڸ� ��µǵ��� �Ͻÿ�.
select m.first_name �����ڸ�, count(*) ����������
from employees emp
join employees m on emp.manager_id=m.employee_id 
group by m.first_name
having count(*) >= 3;

