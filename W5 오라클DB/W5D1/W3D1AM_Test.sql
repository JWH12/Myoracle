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
-- ORACLE DB������ ����� ������ ORACLE INNER JOIN��.
-- ORACLE JOIN���� WHERE ������ �Է� ���ϸ� CROSS JOIN�� �ȴ�.

SELECT * 
FROM STUDENT S, ENROL E                                        -- �ΰ� �̻��� ���̺��� ���� �� �� ORACLE JOIN�� ��� FROM���� �Է��� �Ѵ�.
WHERE S.STU_NO = E.STU_NO AND STU_DEPT = '��ǻ������';          -- ORACLE JOIN�� INNER JOIN�� �ٸ��� WHERE�� AND�� �̿��Ͽ� �������ǵ��� �ִ´�. 


--���� 1=========
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--���� 2 LEFT JOIN=========

SELECT * 
FROM T_PRODUCT P, T_PIMAGE I
WHERE P.P_ID = I.P_ID(+);                                    -- WHERE ���ǿ� (+)�� ���̸� ORACLE JOIN������ LEFT JOIN�̴�. 

--���� 3 LEFT JOIN=========

SELECT * 
FROM T_PRODUCT P, T_CODE C
WHERE P.KIND = C.CODE(+) AND C.KIND = 'CLOTH';      

--���� 4 CROSS JOIN=========

SELECT * 
FROM EMP E
CROSS JOIN DEPT D;           -- ���ǰ� ������� ������ ��� �÷��� ������ �Ͽ� ����� �����ش�. ��, ��� ����� ���� ������ �Ѵ�.


--����===============================================================
-- ��ǻ�� ���� ������ ��� �л����� ��� �������� ���� ������ ������ �ִ� ��ǻ�������а� �л� ���
-- ORACLE JOIN�� ��� �� ��

SELECT *
FROM STUDENT S, ENROL E
WHERE S.STU_NO = E.STU_NO AND STU_DEPT = '��ǻ������'
      AND ENR_GRADE >= (
            SELECT AVG(ENR_GRADE) AS AVG_COM
            FROM ENROL E, SUBJECT S
            WHERE E.SUB_NO = S.SUB_NO AND S.SUB_NAME = '��ǻ�Ͱ���'
                )
;

--INNER JOIN�� ��� ���� ��

SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
WHERE STU_DEPT = '��ǻ������' AND ENR_GRADE > ( 
                      SELECT AVG(ENR_GRADE) AS AVG_COM
                    FROM ENROL E
                    INNER JOIN SUBJECT S ON E.SUB_NO = S.SUB_NO
                    WHERE S.SUB_NAME = '��ǻ�Ͱ���'
                    );



--UNION // --UNION ALL  ==================================================================================================================================

-- �ΰ��� ������ �ϳ��� ��ġ�� �뵵�̴�.
-- ���������� ���� ������, �ϳ��� �������� �������� ���ϴ� ��쿡 ����Ѵ�.
--�÷��� ���� ���� �Ʒ� �����ϰ� �ؾ��ϸ�, �ι�° ������ ù�� ° ������ ������ ������ �ι�° ������ ù�� ° ������ ������ ���� �ʴ´�.

SELECT STU_NO, STU_NAME   
FROM STUDENT
WHERE STU_HEIGHT >= 170

UNION                       -- �ߺ��� ������ ������ �� ���� �Ʒ��� �ΰ��� ������ ���ļ� ����Ѵ�.
--UNION ALL                 -- UNION ALL�� �ߺ����Ÿ� ���� �ʰ� ��� ���� ����Ѵ�.

SELECT STU_NO, STU_NAME
FROM STUDENT
WHERE STU_WEIGHT >= 50
;



--���� 1==========================================================================================
-- EMP���̺��� �޿��� 1500�̻�(ù��° ���̺�)�̰ų� Ȥ�� COMM�� �޴� ���(�ι�° ���̺�)�� ���, �̸�, ����

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



--���� 2==========================================================================================
-- �� �μ��� ��� �޿��� ��ü��� �޿��� ����϶� 


SELECT DNAME AS �μ�, ROUND(AVG(SAL), 2) AS ��� 
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY DNAME

UNION

SELECT '��ü', ROUND(AVG(SAL), 2) -- ù��° ������ ���� '��ü'�� ��Ī���� �Է� �� �� ��ü ����� ���Ѵ�. 
FROM EMP 
;


--���� 3==========================================================================================
-- �� ������ ��� Ű,�����Ը� ���ϴµ� �л��� �ְ� ���� �������� ���� ��

SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

SELECT STU_DEPT, ROUND(AVG(STU_HEIGHT), 2) AS ���Ű, ROUND(AVG(STU_WEIGHT), 2) AS ��ո�����
FROM STUDENT
GROUP BY STU_DEPT

UNION

SELECT '�л��� �ְ�', MAX(STU_HEIGHT) , MAX(STU_WEIGHT) 
FROM STUDENT 

UNION

SELECT '�л��� ������', MIN(STU_HEIGHT), MIN(STU_WEIGHT) 
FROM STUDENT 

UNION

SELECT '��ü���', ROUND(AVG(STU_HEIGHT), 2) ,  ROUND(AVG(STU_WEIGHT), 2)
FROM STUDENT 
;




--MINUS ==================================================================================================================================
-- ���� ���̺��� �������� �ؿ� ���̺��� ������ ���� �����͵��� �����ϰ� ����Ѵ�.
-- ���� �����Ϳ� �Ʒ� �����͵� ���Ͽ� �ߺ��� ���� �����ϰ� ����Ѵ�.

SELECT STU_NO, STU_NAME
FROM STUDENT
WHERE STU_HEIGHT >= 160

MINUS

SELECT STU_NO, STU_NAME
FROM STUDENT
WHERE STU_GENDER = 'M'
;


--���� 1==========================================================================================
-- EMP ���̺��� �޿��� 1000�̻��� ���
-- �μ��� 10�� �μ��� ������ �ʰ�
-- �Ի����� 81�⵵ ������ ���

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
WHERE HIREDATE < TO_DATE('1982', 'YYYY') -- ��¥Ÿ���� �񱳸� �� �� ����Ѵ�.
;



--LISTAGG ==================================================================================================================================
-- LISTAGG(�ķ�, ',')�� ,�� �������� ������� ����ϰڴٴ� ���̴�.
SELECT 
    LISTAGG (ENAME, ',') AS NAMES
FROM EMP;


-- GROUP BY�� ����ϸ� ���س��� �׷캰�� ������ �� �� �ִ�.
SELECT 
    DEPTNO,
    LISTAGG (ENAME, ',') AS NAMES
FROM EMP
GROUP BY DEPTNO
;


--���� 1===================================================================
-- �а����� ��� ��Ÿ����
SELECT 
    STU_DEPT,
    LISTAGG (STU_NAME, ', ') AS NAMES
FROM STUDENT
GROUP BY STU_DEPT
;


--���� 2===================================================================
-- HTML �ɼ����� �� �� ����ϴ� �ڵ�

WITH TEMP_TABLE AS (                            -- WITH ���̺� �� AS �� ����ϸ� �ӽ����̺��� ���� �� �ִ�   
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

SELECT REGEXP_SUBSTR(HTML, '<H1>.*</H1>') AS TAG  -- *�� ��ü�� �ǹ��ϱ� ������ ��� ��Ҹ� ����Ѵ�.
FROM TEMP_TABLE;



--OVER==================================================================================================================================
--���������� �ִ��� ������ Ȯ���ϴ� �ڵ�
-- OVER(PARTITION BY �÷�)�� ���� ���Ŀ� �ѹ��� ������ �� �� �� �ִ� �ڵ��̴�.

WITH TEMP(ENAME, BIRTH, JOB) AS (                               -- WITH ���̺� ��(�÷���) AS �� ����ϸ� Ż���ϴ� �ӽ����̺��� ���� �� �ִ�   
  SELECT 'ȫ�浿', '1982-01-23', 'SALESMAN' FROM DUAL UNION ALL    --TEMP��� ���̺� ������ �÷��� ������ ����.
  SELECT '���缮', '1987-04-19', 'CLERK'    FROM DUAL UNION ALL
  SELECT '��ȣ��', '1985-12-01', 'SALESMAN' FROM DUAL UNION ALL
  SELECT '���缮', '1986-12-10', 'CLERK'    FROM DUAL UNION ALL
  SELECT 'ȫ�浿', '1987-06-02', 'MANAGER'  FROM DUAL
)

SELECT ENAME
    , BIRTH
    , JOB
    , COUNT(DISTINCT BIRTH) OVER(PARTITION BY ENAME) AS CNT     --DISTINCT�� �ߺ������̴�. // OVER(PARTITION BY ENAME)�� ������ �̸��� ���� ����� ���Ϸ� ���Ͽ� �ߺ��� ã�Ƴ���� ���̴�.
FROM TEMP;



--���� 1==========================================================================================
-- ������ �̸��� ������ Y�� �׷��� ������ N���� ǥ���Ͽ� ��Ÿ����


WITH TEMP(ENAME, BIRTH, JOB) AS (                               -- WITH ���̺� ��(�÷���) AS �� ����ϸ� Ż���ϴ� �ӽ����̺��� ���� �� �ִ�   
  SELECT 'ȫ�浿', '1982-01-23', 'SALESMAN' FROM DUAL UNION ALL    --TEMP��� ���̺� ������ �÷��� ������ ����.
  SELECT '���缮', '1987-04-19', 'CLERK'    FROM DUAL UNION ALL
  SELECT '��ȣ��', '1985-12-01', 'SALESMAN' FROM DUAL UNION ALL
  SELECT '���缮', '1986-12-10', 'CLERK'    FROM DUAL UNION ALL
  SELECT 'ȫ�浿', '1987-06-02', 'MANAGER'  FROM DUAL
)

SELECT ENAME
    , BIRTH
    , JOB
    , DECODE(COUNT(DISTINCT BIRTH) OVER(PARTITION BY ENAME), 1, 'N', 'Y' ) AS CNT     --DECODE�� ����Ͽ� ���� �̸��� �ΰ��� ������ Y �׷��� ������ N���� ǥ�� �ǰ� �� �� �ִ�.
FROM TEMP;





