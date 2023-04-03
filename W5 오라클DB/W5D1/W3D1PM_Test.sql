-- SELECT�� ������ ����ϴ� ���

SELECT S.STU_NO 
        , STU_NAME
        , AVG(ENR_GRADE) - (SELECT ROUND(AVG(ENR_GRADE), 2) FROM ENROL) 
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY S.STU_NO, STU_NAME
;


SELECT * FROM EMP;

--����==========================================================================

--1. EMP ���̺��� �̸��� 3��°�� R�̸� �̸��� ���̰� 6������ ����� ������ ����Ͽ���

SELECT *
FROM EMP
WHERE SUBSTR(ENAME, 3, 1) = 'R' AND LENGHT(ENAME) =6   --SUBSTR�� ���ڿ��� ���°�� ���� �������� ã�� �� ��� �� �� �ִ�.
;



--2. ���� ��ĥ�� �������� ����Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����Ͻÿ�.

SELECT TO_DATE(SYSDATE) - TO_DATE('2023-01-01','YYYY-MM-DD') AS ������
FROM DUAL
;



--3. DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANALIST'�� ����� 200, 
--   'SALESMAN'�� ����� 180, 'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�

SELECT ENAME, JOB, SAL, DECODE(JOB, 'ANALIST', SAL+200 
                                , 'SALESMAN', SAL+180
                                , 'MANAGER', SAL+150
                                , 'CLERK', SAL+100) AS �޿��λ�  
FROM EMP
;





--4. �� �μ��� ���� �μ���ȣ, �̸�, ���� ��, ��� ��, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. 
--   ��� �޿��� ������ �ݿø� �Ͻÿ�. DECODE ���

SELECT DEPTNO, DECODE(DEPTNO, '10', 'NAME' 
                        , '20', 'RESERCH'
                        , '30', 'SALES'
                        , '40', 'OPERATIONS') AS �μ��̸�,
        DECODE(DEPTNO, '10', 'NEW YORK' 
                        , '20', 'DALLAS'
                        , '30', 'CHICAGO'
                        , '40', 'BOSTON') AS ������ 
        , COUNT(*) AS �����, ROUND(AVG(SAL) ,2) AS ��ձ޿�  
FROM EMP
GROUP BY DEPTNO
;



--5. EMP ���̺��� ���� VIEW�� ����ÿ�. (��, COMM�� ������ O �ƴϸ� X)

CREATE OR REPLACE VIEW EMP_VIEW2
AS (SELECT EMPNO, ENAME, JOB, DEPTNO,
        SAL, NVL2(COMM, 'O', 'X') AS COMM
FROM EMP);

SELECT * FROM EMP_VIEW2;


SELECT * FROM EMP;
SELECT * FROM DEPT;


--6. �μ��� �� �⵵�� �Ի��� ����� �� ���ϱ�

SELECT DEPTNO AS �μ�, TO_CHAR(HIREDATE, 'YYYY') AS �⵵��, COUNT(*) AS �����
FROM EMP
GROUP BY DEPTNO, TO_CHAR(HIREDATE, 'YYYY')
ORDER BY DEPTNO ASC
;





--7. Ŀ�̼� �޴� ����� ���� ���� ���ϴ� ����� ���� O,X�� �����Ͽ� ���ϱ�

SELECT  NVL2(COMM, 'O', 'X') AS Ŀ�̼ǹ޴»��, COUNT(*) CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X') 
;




--8. �� �⵵�� �Ի��� ������� �ְ� �޿��� ���� �޿�, ��� �޿�, �ο��� ���ϱ�

SELECT TO_CHAR(HIREDATE, 'YYYY') AS �⵵��, MAX(SAL) AS �ְ�޿�, MIN(SAL) AS �����޿�, ROUND(AVG(SAL),2) AS ��ձ޿�, COUNT(*) AS �����
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
;



















