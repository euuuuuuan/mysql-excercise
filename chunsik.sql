select *
from TB_DEPARTMENT; --  학과테이블
select *
from TB_STUDENT; -- 학생테이블
select *
from TB_PROFESSOR; -- 교수테이블
select *
from TB_CLASS; -- 수업테이블
select *
from TB_CLASS_PROFESSOR; -- 수업교수테이블
select *
from TB_GRADE;
-- 학점테이블

-- level 1
-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오.
-- 단, 출력 헤더는 "학과 명", "계열"으로 표시하도록 한다.
select department_name,
       category
from tb_department;


-- 2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
select concat(department_name, '의 정원은 ', capacity, ' 명 입니다.')
from tb_department;

-- 3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 들어왔다.
-- 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)
select student_name
from tb_student
         join tb_department
              on tb_student.DEPARTMENT_NO
                  = tb_department.DEPARTMENT_NO
where ABSENCE_YN = 'Y'
  and substring(STUDENT_SSN, 8, 1) = '2'
  and DEPARTMENT_NAME = '국어국문학과';


-- 4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다.
-- 그 대상자들의 학번이 다음과 같을 때 대상자들을 찾는 적 SQL 구문을 작성하시오.

select STUDENT_NAME
from tb_student
where STUDENT_NO in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
order by STUDENT_NO desc;

-- 5. 입학정원이 20 명 이상 30 명 이하인 학과들의 학과 이름과 계열을 출력하시오.
select DEPARTMENT_NAME,
       CATEGORY
from tb_department
where CAPACITY >= 20
  and CAPACITY <= 30;

-- 6. 춘기술대학교는 총장을 제외하고 모든 교수들이 소속학과를 가지고있다.
-- 그럼 춘기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
select PROFESSOR_NAME
from tb_professor
where DEPARTMENT_NO IS NULL;


-- 7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
-- 어떠한 SQL 문장을 사용하면 될 것인지 작성하시오.
select STUDENT_NAME
from tb_student
where DEPARTMENT_NO is null;

-- 8. 수강신청을 하려고 한다.
-- 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는 과목들은 어떤 과목인지 과목번호를 조회해보시오.
select CLASS_NO
from tb_class
where PREATTENDING_CLASS_NO is not null;


-- 9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
select distinct CATEGORY
from tb_department;

-- 10. 19 학번 전주 거주자들의 모임을 만들려고 한다.
-- 휴학한 사람들은 제외하고, 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
select STUDENT_NO,
       STUDENT_NAME,
       STUDENT_SSN
from tb_student
where ABSENCE_YN = 'N'
  and ENTRANCE_DATE like '%2019%'
  and STUDENT_ADDRESS like '%전주시%'
order by STUDENT_NO;


-- level 2
-- 1. 영어영문학과(학과코드 `002`) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른순으로 표시하는 SQL 문장을 작성하시오.

-- ( 단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)

select s.STUDENT_NO,
       s.STUDENT_NAME,
       s.ENTRANCE_DATE
from tb_student s
         join tb_department d
              on d.DEPARTMENT_NO
                  = s.DEPARTMENT_NO
# group by d.DEPARTMENT_NO = 2
where d.DEPARTMENT_NO = 2
order by ENTRANCE_DATE desc;

