-- 01 복습: madang 사용
use madang;
show tables;

select * from book;
select * from customer;
select * from orders;

-- between은 이상, 이하로 두 조건을 모두 포함한다!
select price
from book
where price between 10000 and 20000;

-- 문자열이 같을 때 = vs like
-- =으로 쓰는 것이 빠르다! 같을때는 =을 쓰는 것이 좋아
select *
from book
where bookname='축구의 역사';

select *
from book
where bookname like '축구의 역사';

select *
from book
where bookname like '%역사';

-- order 테이블에서 고객별 주문 건수와 주문 금액 합계
select custid, max(orderid) 최근주문번호, count(*) 주문건수, sum(saleprice) 주문금액
from orders
group by custid;

-- 주문이 고객을 참조 -> 주문의 건수만큼 나옴
-- 명확하게 쓰고 싶다면 테이블.칼럼으로 작성하는 것이 좋음 (중복되지 않는다면 작성하지 않아도 됨)
-- 방법1: Vendor 문법
select orderid, name, bookname, price, orderdate
from orders, customer, book
where orders.custid=customer.custid
and orders.bookid=book.bookid
order by orderid;

-- 방법2: ANSI 표준 문법
select orderid, name, bookname, price, orderdate
from orders join customer using(custid)
join book on orders.bookid=book.bookid
-- join book using(bookid)
order by orderid;