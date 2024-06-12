-- EMPLOYEE 테이블에서 '해외영업1부'에 속한 모든 직원의 이름, 직급, 급여를 조회하시오.
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID
                   FROM DEPARTMENT
                   WHERE DEPT_TITLE = '해외영업1부');
-- select 뒤에 , 후 서브쿼리가 들어가는 것은 행을 추가로 발생
-- select -> from 뒤에 = 부등호가 들어가는 것은 서브쿼리와 값을 비교하는 것


-- EMPLOYEE 테이블에서 모든 직원의 평균 급여보다 높은 급여를 받는 직원의 이름과 급여를 조회하시오.
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE);

# select emp_name,
#        max(salary)
# from employee a
# where emp_name = (select max(salary)
#                   from employee b
#                   where a.emp_name = b.emp_name);


-- EMPLOYEE 테이블에서 각 부서의 평균 급여보다 높은 급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY
# 이 부분은 SELECT 문을 사용하여 결과 집합에 반환할 열을 선택합니다.
# EMPLOYEE 테이블의 EMP_NAME 및 SALARY 열,
# 그리고 DEPARTMENT 테이블의 DEPT_TITLE 열을 선택합니다.
FROM EMPLOYEE E
         JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
# 이 부분은 FROM 절에서 EMPLOYEE 테이블(E라는 별칭 사용)과 DEPARTMENT 테이블(D라는 별칭 사용)을 조인합니다.
# 이 조인은 EMPLOYEE 테이블의 DEPT_CODE 열과 DEPARTMENT 테이블의 DEPT_ID 열 간의 일치를 찾습니다.
WHERE E.SALARY > (SELECT AVG(SALARY)
                  FROM EMPLOYEE
                  WHERE DEPT_CODE = E.DEPT_CODE);
#  이 부분은 WHERE 절에서 각 직원의 급여가 그들이 속한 부서의 평균 급여보다 높은 직원만을 선택합니다.
#  서브쿼리(SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE)는
#  E.DEPT_CODE의 값을 가진 EMPLOYEE 행들의 평균 급여를 계산합니다.

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
WHERE E.SALARY = (SELECT MAX(SALARY)
                  FROM EMPLOYEE
                  WHERE DEPT_CODE = E.DEPT_CODE);
-- EMPLOYEE 테이블에서 각 직급별 평균 급여보다 높은 급여를 받는 직원의 이름, 직급, 급여를 조회하시오.
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
         JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.SALARY > (SELECT AVG(SALARY)
                  FROM EMPLOYEE
                  WHERE JOB_CODE = E.JOB_CODE);

-- EXISTS 절 문제
-- DEPARTMENT 테이블에서 직원이 있는 부서의 부서명을 조회하시오.
SELECT D.DEPT_TITLE
FROM DEPARTMENT D
WHERE EXISTS (SELECT 1
              FROM EMPLOYEE E
              WHERE E.DEPT_CODE = D.DEPT_ID);
# 서브쿼리는 EMPLOYEE 테이블에서 DEPT_CODE가 현재 부서의 DEPT_ID와 일치하는지 확인합니다.
# 만약 하나 이상의 행이 존재한다면, EXISTS는 TRUE를 반환하고, 해당 부서가 선택됩니다.

-- EMPLOYEE 테이블에서 급여가 가장 높은 직원의 이름과 급여를 조회하시오. (NOT EXISTS 사용)
SELECT E.EMP_NAME, E.SALARY
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT 1
                  FROM EMPLOYEE E2
                  WHERE E2.SALARY > E.SALARY);
# 메인 쿼리의 급여보다 서브 쿼리의 급여가 크면(큰 것은) 존재하지 않는다.
# 여기서는 NOT EXISTS를 사용하여 서브쿼리가 어떠한 결과도 반환하지 않을 때 조건이 충족되도록 합니다.
# 서브쿼리는 EMPLOYEE 테이블에서 현재 직원의 급여보다 더 높은 급여를 받는 다른 직원이 있는지 확인합니다.
# 만약 어떠한 직원도 현재 직원보다 더 높은 급여를 받지 않는다면,
# NOT EXISTS는 TRUE를 반환하고, 해당 직원은 선택됩니다.

-- CTE 문제
-- EMPLOYEE 테이블에서 각 부서별 평균 급여를 계산하고,
-- 평균 급여가 4000000 이상인 부서의 부서명과 평균 급여를 조회하시오.
WITH DeptAvgSalary AS (SELECT DEPT_CODE, AVG(SALARY) AS AvgSalary
                       FROM EMPLOYEE
                       GROUP BY DEPT_CODE)
SELECT D.DEPT_TITLE, DAS.AvgSalary
FROM DeptAvgSalary DAS
         JOIN DEPARTMENT D ON DAS.DEPT_CODE = D.DEPT_ID
WHERE DAS.AvgSalary >= 4000000;

# WITH DeptAvgSalary AS (...):
# 이 부분은 공통 테이블 표현식(Common Table Expression, CTE)을 정의합니다.
# CTE는 쿼리 내에서 임시로 사용할 수 있는 이름이 지정된 쿼리 결과 세트입니다.
# 이 경우, EMPLOYEE 테이블에서 각 부서(DEPT_CODE 별로 그룹화)의 평균 급여를 계산합니다.
# DEPT_CODE와 해당 부서의 평균 급여(AvgSalary)가 선택됩니다.
#
# SELECT D.DEPT_TITLE, DAS.AvgSalary FROM DeptAvgSalary DAS ...:
# 이 부분은 공통 테이블 표현식으로부터 얻은 결과를 사용하여 부서의 제목과 해당 부서의 평균 급여를 선택합니다.
# 이 결과는 부서 제목(D.DEPT_TITLE)과 해당 부서의 평균 급여(DAS.AvgSalary)로 구성됩니다.
#
# JOIN DEPARTMENT D ON DAS.DEPT_CODE = D.DEPT_ID:
# 이 부분은 DEPTAvgSalary CTE와 DEPARTMENT 테이블을 조인합니다.
# 조인은 DEPT_CODE와 DEPT_ID가 일치하는 행만 선택합니다.
#
# WHERE DAS.AvgSalary >= 4000000:
# 이 부분은 평균 급여가 400만 이상인 부서들만 선택합니다.
# 이는 이전에 계산된 평균 급여를 기준으로 부서를 필터링합니다.