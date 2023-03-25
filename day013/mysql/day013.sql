-- 02 (얘는 거의 안 쓰고 oracle sql developer로 많이 함)
show databases;
use sakila; -- 내가 어떤 db를 사용하는지 적어줘야 함!
show tables;
select * from city;

desc customer;-- 내가 어떤 db를 사용하는지 적어줘야 함!

select * from customer;

select customer_id, first_name, last_name, concat(first_name,' ',last_name) 이름 from customer;

-- mysql은 from이 필수가 아님!
select 1+2, sysdate();

/* 다른ppt 5장 p.14 사번이 홀수인 사람 검색 */
select * from customer where mod(customer_id, 2)=1; 