SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

SELECT * FROM T_PRODUCT;
SELECT * FROM T_PIMAGE;
SELECT * FROM T_CODE;

--ORACLE JOIN=======================================================================================================================
-- ORACLE DB에서만 사용이 가능한 ORACLE INNER JOIN다.
-- ORACLE JOIN에서 WHERE 조건을 입력 안하면 CROSS JOIN이 된다.

SELECT * 
FROM STUDENT S, ENROL E                                        -- 두개 이상의 테이블을 연결 할 때 ORACLE JOIN의 경우 FROM절에 입력을 한다.
WHERE S.STU_NO = E.STU_NO AND STU_DEPT = '컴퓨터정보';          -- ORACLE JOIN은 INNER JOIN과 다르게 WHERE에 AND를 이용하여 여러조건들을 넣는다. 


--예제 1=========
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--예제 2 LEFT JOIN=========

SELECT * 
FROM T_PRODUCT P, T_PIMAGE I
WHERE P.P_ID = I.P_ID(+);                                    -- WHERE 조건에 (+)를 붙이면 ORACLE JOIN에서의 LEFT JOIN이다. 

--예제 3 LEFT JOIN=========

SELECT * 
FROM T_PRODUCT P, T_CODE C
WHERE P.KIND = C.CODE(+) AND C.KIND = 'CLOTH';      

--예제 4 CROSS JOIN=========

SELECT * 
FROM EMP E
CROSS JOIN DEPT D;           -- 조건과 상관없이 가능한 모든 컬럼과 조인을 하여 결과를 보여준다. 즉, 모든 경우의 수의 조인을 한다.


--문제===============================================================
-- 컴퓨터 개론 수업을 듣는 학생들의 평균 점수보다 높은 점수를 가지고 있는 컴퓨터정보학과 학생 출력
-- ORACLE JOIN을 사용 할 떄

SELECT *
FROM STUDENT S, ENROL E
WHERE S.STU_NO = E.STU_NO AND STU_DEPT = '컴퓨터정보'
      AND ENR_GRADE >= (
            SELECT AVG(ENR_GRADE) AS AVG_COM
            FROM ENROL E, SUBJECT S
            WHERE E.SUB_NO = S.SUB_NO AND S.SUB_NAME = '컴퓨터개론'
                )
;

--INNER JOIN을 사용 했을 때

SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
WHERE STU_DEPT = '컴퓨터정보' AND ENR_GRADE > ( 
                      SELECT AVG(ENR_GRADE) AS AVG_COM
                    FROM ENROL E
                    INNER JOIN SUBJECT S ON E.SUB_NO = S.SUB_NO
                    WHERE S.SUB_NAME = '컴퓨터개론'
                    );



--UNION // --UNION ALL  ==================================================================================================================================

-- 두개의 정보를 하나로 합치는 용도이다.
-- 성능적으로 좋지 않지만, 하나의 쿼리에서 실행하지 못하는 경우에 사용한다.
--컬럼의 수가 위와 아래 동일하게 해야하며, 두번째 쿼리는 첫번 째 쿼리에 영향을 받으며 두번째 쿼리는 첫번 째 쿼리에 영향을 주지 않는다.

SELECT STU_NO, STU_NAME   
FROM STUDENT
WHERE STU_HEIGHT >= 170

UNION                       -- 중복된 내용을 제거한 후 위와 아래의 두가지 정보를 합쳐서 출력한다.
--UNION ALL                 -- UNION ALL은 중복제거를 하지 않고 모든 값을 출력한다.

SELECT STU_NO, STU_NAME
FROM STUDENT
WHERE STU_WEIGHT >= 50
;



--문제 1==========================================================================================
-- EMP테이블에서 급여가 1500이상(첫번째 테이블)이거나 혹은 COMM을 받는 사람(두번째 테이블)의 사번, 이름, 직업

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE SAL >= 1500

UNION

SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE COMM IS NOT NULL;



--문제 2==========================================================================================
-- 각 부서의 평균 급여와 전체평균 급여를 출력하라 


SELECT DNAME AS 부서, ROUND(AVG(SAL), 2) AS 평균 
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY DNAME

UNION

SELECT '전체', ROUND(AVG(SAL), 2) -- 첫번째 쿼리의 값을 '전체'로 별칭으로 입력 한 뒤 전체 평균을 구한다. 
FROM EMP 
;


--문제 3==========================================================================================
-- 각 과별로 평균 키,몸무게를 구하는데 학생들 최고 값과 최저값을 구할 것

SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

SELECT STU_DEPT, ROUND(AVG(STU_HEIGHT), 2) AS 평균키, ROUND(AVG(STU_WEIGHT), 2) AS 평균몸무게
FROM STUDENT
GROUP BY STU_DEPT

UNION

SELECT '학생별 최고값', MAX(STU_HEIGHT) , MAX(STU_WEIGHT) 
FROM STUDENT 

UNION

SELECT '학생별 최저값', MIN(STU_HEIGHT), MIN(STU_WEIGHT) 
FROM STUDENT 

UNION

SELECT '전체평균', ROUND(AVG(STU_HEIGHT), 2) ,  ROUND(AVG(STU_WEIGHT), 2)
FROM STUDENT 
;




--MINUS ==================================================================================================================================
-- 위에 테이블을 기준으로 밑에 테이블에서 나오지 않은 데이터들을 제외하고 출력한다.
-- 위에 데이터와 아래 데이터들 비교하여 중복된 값을 제거하고 출력한다.

SELECT STU_NO, STU_NAME
FROM STUDENT
WHERE STU_HEIGHT >= 160

MINUS

SELECT STU_NO, STU_NAME
FROM STUDENT
WHERE STU_GENDER = 'M'
;


--문제 1==========================================================================================
-- EMP 테이블에서 급여가 1000이상인 사람
-- 부서가 10번 부서에 속하지 않고
-- 입사일이 81년도 이후인 사람

SELECT EMPNO, ENAME, HIREDATE, DEPTNO
FROM EMP
WHERE SAL >= 1000

MINUS

SELECT EMPNO, ENAME, HIREDATE, DEPTNO
FROM EMP
WHERE DEPTNO = 10

MINUS

SELECT EMPNO, ENAME, HIREDATE, DEPTNO
FROM EMP
WHERE HIREDATE < TO_DATE('1982', 'YYYY') -- 날짜타입을 비교를 할 때 사용한다.
;



--LISTAGG ==================================================================================================================================
-- LISTAGG(컴럼, ',')은 ,를 기준으로 구분지어서 출력하겠다는 뜻이다.
SELECT 
    LISTAGG (ENAME, ',') AS NAMES
FROM EMP;


-- GROUP BY를 사용하면 정해놓은 그룹별로 정렬을 할 수 있다.
SELECT 
    DEPTNO,
    LISTAGG (ENAME, ',') AS NAMES
FROM EMP
GROUP BY DEPTNO
;


--예제 1===================================================================
-- 학과별로 묶어서 나타내기
SELECT 
    STU_DEPT,
    LISTAGG (STU_NAME, ', ') AS NAMES
FROM STUDENT
GROUP BY STU_DEPT
;


--예제 2===================================================================
-- HTML 옵션으로 줄 때 사용하는 코드

WITH TEMP_TABLE AS (                            -- WITH 테이블 명 AS 을 사용하면 임시테이블을 만들 수 있다   
  SELECT '<HTML>'
      || '  <HEAD>'
      || '    <TITLE>TEST</TITLE>'
      || '  </HEAD>'
      || '  <BODY>'
      || '    <H1>TEST 123</H1>'    
      || '    <H2>TEST 456</H2>' 
      || '  </BODY>'
      || '</HTML>' AS HTML
    FROM DUAL
)

SELECT REGEXP_SUBSTR(HTML, '<H1>.*</H1>') AS TAG  -- *은 전체를 의미하기 때문에 모든 요소를 출력한다.
FROM TEMP_TABLE;



--OVER==================================================================================================================================
--동명이인이 있는지 없는지 확인하는 코드
-- OVER(PARTITION BY 컬럼)은 집계 이후에 한번의 조건을 더 줄 수 있는 코드이다.

WITH TEMP(ENAME, BIRTH, JOB) AS (                               -- WITH 테이블 명(컬럼명) AS 을 사용하면 탈출하는 임시테이블을 만들 수 있다   
  SELECT '홍길동', '1982-01-23', 'SALESMAN' FROM DUAL UNION ALL    --TEMP라는 테이블에 정해진 컬럼에 내용이 들어간다.
  SELECT '유재석', '1987-04-19', 'CLERK'    FROM DUAL UNION ALL
  SELECT '강호동', '1985-12-01', 'SALESMAN' FROM DUAL UNION ALL
  SELECT '유재석', '1986-12-10', 'CLERK'    FROM DUAL UNION ALL
  SELECT '홍길동', '1987-06-02', 'MANAGER'  FROM DUAL
)

SELECT ENAME
    , BIRTH
    , JOB
    , COUNT(DISTINCT BIRTH) OVER(PARTITION BY ENAME) AS CNT     --DISTINCT는 중복제거이다. // OVER(PARTITION BY ENAME)은 동일한 이름을 가진 사람을 생일로 비교하여 중복을 찾아내라는 뜻이다.
FROM TEMP;



--문제 1==========================================================================================
-- 동일한 이름이 있을시 Y로 그렇지 않음녀 N으로 표시하여 나타내기


WITH TEMP(ENAME, BIRTH, JOB) AS (                               -- WITH 테이블 명(컬럼명) AS 을 사용하면 탈출하는 임시테이블을 만들 수 있다   
  SELECT '홍길동', '1982-01-23', 'SALESMAN' FROM DUAL UNION ALL    --TEMP라는 테이블에 정해진 컬럼에 내용이 들어간다.
  SELECT '유재석', '1987-04-19', 'CLERK'    FROM DUAL UNION ALL
  SELECT '강호동', '1985-12-01', 'SALESMAN' FROM DUAL UNION ALL
  SELECT '유재석', '1986-12-10', 'CLERK'    FROM DUAL UNION ALL
  SELECT '홍길동', '1987-06-02', 'MANAGER'  FROM DUAL
)

SELECT ENAME
    , BIRTH
    , JOB
    , DECODE(COUNT(DISTINCT BIRTH) OVER(PARTITION BY ENAME), 1, 'N', 'Y' ) AS CNT     --DECODE를 사용하여 같은 이름이 두개가 있으면 Y 그렇기 않으면 N으로 표시 되게 할 수 있다.
FROM TEMP;





