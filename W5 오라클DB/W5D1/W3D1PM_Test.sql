-- SELECT에 쿼리를 사용하는 방법

SELECT S.STU_NO 
        , STU_NAME
        , AVG(ENR_GRADE) - (SELECT ROUND(AVG(ENR_GRADE), 2) FROM ENROL) 
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY S.STU_NO, STU_NAME
;


SELECT * FROM EMP;

--문제==========================================================================

--1. EMP 테이블에서 이름의 3번째가 R이며 이름의 길이가 6글자인 사원의 정보를 출력하여라

SELECT *
FROM EMP
WHERE SUBSTR(ENAME, 3, 1) = 'R' AND LENGHT(ENAME) =6   --SUBSTR은 문자열의 몇번째가 무슨 글자인지 찾을 때 사용 할 수 있다.
;



--2. 올해 며칠이 지났는지 출력하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하시오.

SELECT TO_DATE(SYSDATE) - TO_DATE('2023-01-01','YYYY-MM-DD') AS 지난날
FROM DUAL
;



--3. DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANALIST'인 사원은 200, 
--   'SALESMAN'인 사원은 180, 'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오

SELECT ENAME, JOB, SAL, DECODE(JOB, 'ANALIST', SAL+200 
                                , 'SALESMAN', SAL+180
                                , 'MANAGER', SAL+150
                                , 'CLERK', SAL+100) AS 급여인상  
FROM EMP
;





--4. 각 부서에 대해 부서번호, 이름, 지역 명, 사원 수, 부서내의 모든 사원의 평균 급여를 출력하시오. 
--   평균 급여는 정수로 반올림 하시오. DECODE 사용

SELECT DEPTNO, DECODE(DEPTNO, '10', 'NAME' 
                        , '20', 'RESERCH'
                        , '30', 'SALES'
                        , '40', 'OPERATIONS') AS 부서이름,
        DECODE(DEPTNO, '10', 'NEW YORK' 
                        , '20', 'DALLAS'
                        , '30', 'CHICAGO'
                        , '40', 'BOSTON') AS 지역명 
        , COUNT(*) AS 사원수, ROUND(AVG(SAL) ,2) AS 평균급여  
FROM EMP
GROUP BY DEPTNO
;



--5. EMP 테이블을 통해 VIEW를 만드시오. (단, COMM이 있으면 O 아니면 X)

CREATE OR REPLACE VIEW EMP_VIEW2
AS (SELECT EMPNO, ENAME, JOB, DEPTNO,
        SAL, NVL2(COMM, 'O', 'X') AS COMM
FROM EMP);

SELECT * FROM EMP_VIEW2;


SELECT * FROM EMP;
SELECT * FROM DEPT;


--6. 부서별 각 년도에 입사한 사람의 수 구하기

SELECT DEPTNO AS 부서, TO_CHAR(HIREDATE, 'YYYY') AS 년도별, COUNT(*) AS 사원수
FROM EMP
GROUP BY DEPTNO, TO_CHAR(HIREDATE, 'YYYY')
ORDER BY DEPTNO ASC
;





--7. 커미션 받는 사람의 수와 받지 못하는 사람의 수를 O,X로 구분하여 구하기

SELECT  NVL2(COMM, 'O', 'X') AS 커미션받는사람, COUNT(*) CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X') 
;




--8. 각 년도별 입사한 사람들의 최고 급여와 최저 급여, 평균 급여, 인원수 구하기

SELECT TO_CHAR(HIREDATE, 'YYYY') AS 년도별, MAX(SAL) AS 최고급여, MIN(SAL) AS 최저급여, ROUND(AVG(SAL),2) AS 평균급여, COUNT(*) AS 사원수
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
;



















