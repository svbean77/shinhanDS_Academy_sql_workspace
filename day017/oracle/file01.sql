-- 01 복습
-- 1. 자신이 속한 부서의 평균 급여보다 더 적은 급여를 받는 직원 조회
-- 1) subquery
select *
from employees emp
where salary < (
    select avg(salary)
    from employees sub -- 여기는 별명 안지어도 됨
    where emp.department_id=sub.department_id
    );
-- 2) inline view
select *
from employees, (select department_id myDept, avg(salary) avgSal
                 from employees
                 group by department_id)
where salary < avgSal
and department_id=myDept;

-- 입력 (insert 해보기)
-- 지금 이미 시퀀스 객체는 만들어둠! 따라서 이클립스에서 바로 사용할 수 있어! object는 db에 만들어진 상태!
create sequence seq_employee start with 300; -- 어느 순서부터 시작인지!

insert into employees(employee_id, last_name, email, hire_date, job_id) -- not null인 값들만
values(seq_employee.nextval, 'aa', 'bb', sysdate, 'IT_PROG');
select * from employees;
rollback; -- rollback을 해도 시퀀스는 이미 +1이 된 상태! 다음 번호는 301이야

-- 수정 (update 해보기, email로 도전)
update employees
set email=?, department_id=?, job_id=?, salary=?
where employee_id=?;

-- trigger 중지 안해도 돌아가도록! 
-- 테이블을 건드릴 때 다른 테이블 어쩌고 자동으로 실행되는 프로시저
alter trigger update_job_history enable;
delete from job_history;

-- 복습2: 복합키를 가진 table을 FK로 설정하기
drop table tbl_parent cascade constraints; -- 자식이 있으면 자식도 삭제
drop table tbl_child cascade constraints;
create table tbl_parent(pid1 number, pid2 number, pname varchar2(30), 
                        constraint pk_tbl_parent primary key(pid1, pid2));
create table tbl_child(ch_id number primary key, ch_name varchar2(20), pid1 number, pid2 number,
                       constraint fk_parent foreign key(pid1, pid2) references tbl_parent(pid1, pid2)
                       on delete cascade); -- 부모가 지워지면 나도 함께 지워짐
                       
insert into tbl_parent values(1, 1, 'aa');
insert into tbl_parent values(1, 2, 'aa'); -- 2개가 세트로 PK이기 때문에 두 개가 모두 같아야 중복임! 이거 들어가!
insert into tbl_child values(100, 'AA', 9, 9); -- 9, 9는 부모에 존재하지 않음 -> 에러
insert into tbl_child values(100, 'AA', 1, 1);
select * from tbl_child;
commit;

delete from tbl_parent where pid1=1 and pid2=1;
select * from tbl_child; -- 데이터가 사라짐!!!!!!! (on delete cascade이기 때문에...)