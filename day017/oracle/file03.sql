-- 03
-- 17장 사용자 권한

-- dba 계정으로 접속했을 때 (sql plus에서 실행)
-- 사용자 생성
create user user01 identified by 1234;
-- db 접속 권한 부여
grant create session user01;
-- select 권한 부여
grant select on employees to user01;

-- user01에 접속 후 검색을 실행하려면
select * from hr.employees; -- 내 테이블이 아니니까!

-- 이건 본인 계정도 가능
-- 현재 사용자가 다른 사용자에게 부여한 권한 조회
select * from user_tab_privs_made;
-- 자신에게 부여된 권한 조회
select * from user_tab_privs_recd;

-- 18장 롤
-- dba 계정 (sql plus에서 실행)
grant connect, resource to user01;

-- 19장 동의어
-- dba 계정 (sql plus)
grant synonym to user01;
-- user01 계정
create synonym hr_emp for hr.employees;
select * from hr_emp; -- 동의어 생성 후 소유자.테이블명으로 작성하지 않아도 됨!