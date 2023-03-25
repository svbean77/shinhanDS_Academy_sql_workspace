-- 02 무결성 제약 조건
-- ch 13 무결성 제약 조건

-- 제약 조건을 확인
select * from user_constraints; -- 전체 테이블
select * from user_constraints
where table_name='EMPLOYEES'; -- 데이터 사전은 대문자로 들어가있기 때문에 대문자로 작성!

-- 직접 테이블 만들어 확인해보자
drop table tbl_test1;
-- constraint를 이용해 제약조건에 이름 부여 가능 (칼럼이 하나일 때, 칼럼 레벨에서 제약)
create table tbl_test1 (id number constraint pk_tbl_test1_id primary key, 
                        name varchar2(20) not null, 
                        phone_number varchar2(13) constraint u_phone unique);
select * from user_constraints
where table_name='TBL_TEST1';

select * from tbl_test1;

insert into tbl_test1(id, name) values(1, 'aa');
insert into tbl_test1 values(1, 'bb'); -- 두 번 실행하면 오류 발생! (기본키가 중복되었으니까!)
insert into tbl_test1 values(2); -- null이기 때문에 오류 발생! (not null로 설정했잖아)
insert into tbl_test1(id, name, phone_number) values(2, 'bb', '13-1234-5432');
insert into tbl_test1(id, name, phone_number) values(3, 'cc', '13-1234-5432'); -- unique이기 때문에 오류

-- 칼럼에 대한 제약조건 보기
select * from user_cons_columns
where table_name='TBL_TEST1';
-- 테이블 조건도, 칼럼 조건도 다 보고싶다: 두 개를 조인

-- pk가 두 개인 경우 어떻게 이름을 줘?! (테이블 레벨에서 제약조건 줌)
-- 주문(고객, 상품, 일자, 가격) pk는 고객+상품
create table tbl_order (고객 number, 상품 number, order_date date, price number,
                        constraint pk_order primary key(고객, 상품));
insert into tbl_order values(1, 100, sysdate, 1000);
insert into tbl_order values(1, 100, sysdate-1, 1200); -- 두 번 실행하면 오류 발생: 고객, 상품 묶어서 pk임: not null + unique

select * from user_constraints
where table_name='TBL_ORDER';
select * from user_cons_columns
where table_name='TBL_ORDER';

-- 참조 무결성
select * from departments;
select * from employees;
-- 누가 누구를 참조하는지 이름으로 잘 찾아보기
select * from user_constraints
where table_name='DEPARTMENTS';
select * from user_constraints
where table_name='EMPLOYEES';
select * from user_cons_columns
where table_name='EMPLOYEES';

alter trigger UPDATE_JOB_HISTORY disable; -- 참조 무결성 걸리는지 보기 위해 트리거 일시중지
update employees set department_id=1; -- parent key not found: 참조 무결성 제한에 걸림

-- 직접 만든 테이블로 해보자
create table tbl_parent (deptid number primary key, deptname varchar2(20));
create table tbl_child(empid number primary key, empname varchar2(20), 
                       deptid number constraint tbl_parent_deptid_FK references tbl_parent(deptid));
insert into tbl_child(empid, empname, deptid) values (1, 'aa', 10); -- tbl_parent에 존재하지 않는 deptid를 넣어 오류: 부모를 먼저!
-- 부모 테이블에 값이 있어야 자식 테이블에 삽입 가능!
insert into tbl_parent(deptid, deptname) values(10, '개발부');
insert into tbl_parent(deptid, deptname) values(20, '영업부');
insert into tbl_parent(deptid, deptname) values(30, '총무부');
insert into tbl_child(empid, empname, deptid) values (1, 'aa', 10);
-- 칼럼의 내용을 다 넣으려면 순서대로 넣고 칼럼명 생략 가능
-- 삽입 순서를 바꾸고싶다면 순서를 명시해야 함
insert into tbl_child values (2, 'bb', 20); 
insert into tbl_child(empid, deptid, empname) values (3, 30, 'cc'); 
insert into tbl_child(empid, empname) values (4, 'dd'); 
select * from tbl_child;

drop table tbl_parent; -- 참조하는 자식이 있는데 부모를 지우면 오류 발생 - 옵션 설정 (같이 지움, null, 기본값)

-- check 제약 조건
drop table tbl_child;
create table tbl_child(empid number primary key, empname varchar2(20) not null, 
                       deptid number constraint tbl_parent_deptid_FK references tbl_parent(deptid),
                       salary number constraint tbl_child_salary_check check(salary between 1000 and 2000),
                       gender char(1) constraint tbl_child_gender_check check(gender in ('M', 'F')),
                       phone_number char(13) unique
                       );
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (1, 'aa', 10, null, null, null);
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (2, 'bb', 10, 500, null, null); -- 1000<=salary<=2000이 아니기 때문에 제약조건에 걸림
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (2, 'aa', 10, 1500, 'W', null); -- M, F가 아니기 때문에 제약조건에 걸림
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (2, 'aa', 10, 1500, 'M', null);            
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (3, 'cc', 10, 1500, 'F', '2345');            
select * from tbl_child;            

-- default 제약 조건
drop table tbl_child;
create table tbl_child(empid number primary key, empname varchar2(20) not null, 
                       deptid number constraint tbl_parent_deptid_FK references tbl_parent(deptid),
                       salary number constraint tbl_child_salary_check check(salary between 1000 and 2000),
                       gender char(1) constraint tbl_child_gender_check check(gender in ('M', 'F')),
                       phone_number char(13) unique,
                       nation varchar2(30) default '한국'
                       );
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number) 
            values (1, 'aa', 10, 1500, 'M', null);            
insert into tbl_child(empid, empname, deptid, salary, gender, phone_number, nation) 
            values (2, 'bb', 10, 1500, 'F', '2345', '대한민국'); 
select * from tbl_child;

-- subquery를 이용해 테이블 생성 -> not null만 복사되기 때문에 다른 제약조건을 추가해보자!
create table tbl_emp_backup
as
select * from employees
where department_id=60;
select * from tbl_emp_backup;
select * from user_constraints where table_name='TBL_EMP_BACKUP';
-- not null만 복사되었기 때문에 이상한 변경도 적용이 되어버림! -> 제약조건을 추가해야 함!
update tbl_emp_backup
set department_id=1;
rollback;
-- 제약조건 추가
alter table tbl_emp_backup
add constraint tbl_emp_backup_PK primary key (employee_id);
alter table tbl_emp_backup
add constraint tbl_emp_backup_FK foreign key (department_id) references departments(department_id);


-- 우리 책(mysql)의 내용도 봐야한다!!!!