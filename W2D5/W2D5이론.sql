-- SELECT, UPDATE, INSERT, DELETE
-- JOIN(INNER, LEFT), SELF JOIN

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

-- INNER JOIN ====================================================================================
-- INNER JOIN을 사용하명 같은 값끼리 연결을 해주지만, 상황에 따라서 연결이 안되는 경우가 있다.

SELECT EMPNO AS 사원번호, E.ENAME AS 사원이름, E.DEPTNO AS 부서번호, E.SAL AS 급여, S.GRADE AS 급여등급
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.DEPTNO = 10
;


SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT S2 ON E.SUB_NO = S2.SUB_NO
;


--GROUP BY ====================================================================================

-- 각 부서별 사원수 
SELECT COUNT(*), DEPTNO
FROM EMP
GROUP BY DEPTNO 
;

-- 각 부서별 급여 평균 
SELECT ROUND(AVG(SAL), 2), DEPTNO
FROM EMP
GROUP BY DEPTNO 
;


-- 각 부서별 급여 평균이 가장 높은 부서에서 가장 낮은부서의 차이

SELECT MAX(AVG_SAL) - MIN(AVG_SAL) AS 급여차이
FROM (
      SELECT ROUND(AVG(SAL), 2) AS AVG_SAL , DEPTNO
      FROM EMP
      GROUP BY DEPTNO )
;


-- 각 부서별 전체 평균보다 높은 급여를 받는 사람

SELECT *
FROM EMP
WHERE SAL > (
             SELECT AVG(SAL)
             FROM EMP)
;





-- SELF JOIN ====================================================================================


-- 사번, 이름, 매니저(사수) 이름 출력

SELECT E1.EMPNO, E1.ENAME, E2.ENAME  
FROM EMP E1
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO   -- E1 테이블의 MGR을 기준으로 두번째 E2 테이블의 EMPNO와 비교한다.
;



-- 부하직원이 가장 많은 사람의 이름과 숫자를 출력

SELECT ENAME AS 이름 , C AS 사람수
FROM (
      SELECT COUNT(*) AS C , E2.ENAME
      FROM EMP E1
      INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
      GROUP BY E2.ENAME
      ) A
WHERE ROWNUM = 1
;


-- 다른 방법
SELECT ENAME, CNT 
FROM EMP E
INNER JOIN (
            SELECT COUNT(*) CNT, MGR
            FROM EMP E
            GROUP BY MGR
            ORDER BY CNT DESC   
            ) A ON A.MGR = E.EMPNO
WHERE ROWNUM = 1        
;


-- 본인 부서의 평균급여보다 많은 급여를 받는 사람 목록 출력

SELECT *
FROM EMP E
INNER JOIN (
            SELECT ROUND(AVG(SAL), 2) AS AVG_DEPT, DEPTNO
            FROM EMP 
            GROUP BY E.DEPTNO
            ) A ON E.DEPTNO = A.DEPTNO
WHERE E.SAL > A.AVG_DEPT
;


-- 본인 학과의 평균 키보다 큰 학생들의 정보 출력

SELECT *
FROM STUDENT S
INNER JOIN (
            SELECT ROUND(AVG(STU_HEIGHT), 2) AVG_STU, STU_DEPT
            FROM STUDENT
            GROUP BY STU_DEPT
            ) A ON S.STU_DEPT = A.STU_DEPT
WHERE S.STU_HEIGHT > A.AVG_STU
            
;




















