-- 01 ����
-- 1. �ڽ��� ���� �μ��� ��� �޿����� �� ���� �޿��� �޴� ���� ��ȸ
-- 1) subquery
select *
from employees emp
where salary < (
    select avg(salary)
    from employees sub -- ����� ���� ����� ��
    where emp.department_id=sub.department_id
    );
-- 2) inline view
select *
from employees, (select department_id myDept, avg(salary) avgSal
                 from employees
                 group by department_id)
where salary < avgSal
and department_id=myDept;

-- �Է� (insert �غ���)
-- ���� �̹� ������ ��ü�� ������! ���� ��Ŭ�������� �ٷ� ����� �� �־�! object�� db�� ������� ����!
create sequence seq_employee start with 300; -- ��� �������� ��������!

insert into employees(employee_id, last_name, email, hire_date, job_id) -- not null�� ���鸸
values(seq_employee.nextval, 'aa', 'bb', sysdate, 'IT_PROG');
select * from employees;
rollback; -- rollback�� �ص� �������� �̹� +1�� �� ����! ���� ��ȣ�� 301�̾�

-- ���� (update �غ���, email�� ����)
update employees
set email=?, department_id=?, job_id=?, salary=?
where employee_id=?;

-- trigger ���� ���ص� ���ư�����! 
-- ���̺��� �ǵ帱 �� �ٸ� ���̺� ��¼�� �ڵ����� ����Ǵ� ���ν���
alter trigger update_job_history enable;
delete from job_history;

-- ����2: ����Ű�� ���� table�� FK�� �����ϱ�
drop table tbl_parent cascade constraints; -- �ڽ��� ������ �ڽĵ� ����
drop table tbl_child cascade constraints;
create table tbl_parent(pid1 number, pid2 number, pname varchar2(30), 
                        constraint pk_tbl_parent primary key(pid1, pid2));
create table tbl_child(ch_id number primary key, ch_name varchar2(20), pid1 number, pid2 number,
                       constraint fk_parent foreign key(pid1, pid2) references tbl_parent(pid1, pid2)
                       on delete cascade); -- �θ� �������� ���� �Բ� ������
                       
insert into tbl_parent values(1, 1, 'aa');
insert into tbl_parent values(1, 2, 'aa'); -- 2���� ��Ʈ�� PK�̱� ������ �� ���� ��� ���ƾ� �ߺ���! �̰� ��!
insert into tbl_child values(100, 'AA', 9, 9); -- 9, 9�� �θ� �������� ���� -> ����
insert into tbl_child values(100, 'AA', 1, 1);
select * from tbl_child;
commit;

delete from tbl_parent where pid1=1 and pid2=1;
select * from tbl_child; -- �����Ͱ� �����!!!!!!! (on delete cascade�̱� ������...)