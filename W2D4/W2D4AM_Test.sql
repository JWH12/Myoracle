SELECT * FROM T_USER;
SELECT * FROM T_BOARD;
SELECT * FROM T_BOARDCOMMENT;
SELECT * FROM T_BOARDFILE;


SET SERVEROUTPUT ON; 

--1. ����==========================================================================================================
-- 1-1. ��� : T_USER, ���ν����� : UPDATE_USER1
-- 1-2. ȣ���� : EXECUTE UPDATE_USER (id-���ڿ�, Point-����)
-- 1-3. ��� : �ش� id�� ���� ����� ����Ʈ�� �Է��� point������ ����



CREATE OR REPLACE PROCEDURE UPDATE_USER1
    (V_ID IN T_USER.ID%TYPE
    , V_POINT IN T_USER.POINT%TYPE)
    
IS


BEGIN
    UPDATE T_USER
    SET POINT = V_POINT
    WHERE ID = V_ID;
    COMMIT;


END UPDATE_USER1;    
/

EXECUTE UPDATE_USER1 ('test125', 1300);

SELECT * FROM T_USER;








--2. ����==========================================================================================================
-- 2-1. ��� : T_USER, ���ν����� : SELECT_USER1
-- 2-2. ȣ���� : EXECUTE SELECT_USER (gender-���ڿ�, Point-����)
-- 2-3. ��� : �ش� ������ ���� ������� �Է��� point������ ���� ������� ����Ʈ�� ���(���̵�. �г���, ����Ʈ)


CREATE OR REPLACE PROCEDURE SELECT_USER1
     (V_GENDER IN T_USER.GENDER%TYPE
    , V_POINT IN T_USER.POINT%TYPE)
    
IS
    TYPE ID_TABLE IS TABLE OF T_USER.ID%TYPE      
    INDEX BY BINARY_INTEGER;
    
    TYPE NICK_TABLE IS TABLE OF T_USER.NICKNAME%TYPE      
    INDEX BY BINARY_INTEGER;

    TYPE POINT_TABLE IS TABLE OF T_USER.POINT%TYPE      
    INDEX BY BINARY_INTEGER;

    ID_ARR ID_TABLE;
    NICK_ARR NICK_TABLE;
    POINT_ARR POINT_TABLE;

    i BINARY_INTEGER := 0;
    
    
BEGIN

    --�ݺ��� ����--    

    FOR USER_LIST IN ( SELECT ID, NICKNAME, POINT
                       FROM T_USER
                       WHERE GENDER = V_GENDER AND POINT > V_POINT) LOOP
                     
    i := i + 1;                
    ID_ARR(i) := USER_LIST.ID;
    NICK_ARR(i) := USER_LIST.NICKNAME;
    POINT_ARR(i) := USER_LIST.POINT;

END LOOP;   

    FOR CNT IN 1..i LOOP
    
    DBMS_OUTPUT.PUT_LINE('���̵� : ' || ID_ARR(CNT) );
    DBMS_OUTPUT.PUT_LINE('�г��� : ' || NICK_ARR(CNT) );
    DBMS_OUTPUT.PUT_LINE('����Ʈ : ' || POINT_ARR(CNT) );
    DBMS_OUTPUT.PUT_LINE('====================================');

END LOOP;    

END SELECT_USER1;
/

EXECUTE SELECT_USER1('M', 500);

SELECT * FROM T_USER;



--������ Ŀ��===================================================================================================================

-- SQL%ROWCOUNT : SQL ���� �� ������� ���� ��
-- SQL%FOUND : SQL ���� �� ������� ���� ���� ��� TRUE ����
-- SQL%NOTFOUND : SQL ���� �� ������� ���� ���� ��� TRUE ����


--���̵� �Ű������� ������ �˻� ����� ������ ����Ʈ 10% ������Ű�� ����

CREATE OR REPLACE PROCEDURE CURSOR_TES2
    (P_ID IN T_USER.ID%TYPE )
IS
    V_POINT T_USER.POINT%TYPE;                   --����Ʈ ����� ���� ã�� ���� ����.
    V_CNT NUMBER;                                -- CNT�� �÷��� ������ �ȵǾ� �ֱ� ������ NUMBER�� Ÿ���� ���Ѵ�.

BEGIN

    SELECT POINT INTO V_POINT                    -- POINT ���� ���� V_POINT�� ���� �� INTO�� ����Ѵ�.
    FROM T_USER
    WHERE ID = P_ID ;


    IF SQL%FOUND THEN                            -- �˻������ ���� �� ���� ������ ����϶�� �� // �÷��� ���� ���̵� ���� �� ����ϴ� ��� //
        DBMS_OUTPUT.PUT_LINE('�˻��� �������� ����Ʈ : ' || V_POINT);
    
    END IF;
    
    UPDATE T_USER                                  -- �Է��� ���̵��� ����Ʈ�� 10% ����.
    SET POINT = POINT * 1.1
    WHERE ID = P_ID ; 
    
    V_CNT := SQL%ROWCOUNT ;                         -- ������Ʈ ���� ���� V_CNT�� ���� ����ȴ�.
    DBMS_OUTPUT.PUT_LINE('����Ʈ ���� �ο��� : ' || V_CNT); 
    
    EXCEPTION                                      -- ����ó��
       WHEN NO_DATA_FOUND THEN                     -- ����, � ���ܸ� ó���� �������� ���Ͽ� ������ �ɾ�� �ϱ� ������ IF�� �ƴ� WHEN THEN�� ����. 
        DBMS_OUTPUT.PUT_LINE('������ ����'); 

END;
/

EXECUTE CURSOR_TES2 ('test123');

SELECT * FROM T_USER;




--�� ����� Ŀ��===================================================================================================================
-- Ŀ���� ������ ���� �Ǿ��� �� �ӽø޸� ������ �����ϴ� �뵵�̴�.

-- 1. Ŀ�� ���� �� CURSOR Ŀ����
   --EX) CURSOR Ŀ���� IS SELECT �Ӽ� FROM ���̺�    // ����� Ŀ������ �ӽ÷� ����.
   
-- 2. Ŀ�� ���� �� OPEN Ŀ����                      
   --EX) OPEN Ŀ����
   
-- 3. ������ ���� �� FETCH Ŀ����                    
   --EX) FETCH Ŀ���� INTO ����
   
-- 4. Ŀ�� ���� �� CLOSE Ŀ����
   --EX) CLOSE Ŀ����



-- ���� ===================================================================================================================
-- 30�� �μ��� �ٹ��ϰ� �ִ� ����� �̸��� �μ� ��ȣ ���

DECLARE 
    V_ENAME EMP.ENAME%TYPE;
    V_DEPTNO EMP.DEPTNO%TYPE;
    
    CURSOR TEST_CUR IS                     --Ŀ���� ����� SELECT�� ������ �Է��Ѵ�. �׷��� �Ǹ� ���� ���� TEST_CUR�� �ӽ÷� ����ȴ�.
        SELECT ENAME, DEPTNO
        FROM EMP
        WHERE DEPTNO = '30';

BEGIN
    OPEN TEST_CUR;                           -- ������ Ŀ������ ��������� �Ѵ�.
    LOOP                                     -- �ӽ����̺��� ����ϴ� ���� �ƴ� �ݺ����� �ٷ� ��� �� ���̱� ������ LOOP�� ����Ѵ�.
        FETCH TEST_CUR INTO V_ENAME, V_DEPTNO;  --
        
    EXIT WHEN TEST_CUR%NOTFOUND;                -- �ݺ����� �������� ������ ������ Ŀ���� %NOTFOUND�� ����Ͽ� �����Ͱ� ���� ���  ���������� �Ѵ�.
        DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_ENAME);
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || V_DEPTNO);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
    END LOOP;
    
    CLOSE TEST_CUR;

END;
/


SELECT * FROM STUDENT;
SELECT * FROM ENROL;

--1. ���� ===================================================================================================================
-- STUDENT ���̺�
-- EXECUTE ���ν�����('��ǻ������');            --�Ű����� �а�
-- �ش� �а� �л����� �й�, �̸�, ��� ���� ���


CREATE OR REPLACE PROCEDURE DEPT_TEST
    (V_DEPT IN STUDENT.STU_DEPT%TYPE)

IS
        V_STUNO STUDENT.STU_NO%TYPE;
        V_STUNAME STUDENT.STU_NAME%TYPE;
        V_GRADE ENROL.ENR_GRADE%TYPE;
        
        
        CURSOR D_TEST IS                  
            SELECT S.STU_NO, STU_NAME, AVG(E.ENR_GRADE) AS GRADE
            FROM STUDENT S
            INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
            WHERE STU_DEPT = V_DEPT
            GROUP BY S.STU_NO, STU_NAME ;


BEGIN

    OPEN D_TEST;    
    
    LOOP                                     
        FETCH D_TEST INTO V_STUNO, V_STUNAME, V_GRADE;  
        
    EXIT WHEN D_TEST%NOTFOUND;               
        DBMS_OUTPUT.PUT_LINE('�й� : ' || V_STUNO);
        DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_STUNAME);
        DBMS_OUTPUT.PUT_LINE('������� : ' || V_GRADE);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
     END LOOP;
    
    CLOSE D_TEST;


END;
/


EXECUTE DEPT_TEST ('��ǻ������');  




SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;

--2. ���� ===================================================================================================================
-- �������̺� : ORDER_TABLE
-- EXECUTE ���ν�����('test123');            --�Ű����� ���̵�
-- �ش� ���̵� ���� ����� �г���, ������ǰ �̸�, ��ۻ��� (�����, ��ۿϷ� ��... T_CODE����)


CREATE OR REPLACE PROCEDURE ORDER_TSET
    (V_ID IN ORDER_TABLE.ID%TYPE)

IS
    V_NICKNAME T_USER.NICKNAME%TYPE;
    V_PNAME PRODUCT.P_NAME%TYPE;
    V_KIND T_CODE.NAME%TYPE;


    CURSOR O_TEST IS                  
            SELECT P.P_NAME, T.NICKNAME, C.NAME  
            FROM ORDER_TABLE O
            INNER JOIN T_USER T ON T.ID = O.ID
            INNER JOIN PRODUCT P ON O.P_ID = P.P_ID
            LEFT JOIN T_CODE  C ON O.STATUS = C.CODE AND C.KIND = 'STATUS'
            WHERE O.ID = V_ID
             ;

BEGIN

    OPEN O_TEST;    
    
    LOOP                                     
        FETCH O_TEST INTO V_NICKNAME, V_PNAME, V_KIND;  
        
    EXIT WHEN O_TEST%NOTFOUND;               
        DBMS_OUTPUT.PUT_LINE('�г��� : ' || V_NICKNAME);
        DBMS_OUTPUT.PUT_LINE('������ǰ : ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('��ۻ��� : ' || V_KIND);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
     END LOOP;
        DBMS_OUTPUT.PUT_LINE('��ü�����ͼ� : ' || O_TEST%ROWCOUNT);   -- ��ü�����ͼ��� ����� �˷��ִ� ������ ��� �� �� �ִ�.
    
    CLOSE O_TEST;

END;
/

EXECUTE ORDER_TSET ('test123'); 




--2. ������ FOR������ Ǫ�� ��� ===================================================================================================================
-- ���� ����
-- FETCH, OPEN, CLOSE ���� 
-- �ܼ������ �� ���� FOR�� ������ �߰��� �ʿ��� ��쿡�� ������ ����� ����Ѵ�.

CREATE OR REPLACE PROCEDURE ORDER_TSET
    (V_ID IN ORDER_TABLE.ID%TYPE)

IS
   
    CURSOR O_TEST IS                  
            SELECT P.P_NAME, T.NICKNAME, C.NAME  
            FROM ORDER_TABLE O
            INNER JOIN T_USER T ON T.ID = O.ID
            INNER JOIN PRODUCT P ON O.P_ID = P.P_ID
            LEFT JOIN T_CODE  C ON O.STATUS = C.CODE AND C.KIND = 'STATUS'
            WHERE O.ID = V_ID
             ;

BEGIN

    FOR F_LIST IN O_TEST LOOP   
                    
        DBMS_OUTPUT.PUT_LINE('�г��� : ' || F_LIST.V_NICKNAME);
        DBMS_OUTPUT.PUT_LINE('������ǰ : ' || F_LIST.V_PNAME);
        DBMS_OUTPUT.PUT_LINE('��ۻ��� : ' || F_LIST.V_KIND);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
     END LOOP;
     
        DBMS_OUTPUT.PUT_LINE('��ü�����ͼ� : ' || O_TEST%ROWCOUNT);   -- ��ü�����ͼ��� ����� �˷��ִ� ������ ��� �� �� �ִ�.

END;
/

EXECUTE ORDER_TSET ('test123'); 





--2. ���� ===================================================================================================================
-- �������̺� : EMP
-- EXECUTE ���ν�����('10'); --�μ���ȣ
-- �ش� �μ���ȣ ������� ���, �̸�, �޿� ���
-- FOR LOOP�� ó���ϱ�



CREATE OR REPLACE PROCEDURE DNO_TSET
    (V_DEPTNO IN EMP.DEPTNO%TYPE)

IS
   
    CURSOR D_TEST IS                  
            SELECT EMPNO, ENAME, SAL  
            FROM EMP
            WHERE DEPTNO = V_DEPTNO
            FOR UPDATE;                             -- CURSOR�� ���������� �����ϸ鼭 UPDATE�� ��Ű�� �ڵ�

BEGIN

    FOR F_LIST IN D_TEST LOOP   
        UPDATE EMP
        SET SAL = SAL + 10                           -- �ݺ���ų���� ���ǿ� �´� �������� SAL���� ��� ������Ʈ ������
        WHERE CURRENT OF D_TEST;
                    
        DBMS_OUTPUT.PUT_LINE('��� : ' || F_LIST.EMPNO);
        DBMS_OUTPUT.PUT_LINE('�̸� : ' || F_LIST.ENAME);
        DBMS_OUTPUT.PUT_LINE('�޿� : ' || F_LIST.SAL);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
     END LOOP;
  
END;
/

EXECUTE DNO_TSET ('10'); 

SELECT * 
FROM EMP
WHERE DEPTNO = '10';





                                                                                                                
