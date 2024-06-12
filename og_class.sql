# 우리반 데이터베이스를 만드세요
# ’ogclass’ database  생성
#
# class table
# student_no : [int] primary key, auto increament
# stuent_name : [varchar[255]] not null
# gender : [varchar[5]] notnull check(’남’,’여’)
# github_id : [varchar[255]]  not null, unique
# email : [varchar[255]]  not null, unique
# mbti : [varchar[10]]
# subject_no : [int] foregin key,
#
# favorite_subject table
# subject_no : [int] primary key, auto increament
# subject_name : [varchar[255]] not null, unique
create table if not exists favorite_subject
(
    subject_no   int auto_increment primary key comment '과목번',
    subject_name varchar(255) not null unique comment '과목명'
);

create table if not exists class
(
    student_no  int auto_increment primary key comment '학번',
    stuent_name varchar(255) not null comment '학생명',
    gender      varchar(5)   not null comment '성별',
    check (gender in ('남', '여')),
    github_id   varchar(255) not null unique comment '깃헙아이디',
    email       varchar(255) not null unique comment '이메일',
    mbti        varchar(10) comment '엠비티아이',
    subject_no  int comment '과목번호',
    foreign key (subject_no)
        references favorite_subject (subject_no)
);

select *
from class;

insert into favorite_subject
    (subject_no, subject_name)
values (null, 'Java'),
       (null, 'MySQL'),
       (null, 'JDBC'),
       (null, 'MyBatis'),
       (null, 'Spring'),
       (null, 'React');

insert into class
    (student_no, stuent_name, gender, github_id, email, mbti, subject_no)
values (null, '박태근', '남', 'Ohgiraffers-bear', 'bear.ohgiraffers@gmail.com', 'ENFJ', 5),
       (null, '지동현', '남', 'Bring2it2on', 'yjkl0516@gmail.com', 'ENFJ', 3),
       (null, '김강현', '남', 'kimkinghyeon', 'modan8199@gmail.com', 'ENFJ', 1),
       (null, '이득규', '남', 'MANTISKYU', 'asdaron44@gmail.com', 'ENFJ', 2),
       (null, '홍주연', '여', 'juyeon99', 'juyeon0806@gmail.com', 'ENFJ', 1),
       (null, '양혜연', '여', 'yanghyeyeon', 'yhy4058@gmail.com', 'ENFJ', 5),
       (null, '이규섭', '남', 'LKS9616', 'lks609591@gmail.com', 'ENFJ', 2),
       (null, '전유안', '남', 'euuuuuuan', 'euan.may24@gmail.com', 'ENFJ', 4),
       (null, '박성은', '여', 'seongeun223', 'jklun080921@gmail.com', 'ENFJ', 2),
       (null, '박하얀', '여', 'parkhayarn', 's0224y92@gmail.com', 'ENFJ', 2),
       (null, '위성민', '남', 'wdh970616', 'wdh970616@naver.com', 'ENFJ', 1),
       (null, '박효찬', '남', 'qwes5674', 'qwes5674@gmail.com', 'ENFJ', 2),
       (null, '이의정', '여', 'himisterlee', 'lejlej100418@gmail.com', 'ENFJ', 2),
       (null, '권은혜', '여', 'dmsgpk237', 'a01027947353@gmail.com', 'ENFJ', 2),
       (null, '권보현', '여', 'Kwonbohyun', 'kwon18923@gmail.com', 'ENFJ', 2),
       (null, '배하은', '여', 'HEun0420', 'usialeta@gmail.com', 'ENFJ', 2),
       (null, '강연진', '여', 'kangyeonjin', 'yeonjin917n.n@gmail.com', 'ENFJ', 5),
       (null, '강진영', '남', 'weed97', 'weed9935@gmail.com', 'ENFJ', 2)
