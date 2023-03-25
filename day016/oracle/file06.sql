-- 06
-- ch16 인덱스

-- 휴지통에 있는 테이블을 조회
show recyclebin; 
-- 삭제된 테이블을 복원
-- flashback table 테이블명 to before drop;       
-- 휴지통에 남기지 않고 완전 삭제
-- drop table 테이블명 purge;     
 -- 휴지통에 있는 테이블 완전 삭제
-- purge table 테이블명;     
purge recyclebin;      -- 휴지통 비우기

-- 인덱스 확인
select *
from user_ind_columns
where table_name='EMPLOYEES';

select *
from user_ind_columns
where table_name='TBL_BOARD';

-- 인덱스를 탄다, 타지 않는다?! -> 실행계획을 봐야 함 (드래그 후 f10)
-- 칼럼을 그대로 사용한 경우 실행계획은 range scan, by index rowid -> 인덱스를 타고 있음!
select *
from employees
where first_name = 'Steven' and last_name = 'King';
-- 칼럼을 변경한 경우(lower) 실행계획은 full (cost도 비싸짐!)
select *
from employees
where lower(first_name) = 'steven' and lower(last_name) = 'king';
-- 그러니까 값을 변경하라!!!! (range scan, by index rowid 둘 다 인덱스 타는것!)
select *
from employees
where first_name = initCap('steven') and last_name = initCap('king');
-- 하지만 무조건 인덱스를 타는 것이 좋은건 아니야! (full 탐색을 했는데 첫 결과에 있을 수 있잖아?! 상황에 따라 다름~)

-- 인덱스 생성
select * from tbl_board
where bno=1; -- 얘는 인덱스를 타지! (pk)
select * from tbl_board
where title='수요일'; -- 얘도 인덱스를 타도록 만들고싶다 -> title로 인덱스를 만들어주면 됨!
create index idx_tbl_board_title
on tbl_board(title);