-- 06
-- 7. �� �μ��� �ο����� ��ȸ�ϵ� �ο����� 5�� �̻��� �μ��� ��µǵ��� �Ͻÿ�.
select department_id, count(*) �ο���
from employees
group by department_id
having count(*) >= 5;





-- 8. �� �μ��� �ִ�޿��� �ּұ޿��� ��ȸ�Ͻÿ�.
--    ��, �ִ�޿��� �ּұ޿��� ���� �μ��� ������ �Ѹ��� ���ɼ��� ���⶧���� 
--    ��ȸ������� ���ܽ�Ų��.
select department_id, max(salary), min(salary)
from employees
group by department_id
having max(salary) != min(salary);



   
-- 9. �μ��� 50, 80, 110 ���� ������ �߿��� �޿��� 5000 �̻� 24000 ���ϸ� �޴�
--    �������� ������� �μ��� ��� �޿��� ��ȸ�Ͻÿ�.
--    ��, ��ձ޿��� 8000 �̻��� �μ��� ��µǾ�� �ϸ�, ��°���� ��ձ޿��� ����
--    �μ����� ��µǵ��� �ؾ� �Ѵ�.
select department_id, avg(salary) ��ձ޿�
from employees
where department_id in(50, 80, 110) and salary between 5000 and 24000
group by department_id
having avg(salary) >= 8000
order by ��ձ޿� desc; -- select�� ���ķ� ������ �ϱ� ������ �ٽ� ����ϴ� �ͺ��ٴ� �������� �����ϵ��� �ϴ� ���� ���� (�� �� ���� ��)
