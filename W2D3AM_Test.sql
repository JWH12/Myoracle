SELECT * FROM STUDENT;
SELECT * FROM SUBJECT;
SELECT * FROM ENROL;


SET SERVEROUTPUT ON; 


--1�� ����===========================================================================================================================
--1. ���ν��� �̸� : UPDATE_TEST1 --------------------------------------------------
--2. ȣ�� ��� : EXECUTE UPDATE_TEST1(101, 5); 
--3. ��� : ENROL ���̺��� SUB_NO�� 101�� �л����� GRADE�� 5���� 


CREATE OR REPLACE PROCEDURE UPDATE_TEST1
        (V_SUBNO IN ENROL.SUB_NO%TYPE
        , V_GRADE IN ENROL.ENR_GRADE%TYPE)
IS
        
BEGIN
     UPDATE ENROL
     SET ENR_GRADE = ENR_GRADE + V_GRADE
     WHERE SUB_NO = V_SUBNO;
     COMMIT;
     
END UPDATE_TEST1;     
/        
        
EXECUTE UPDATE_TEST1(101, 5);

SELECT * FROM ENROL;




--2�� ����===========================================================================================================================
--1. ���ν��� �̸� : INSERT_TEST1 --------------------------------------------------
--2. ȣ�� ��� : EXECUTE INSERT_TEST1(20201234 , 'ȫ�浿', '���', 1, C, M); 
--3. ��� : STUDENT ���̺� STU_NO, STU_NAME, STU_DEPT, STU_GRADE, 
--		STU_CLASS, STU_GENDER ������ ����

CREATE OR REPLACE PROCEDURE INSERT_TEST1
       ( V_STUNO IN STUDENT.STU_NO%TYPE, 
         V_STUNAME IN STUDENT.STU_NAME%TYPE,
         V_STUDEPT IN STUDENT.STU_DEPT%TYPE,
         V_STUGRADE IN STUDENT.STU_GRADE%TYPE,
         V_STUCLASS  IN STUDENT.STU_CLASS%TYPE,    
         V_STUGENDER IN STUDENT.STU_GENDER%TYPE )
IS

BEGIN

    INSERT INTO STUDENT (STU_NO, STU_NAME, STU_DEPT, STU_GRADE, STU_CLASS, STU_GENDER)        -- ���� �޾� ���� ���̺��� �����ϰ� �÷����� ()�ȿ� �ִ´�.
    VALUES (V_STUNO, V_STUNAME, V_STUDEPT, V_STUGRADE, V_STUCLASS, V_STUGENDER );       -- ������ ���� ���� ������ ������ �ȿ� �ִ´ٴ� ��
    COMMIT;
    
     DBMS_OUTPUT.PUT_LINE('�й� : ' || V_STUNO);
     DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_STUNAME);
     DBMS_OUTPUT.PUT_LINE('�а� : ' || V_STUDEPT);
     DBMS_OUTPUT.PUT_LINE('�г� : ' || V_STUGRADE);
     DBMS_OUTPUT.PUT_LINE('���� : ' || V_STUCLASS);
     DBMS_OUTPUT.PUT_LINE('���� : ' || V_STUGENDER);
     
END INSERT_TEST1;
/    
        
EXECUTE INSERT_TEST1(20201234 , 'ȫ�浿', '���', 1, 'C', 'M');    
        
SELECT * FROM STUDENT;        



--�ݺ���===========================================================================================================================
-- �μ���ȣ�� �޾Ƽ� �ش� �μ��� ��� ���, �̸�, �޿� ���� ���
--

CREATE OR REPLACE PROCEDURE LOOP_TEST1                  --���ν��� �̸�
    (V_DEPTNO IN EMP.DEPTNO%TYPE)                       --�μ���ȣ�� ���� ���� ����
    
IS
    --3������ �迭�� ���������� ������ �Ͱ� ����
    TYPE EMPNO_TABLE IS TABLE OF EMP.EMPNO%TYPE       -- TYPE ���̺�� IS TABLE OF ���̺�Ÿ��  // �迭�̶�� ���� �� �� 
    INDEX BY BINARY_INTEGER;                          -- �� �迭�� ���� �ε��� ���� // INTEGER Ÿ���� �迭�� �����ϰڴٴ� ���� ����
    
    TYPE ENAME_TABLE IS TABLE OF EMP.ENAME%TYPE       -- �̸�(EMP.ENAME) Ÿ���� ���� �Ѵٴ� ���� ��, �ڹٿ����� Ŭ���� ����� ����
    INDEX BY BINARY_INTEGER;
    
    TYPE SAL_TABLE IS TABLE OF EMP.SAL%TYPE           -- �޿�(EMP.SAL) Ÿ���� �����Ѵٴ� ����
    INDEX BY BINARY_INTEGER;

    
    EMPNO_ARR EMPNO_TABLE;                           -- �����ִ� ���̺��� �����ؼ� ��ä�� ������̴�.
    ENAME_ARR ENAME_TABLE;
    SAL_ARR SAL_TABLE;    
    
    
    i BINARY_INTEGER := 0;                           -- �ݺ����� ����� ���� ���� �� �ε��� �ʱⰪ�� 0���� ���� 
                                                     -- BINARY_INTEGER�� ��� NUMBER�� �ٸ��� ��������� ���� �� ��ƸԱ� ������ ����ӵ��� ������
BEGIN
    -- �ݺ��� / FOR ~ LOOP , END LOOP  �ݺ����� ���۰� ���� ����ؾ��Ѵ�.
    FOR EMP_LIST IN (SELECT EMPNO, ENAME, SAL                      -- EMP_LIST�� �ӽ� ���̺��̴� // �ݺ����� �ѹ� �������� EMP_LIST�� �����Ѵ�.
                     FROM EMP
                     WHERE DEPTNO = V_DEPTNO) LOOP                 -- DEPPTNO = V_DEPTNO �ɶ����� �ݺ��ϰڴٴ� �� / LOOP�� �ۼ��Ͽ� �ݺ����� �ϼ��Ѵ�.

        i := i + 1;                                                -- ������ ������ �ε��� ������ ����Ͽ� �ݺ����� �ѹ� �������� �ε��� ���� 1�� �����ش�
        EMPNO_ARR(i) := EMP_LIST.EMPNO;                            -- EMP_LIST�� �ӽ� ���̺��̴�
        ENAME_ARR(i) := EMP_LIST.ENAME;                            -- �ݺ����� 3�� �ݺ��Ǹ� EMPNO_ARR(7369, 7499, 7521) ������ ����Ǿ� �ִ�
        SAL_ARR(i) := EMP_LIST.SAL;


END LOOP;                                                          -- END LOOP�� �Է��Ͽ� �ݺ����� �����Ѵ�.

    -- �ݺ����� ����ϱ� ���� FOR��
    FOR CNT IN 1..i   LOOP                                       -- CNT�� ���� �迭 ���ڸ� ���� �ӽ� �����̴�. / 1���� i��°�� ���ڱ��� �����Ҷ����� �ݺ��Ѵ�.
    
        DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || EMPNO_ARR(CNT) );   -- CNT�� ���������� �ݺ����� ���� �ϴ� �����̴�
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || ENAME_ARR(CNT) ); 
        DBMS_OUTPUT.PUT_LINE('����޿� : ' || SAL_ARR(CNT) ); 
        DBMS_OUTPUT.PUT_LINE('-----------------------------------'); 
         
END LOOP;    
END;

/

EXECUTE LOOP_TEST1(10);

SELECT * FROM STUDENT;


--FOR�� ����=====================================================================================================================
--STUDENT ���̺�
-- ���ν��� �̸� : LOOP_TEST2
-- EXECUTE LOOP_TEST2('M'); OR EXCUTE LOOK_TEST2('F'); //���л� �Ǵ� ���л��� ���� ����ض�
-- ��°�� : �й�, �̸�, �а�
-- �������ڰ� Ȯ���� ������� ���

CREATE OR REPLACE PROCEDURE LOOP_TEST2
    (V_STUGENDER IN STUDENT.STU_GENDER%TYPE )
    
IS
    TYPE STUNO_TABLE IS TABLE OF STUDENT.STU_NO%TYPE      
    INDEX BY BINARY_INTEGER;
    
    TYPE STUNAME_TABLE IS TABLE OF STUDENT.STU_NAME%TYPE      
    INDEX BY BINARY_INTEGER;

    TYPE STUDEPT_TABLE IS TABLE OF STUDENT.STU_DEPT%TYPE      
    INDEX BY BINARY_INTEGER;

    STUNO_ARR STUNO_TABLE;
    STUNAME_ARR STUNAME_TABLE;
    STUDEPT_ARR STUDEPT_TABLE;

    i BINARY_INTEGER := 0;
    
    
BEGIN
     
    
--�ݺ��� ����--    

    FOR STU_LIST IN ( SELECT STU_NO, STU_NAME, STU_DEPT
                    FROM STUDENT
                    WHERE STU_GENDER = V_STUGENDER ) LOOP
                    
     i := i + 1;                
    STUNO_ARR(i) := STU_LIST.STU_NO;
    STUNAME_ARR(i) := STU_LIST.STU_NAME;
    STUDEPT_ARR(i) := STU_LIST.STU_DEPT;

END LOOP;   
    
    FOR CNT IN 1..i   LOOP
    
    DBMS_OUTPUT.PUT_LINE('�й� : ' || STUNO_ARR(CNT) );
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || STUNAME_ARR(CNT) );
    
    -- IF�� �߰��ؼ� ������ �Ǵ�
    IF '��������' = STUDEPT_ARR(CNT) THEN
        DBMS_OUTPUT.PUT_LINE('�а� : ' || '�����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�а� : ' || STUDEPT_ARR(CNT));
    
    END IF;
    DBMS_OUTPUT.PUT_LINE('-------------------------------');
    
END LOOP;    

END;
/

EXECUTE LOOP_TEST2('F');

SELECT * FROM STUDENT;

        
        
        
        
--�ݺ���2===========================================================================================================================        
--LOOP, END LOO  
--�ݺ��ϸ鼭 �����͸� ����(EMP ���̺� ����)

DECLARE                 
    CNT NUMBER := 1000;     -- �ݺ��� ���� ����

BEGIN
    LOOP 
        INSERT INTO EMP(EMPNO, ENAME, DEPTNO)              -- EMP(EMPNO, ENAME, DEPTNO)�� CNT���ǿ� ������ �� ���� ������ ������� ���������� �ִ´�
            VALUES(CNT, 'HONG' || CNT, 40);       
        CNT := CNT +1 ;                                    -- CNT ���� 1�� ������Ų��
        
    EXIT WHEN CNT > 1010;                                  -- EXIT WHEN ����; : ������ �ְ� �ݺ����� ���������� �ϴ� �ڵ�    
    END LOOP;     
END;
/

SELECT * FROM EMP; 

DELETE FROM EMP WHERE DEPTNO = '40';


--����===========================================================================================================================   
-- 1���� 100���� ��� ���ϱ�

DECLARE                 
    CNT NUMBER := 1;     
    ODD_SUM NUMBER := 0;   
    EVEN_SUM NUMBER := 0;   
        
BEGIN
    LOOP
             
      IF MOD(CNT, 2) = 0 THEN
        EVEN_SUM := EVEN_SUM + CNT;
      
      ELSE 
        ODD_SUM := ODD_SUM + CNT;
   
      END IF;    
        CNT := CNT +1 ;
        
    EXIT WHEN CNT > 100;    --100�� �� ������ �ݺ��ض�                                  
    END LOOP; 
    
    DBMS_OUTPUT.PUT_LINE(EVEN_SUM);
    DBMS_OUTPUT.PUT_LINE(ODD_SUM);
    
END;
/


--MOD================================================================================
-- ù��° ������ �ι� ° ���� ������ ������ ���� ����Ѵ�.

SELECT MOD(11,2)
FROM DUAL;



--WHILE ~ LOOP===========================================================================================================================   
-- �ڹٿ����� FOR���� ����ϴ�.

DECLARE                 
    CNT NUMBER := 1;     
    ODD_SUM NUMBER := 0;   
    EVEN_SUM NUMBER := 0;   
        
BEGIN
    WHILE CNT <= 100 LOOP  -- WHILE ���� LOOP // CNT ���� 100�� �ɶ����� �ݺ��ض�
             
      IF MOD(CNT, 2) = 0 THEN
        EVEN_SUM := EVEN_SUM + CNT;
      
      ELSE 
        ODD_SUM := ODD_SUM + CNT;
   
      END IF;    
        CNT := CNT +1 ;
        
                              
    END LOOP; 
    
    DBMS_OUTPUT.PUT_LINE(EVEN_SUM);
    DBMS_OUTPUT.PUT_LINE(ODD_SUM);
    
END;
/

        
--����================================================================================        
-- 1. �ݺ��� �ϸ鼭 EMP���̺� �����͸� ���� (EMPNO, ENAME -> 'HONG', DEPTNO -> 40)        
-- 2. ������(PL-SEQ) - 1000���� �����ϴ� ������ �����
-- 3. EMPNO ���� �������� ä���
-- 4. CNT�� 1���� �����ؼ� 10�� �ݺ�

-- EMPNO �� PK ���� �ߺ��� �ȵǱ� ������ �ʿ信 ���� ���� ���� ��ų �� �ִ�.
        
CREATE SEQUENCE PL_SEQ
INCREMENT BY 1              -- 1�� ����    
START WITH 1000
MINVALUE 1000               -- �ּҰ�
MAXVALUE 10000              -- �ִ밪
NOCYCLE
;
        
DECLARE                 
    CNT NUMBER := 1;  
    
BEGIN
    WHILE CNT <= 10 LOOP
        INSERT INTO EMP(EMPNO, ENAME, DEPTNO)             
            VALUES(PL_SEQ.NEXTVAL, 'HONG' || CNT, 40);       
        CNT := CNT +1 ;                                   
        
                                 
    END LOOP;     
    
END;
/  
        
SELECT * FROM EMP;         
        
        
DELETE FROM EMP WHERE DEPTNO = '40';     
        
        
        
        
        
        
        
        
        
        
        
        
        