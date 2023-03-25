-- 08 ch03_02_LAB3
-- 1.�������� �̸��� ���޸�(job_title)�� ��ȸ�Ͻÿ�.
select first_name, job_title
from employees join jobs using (job_id);


-- 2.�μ��̸��� �μ��� ���� ���ø�(city)�� ��ȸ�Ͻÿ�.
select department_name, city
from departments join locations using (location_id);


-- 3. ������ �̸��� �ٹ��������� ��ȸ�Ͻÿ�. (employees, departments, locations,countries)
select first_name, country_name
from employees join departments using (department_id)
join locations using (location_id)
join countries using (country_id);


-- 4. ��å(job_title)�� 'manager' �� ����� �̸�, ��å, �μ����� ��ȸ�Ͻÿ�.
select first_name, job_title, department_name
from jobs join employees using (job_id)
join departments using (department_id)
where job_title like initCap('%manager');


-- 5. �������� �̸�, �Ի���, �μ����� ��ȸ�Ͻÿ�.
select first_name, hire_date, department_name
from employees join departments using(department_id);


-- 6. �������� �̸�, �Ի���, �μ����� ��ȸ�Ͻÿ�.
-- ��, �μ��� ���� ������ �ִٸ� �� ���������� ��°���� ���Խ�Ų��.
select first_name, hire_date, department_name
from employees left outer join departments using (department_id);


-- 7. ������ �̸��� ��å(job_title)�� ����Ͻÿ�.
-- ��, ������ �ʴ� ��å�� �ִٸ� �� ��å������ ��°���� ���Խ�Ű�ÿ�.
select first_name, job_title
from employees right outer join jobs using (job_id);
