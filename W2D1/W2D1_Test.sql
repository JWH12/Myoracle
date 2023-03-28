


--셀프조인 예제 사수의 이름 출력 --------------------------------------------------------- 
SELECT E.*, E2.ENAME AS 사수
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO; -- 출력값이 같은 테이블의 연계성을 가졌을 때는 셀프조인을 사용한다





--1번 급여가 많은 순으로 출력 --------------------------------------------------------- 
SELECT *
FROM EMP
ORDER BY SAL DESC; --ASC 오름차순, DESC 내림차순





--2번 각 부서의 사람 수 구하기 --------------------------------------------------------- 
SELECT COUNT(*), DEPTNO
FROM EMP
GROUP BY DEPTNO
;



--3번 SALESMAN의 평균 급여 구하기 --------------------------------------------------------- 

SELECT AVG(SAL)
FROM EMP
WHERE JOB = 'SALESMAN'
;




--4번 커미션(COMM)을 받는 사람의 수 구하기 ---------------------------------------------------------

SELECT COUNT(COMM)
FROM EMP
WHERE COMM IS NOT NULL
;



--5번 커미션(COMM)을 받는 사람들의 평균 구하기 ---------------------------------------------------------

SELECT ROUND(AVG(COMM),2)
FROM EMP
WHERE COMM IS NOT NULL
;



--6번 출력 ---------------------------------------------------------

SELECT *
FROM EMP
WHERE EMPNO LIKE '77%'
;




--7번 부서 인원이 가장 적은 곳의 위치 구하기 ---------------------------------------------------------

SELECT *
FROM (
        SELECT COUNT(*) AS 사원수, D.DEPTNO, D.LOC
        FROM EMP E
        INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
        GROUP BY D.DEPTNO, D.LOC
        ORDER BY 사원수 ASC
    ) WHERE ROWNUM = 1
    ;


--7번 다른 예제
SELECT COUNT(EMPNO)AS EC, E.DEPTNO, LOC
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, LOC
ORDER BY EC ASC
;


--8번 출력 ---------------------------------------------------------

SELECT E.*, E2.ENAME AS 사수
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO
WHERE E2.ENAME = 'BLAKE'
;



--9번 출력 ---------------------------------------------------------

SELECT E.*, E2.ENAME AS 사수
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO
WHERE E2.ENAME = 'KING'
;



--10번 SALESMAN이 가장 많은 부서의 지역구하기 ---------------------------------------------------------

SELECT COUNT(*), D.DEPTNO, LOC
        FROM EMP E
        INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
        WHERE E.JOB = 'SALESMAN'
        GROUP BY D.DEPTNO, LOC
;



--11번 전체 평균보다 급여를 더 많이 받는 직원 출력 ---------------------------------------------------------

SELECT *
FROM EMP
WHERE SAL > (
            SELECT ROUND(AVG(SAL),2)
            FROM EMP
        )
;

--서브쿼리
SELECT ROUND(AVG(SAL),2)
FROM EMP
;



--12번 부서 평균 급여가 가장 적은 곳의 위치 구하기.

SELECT *
FROM (
    SELECT AVG(SAL) SAVG , DEPTNO
    FROM EMP 
    GROUP BY DEPTNO
    ORDER BY SAVG ASC
    ) A
INNER JOIN DEPT D ON A.DEPTNO = D.DEPTNO
WHERE ROWNUM = 1;






--13번 각 사람들의 급여 등급

SELECT E.*, S.GRADE
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL  -- LOSAL값과 HISAL 사이에 포함 된 값들을 출력한다. // JOIN은 이처럼 조건형으로 값을 출력 할 수 있다.  
;




-----------------------------------------------------------------------------------------------------------------------------------------
-- 컬럼을 조회 할 때 자바의 IF문처럼 조건을 줘서 값을 출력하는 법
-- DECODE

SELECT STU_NAME, DECODE(STU_GENDER, 'M', '남자', 'F', '여자', '기타' ) AS 성별       -- DECODE(컬럼, 조건(if), 출력값, 조건(else if), '출력값', 조건(else = 앞의 두개의 조건에 해당이 안될 시 출력))
FROM STUDENT;

SELECT ENAME, DEPTNO,DECODE (DEPTNO, '10', 'NEW YORK' 
                            , '20', 'DALLAS'
                            , '30', 'CHICAGO' 
                            , '40', 'BOSTON'
                            , 'NOE' ) AS 지역
FROM EMP;


SELECT * FROM DEPT;
SELECT * FROM EMP;



-- CASE ~ WHEN ~ THAN ~ END 순으로 사용한다. 
-- JAVA의 SWICH ~ CAS문과 IF문 사이의 기능을 운용한다. -------------------------


SELECT CASE WHEN STU_GENDER = 'M' THEN '남자'     -- WHEN뒤에 조건이 들어가고 THEN뒤가 결과 값이다
            WHEN STU_GENDER = 'F' THEN '여자'
            ELSE '몰라'                           -- JAVA IF문의 ELSE와 같이 추가 조건값을 넣어 줄 수 있다.
            END AS GENDER                        -- END로 마무리를 해줘야 한다.    
            , STU_NAME
FROM STUDENT;




-------오후 수업---------------------------------------------------------------------------------------------------------------

--DECODE 문제 EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 출력하라
-- 레코드 하나로 출력

SELECT  
    SUM(DECODE(DEPTNO, 10, 1)) AS DEPT10,     -- 10의 값을 가진 값이 나올 때 마다 1씩 더한 것
    SUM(DECODE(DEPTNO, 30, 1)) AS DEPT30
FROM EMP
;

SELECT  
    COUNT(DECODE(DEPTNO, 10, 1)) AS DEPT10,     -- 10의 값을 가진 값의 개수를 구한 것이기 때문에 조건에 있는 값이 무엇이든지 개수만 샌다
    COUNT(DECODE(DEPTNO, 30, 1)) AS DEPT30
FROM EMP
;

SELECT * FROM EMP;
SELECT * FROM DEPT;




--1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력하라---------------------------------------------
SELECT COUNT(*), DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 4;                                    --HAVING : WHERE를 이용한 서브쿼리 없이 그룹함수에 조건을 줄 수 있는 방법




--2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하라---------------------------------------------

SELECT COUNT(*) , E.DEPTNO
FROM EMP E 
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO
HAVING COUNT(*) = (                                       -- HAVING은 별칭이 안들어가기 때문에 그룹함수를 사용해야 한다.
            SELECT MAX(COUNT(*))
            FROM EMP
            GROUP BY DEPTNO
            )
;

SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

--1. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력하라---------------------------------------------

SELECT COUNT(*) AS 사원수 , MGR 
FROM EMP 
HAVING COUNT(*) = (
               SELECT MAX(COUNT(*))
               FROM EMP
               GROUP BY MGR
            )GROUP BY MGR
;




--2. EMP 테이블에서 사원번호가 7521인 사원의 직업과 같고 사원번호가 7934인 사원의급여(SAL)보다 많은 사원의 사원번호, 이름, 직업, 급여를 출력하라. ---------------------------------------------

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = (
    SELECT JOB FROM EMP
    WHERE EMPNO = 7521
    )
    AND SAL >
    (
    SELECT SAL FROM EMP
    WHERE EMPNO = 7934
    )
    
;



--3. 직업(JOB)별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명을 출력하라.---------------------------------------------

SELECT DEPTNO, ENAME, JOB, SAL, EMPNO
FROM EMP
WHERE (JOB, SAL) IN     --서브쿼리 두개이상을 비교할 떄 사용한다.
        (SELECT JOB, MIN(SAL)
         FROM EMP
         GROUP BY JOB)
ORDER BY JOB;         




--4. 각 사원 별 커미션이 0 또는 NULL이고 부서위치가 ‘GO’로 끝나는 사원의 정보를 사원번호, 사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하라. ---------------------------------------------
-- 조건1. 보너스가 NULL이면 0으로 출력

SELECT E.EMPNO, ENAME, DECODE(E.COMM, NULL, 0) COMM, E.DEPTNO, D.DNAME, LOC     --DECODE E.CMMM의 값이 NULL일 때 0으로 출력해라
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE (E.COMM = 0 OR E.COMM IS NULL) AND LOC LIKE '%GO' 
;



--5. 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하라. ---------------------------------------------

SELECT DEPTNO, (CASE WHEN (AVG(SAL) > 2000) THEN '초과' ELSE '미만' END) AS 평균값 
FROM EMP
GROUP BY DEPTNO ;




--특정 요소를 문자열로 나타내주는 함수들

SELECT NVL(COMM, 0)         --NULL 값을 0으로 바꾸는 함수
FROM EMP;

SELECT SYSDATE             --현재 날짜를 알려주는 함수
FROM DUAL;



SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH24:MI:SS')       -- 원하는 문자열로 출력하게 해주는 함수 // HH24로 기입하면 시간이 24시로 표현된다
FROM DUAL;



SELECT TO_CHAR(123.456, 'FM9999.9')             -- 'FM 999.99'은 0와9만 사용하여 원하는 소수점까지의 값을 불려올 때 사용한다. 또한 소수점에서 반올림을 하여 출력한다.
FROM DUAL;                                      -- 9는 해당 위치에 맞는 값이 없다면 표시를 하지 않는다.               



SELECT TO_CHAR(123.456, 'FM0999.99')            -- 0은 해당 위치에 값이 없으면 0으로 채워서 출력한다. 
FROM DUAL;  



SELECT TO_CHAR(1000000, 'FML999,999,999')     -- ,를 찍으면 원화로 표현이 가능하다 / FM뒤에 L을 적으면 원화표시가 적용된다.
FROM DUAL;  



SELECT TO_CHAR(SYSDATE, 'FMMM/DD')             -- 날짜 앞에 FM을 붙이면 0이 사라진다         
FROM DUAL;  



SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') AS 날짜, TO_CHAR(SYSDATE, 'HH24"시" MI"분" SS"초"') AS 시간     -- 문자열은 ""을 사용해야 한다.
FROM DUAL;



SELECT TO_CHAR(SYSDATE, 'AM')
              , (SYSDATE, 'D'),   -- 1(일) ~ 7(토)
              , (SYSDATE, 'DY')
              , (SYSDATE, 'DAY')
              , (SYSDATE, 'DDD') 
              , (SYSDATE, 'WW') --1년 기준 30주, 몇주지났는지
              , (SYSDATE, 'MON') -- 몇월인지 알려준다
FROM DUAL;



--TO_CHAR 문제----------------------------------

--1번----------------------------------------------------------
SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;



SELECT 
        D.DEPTNO, D.DNAME,
        COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1980', 1)) AS "입사 1980"
      , COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1981', 1)) AS "입사 1981"
      , COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1982', 1)) AS "입사 1982"
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
GROUP BY D.DEPTNO, D.DNAME
;




SELECT E.EMPNO, ENAME, DECODE(E.COMM, NULL, 0) COMM, E.DEPTNO, D.DNAME, LOC     --DECODE E.CMMM의 값이 NULL일 때 0으로 출력해라
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE (E.COMM = 0 OR E.COMM IS NULL) AND LOC LIKE '%GO';


SELECT  
    COUNT(DECODE(DEPTNO, 10, 1)) AS DEPT10,     -- 10의 값을 가진 값의 개수를 구한 것이기 때문에 조건에 있는 값이 무엇이든지 개수만 샌다
    COUNT(DECODE(DEPTNO, 30, 1)) AS DEPT30
FROM EMP
;



