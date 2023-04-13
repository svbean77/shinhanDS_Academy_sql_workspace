-- 이미지를 WAS의 file 서버에 올릴 것인가, DB에 넣을 것인가?
-- DB에 넣는 타입은 BLOB, 용량을 많이 차지하기 때문에 잘 안 써
-- 그렇다면 WAS의 file 서버에 저장해야돼!! -> 이게 바로 .metadata~~~wtpwebapps 이 어려운 경로~
-- DB에는 이 경로를 저장하고 실제 업로드는 file서버다!

alter table admins
add pic varchar2(20);

delete from admins;
commit;

select * from admins;