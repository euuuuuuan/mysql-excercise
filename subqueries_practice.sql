-- EMPLOYEE 테이블에서 '해외영업1부'에 속한 모든 직원의 이름, 직급, 급여를 조회하시오.
select dept_title,
       job_name,
       emp_name,
       salary
from employee,
     department,
     job
where dept_id = (select dept_id
                 from department
                 where dept_title = '해외영업1부');


-- EMPLOYEE 테이블에서 모든 직원의 평균 급여보다 높은 급여를 받는 직원의 이름과 급여를 조회하시오.
select emp_name,
       salary
from employee
where salary > (select avg(salary)
                from employee);


-- EMPLOYEE 테이블에서 각 부서의 평균 급여보다 높은 급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
# select b.dept_title,
#        a.emp_name,
#        avg(salary)
# from employee a
#     left join department b on a.EMP_ID = b.DEPT_ID
# group by emp_name, b.dept_title;

# select emp_name,
#        dept_code,
#        avg(salary)
# from employee
# where avg(salary) >= 2000
# group by emp_name, dept_code;
# 그루핑을 하는 것과 안하는 것의 차이가 무엇인가. 위와 아래의 차이.


-- 상관서브쿼리문제
-- EMPLOYEE 테이블에서 각 부서별로 가장 높은 급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.

-- EMPLOYEE 테이블에서 각 직급별 평균 급여보다 높은 급여를 받는 직원의 이름, 직급, 급여를 조회하시오.


-- EXISTS 절 문제
-- DEPARTMENT 테이블에서 직원이 있는 부서의 부서명을 조회하시오.
select a.dept_id,
       a.dept_title
from department a
where exists(select dept_id
             from department b
             where b.dept_id = a.dept_id);
-- EMPLOYEE 테이블에서 급여가 가장 높은 직원의 이름과 급여를 조회하시오. (NOT EXISTS 사용)
# select a.emp_name,
#        max(salary)
# from employee a
# where not exists(select salary
#              from employee b
#              where b.emp_name = a.emp_name);

-- CTE 문제
-- EMPLOYEE 테이블에서 각 부서별 평균 급여를 계산하고,
-- 평균 급여가 4000000 이상인 부서의 부서명과 평균 급여를 조회하시오.
