-- �̹����� WAS�� file ������ �ø� ���ΰ�, DB�� ���� ���ΰ�?
-- DB�� �ִ� Ÿ���� BLOB, �뷮�� ���� �����ϱ� ������ �� �� ��
-- �׷��ٸ� WAS�� file ������ �����ؾߵ�!! -> �̰� �ٷ� .metadata~~~wtpwebapps �� ����� ���~
-- DB���� �� ��θ� �����ϰ� ���� ���ε�� file������!

alter table admins
add pic varchar2(20);

delete from admins;
commit;

select * from admins;