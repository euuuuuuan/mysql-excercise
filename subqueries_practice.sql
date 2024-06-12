-- EMPLOYEE 테이블에서 '해외영업1부'에 속한 모든 직원의 이름, 직급, 급여를 조회하시오.
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (
    SELECT DEPT_ID
    FROM DEPARTMENT
    WHERE DEPT_TITLE = '해외영업1부'
);
-- select 뒤에 , 후 서브쿼리가 들어가는 것은 행을 추가로 발생
-- select -> from 뒤에 = 부등호가 들어가는 것은 서브쿼리와 값을 비교하는 것


-- EMPLOYEE 테이블에서 모든 직원의 평균 급여보다 높은 급여를 받는 직원의 이름과 급여를 조회하시오.
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
);
# select emp_name,
#        max(salary)
# from employee a
# where emp_name = (select max(salary)
#                   from employee b
#                   where a.emp_name = b.emp_name);


-- EMPLOYEE 테이블에서 각 부서의 평균 급여보다 높은 급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY
FROM EMPLOYEE E
         JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE E.SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
    WHERE DEPT_CODE = E.DEPT_CODE
);
#        dept_code,
#        avg(salary)
# from employee
# where avg(salary) >= 2000
# group by emp_name, dept_code;
# 그루핑을 하는 것과 안하는 것의 차이가 무엇인가. 위와 아래의 차이.


-- 상관서브쿼리문제
-- EMPLOYEE 테이블에서 각 부서별로 가장 높은 급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY
FROM EMPLOYEE E
         JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE E.SALARY = (
    SELECT MAX(SALARY)
    FROM EMPLOYEE
    WHERE DEPT_CODE = E.DEPT_CODE
);
-- EMPLOYEE 테이블에서 각 직급별 평균 급여보다 높은 급여를 받는 직원의 이름, 직급, 급여를 조회하시오.
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
         JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
    WHERE JOB_CODE = E.JOB_CODE
);

-- EXISTS 절 문제
-- DEPARTMENT 테이블에서 직원이 있는 부서의 부서명을 조회하시오.
SELECT D.DEPT_TITLE
FROM DEPARTMENT D
WHERE EXISTS (
    SELECT 1
    FROM EMPLOYEE E
    WHERE E.DEPT_CODE = D.DEPT_ID
);
-- EMPLOYEE 테이블에서 급여가 가장 높은 직원의 이름과 급여를 조회하시오. (NOT EXISTS 사용)
SELECT E.EMP_NAME, E.SALARY
FROM EMPLOYEE E
WHERE NOT EXISTS (
    SELECT 1
    FROM EMPLOYEE E2
    WHERE E2.SALARY > E.SALARY
);

-- CTE 문제
-- EMPLOYEE 테이블에서 각 부서별 평균 급여를 계산하고,
-- 평균 급여가 4000000 이상인 부서의 부서명과 평균 급여를 조회하시오.
WITH DeptAvgSalary AS (
    SELECT DEPT_CODE, AVG(SALARY) AS AvgSalary
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
SELECT D.DEPT_TITLE, DAS.AvgSalary
FROM DeptAvgSalary DAS
         JOIN DEPARTMENT D ON DAS.DEPT_CODE = D.DEPT_ID
WHERE DAS.AvgSalary >= 4000000;