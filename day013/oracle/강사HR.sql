-- 03: �ٸ� ��� pc ����
-- �� ������Ʈ�� �� �� �̷� ������� DB ���! db �ϳ��� ����ϰ� ���� ���� ����ϵ���

-- ���̺� ����
-- create table student ( stdid number, stdname varchar2(50));

-- ������ ����
insert into student values(11, '������');
-- commit���� �Ϸ��ؾ� �ٸ� ����� �� �� �ִ�!
commit;

select * from student order by 1;