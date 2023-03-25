-- 02
-- 5�� �ֿ��Լ� p.41
-- ppt p.44: ������� ��������� �ٹ� �ϼ� ���
-- ��¥ �Լ�
select  sysdate, hire_date, floor((sysdate-hire_date)/365) "�ٹ����(��ȮX)", add_months(sysdate, 10) "10���� ��",
floor(MONTHS_BETWEEN(SYSDATE,hire_date)/12) "�ٹ����(��ȮO)", first_name, salary, add_months(hire_date, 4) "�Ի� 4���� ��",
last_day(hire_date) "������ ��", NEXT_DAY(hire_date, '������')
from employees; 

-- ��¥ �ݿø� ROUND, ���� TRUNC
select hire_date, round(hire_date, 'month') "�ݿø�(ROUND)", trunc(hire_date, 'month') "����(TRUNC)"
from employees;

-- �� ��ȯ �Լ�
-- to_char (��¥ -> ����)
select sysdate, to_char(sysdate, 'yyyy/mm/dd'), to_char(sysdate, 'hh:mi:ss'), to_char(sysdate, 'DAY DY MON AM/PM')
from dual;

-- to_char (���� -> ����)
select to_char(10000000, 'L999,999,999')
from dual;

-- to_date (���� -> ��¥)
select to_date(20000101, 'yyyymmdd') YYYYMMDD, to_date(220101, 'yymmdd') as "YYMMDD"
from dual;

select first_name, hire_date
from employees
where hire_date = to_date('030617', 'rrmmdd');

select first_name, hire_date
from employees
where hire_date='030617'; -- rr �������� ���� �ʴ� �͵� �����ϳ�

select first_name, hire_date
from employees
where hire_date='03/06/17'; -- rr �������� ���� (rr ����: 50 �̻��̸� 19Xx, �̸��̸� 20Xx��)

select first_name, hire_date
from employees
where hire_date='20030617'; -- ������ ������ ���� �͵� ������!
-- nls_date_format ������ �ٲ� �� ����. alter session set nls_date_format='';
-- ���� ���ڿ��� ���� �ͺ��ٴ� ���� ������ to_date�� ���ߴ� ���� ����

-- ���ĵ��� �� �� ����
select * from v$nls_parameters;

-- nvl: null�� �ٸ� ������
select first_name, hire_date, commission_pct, nvl(commission_pct, 0), salary, salary+salary*nvl(commission_pct, 0) �Ǽ��ɾ�
from employees
order by commission_pct nulls first;

-- �߰�) null�̸� ���, not null�̸� ��� �ϰ� �ʹ�! -> nlv2 (��, not null, null)
select salary, salary+salary*nvl2(commission_pct, commission_pct, 0) �Ǽ��ɾ�, 
nvl2(commission_pct, '�ִ�', '����'), commission_pct
from employees
order by commission_pct;

-- ppt p.71manager�� null�� ����� CEO�� ���
-- �ϳ��� Ÿ���� �� ���� ����� �� ���� (id�� ����, ceo�� ����) -> Ÿ���� �ϳ��� ���Ͻ��Ѿ� ��
select employee_id, first_name, manager_id, nvl(to_char(manager_id), 'CEO')
from employees;
select employee_id, first_name, manager_id, nvl2(manager_id, to_char(manager_id), 'CEO')
from employees;

select first_name, department_id, nvl(to_char(department_id), '�μ� ����')
from employees;

-- DECODE
select department_id, decode(department_id, 10, 'A', 60, 'B', 90, 'C', 'D') �μ�
from employees;

-- CASE
select salary, case 
when salary>=10000 then '�ſ츹��'
when salary>=7000 then '����'
when salary>=5000 then '����'
else '����'
end "case ���"
from employees;

select first_name, case when first_name like 'A%' then 'A�� ����' else 'A�� �ƴ�' end "���ڿ��� ��"
from employees;

select first_name, case when first_name like '%a' then 'a�� ��' else '�ƴϾ�' end "���ڿ�2"
from employees;