


--�������� ���� ����� �̸� ��� --------------------------------------------------------- 
SELECT E.*, E2.ENAME AS ���
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO; -- ��°��� ���� ���̺��� ���輺�� ������ ���� ���������� ����Ѵ�





--1�� �޿��� ���� ������ ��� --------------------------------------------------------- 
SELECT *
FROM EMP
ORDER BY SAL DESC; --ASC ��������, DESC ��������





--2�� �� �μ��� ��� �� ���ϱ� --------------------------------------------------------- 
SELECT COUNT(*), DEPTNO
FROM EMP
GROUP BY DEPTNO
;



--3�� SALESMAN�� ��� �޿� ���ϱ� --------------------------------------------------------- 

SELECT AVG(SAL)
FROM EMP
WHERE JOB = 'SALESMAN'
;




--4�� Ŀ�̼�(COMM)�� �޴� ����� �� ���ϱ� ---------------------------------------------------------

SELECT COUNT(COMM)
FROM EMP
WHERE COMM IS NOT NULL
;



--5�� Ŀ�̼�(COMM)�� �޴� ������� ��� ���ϱ� ---------------------------------------------------------

SELECT ROUND(AVG(COMM),2)
FROM EMP
WHERE COMM IS NOT NULL
;



--6�� ��� ---------------------------------------------------------

SELECT *
FROM EMP
WHERE EMPNO LIKE '77%'
;




--7�� �μ� �ο��� ���� ���� ���� ��ġ ���ϱ� ---------------------------------------------------------

SELECT *
FROM (
        SELECT COUNT(*) AS �����, D.DEPTNO, D.LOC
        FROM EMP E
        INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
        GROUP BY D.DEPTNO, D.LOC
        ORDER BY ����� ASC
    ) WHERE ROWNUM = 1
    ;


--7�� �ٸ� ����
SELECT COUNT(EMPNO)AS EC, E.DEPTNO, LOC
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, LOC
ORDER BY EC ASC
;


--8�� ��� ---------------------------------------------------------

SELECT E.*, E2.ENAME AS ���
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO
WHERE E2.ENAME = 'BLAKE'
;



--9�� ��� ---------------------------------------------------------

SELECT E.*, E2.ENAME AS ���
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO
WHERE E2.ENAME = 'KING'
;



--10�� SALESMAN�� ���� ���� �μ��� �������ϱ� ---------------------------------------------------------

SELECT COUNT(*), D.DEPTNO, LOC
        FROM EMP E
        INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
        WHERE E.JOB = 'SALESMAN'
        GROUP BY D.DEPTNO, LOC
;



--11�� ��ü ��պ��� �޿��� �� ���� �޴� ���� ��� ---------------------------------------------------------

SELECT *
FROM EMP
WHERE SAL > (
            SELECT ROUND(AVG(SAL),2)
            FROM EMP
        )
;

--��������
SELECT ROUND(AVG(SAL),2)
FROM EMP
;



--12�� �μ� ��� �޿��� ���� ���� ���� ��ġ ���ϱ�.

SELECT *
FROM (
    SELECT AVG(SAL) SAVG , DEPTNO
    FROM EMP 
    GROUP BY DEPTNO
    ORDER BY SAVG ASC
    ) A
INNER JOIN DEPT D ON A.DEPTNO = D.DEPTNO
WHERE ROWNUM = 1;






--13�� �� ������� �޿� ���

SELECT E.*, S.GRADE
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL  -- LOSAL���� HISAL ���̿� ���� �� ������ ����Ѵ�. // JOIN�� ��ó�� ���������� ���� ��� �� �� �ִ�.  
;




-----------------------------------------------------------------------------------------------------------------------------------------
-- �÷��� ��ȸ �� �� �ڹ��� IF��ó�� ������ �༭ ���� ����ϴ� ��
-- DECODE

SELECT STU_NAME, DECODE(STU_GENDER, 'M', '����', 'F', '����', '��Ÿ' ) AS ����       -- DECODE(�÷�, ����(if), ��°�, ����(else if), '��°�', ����(else = ���� �ΰ��� ���ǿ� �ش��� �ȵ� �� ���))
FROM STUDENT;

SELECT ENAME, DEPTNO,DECODE (DEPTNO, '10', 'NEW YORK' 
                            , '20', 'DALLAS'
                            , '30', 'CHICAGO' 
                            , '40', 'BOSTON'
                            , 'NOE' ) AS ����
FROM EMP;


SELECT * FROM DEPT;
SELECT * FROM EMP;



-- CASE ~ WHEN ~ THAN ~ END ������ ����Ѵ�. 
-- JAVA�� SWICH ~ CAS���� IF�� ������ ����� ����Ѵ�. -------------------------


SELECT CASE WHEN STU_GENDER = 'M' THEN '����'     -- WHEN�ڿ� ������ ���� THEN�ڰ� ��� ���̴�
            WHEN STU_GENDER = 'F' THEN '����'
            ELSE '����'                           -- JAVA IF���� ELSE�� ���� �߰� ���ǰ��� �־� �� �� �ִ�.
            END AS GENDER                        -- END�� �������� ����� �Ѵ�.    
            , STU_NAME
FROM STUDENT;




-------���� ����---------------------------------------------------------------------------------------------------------------

--DECODE ���� EMP ���̺��� �μ���ȣ�� 10�� ������� �μ���ȣ�� 30�� ������� ���� ����϶�
-- ���ڵ� �ϳ��� ���

SELECT  
    SUM(DECODE(DEPTNO, 10, 1)) AS DEPT10,     -- 10�� ���� ���� ���� ���� �� ���� 1�� ���� ��
    SUM(DECODE(DEPTNO, 30, 1)) AS DEPT30
FROM EMP
;

SELECT  
    COUNT(DECODE(DEPTNO, 10, 1)) AS DEPT10,     -- 10�� ���� ���� ���� ������ ���� ���̱� ������ ���ǿ� �ִ� ���� �����̵��� ������ ����
    COUNT(DECODE(DEPTNO, 30, 1)) AS DEPT30
FROM EMP
;

SELECT * FROM EMP;
SELECT * FROM DEPT;




--1. EMP ���̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ���� ����϶�---------------------------------------------
SELECT COUNT(*), DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 4;                                    --HAVING : WHERE�� �̿��� �������� ���� �׷��Լ��� ������ �� �� �ִ� ���




--2. EMP ���̺��� ���� ���� ����� �����ִ� �μ���ȣ�� ������� ����϶�---------------------------------------------

SELECT COUNT(*) , E.DEPTNO
FROM EMP E 
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO
HAVING COUNT(*) = (                                       -- HAVING�� ��Ī�� �ȵ��� ������ �׷��Լ��� ����ؾ� �Ѵ�.
            SELECT MAX(COUNT(*))
            FROM EMP
            GROUP BY DEPTNO
            )
;

SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

--1. EMP ���̺��� ���� ���� ����� ���� MGR�� �����ȣ�� ����϶�---------------------------------------------

SELECT COUNT(*) AS ����� , MGR 
FROM EMP 
HAVING COUNT(*) = (
               SELECT MAX(COUNT(*))
               FROM EMP
               GROUP BY MGR
            )GROUP BY MGR
;




--2. EMP ���̺��� �����ȣ�� 7521�� ����� ������ ���� �����ȣ�� 7934�� ����Ǳ޿�(SAL)���� ���� ����� �����ȣ, �̸�, ����, �޿��� ����϶�. ---------------------------------------------

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



--3. ����(JOB)���� �ּ� �޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ����� ����϶�.---------------------------------------------

SELECT DEPTNO, ENAME, JOB, SAL, EMPNO
FROM EMP
WHERE (JOB, SAL) IN     --�������� �ΰ��̻��� ���� �� ����Ѵ�.
        (SELECT JOB, MIN(SAL)
         FROM EMP
         GROUP BY JOB)
ORDER BY JOB;         




--4. �� ��� �� Ŀ�̼��� 0 �Ǵ� NULL�̰� �μ���ġ�� ��GO���� ������ ����� ������ �����ȣ, ����̸�, Ŀ�̼�, �μ���ȣ, �μ���, �μ���ġ�� ����϶�. ---------------------------------------------
-- ����1. ���ʽ��� NULL�̸� 0���� ���

SELECT E.EMPNO, ENAME, DECODE(E.COMM, NULL, 0) COMM, E.DEPTNO, D.DNAME, LOC     --DECODE E.CMMM�� ���� NULL�� �� 0���� ����ض�
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE (E.COMM = 0 OR E.COMM IS NULL) AND LOC LIKE '%GO' 
;



--5. �� �μ� �� ��� �޿��� 2000 �̻��̸� �ʰ�, �׷��� ������ �̸��� ����϶�. ---------------------------------------------

SELECT DEPTNO, (CASE WHEN (AVG(SAL) > 2000) THEN '�ʰ�' ELSE '�̸�' END) AS ��հ� 
FROM EMP
GROUP BY DEPTNO ;




--Ư�� ��Ҹ� ���ڿ��� ��Ÿ���ִ� �Լ���

SELECT NVL(COMM, 0)         --NULL ���� 0���� �ٲٴ� �Լ�
FROM EMP;

SELECT SYSDATE             --���� ��¥�� �˷��ִ� �Լ�
FROM DUAL;



SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH24:MI:SS')       -- ���ϴ� ���ڿ��� ����ϰ� ���ִ� �Լ� // HH24�� �����ϸ� �ð��� 24�÷� ǥ���ȴ�
FROM DUAL;



SELECT TO_CHAR(123.456, 'FM9999.9')             -- 'FM 999.99'�� 0��9�� ����Ͽ� ���ϴ� �Ҽ��������� ���� �ҷ��� �� ����Ѵ�. ���� �Ҽ������� �ݿø��� �Ͽ� ����Ѵ�.
FROM DUAL;                                      -- 9�� �ش� ��ġ�� �´� ���� ���ٸ� ǥ�ø� ���� �ʴ´�.               



SELECT TO_CHAR(123.456, 'FM0999.99')            -- 0�� �ش� ��ġ�� ���� ������ 0���� ä���� ����Ѵ�. 
FROM DUAL;  



SELECT TO_CHAR(1000000, 'FML999,999,999')     -- ,�� ������ ��ȭ�� ǥ���� �����ϴ� / FM�ڿ� L�� ������ ��ȭǥ�ð� ����ȴ�.
FROM DUAL;  



SELECT TO_CHAR(SYSDATE, 'FMMM/DD')             -- ��¥ �տ� FM�� ���̸� 0�� �������         
FROM DUAL;  



SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') AS ��¥, TO_CHAR(SYSDATE, 'HH24"��" MI"��" SS"��"') AS �ð�     -- ���ڿ��� ""�� ����ؾ� �Ѵ�.
FROM DUAL;



SELECT TO_CHAR(SYSDATE, 'AM')
              , (SYSDATE, 'D'),   -- 1(��) ~ 7(��)
              , (SYSDATE, 'DY')
              , (SYSDATE, 'DAY')
              , (SYSDATE, 'DDD') 
              , (SYSDATE, 'WW') --1�� ���� 30��, ������������
              , (SYSDATE, 'MON') -- ������� �˷��ش�
FROM DUAL;



--TO_CHAR ����----------------------------------

--1��----------------------------------------------------------
SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;



SELECT 
        D.DEPTNO, D.DNAME,
        COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1980', 1)) AS "�Ի� 1980"
      , COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1981', 1)) AS "�Ի� 1981"
      , COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1982', 1)) AS "�Ի� 1982"
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
GROUP BY D.DEPTNO, D.DNAME
;




SELECT E.EMPNO, ENAME, DECODE(E.COMM, NULL, 0) COMM, E.DEPTNO, D.DNAME, LOC     --DECODE E.CMMM�� ���� NULL�� �� 0���� ����ض�
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE (E.COMM = 0 OR E.COMM IS NULL) AND LOC LIKE '%GO';


SELECT  
    COUNT(DECODE(DEPTNO, 10, 1)) AS DEPT10,     -- 10�� ���� ���� ���� ������ ���� ���̱� ������ ���ǿ� �ִ� ���� �����̵��� ������ ����
    COUNT(DECODE(DEPTNO, 30, 1)) AS DEPT30
FROM EMP
;



