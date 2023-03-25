-- 01  

-- ��ҹ��� ���� ����
-- ���� �������� �ۼ� ����
-- ������ ���� ;


-- 2�� 
-- ���̺��� ������ ������
desc employees;

-- ��� ���̺��� ������
select * from tab;

-- �ش� ���̺��� ��� Į���� ������
select * from employees;

-- �ش� ���̺��� Ư�� Į���� ������
select employee_id, first_name
from employees;

-- ����, ���ڵ� ������ �� ���� 
-- invalid identifier: �ĺ��� ���� (�ĺ���: Į�� �̸�, ���̺� �̸�) -> ���� ���� �ݵ�� ''�� ��� ��
-- oracle�� ������ ������ �ִ�. (���̺� �̸��� '�빮�ڷ�'�����ص�) -> ""�� ���� ���� ��ҹ��� ����!
-- from�� ���̺��� �ҹ��ڷ� ��µ� ""�� ������ 'table or view does not exist' ���� �߻�
select employee_id, first_name, 1+2, 'SQL����'
from "EMPLOYEES";

-- distinct: �ߺ� ����
select distinct department_id
from EMPLOYEES;

-- �ؼ� ������ from -> select (� ���̺��� ����ϴ����� ���� �ؼ�)
select * from employees; 

-- sql���� ��� ������ ����!
-- ���� ����: null -> null�̸� ��� ����� null -> null�� ��ü�ؾ� ��!
-- Į���� ��Ī�� ������ �� ���� -> Ư������ ���Ե� �ĺ��� �̸��� ""�� ���ξ� ��!
-- ��Ī �� �� as ���� ����
select employee_id as ������ȣ, first_name �̸�, salary, commission_pct, salary+salary*nvl(commission_pct, 0) "Ŀ�̼� ���� �޿�"
from employees;

-- ���� �����ڴ� oracle: ||, concat(2���� ����), mysql: concat
select employee_id as ������ȣ, first_name||' '||last_name �̸�, salary, 
commission_pct, salary+salary*nvl(commission_pct, 0) "Ŀ�̼� ���� �޿�", hire_date
from employees;
select employee_id as ������ȣ, concat(concat(first_name,' '),last_name) �̸�, salary, 
commission_pct, salary+salary*nvl(commission_pct, 0) "Ŀ�̼� ���� �޿�", hire_date
from employees;

-- distinct�� ���� ��: ���� �� ������ �ߺ� ���� (�� ���� ��� ������ ����)
select distinct department_id, job_id
from employees;


-- 3���� �н�~
-- 4��
-- ������
-- �ؼ� ������ from - where - select
select employee_id ������ȣ, first_name||' '||last_name �̸�, salary �޿�
from employees
where salary >= 10000;

-- ������� �������� ���ڴ�: order by
-- from - where - select - order by (������ �ƴ� ����� �ĺ��ڸ� �ٸ� ���� �־��ຸ�� ��!!!!
select employee_id ������ȣ, first_name||' '||last_name �̸�, salary �޿�
from employees
where salary >= 10000
order by �޿� desc;

-- order by ���� Į�� �̸�, ����, select ���� ���� ����! (������ 1���� ����)
select employee_id ������ȣ, first_name||' '||last_name �̸�, salary �޿�
from employees
where salary >= 10000
order by 3 desc;

-- ����HR ���� ��
-- select * from student order by 1; -- �� db���� ������ �ʾұ� ������ ���� �߻�!

-- select Į���̸��� -- �ؼ����� 3
-- from ���̺��̸��� -- �ؼ����� 1
-- where ������ -- �ؼ����� 2
-- order by Į����; -- �ؼ����� 4

-- ��¥�� 19XX���� 20XX���� ��� �˾�?! -> RR����
-- 50�� �������� ������ 20, ũ�� 19 ���� ex) 20 -> 2020��, 61 -> 1961��
select employee_id, first_name, salary, hire_date
from employees
where salary >= 10000
order by hire_date asc;
-- yyyy�� ��Ȯ�ϰ� ����ʹٸ�? -> to_char(Į��, 'yyyy/mm/dd hh:mi:ss')�� ������ �־���
select employee_id, first_name, salary, to_char(hire_date, 'yyyy/mm/dd hh:mi:ss')
from employees
where salary >= 10000
order by hire_date asc;

-- �� ������
select employee_id, first_name, salary, to_char(hire_date, 'yyyy/mm/dd hh:mi:ss') �Ի���, department_id
from employees
where salary >= 10000 and department_id=80
order by hire_date asc;

-- ���� ������ ��ȸ (��ҹ��� ���� ��)
select employee_id, first_name, salary, to_char(hire_date, 'yyyy/mm/dd hh:mi:ss') �Ի���, department_id
from employees
where salary >= 10000 and department_id=80 and first_name='Lisa'
order by hire_date asc;

-- 5��
-- dual table�� oracle���� �����ϴ� dumy table
desc dual;
select * from dual;

-- ���� ����� �ϳ��� row�� ������ �ϱ� ���� ���� ���̺��̴� (�ٸ� ���̺��� �ϸ� ������ ����ŭ ���� ���͹���!)
select 1+2 from employees; -- �ٸ� ���̺�
select 1+2, sysdate from dual; -- dual ���̺� �̿�

-- ���� �Լ�
select 10/3, floor(10/3), floor(10.9) from dual; -- floor: ����
select 10/1, ceil(10/3), floor(10.01) from dual; -- ceil: �ø�
select round(35.67), round(35.67, 1), round(35.67, -1) from dual; -- round: �Ҽ����� ��ġ��ŭ �Ű� �ڿ��� �ݿø� ����

-- �ٸ�ppt 5�� p.14 ����� Ȧ���� ��� �˻�
select * from employees where mod(employee_id, 2)=1;

-- ���� ó�� �Լ�
select first_name, upper(first_name) �빮��, lower(first_name) �ҹ���, email, initCap(email) ĳ��
from employees;

-- ����! first_name�� david�� ����� �˻��ϰ�ʹ�! (Į���� initCap ������)
-- ���1�� ���� ���� �����: �ε���(Į��)�� �ٲ��� �ʴ� ���̱� ������! �ε����� ������ �ӵ��� ������ �� �־�..
-- db�� �������� �ʴ� ���� ���� ���� ����̴�.
-- ex) first_name Į������ ����(index)�� �����Ǿ� �־��ٸ� �Լ��� �̿����� �� �ε����� ������.. (= �ε��� ��� �Ұ�)
select * from employees where first_name=initCap('david'); -- ���1: �Է��� ù �빮�ڷ� �ø���
select * from employees where lower(first_name)='david'; -- ���2: Į���� �ҹ��ڷ� ������
select * from employees where upper(first_name)=upper('david'); -- ���3: �� �빮�ڷ� �ø���

-- ���ڿ��� ���̸� ���϶�
select first_name, length(first_name) �̸�����, '��ö��', length('��ö��') �̸�����, lengthb('��ö��')
from employees;

-- �Ķ������ ������ �� �� ����
select * from v$nls_parameters;
select lengthb('oracle'), lengthb('����Ŭ') -- nls characterset�� al32utf8�� �Ǿ� �ֱ� ������ �ѱ��� 3����Ʈ�� ��
from dual;

-- �ٸ� ppt 5�� p.28
-- 05�⵵�� �Ի��� ����, substr �Լ��� �̿��� ��볯¥ 2���� ������ 05���� üũ
select *
from employees
where substr(hire_date, 1, 2)='05';

select *
from employees
where to_char(hire_date, 'RR')='05'; -- ������ RR�� �̱� (rr����!)

-- �̸��� E�� ������ ����, substr �̿��� ������ �� ���ڸ� �����ؼ� Ȯ��
select *
from employees
where substr(first_name, -1)=lower('E');

-- Ư�� ������ �ε��� ã�� (���, ã�� ����, ���� ��ġ, �� ��°)
select first_name, instr(first_name, 'a'), instr(first_name, 'a', 2, 2)
from employees;

-- �ٸ� ppt 5�� p.34 �̸� 3��° �ڸ��� r�� ���
-- _: ������ ���� 1��, %: ������ ���� 0�� �̻�
select first_name
from employees
where first_name like '__r%';

-- null�� ���������� ���߿� ����
-- nulls Xxx�� ���� ��ġ ���� ����
select *
from employees
order by commission_pct asc nulls first;
select *
from employees
order by commission_pct desc nulls last;

-- lpad, rpad
select lpad(first_name, 10, '#'), rpad(first_name, 20, '*')
from employees;

-- trim
select '!'||ltrim('      Oracle       ')||'!' as "LTRIM",'!'||rtrim('      Oracle       ')||'!' as "RTRIM",
'!'||trim('      Oracle       ')||'!' as "TRIM", '!'||trim('^' from '^^^^^^Oracle^^^^^')||'!' as "word TRIM"
from dual;