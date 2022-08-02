delete from department;
delete from student where s_id=22001001;
delete from personal where p_id='p2001001';
delete from ssubject where sub_name ='범죄와인권';
delete from post;
delete from application;
delete from application where s_id=22001001 and sub_code='S0036';

select * from application;
select * from ssubject;
select * from department;
select * from student;
select * from personal;
select * from post;
select * from notice;
select * from exam1;
select * from exam2;
select * from answer;
select s_name, s_id from student where s_regNumber1=200101 and s_regNumber2=1111111;
select * from student where s_id=22001001;
select * from application;
select * from lecture;

select * from ssubject where sub_name in(select sub_name from application where s_id=22001001);
select count(*) from application where sub_code='S0011' and s_id=22001001;

update student set s_max=0 where s_id=22001001;
update ssubject set sub_max=0 where sub_name='범죄와인권';
update ssubject set sub_max=30 where sub_name='범죄와인권';
update ssubject set sub_classtime='11,12,13' where sub_name='범죄와인권';

/*1 : 학과 - 학과명, 학과코드*/
insert into department values('법학과', '001');
insert into department values('의예과', '002');
insert into department values('간호학과','003');
insert into department values( '전기과', '004');
insert into department values( '전자과','005');

/*2 : 학생 - 학번,이름,주민번호1,주민번호2,비밀번호,단과대,학과명,총학점,학적,학년,연락처,이메일,은행,계좌1,계좌2,최대학점*/
insert into student values(22001001,'가가가','200101','1111111',null,'법대','법학과',null,'재학',1,'경상남도 창원시','01000000000','abcd@naver.com','농협','11111111111','가가가',null);
insert into student values(22002001,'나나나','200102','1111112',null,'의대','의예과',null,'재학',1,null,'01011111111',null,null,null,null,null);
insert into student values(22003001,'다다다','200103','1111113',null,'간호대','간호학과',null,'재학',1,null,'01011112222',null,null,null,null,null);
insert into student values(22004001,'라라라','200104','1111114',null,'공대','전기과',null,'재학',1,null,'01011113333',null,null,null,null,null);
insert into student values(22005001,'마마마','200105','1111115',null,'공대','전자과',null,'재학',1,null,'01011114444',null,null,null,null,null);

/*3:교직원-직번,이름,주민번호1,주민번호2,비밀번호,단과대,학과 및 부서,전공,사무실,전화번호,이메일*/
insert into personal values ('p2001001','배영애','720101','2222222',null,'법대','법학과','법학','505호','00111110000','pesonal1@email.com');
insert into personal values ('p1102010','박형생','771211','1920221',null,'의대','의예과','의예','401호','00111112222','pesonal2@email.com');
insert into personal values ('p1103010','박문숙','801001','2500001',null,'간호대','간호학과','간호','205호','00111113333','pesonal3@email.com');
insert into personal values ('p2004020','김영','820204','2855262',null,'공대','전기과','전기','105호','00000004444','personal4@email.com');
insert into personal values ('p9005001','김수안','680514','1755362',null,'공대','전자과','전자','101호','00000005555','personal5@email.com');

/*5:과목테이블 - 과목명, 과목코드, 이수구분, 학점(시수), 담당교수이름, 담당교수직번, 강의요일, 강의시간, 수업일수, 학과명,강의실,수업시간*/			
insert into ssubject values('범죄와인권', 'S0011', '전필', '3', '배영애', 'p2001001', '월요일', 9, 32, '법학과',11101,'9,10,11',30);
insert into ssubject values('형법각론', 'S0012', '전필', '3', '배영애', 'p2001001', '월요일', 12, 32, '법학과',11102,'12,13,14',30);
insert into ssubject values('행정법총론', 'S0013', '전선', '3', '배영애', 'p2001001', '화요일', 9, 33, '법학과',12101,'9,10,11',30);
insert into ssubject values('특별형사법', 'S0014', '전필', '3', '배영애', 'p2001001', '화요일', 15, 29, '법학과',12102,'15,16,17',30);
insert into ssubject values('법사학', 'S0015', '전선', '3', '배영애', 'p2001001', '수요일', 12, 32, '법학과',13104,'12,13,14',30);
insert into ssubject values('형사소송법', 'S0016', '전필', '3', '배영애', 'p2001001', '금요일', 15, 30, '법학과',14107,'15,16,17',30);

insert into ssubject values('생물학', 'S0021', '전필', '3', '박형생', 'p1102010', '월요일', 9, 32, '의예과',21208,'9,10,11',30);
insert into ssubject values('해부학', 'S0022', '전필', '3', '박형생', 'p1102010', '월요일', 15, 32, '의예과',21101,'15,16,17',30);
insert into ssubject values('생리학', 'S0023', '전선', '3', '박형생', 'p1102010', '화요일', 12, 33, '의예과',21101,'12,13,14',30);
insert into ssubject values('병리학', 'S0024', '전필', '3', '박형생', 'p1102010', '수요일', 12, 29, '의예과',22105,'12,13,14',30);
insert into ssubject values('생화학', 'S0025', '전선', '3', '박형생', 'p1102010', '목요일', 12, 32, '의예과',23105,'12,13,14',30);
insert into ssubject values('미생물학', 'S0026', '전필', '3', '박형생', 'p1102010', '금요일', 15, 30, '의예과',21208,'15,16,17',30);

insert into ssubject values('간호학개론', 'S0031', '전필', '3', '박문숙', 'p1103010', '월요일', 9, 32, '간호학과',31101,'9,10,11',30);
insert into ssubject values('생명윤리학', 'S0032', '전필', '3', '박문숙', 'p1103010', '월요일', 15, 32, '간호학과',31102,'15,16,17',30);
insert into ssubject values('의학용어', 'S0033', '전선', '3', '박문숙', 'p1103010', '화요일', 12, 33, '간호학과',31103,'12,13,14',30);
insert into ssubject values('인체구조와기능', 'S0034', '전필', '3', '박문숙', 'p1103010', '수요일', 12, 29, '간호학과',31104,'12,13,14',30);
insert into ssubject values('기본간호학', 'S0035', '전선', '3', '박문숙', 'p1103010', '목요일', 12, 32, '간호학과',31105,'12,13,14',30);
insert into ssubject values('기본간호학실습', 'S0036', '전필', '3', '박문숙', 'p1103010', '금요일', 15, 30, '간호학과',31106,'15,16,17',30);

insert into ssubject values('전기전자물성', 'S0041', '전필', '3', '김영', 'p2004020', '월요일', 9, 32, '전기과',41101,'9,10,11',30);
insert into ssubject values('전기전자계측', 'S0042', '전필', '3', '김영', 'p2004020', '월요일', 15, 32, '전기과',42101,'15,16,17',30);
insert into ssubject values('반도체소자', 'S0043', '전선', '3', '김영', 'p2004020', '화요일', 12, 33, '전기과',42103,'12,13,14',30);
insert into ssubject values('전자디스플레이', 'S0044', '전필', '3', '김영', 'p2004020', '수요일', 12, 29, '전기과',43101,'12,13,14',30);
insert into ssubject values('전력전자공학', 'S0045', '전선', '3', '김영', 'p2004020', '목요일', 12, 32, '전기과',44101,'12,13,14',30);
insert into ssubject values('집적회로설계', 'S0046', '전필', '3', '김영', 'p2004020', '금요일', 15, 30, '전기과',44102,'15,16,17',30);

insert into ssubject values('전자기학', 'S0051', '전필', '3', '김수안', 'p9005001', '월요일', 9, 32, '전자과',51101,'9,10,11',30);
insert into ssubject values('회로이론', 'S0052', '전필', '3', '김수안', 'p9005001', '월요일', 15, 32, '전자과',51102,'15,16,17',30);
insert into ssubject values('반도체물리전자', 'S0053', '전선', '3', '김수안', 'p9005001', '화요일', 12, 33, '전자과',51103,'12,13,14',30);
insert into ssubject values('전자시스템', 'S0054', '전필', '3', '김수안', 'p9005001', '수요일', 12, 29, '전자과',51104,'12,13,14',30);
insert into ssubject values('제어공학', 'S0055', '전선', '3', '김수안', 'p9005001', '목요일', 12, 32, '전자과',51105,'12,13,14',30);
insert into ssubject values('마이크로파공학', 'S0056', '전필', '3', '김수안', 'p9005001', '금요일', 15, 30, '전자과',51106,'15,16,17',30);	
			

/*10:과목별게시판 테이블 - 글번호, 글제목, 등록일, 과목명, 연락처, 글내용, 작성자(교직원), 직번*/

/*11:수강신청테이블 - 학번, 과목이름, 과목코드*/
insert into application(s_id, sub_name, sub_code) values(22001001,'마이크로파공학', 'S0056');