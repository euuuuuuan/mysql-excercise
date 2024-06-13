-- EMPLOYEE 테이블에서 각 직원의 이메일 주소에서 도메인 부분을 추출하여 출력하시오.
select substring_index(email, '@', -1)
from employee;

-- EMPLOYEE 테이블에서 각 직원의 급여에서 10%를 감한 후, 이를 소수점 둘째 자리에서 반올림하여 출력하시오
select format(salary - (salary * 0.1) , 2)
from employee;

-- EMPLOYEE 테이블에서 각 부서의 평균 급여를 계산하고, 그 값을 '부서별 평균 급여는 X 원입니다' 형식의 문자열로 출력하시오.
select insert('부서별 평균 급여는 X 원입니다.', 12, 2, round(avg(salary), 0))
from employee e
join department d on e.dept_code = d.dept_id
group by e.dept_code;

-- EMPLOYEE 테이블에서 각 직원의 입사 연도, 입사 월, 입사일을 각각 조회하시오.
select emp_name name, year(hire_date) yrs, month(hire_date) months, day(hire_date) days
from employee
order by year(hire_date);

-- EMPLOYEE 테이블에서 입사일이 2010년 1월 1일 이후인 직원들의 이름과 입사일을 조회하시오.
select emp_name, hire_date
from employee
where hire_date >= '2010-01-01'
order by hire_date;
