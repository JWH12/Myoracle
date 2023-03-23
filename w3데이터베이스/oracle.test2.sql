/*
CREATE TABLE student (
  stu_no char(9)PRIMARY KEY,
  stu_name varchar(12),
  stu_dept varchar(20),
  stu_grade NUMBER ,
  stu_class char(1) ,
  stu_gender char(1) ,
  stu_height NUMBER ,
  stu_weight NUMBER
 
);

CREATE TABLE subject (
  sub_no char(3) PRIMARY KEY,
  sub_name varchar(30) ,
  sub_prof varchar(12) ,
  sub_grade NUMBER ,
  sub_dept varchar(20) 
) ;

CREATE TABLE enrol (
  sub_no char(3) REFERENCES subject(sub_no),
  stu_no char(9) REFERENCES student(stu_no),
  enr_grade NUMBER 
);
INSERT INTO STUDENT VALUES(20153075,'옥한빛','기계',1,'C','M',177,80);
INSERT INTO STUDENT VALUES(20153088,'이태연','기계',1,'C','F',162,50);
INSERT INTO STUDENT VALUES(20143054,'유가인','기계',2,'C','F',154,47);
INSERT INTO STUDENT VALUES(20152088,'조민우','전기전자',1,'C','M',188,90);
INSERT INTO STUDENT VALUES(20142021,'심수정','전기전자',2,'A','F',168,45);
INSERT INTO STUDENT VALUES(20132003,'박희철','전기전자',3,'B','M',NULL,63);
INSERT INTO STUDENT VALUES(20151062,'김인중','컴퓨터정보',1,'B','M',166,67);
INSERT INTO STUDENT VALUES(20141007,'진현무','컴퓨터정보',2,'A','M',174,64);
INSERT INTO STUDENT VALUES(20131001,'김종헌','컴퓨터정보',3,'C','M',NULL,72);
INSERT INTO STUDENT VALUES(20131025,'옥성우','컴퓨터정보',3,'A','F',172,63);
INSERT INTO SUBJECT VALUES('111', '데이터베이스', '이재영',2,'컴퓨터정보');
INSERT INTO SUBJECT VALUES('110', '자동제어','정순정',2,'전기전자');
INSERT INTO SUBJECT VALUES('109', '자동화설계','박민영',3,'기계');
INSERT INTO SUBJECT VALUES('101', '컴퓨터개론','강종영',3,'컴퓨터정보');
INSERT INTO SUBJECT VALUES('102', '기계공작법','김태영',1,'기계');
INSERT INTO SUBJECT VALUES('103', '기초전자실험','김유석',1,'전기전자');
INSERT INTO SUBJECT VALUES('104', '시스템분석설계','강석현',3,'컴퓨터정보');
INSERT INTO SUBJECT VALUES('105', '기계요소설계','김명성',1,'기계');
INSERT INTO SUBJECT VALUES('106', '전자회로실험','최영민',3,'전기전자');
INSERT INTO SUBJECT VALUES('107', 'CAD응용실습','구봉규',2,'기계');
INSERT INTO SUBJECT VALUES('108', '소프트웨어공학','권민성',1,'컴퓨터정보');
INSERT INTO ENROL VALUES('101', '20131001', 80);
INSERT INTO ENROL VALUES('104', '20131001', 56);
INSERT INTO ENROL VALUES('106', '20132003', 72);
INSERT INTO ENROL VALUES('103', '20152088', 45);
INSERT INTO ENROL VALUES('101', '20131025', 65);
INSERT INTO ENROL VALUES('104', '20131025', 65);
INSERT INTO ENROL VALUES('108', '20151062', 81);
INSERT INTO ENROL VALUES('107', '20143054', 41);
INSERT INTO ENROL VALUES('102', '20153075', 66);
INSERT INTO ENROL VALUES('105', '20153075', 56);
INSERT INTO ENROL VALUES('102', '20153088', 61);
INSERT INTO ENROL VALUES('105', '20153088', 78);  */

/*
SELECT * FROM STUDENT; -- 학생 정보

SELECT * FROM ENROL;   -- 과목번호 학번 및 성적

SELECT * FROM Subject;  -- 과목명 및 관련 정보  */



--1번문제 -------------------------------------------------------
SELECT COUNT(stu_height)FROM STUDENT 
WHERE stu_height >= 180;


--2번문제 -------------------------------------------------------
SELECT * FROM STUDENT 
WHERE stu_dept LIKE '전기전자' AND stu_weight >= 50;

--3번문제 X-------------------------------------------------------
UPDATE STUDENT
SET 
    STU_HEIGHT = STU_HEIGHT+1
WHERE STU_DEPT = '컴퓨터정보' AND STU_HEIGHT IS NOT NULL;

--4번문제 X-------------------------------------------------------
SELECT AVG(ENR_GRADE) AS 평균, STU_NO 
FROM ENROL 
GROUP BY STU_NO 
ORDER BY 평균 DESC;


--5번문제 X-------------------------------------------------------
SELECT MAX(ENR_GRADE) AS 최고점수, SUB_NO
FROM ENROL 
GROUP BY SUB_NO
ORDER BY SUB_NO;


--6번문제 -------------------------------------------------------
SELECT * FROM Subject 
WHERE sub_NAME LIKE '%설계%';


--7번문제 X-------------------------------------------------------
SELECT AVG(STU_HEIGHT), STU_GRADE, STU_GENDER FROM STUDENT 
WHERE STU_GRADE = 2 AND STU_GENDER ='M'
GROUP BY STU_GRADE, STU_GENDER;




--INNER JOIN을 통하여 3개의 테이블을 연결하는 코드 // 학생들의 성적 테이블을 작성 한 것
SELECT E.*, S.STU_NAME, S2.SUB_NAME
FROM ENROL E
INNER JOIN STUDENT S ON S.stu_no = E.STU_NO 
INNER JOIN SUBJECT S2 ON S2.SUB_NO = E.SUB_NO;

--학생들의 성적 테이블을 작성 한 것 => 컴퓨터정보 학과 학생들만 출력
SELECT E.*, S.STU_NAME, S.STU_DEPT, S2.SUB_NAME 
FROM ENROL E
INNER JOIN STUDENT S ON S.stu_no = E.STU_NO 
INNER JOIN SUBJECT S2 ON S2.SUB_NO = E.SUB_NO
WHERE S.STU_DEPT LIKE '컴퓨터정보';



-- 서브 쿼리 : 쿼리 안에 다른 쿼리가 들어가는 것
-- 점수가 전체 평균보다 높은 점수를 받은 목록을 출력 
SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
WHERE E.ENR_GRADE >(SELECT AVG(ENR_GRADE)FROM ENROL); -- 서브쿼리를 추가하는 방법


SELECT AVG(ENR_GRADE)
FROM ENROL; 



-- 구한 값에 평균 값을 추가로 출력하는 방법
SELECT stu_NAME, ENR_GRADE, ROUND(AVG_ALL, 2)AS 평균             -- ROUND (테이블 ,2) 소숫점을 원하는 자리까지 출력하는 방법 / 별칭을 띄어쓰려면 ""를 사용하여 사용 할 것
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO                       
INNER JOIN
 (SELECT AVG(ENR_GRADE)AVG_ALL FROM ENROL)                    --서브 쿼리로 들어간 평균을 구한 값도 테이블이기 때문에 INNER JOIN을 사용 할 수 있다.
 A ON E.ENR_GRADE > A.AVG_ALL;                                 -- 서브쿼리를 INNER JOIN으로 사용할 때는 ()를 사용해야 한다.


--(서브쿼리) 전체평균을 구한 값
SELECT AVG(ENR_GRADE)
FROM ENROL; 




--서브쿼리 문제------------------------------------------------------------------

--1번--------------------------------
SELECT S.STU_NAME, S.STU_NO, S.STU_HEIGHT
FROM STUDENT S
INNER JOIN (SELECT AVG(STU_HEIGHT)AVG_ALL FROM STUDENT) A
ON S.STU_HEIGHT > A.AVG_ALL ;                                                  -- 서브쿼리와 메인 쿼리를 비교할 때는 서브쿼리에 여러 값을 넣으면 오류가 난다. 

--서브쿼리
SELECT AVG(STU_HEIGHT)
FROM STUDENT;




--2번----------------------------

SELECT S.STU_NAME, S.STU_DEPT, SUB.SUB_NAME, E.ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON E.SUB_NO = SUB.SUB_NO
INNER JOIN (SELECT AVG(ENR_GRADE)AVG_ALL FROM ENROL) A
ON E.ENR_GRADE > A.AVG_ALL

WHERE STU_DEPT LIKE '컴퓨터정보' ;

--서브쿼리
SELECT AVG(ENR_GRADE)
FROM ENROL;




--3번------------------------------- 

SELECT S.STU_NAME, S.STU_DEPT, S.STU_HEIGHT, ROUND(AVG_DEPT, 2) AS 학과평균
FROM STUDENT S
INNER JOIN (
    SELECT AVG(STU_HEIGHT) AS AVG_DEPT, STU_DEPT
    FROM STUDENT
    GROUP BY STU_DEPT
) A ON S.STU_DEPT = A.STU_DEPT
WHERE S.STU_HEIGHT > A.AVG_DEPT;


--서브쿼리
SELECT AVG(STU_HEIGHT)
FROM STUDENT
GROUP BY STU_EDPT;





--DB2 문제======================================================================================================================================================================

--1번 학생번호, 이름, 과목명, 점수 출력--------------------------------

SELECT S.STU_NO, S.STU_NAME, SUB_NAME, ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON E.STU_NO = S.STU_NO  
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO  
;




--2번 점수가 70점 이상인 학생들의 이름 출력---------------------------------

SELECT S.STU_NAME, E.ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON E.STU_NO = S.STU_NO
INNER JOIN (SELECT AVG(ENR_GRADE)AVG_ALL FROM enrol )A
ON  E.ENR_GRADE > A.AVG_ALL
WHERE ENR_GRADE >= 70
;


--서브쿼리
SELECT AVG(ENR_GRADE)
FROM enrol;





--3번 김인중 학생이 수강하는 과목과 해당 교수 출력--------------------------------------------------

SELECT S.STU_NAME, SUB.SUB_NAME, SUB.SUB_PROF
FROM STUDENT S
INNER JOIN ENROL E ON E.STU_NO = S.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO
WHERE S.STU_NAME LIKE '김인중'
;






--4번 컴퓨터개론 수업을 듣는 학생의 학번,  이름 출력-----------------------------------------------

SELECT S.STU_NAME, S.STU_NO, SUB.SUB_NAME
FROM STUDENT S
INNER JOIN ENROL E ON E.STU_NO = S.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO
WHERE SUB.SUB_NAME LIKE '컴퓨터개론'
;






--5번 기계공작법, 기초전자실험 수업을 듣는 학생의 학번, 이름, 과목명 출력----------------------------------------------

SELECT S.STU_NAME, S.STU_NO, SUB.SUB_NAME
FROM STUDENT S
INNER JOIN ENROL E ON E.STU_NO = S.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO
WHERE SUB.SUB_NAME LIKE '기계공작법' OR SUB.SUB_NAME LIKE '기초전자실험'
--WHERE SUB.SUB_NAME IN ('기계공작벅', '기초전자실험') -- IN을 사용하여 출력을 더 많이 사용한다  // NOT IN ()은 괄호안에 포함되지 않은 값을 출력한다
;






--6번 여자이면서 구봉규 교수의 수업을 듣는 학생 출력------------------------------------------------
SELECT S.STU_NAME, SUB.SUB_PROF, SUB.SUB_NAME
FROM STUDENT S
INNER JOIN ENROL E ON E.STU_NO = S.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO
WHERE S.STU_GENDER = 'F' AND sub.sub_prof = '구봉규'
;






--7번 김인중의 과목 평균 점수보다 낮은 학생들의 이름, 점수 출력, 단 점수가 높은 순서대로. ------------------------------------------------

SELECT S.STU_NAME, E.ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON E.STU_NO = S.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO
INNER JOIN (SELECT AVG(ENR_GRADE)AVG_KIM
            FROM ENROL E
            INNER JOIN STUDENT S ON S.STU_NO = E.STU_NO
            WHERE STU_NAME LIKE '김인중')A
            ON E.ENR_GRADE < A.AVG_KIM

ORDER BY E.ENR_GRADE DESC
;

--서브쿼리---
SELECT AVG(ENR_GRADE)
FROM ENROL E
INNER JOIN STUDENT S ON S.STU_NO = E.STU_NO
WHERE STU_NAME LIKE '김인중' 
;

  
  
  
  
--8번 두 과목 이상을 수강한 학생(enrol에 2개이상 데이터 있는)들의 학번, 이름, 과목명, 점수 출력 -----------------------------------------------  
  
SELECT S.STU_NO, STU_NAME, STU_DEPT, ENR_GRADE
FROM STUDENT S 
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO
WHERE S.STU_NO IN (                                                            -- in()을 사용하면 특정값들을 설정하여 확인이 가능하다.                                         
    SELECT STU_NO
    FROM (                                                                     --서브쿼리도 테이블이기 떄문에 FROM절 뒤에 올 수 있다. 이렇게 되면 CNT가 컬럼이 되어 조건을 수용 할 수 있게 된다.
        SELECT COUNT(*) AS CNT, STU_NO 
        FROM ENROL  
        GROUP BY STU_NO
    ) T
    WHERE T.CNT > 1
)
ORDER BY STU_NAME;



--서브쿼리
SELECT COUNT(*) AS CNT, STU_NO 
FROM ENROL  
GROUP BY STU_NO
;




-- 9. 각 학과의 평균점수 중 가장 높은 점수보다 높은 점수를 받은 학생의 정보 출력 ---------------------------------------------

SELECT * 
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN (SELECT MAX(AVG_DEPT) AS AVG_MAX
            FROM ( 
                SELECT AVG(ENR_GRADE) AS AVG_DEPT
                FROM STUDENT S
                INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
                GROUP BY STU_DEPT)
            ) A ON E.ENR_GRADE > A.AVG_MAX;


--9. ALL 사용 법
SELECT * 
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
WHERE E.ENR_GRADE > ALL(            --ALL을 사용하면 괄호안에 있는 서브쿼리와 비교하여 WHERE E.ENR_GRADE > 조건에 맞는 값만 출력한다.
    SELECT AVG(ENR_GRADE)
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY STU_DEPT



























