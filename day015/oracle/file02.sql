-- 02 과제(3장 2절 LAB3) 4번 다른 풀이, 7번 확인

-- 4. 직책(job_title)이 'manager' 인 사람의 이름, 직책, 부서명을 조회하시오.
-- 내 풀이: like 사용
select first_name, job_title, department_name
from jobs join employees using (job_id)
join departments using (department_id)
where job_title like initCap('%manager');

-- 다른 풀이: substr 사용
select first_name, job_title, department_name
from jobs join employees using (job_id)
join departments using (department_id)
where substr(job_title, -7)=initCap('manager');


-- 7. 직원의 이름과 직책(job_title)을 출력하시오.
-- 단, 사용되지 않는 직책이 있다면 그 직책정보도 출력결과에 포함시키시오.
select first_name, job_title
from employees right outer join jobs using (job_id);

-- 정말 모든 직책이 사용되었나 확인하기 -> 이렇게 점검도 할 줄 알아야 해!!!!
select count(distinct job_id) from employees; -- employees에서 사용하는 job_id 개수: 19
select count(*) from jobs; -- jobs의 직책 개수: 19