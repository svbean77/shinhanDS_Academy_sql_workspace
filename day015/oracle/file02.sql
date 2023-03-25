-- 02 ����(3�� 2�� LAB3) 4�� �ٸ� Ǯ��, 7�� Ȯ��

-- 4. ��å(job_title)�� 'manager' �� ����� �̸�, ��å, �μ����� ��ȸ�Ͻÿ�.
-- �� Ǯ��: like ���
select first_name, job_title, department_name
from jobs join employees using (job_id)
join departments using (department_id)
where job_title like initCap('%manager');

-- �ٸ� Ǯ��: substr ���
select first_name, job_title, department_name
from jobs join employees using (job_id)
join departments using (department_id)
where substr(job_title, -7)=initCap('manager');


-- 7. ������ �̸��� ��å(job_title)�� ����Ͻÿ�.
-- ��, ������ �ʴ� ��å�� �ִٸ� �� ��å������ ��°���� ���Խ�Ű�ÿ�.
select first_name, job_title
from employees right outer join jobs using (job_id);

-- ���� ��� ��å�� ���Ǿ��� Ȯ���ϱ� -> �̷��� ���˵� �� �� �˾ƾ� ��!!!!
select count(distinct job_id) from employees; -- employees���� ����ϴ� job_id ����: 19
select count(*) from jobs; -- jobs�� ��å ����: 19