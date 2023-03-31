SELECT * FROM EMP;

--����======================================================================================================
-- �ڵ��� ��ȣ �տ� 7���ڴ� ���� �������� *�� ǥ�� �ǰ��ϱ�

SELECT NAME
       , RPAD(SUBSTR(PHONE,1,9), 13, '*') AS ����ȣ 
FROM CUSTOMER 
;


SET SERVEROUTPUT ON; 

--�̷�======================================================================================================

SYS_CONTEXT('USERTENV', 'SESSION_USER'); --���� ���� ����

SELECT SYS_CONTEXT('USERTENV', 'SESSION_USER')
FROM DUAL;


--TRIGGER : ���� ���� ��� ���ƴ����� ���� �αױ���� ���� �� �� ���ȴ�. ======================================================================================================

SET SERVEROUTPUT ON; 

SELECT * FROM DEPT;

CREATE OR REPLACE TRIGGER TRIGGER_TEST1         -- Ʈ���� ���� �����Ѵ�.
     
     BEFORE                                     -- ù�� ° �ɼ� : BEFORE, AFTER�� ����Ͽ� ���࿡���� ������ ���Ѵ�
     
     UPDATE ON DEPT                             -- DEPT ���̺��� ���� �� �� �ؿ� ������ ���� �ڵ尡 ����ȴ� / UPDATE, INSERT DELTE�� ���ÿ� �� �� �ִ�.
     
     FOR EACH ROW                               -- �ι� ° �ɼ� : ���࿡ �ѹ��� ����ǰ� �ϴ� �ڵ� 
     
BEGIN                                           -- ����� 

    DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || :OLD.DNAME );   -- OLD : DEPT���̺��� ���� �� �÷��� �����Ͽ� ����Ѵ�
    DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || :NEW.DNAME );   -- NEW : DEPT���̺��� ���� �� �÷��� �����Ͽ� ����Ѵ�

END;
/

UPDATE DEPT
SET DNAME = 'NAME'
WHERE DEPTNO = '10'
;

-- ���� �� �ø� : AAA
-- ���� �� �÷� : BBB
     
     


--����======================================================================================================
SELECT * FROM DEPT;

CREATE OR REPLACE TRIGGER TRIGGER_TEST2         -- Ʈ���� ���� �����Ѵ�.
     
     BEFORE                                     -- ù�� ° �ɼ� : BEFORE, AFTER�� ����Ͽ� ���࿡���� ������ ���Ѵ�
     
      INSERT ON EMP                             -- INSERT �϶� ���� �ϰڴٴ� ��
    
      FOR EACH ROW     

DECLARE
    AVG_SAL NUMBER;
      
BEGIN                                          
    
    SELECT AVG(SAL) INTO AVG_SAL
    FROM EMP;
    
    DBMS_OUTPUT.PUT_LINE('��� �� : ' || AVG_SAL );   


END;
/

-- INSERT INTO  EMP(EMPNO, ENAME, JOB, HIREDATE, SAL)
--   VALUSE(1000, 'TEST', 'SALES', SYSDATE, 1234);



CREATE TABLE BOOK_LOG (
    BOOKID_L NUMBER,
    BOOKNAME_L VARCHAR2(40),
    PUBLISHER_L VARCHAR2(40),
    PRICE_L NUMBER,
    CDATETIME DATE,
    ID VARCHAR2(40)
);


INSERT INTO BOOK VALUES(50, '������ ���� 1', '�̻�̵��', 25000);

INSERT INTO BOOK VALUES(51, '������ ���� 1', '�̻�̵��', 25000);

SELECT * FROM BOOK;

DELETE BOOK WHERE BOOKID = '50'; 

SELECT * FROM BOOK_LOG;


--����======================================================================================================

CREATE OR REPLACE TRIGGER TRIGGER_TEST3 

    AFTER 
    
    INSERT ON BOOK                                              -- �Ͽ� �μ�Ʈ�� ���� ��Ű�ڴ�
    
    FOR EACH ROW                                                -- �μ�Ʈ�� �� ������ �ݺ��ϸ� ������ ������ش�

BEGIN
    
    INSERT INTO BOOK_LOG
    
        VALUES(:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER,
              :NEW.PRICE, SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER')); --���� ���� ���� )
       
    
END;
/


INSERT INTO BOOK VALUES(51, '������ ���� 1', '�̻�̵��', 25000);


SELECT * FROM BOOK;

SELECT BOOKID_L, BOOKNAME_L, TO_CHAR(CDATETIME, 'YYYY-MM-DD HH24:MM:SS') AS �ð�, ID
FROM BOOK_LOG;


--Ʈ���� ����======================================================================================================
--����
-- 1. STUDENT Ʈ����
-- 2. STUDENT_LOG ���̺� ����� -> L_STUNO, L_STUNAME, L_STUDEPT, L_DATE, L_ID
-- 3. �����Ͱ� INSERT OR UPDATE�� �Ǹ� STUDENT_LOG�� ������ ����



-- STUDENT_LOG ���̺�
CREATE TABLE STUDENT_LOG (
    L_STUNO VARCHAR2(20),
    L_STUNAME VARCHAR2(40),
    L_STUDEPT VARCHAR2(40),
    L_DATE DATE,
    CDATETIME DATE,
    L_ID VARCHAR2(40)
);



---- STUDENT Ʈ����
--CREATE OR REPLACE TRIGGER TRIGGER_TEST4 
--
--    AFTER 
--    
--    UPDATE OR INSERT ON STUDENT                                 -- STUDENT�� UPDATE �Ǵ� INSERT�� ���� ��Ű�ڴ�
--    
--    FOR EACH ROW                                                -- UPDATE �Ǵ� INSERT�� �� ������ �ݺ��ϸ� �α� ����� �����
--
--BEGIN
--    IF INSERTING THEN
--        INSERT INTO STUDENT_LOG
--    
--        VALUES(:NEW.STU_NO, :NEW.STU_NAME, :NEW.STU_DEPT, 
--               SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER'), 'U'); 
--
----    ELSE IF  THEN
------        INSERT UPDATING INTO STUDENT_LOG
----    
----        VALUES(:NEW.STU_NO, :NEW.STU_NAME, :NEW.STU_DEPT, 
----               SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER'), 'U'); 
----               
--    ELSE IF UPDATING THEN
--        INSERT INTO STUDENT_LOG
--    
--        VALUES(:NEW.STU_NO, :NEW.STU_NAME, :NEW.STU_DEPT, 
--               SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER'), 'U');     
--   
--       END IF;
--    
--END;
--/




INSERT INTO STUDENT VALUES(SYSDATE, '��ö��', '���', 3, 'A', 'M', '185', '75');

SELECT * 
FROM STUDENT;

UPDATE STUDENT
SET STU_HEIGHT = STY_HEIGHT + 1
WHERE STU_NO = '20153075';




--Ʈ���� ����======================================================================================================
--����
-- 1. EMP ���̺�
-- 2. EMP_LOG ���̺� ����� -> L_EMPNO, L_MGR, L_SAL, L_COMM, L_DATE, L_ID, EVENT
-- 3. INSERT, UPDATE, DELETE ==> INSERT -> I, UPDATE -> U, DELETE -> D

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;


-- EMP_LOG ���̺�

CREATE TABLE EMP_LOG (
    L_EMPNO NUMBER,
    L_MGR VARCHAR2(40),
    L_SAL VARCHAR2(40),
    L_COMM NUMBER,
    L_DATE DATE,
    L_ID VARCHAR2(40),
    EVENT VARCHAR2(20)
);




---- EMP Ʈ����
CREATE OR REPLACE TRIGGER TRIGGER_TEST5 

    AFTER 
    
    INSERT OR UPDATE OR DELETE ON EMP                                              
    
    FOR EACH ROW                                                

BEGIN
    
--    IF TO_CHAR (SYSDATE, DY ) IN ('��', '��', '��') THEN      -- �����Ͽ��� EMP ���̺� ���� �Ұ��ϵ��� ��
--        
--         IF INSERTING THEN 
--         raise_application_error(-20000,'������ ��� ���� �߰� �Ұ�'); 
--         
--         ELSIF UPDATING THEN 
--         raise_application_error(-20000,'������ ��� ���� ���� �Ұ�'); 
--        
--         ELSIF DELETING THEN 
--         raise_application_error(-20000,'������ ��� ���� ���� �Ұ�'); 
--         
--         ELSE
--         raise_application_error(-20000,'������ ��� ���� ���� �Ұ�'); 
--         
--    END IF;  
    
    IF INSERTING THEN
        
        INSERT INTO EMP_LOG
        VALUES(:NEW.EMPNO, :NEW.MGR, :NEW.SAL, :NEW.COMM
               , SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER'), 'I'); 
     
     ELSIF UPDATING THEN
        
        INSERT INTO EMP_LOG
        VALUES(:NEW.EMPNO, :NEW.MGR, :NEW.SAL, :NEW.COMM
               , SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER'), 'U');
     
     ELSIF DELETING THEN
        
--        INSERT INTO EMP_LOG            
--        VALUES(:OLD.EMPNO, :OLD.MGR, :OLD.SAL, :OLD.COMM                 -- ������ �� ������ ���ο� ���� ����°� �ƴϱ� ������ OLD�� ����Ѵ�.
--               , SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER'), 'D');

        raise_application_error(-20000,'EMP ���̺��� ���� �Ұ�');       -- ���� �����ڵ带 © �� �ִ�. //������ȣ�� �ָ鼭 �ش� ���̺��� ������ �Ұ��� �ϴٴ� ������ ����ִ� �ڵ��̴�
        
      
      END IF; 
    
END;
/



---- INSERT ����
INSERT INTO STUDENT VALUES(SYSDATE, '��ö��', '���', 3, 'A', 'M', '185', '75');

---- UPDATE ����
UPDATE EMP
SET SAL = SAL +10
WHERE EMPNO = '7369';


SELECT * FROM EMP_LOG;




--�Լ� �����======================================================================================================

-- �ش� �μ��� ���� ���� �޿� ��

CREATE OR REPLACE FUNCTION MAX_TEST                                     -- FUNCTION : �Լ� ���� �� ���� �ڵ�
    (P_DEPTNO IN EMP.DEPTNO%TYPE)                                       -- �μ��� ���� �ޱ� ���ؼ� Ÿ���� �����´�
    
    RETURN NUMBER                                                       -- RETURN Ÿ���� ������� �Ѵ�.

IS

    MAX_SAL EMP.SAL%TYPE;                                               -- MAX_SAL�� �� Ÿ���� EMP.SALŸ�԰� �����ϰ� �Ѵ�.
    
BEGIN

    --���� ����
    SELECT MAX(SAL) INTO MAX_SAL
    FROM EMP
    WHERE DEPTNO = P_DEPTNO;
    
    
    -- �˻� ����� �������ش�
    
    RETURN MAX_SAL;
    
END;
/


SELECT MAX_TEST(10)
FROM DUAL;


--���� ======================================================================================================

-- DATE_TEST1(��¥������, ������ ��ȯ ����);
-- �Ʒ� ������ ������ ���ϸ� ������ Ÿ���� ������ �� ��
-- �����ͺ�ȯ ���� => 'DATETIME' -> YYYY-MM-DD HH24:MI:SS
-- �����ͺ�ȯ ���� => 'DATE' -> YYYY-MM-DD 
-- �����ͺ�ȯ ���� => 'TIME' -> HH24:MI:SS


CREATE OR REPLACE FUNCTION DATE_TEST1
    (P_DATE IN DATE
     ,P_KIND IN VARCHAR2) 

        RETURN VARCHAR2
IS
    
    V_DATE VARCHAR2(30);

BEGIN

    IF P_KIND = 'DATETIME' THEN
        V_DATE := TO_CHAR(P_DATE, 'YYYY-MM-DD HH24:MI:SS');
    
    ELSIF P_KIND  = 'DATE' THEN
        V_DATE := TO_CHAR(P_DATE, 'YYYY-MM-DD');
   
    ELSIF P_KIND  = 'TIME' THEN
        V_DATE := TO_CHAR(P_DATE, 'HH24:MI:SS');

    END IF;

    RETURN V_DATE;
    
END;
/

SELECT 
    DATE_TEST1 (HIREDATE,'DATE') AS DATETIME
FROM EMP;










