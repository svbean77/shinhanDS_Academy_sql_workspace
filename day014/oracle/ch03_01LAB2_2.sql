-- 06
-- 7. 각 부서별 인원수를 조회하되 인원수가 5명 이상인 부서만 출력되도록 하시오.
select department_id, count(*) 인원수
from employees
group by department_id
having count(*) >= 5;





-- 8. 각 부서별 최대급여와 최소급여를 조회하시오.
--    단, 최대급여와 최소급여가 같은 부서는 직원이 한명일 가능성이 높기때문에 
--    조회결과에서 제외시킨다.
select department_id, max(salary), min(salary)
from employees
group by department_id
having max(salary) != min(salary);



   
-- 9. 부서가 50, 80, 110 번인 직원들 중에서 급여를 5000 이상 24000 이하를 받는
--    직원들을 대상으로 부서별 평균 급여를 조회하시오.
--    다, 평균급여가 8000 이상인 부서만 출력되어야 하며, 출력결과를 평균급여가 높은
--    부서면저 출력되도록 해야 한다.
select department_id, avg(salary) 평균급여
from employees
where department_id in(50, 80, 110) and salary between 5000 and 24000
group by department_id
having avg(salary) >= 8000
order by 평균급여 desc; -- select문 이후로 정렬을 하기 때문에 다시 계산하는 것보다는 별명으로 정렬하도록 하는 것이 좋음 (일 한 번만 함)
