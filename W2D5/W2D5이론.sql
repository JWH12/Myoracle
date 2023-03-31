-- SELECT, UPDATE, INSERT, DELETE
-- JOIN(INNER, LEFT), SELF JOIN

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

-- INNER JOIN ====================================================================================
-- INNER JOIN�� ����ϸ� ���� ������ ������ ��������, ��Ȳ�� ���� ������ �ȵǴ� ��찡 �ִ�.

SELECT EMPNO AS �����ȣ, E.ENAME AS ����̸�, E.DEPTNO AS �μ���ȣ, E.SAL AS �޿�, S.GRADE AS �޿����
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

-- �� �μ��� ����� 
SELECT COUNT(*), DEPTNO
FROM EMP
GROUP BY DEPTNO 
;

-- �� �μ��� �޿� ��� 
SELECT ROUND(AVG(SAL), 2), DEPTNO
FROM EMP
GROUP BY DEPTNO 
;


-- �� �μ��� �޿� ����� ���� ���� �μ����� ���� �����μ��� ����

SELECT MAX(AVG_SAL) - MIN(AVG_SAL) AS �޿�����
FROM (
      SELECT ROUND(AVG(SAL), 2) AS AVG_SAL , DEPTNO
      FROM EMP
      GROUP BY DEPTNO )
;


-- �� �μ��� ��ü ��պ��� ���� �޿��� �޴� ���

SELECT *
FROM EMP
WHERE SAL > (
             SELECT AVG(SAL)
             FROM EMP)
;





-- SELF JOIN ====================================================================================


-- ���, �̸�, �Ŵ���(���) �̸� ���

SELECT E1.EMPNO, E1.ENAME, E2.ENAME  
FROM EMP E1
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO   -- E1 ���̺��� MGR�� �������� �ι�° E2 ���̺��� EMPNO�� ���Ѵ�.
;



-- ���������� ���� ���� ����� �̸��� ���ڸ� ���

SELECT ENAME AS �̸� , C AS �����
FROM (
      SELECT COUNT(*) AS C , E2.ENAME
      FROM EMP E1
      INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
      GROUP BY E2.ENAME
      ) A
WHERE ROWNUM = 1
;


-- �ٸ� ���
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


-- ���� �μ��� ��ձ޿����� ���� �޿��� �޴� ��� ��� ���

SELECT *
FROM EMP E
INNER JOIN (
            SELECT ROUND(AVG(SAL), 2) AS AVG_DEPT, DEPTNO
            FROM EMP 
            GROUP BY E.DEPTNO
            ) A ON E.DEPTNO = A.DEPTNO
WHERE E.SAL > A.AVG_DEPT
;


-- ���� �а��� ��� Ű���� ū �л����� ���� ���

SELECT *
FROM STUDENT S
INNER JOIN (
            SELECT ROUND(AVG(STU_HEIGHT), 2) AVG_STU, STU_DEPT
            FROM STUDENT
            GROUP BY STU_DEPT
            ) A ON S.STU_DEPT = A.STU_DEPT
WHERE S.STU_HEIGHT > A.AVG_STU
            
;




















