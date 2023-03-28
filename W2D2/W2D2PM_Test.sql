-- Ʈ���� -> UPDATE, DELETE, INSERT �� Ȱ���� �� �� �αױ���� ����� ������ �Ѵ�.

-- PLSQL ���α׷����� �Ѵ�.
-- DECLARE ���� �� ����� �����Ѵ�
-- BEGIN ���� �� �� �ֵ��� �ϴ� ������ �Ѵ�.
-- EXCEPTION(����ó��) / END

SET SERVEROUTPUT ON;                -- ����Ŭ�� ���� �� ���� �ѹ� �����ؾ� �Ѵ�.

--�������� �ڵ�
DECLARE 
    NAME VARCHAR2(10) := 'ȫ�浿' ;                                          -- DECLARE �ۼ��� : �÷���, Ÿ��, := , '' ;
           BEGIN                                                                       -- ���� ���� BEGIN �Է�
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);                                 -- JAVA�� SYSTEM.OUT.PRINTLN();�� ����
END;                                                             -- END ������ ���� ����.    
/                                                                           -- �ۼ� �� /�� �Է��ؾ� �ߺ����� ������ �ȵȴ�.


-- ���ν��� ======================================================================



-- EMP���̺��� EMPNO�� �Է� �޾Ƽ� ���� ����� SAL���� 100 �߰�

CREATE OR REPLACE PROCEDURE UPDATE_PRO
    (V_EMPNO IN NUMBER)                                              --�Ű������� �ϳ��� �����Ͽ� �޴´�
    IS 
    BEGIN                                                            -- ���๮        
        UPDATE EMP
        SET SAL = SAL+100
        WHERE EMPNO = V_EMPNO;                                      -- �Է� �޴� �������̺��� �������� �Ѵ�.
        COMMIT;     
    END UPDATE_PRO;                                                -- ���� �� ���ν����� �������� �Ѵ�.


--ȣ�� ��ɾ�
EXECUTE UPDATE_PRO(7369);

SELECT * FROM EMP;




--

DECLARE 
    V_ENAME EMP.ENAME%TYPE;                                       -- EMP ���̺� �ִ� ENAME�� �÷��� Ÿ�԰� �����ϰ� �����ϴ� ��� 
    V_DEPTNO EMP.DEPTNO%TYPE;                                    -- EMP ���̺� �ִ� DEPTNO�� �÷��� Ÿ�԰� �����ϰ� �����ϴ� ���              

BEGIN                                                             -- ���� ���� BEGIN �Է�

    SELECT ENAME, DEPTNO  INTO V_ENAME, V_DEPTNO                   -- SELECT ���ؼ� �Է¹��� ���� INTO�� �ҷ��´�       
    FROM EMP
    WHERE EMPNO  = '7369';
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_ENAME);                     -- JAVA�� SYSTEM.OUT.PRINTLN();�� ����
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || V_DEPTNO);
END;                                                                        -- END ������ ���� ����.    
/                                                                           -- �ۼ� �� /�� �Է��ؾ� �ߺ����� ������ �ȵȴ�.


SELECT * FROM EMP;


-- ���ν��� ����=================================================================
-- ���ν��� �̸� : INERT_PRO
-- INERT_PRO(1234, 'HONG', 'SALESMAN', 7698, SYSDATE, 3000, 100, 30)
-- ���ν��� �̸� : DELETE_PRO
-- DELETE_PRO(1234)



--INERT_PRO ���ν���

-- EMP.EMPNO%TYPE�� EMP���̺��� Ÿ���� �����ϰڴٴ� ���̴�.
-- V_�� �� ������ ���� ������ �Ѱ��̴�.
CREATE OR REPLACE PROCEDURE INSERT_PRO                                      
    (V_EMPNO IN EMP.EMPNO%TYPE, 
    V_ENAME  IN EMP.ENAME%TYPE,
    V_JOB    IN EMP.JOB%TYPE,
    V_MGR    IN EMP.MGR%TYPE,
    V_HIREDATE  IN EMP.HIREDATE%TYPE,    
    V_SAL    IN EMP.SAL%TYPE,
    V_COMM   IN EMP.COMM%TYPE,
    V_DEPTNO  IN EMP.DEPTNO%TYPE )
IS
--
BEGIN
    DBMS_OUTPUT.ENABLE;
    INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)        -- ���� �޾� ���� ���̺��� �����ϰ� �÷����� ()�ȿ� �ִ´�.
    VALUES (V_EMPNO, V_ENAME, V_JOB, V_MGR, V_HIREDATE, V_SAL,V_COMM, V_DEPTNO ); -- ������ ���� ���� ������ ������ �ȿ� �ִ´ٴ� ��
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('����μ� : ' || V_DEPTNO);
    DBMS_OUTPUT.PUT_LINE('������ �Է� ����');
END INSERT_PRO;
/

EXECUTE INSERT_PRO('1234', 'HONG', 'SALSEMAN', 7698, SYSDATE, 3000, 100, 30);




--DELETE_PRO ���ν���
--CREATE OR REPLACE PROCEDURE DELETE_PRO 
--     (V_EMPNO IN EMP.EMPNO%TYPE)
--IS
--
--BEGIN
--    
--
----    END; DELETE_PRO;



--2�� ����----------------------------------------------------------------------
-- SELECT_STUDENT
-- EXCUTE SELECT_STUDENT(170, 50)
-- Ű�� 170 �����԰� 50�̻� �л��� �й�, �̸�, �а�, ���� ���

CREATE OR REPLACE PROCEDURE SELECT_STUDENT      -- ���ν����� ���� ����ų� ��ä�ؾ� �� ��  CREATE OR REPLACE�� ����Ѵ�.
    (V_HEIGHT IN STUDENT.STU_HEIGHT%TYPE,       -- �Է¹޴� ���
    V_WEIGHT IN STUDENT.STU_WEIGHT%TYPE)
IS
    V_STUNO STUDENT.STU_NO%TYPE;                -- �Ű������� �־� ���� �뵵
    V_STUNAME STUDENT.STU_NAME%TYPE;
    V_STUDEPT STUDENT.STU_DEPT%TYPE;
    V_STUGENDER STUDENT.STU_GENDER%TYPE;

BEGIN 
    SELECT STU_NO, STU_NAME, STU_DEPT, STU_GENDER
      INTO V_STUNO, V_STUNAME, V_STUDEPT, V_STUGENDER 
    FROM STUDENT
    WHERE STU_HEIGHT >= V_HEIGHT AND STU_WEIGHT >= V_WEIGHT AND ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('�й� : ' || V_STUNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_STUNAME);
    DBMS_OUTPUT.PUT_LINE('�а� : ' || V_STUDEPT);
    DBMS_OUTPUT.PUT_LINE('���� : ' || V_STUGENDER);
    
END; 
/

EXECUTE SELECT_STUDENT(170, 50);





--%ROWTYPE�� �ش� Ÿ���� ������ ��� �����´�=========================================================================================
--%TYPE�� �÷� ������ �����´�

-- EMP���̺��� ���, �̸�, �μ���ȣ ���

CREATE OR REPLACE PROCEDURE SELECT_ROW
    (P_EMPNO IN EMP.EMPNO%TYPE)
IS
    V_EMP EMP%ROWTYPE;                                        -- EMP���̺� �ִ� �÷����� ��� V_EMP�� ����/ Ư�� �÷��� �ҷ����� ������ V_EMP.ENAME, V_EMP.DEPNO ���� ������ �����ϴ�
BEGIN 
    SELECT EMPNO, ENAME, DEPTNO
        INTO V_EMP.EMPNO, V_EMP.ENAME,V_EMP.DEPTNO
    FROM EMP
    WHERE EMPNO  = P_EMPNO;
    DBMS_OUTPUT.PUT_LINE('��� : ' || V_EMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_EMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || V_EMP.DEPTNO);
END;
/

SELECT * FROM EMP;

EXECUTE SELECT_ROW(7369);



-- IF�� =====================================================================================================
-- ����Է� -> �ش� ����� ���� �μ��̸� ���
-- �μ��̸� ����� JOIN (X), DECODE (X), IF�����θ� ���

CREATE OR REPLACE PROCEDURE TEST_IF
    (P_EMPNO IN EMP.EMPNO%TYPE)
IS 
    V_DEPTNO EMP.DEPTNO%TYPE;
BEGIN 
    SELECT DEPTNO
        INTO V_DEPTNO
    FROM EMP
    WHERE EMPNO = P_EMPNO;
    IF V_DEPTNO = 10 THEN                                     -- V_DEPRNO ���� 10�� �� THEN(����϶�)
        DBMS_OUTPUT.PUT_LINE('�μ��� ACC');
    ELSIF V_DEPTNO = 20 THEN                                                    --ELSIF = ELSE IF
         DBMS_OUTPUT.PUT_LINE('�μ��� RCC');
    ELSIF V_DEPTNO = 30 THEN     
         DBMS_OUTPUT.PUT_LINE('�μ��� SAL');
    ELSE    
         DBMS_OUTPUT.PUT_LINE('����');
    END IF;                                                        -- IF���� ��������� �˷��ִ� �ڵ带 �Է��ؼ� ����������� �Ѵ�.  
END;
/

SELECT * FROM EMP;
EXECUTE TEST_IF(7369);


--IF���� ------------------------------------------------------------------------
--STUDENT ���̺� ���ν��� ����
--ȣ���� �й�����
--STU_GRADE�� 1�̸� '���Ի�', 2�̸� '2�г�', 3�̸� '��������'�� ��µǰ� �� ��


CREATE OR REPLACE PROCEDURE TEST_GRADE
    (V_STUNO IN STUDENT.STU_NO%TYPE)
IS
    V_STUGRADE STUDENT.STU_GRADE%TYPE;
BEGIN
    SELECT STU_GRADE
        INTO V_STUGRADE
    FROM STUDENT
    WHERE STU_NO = V_STUNO;
    IF V_STUGRADE = 1 THEN
     DBMS_OUTPUT.PUT_LINE('���Ի�');
    ELSIF V_STUGRADE = 2 THEN
     DBMS_OUTPUT.PUT_LINE('2�г�');
    ELSIF V_STUGRADE = 3 THEN
     DBMS_OUTPUT.PUT_LINE('��������');
     ELSE    
     DBMS_OUTPUT.PUT_LINE('����');
     END IF;
END;

EXECUTE TEST_GRADE(20131001);

SELECT * FROM STUDENT;
















