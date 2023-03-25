-- 03: 다른 사람 pc 연결
-- 팀 프로젝트를 할 때 이런 방식으로 DB 사용! db 하나만 사용하고 같이 들어가서 사용하도록

-- 테이블 생성
-- create table student ( stdid number, stdname varchar2(50));

-- 데이터 삽입
insert into student values(11, '오은빈');
-- commit까지 완료해야 다른 사람도 볼 수 있다!
commit;

select * from student order by 1;