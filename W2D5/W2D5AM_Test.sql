SELECT * FROM EMP;

--문제======================================================================================================
-- 핸드폰 번호 앞에 7글자는 숫자 나머지는 *로 표시 되게하기

SELECT NAME
       , RPAD(SUBSTR(PHONE,1,9), 13, '*') AS 폰번호 
FROM CUSTOMER 
;


SET SERVEROUTPUT ON; 

--이론======================================================================================================

SYS_CONTEXT('USERTENV', 'SESSION_USER'); --현재 계정 정보

SELECT SYS_CONTEXT('USERTENV', 'SESSION_USER')
FROM DUAL;


--TRIGGER : 누가 언제 어떻게 고쳤는지에 대한 로그기록을 관리 할 때 사용된다. ======================================================================================================

SET SERVEROUTPUT ON; 

SELECT * FROM DEPT;

CREATE OR REPLACE TRIGGER TRIGGER_TEST1         -- 트리거 명을 선언한다.
     
     BEFORE                                     -- 첫번 째 옵션 : BEFORE, AFTER를 사용하여 실행에대한 순서를 정한다
     
     UPDATE ON DEPT                             -- DEPT 테이블이 수정 될 때 밑에 설정해 놓은 코드가 실행된다 / UPDATE, INSERT DELTE가 동시에 올 수 있다.
     
     FOR EACH ROW                               -- 두번 째 옵션 : 한행에 한번씩 실행되게 하는 코드 
     
BEGIN                                           -- 실행기 

    DBMS_OUTPUT.PUT_LINE('변경 전 컬럼 값 : ' || :OLD.DNAME );   -- OLD : DEPT테이블의 변경 전 컬럼을 참조하여 출력한다
    DBMS_OUTPUT.PUT_LINE('변경 후 컬럼 값 : ' || :NEW.DNAME );   -- NEW : DEPT테이블의 변경 후 컬럼을 참조하여 출력한다

END;
/

UPDATE DEPT
SET DNAME = 'NAME'
WHERE DEPTNO = '10'
;

-- 변경 전 컬름 : AAA
-- 변경 후 컬럼 : BBB
     
     


--문제======================================================================================================
SELECT * FROM DEPT;

CREATE OR REPLACE TRIGGER TRIGGER_TEST2         -- 트리거 명을 선언한다.
     
     BEFORE                                     -- 첫번 째 옵션 : BEFORE, AFTER를 사용하여 실행에대한 순서를 정한다
     
      INSERT ON EMP                             -- INSERT 일때 실행 하겠다는 뜻
    
      FOR EACH ROW     

DECLARE
    AVG_SAL NUMBER;
      
BEGIN                                          
    
    SELECT AVG(SAL) INTO AVG_SAL
    FROM EMP;
    
    DBMS_OUTPUT.PUT_LINE('평균 값 : ' || AVG_SAL );   


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


INSERT INTO BOOK VALUES(50, '스포츠 과학 1', '이상미디어', 25000);

INSERT INTO BOOK VALUES(51, '스포츠 과학 1', '이상미디어', 25000);

SELECT * FROM BOOK;

DELETE BOOK WHERE BOOKID = '50'; 

SELECT * FROM BOOK_LOG;


--문제======================================================================================================

CREATE OR REPLACE TRIGGER TRIGGER_TEST3 

    AFTER 
    
    INSERT ON BOOK                                              -- 북에 인서트를 실행 시키겠다
    
    FOR EACH ROW                                                -- 인서트가 될 때마다 반복하며 문구를 출력해준다

BEGIN
    
    INSERT INTO BOOK_LOG
    
        VALUES(:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER,
              :NEW.PRICE, SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER')); --현재 계정 정보 )
       
    
END;
/


INSERT INTO BOOK VALUES(51, '스포츠 과학 1', '이상미디어', 25000);


SELECT * FROM BOOK;

SELECT BOOKID_L, BOOKNAME_L, TO_CHAR(CDATETIME, 'YYYY-MM-DD HH24:MM:SS') AS 시간, ID
FROM BOOK_LOG;


--트리거 문제======================================================================================================
--조건
-- 1. STUDENT 트리거
-- 2. STUDENT_LOG 테이블 만들기 -> L_STUNO, L_STUNAME, L_STUDEPT, L_DATE, L_ID
-- 3. 데이터가 INSERT OR UPDATE가 되면 STUDENT_LOG에 데이터 삽입



-- STUDENT_LOG 테이블
CREATE TABLE STUDENT_LOG (
    L_STUNO VARCHAR2(20),
    L_STUNAME VARCHAR2(40),
    L_STUDEPT VARCHAR2(40),
    L_DATE DATE,
    CDATETIME DATE,
    L_ID VARCHAR2(40)
);



---- STUDENT 트리거
--CREATE OR REPLACE TRIGGER TRIGGER_TEST4 
--
--    AFTER 
--    
--    UPDATE OR INSERT ON STUDENT                                 -- STUDENT에 UPDATE 또는 INSERT를 실행 시키겠다
--    
--    FOR EACH ROW                                                -- UPDATE 또는 INSERT가 될 때마다 반복하며 로그 기록을 남긴다
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




INSERT INTO STUDENT VALUES(SYSDATE, '김철수', '기계', 3, 'A', 'M', '185', '75');

SELECT * 
FROM STUDENT;

UPDATE STUDENT
SET STU_HEIGHT = STY_HEIGHT + 1
WHERE STU_NO = '20153075';




--트리거 문제======================================================================================================
--조건
-- 1. EMP 테이블
-- 2. EMP_LOG 테이블 만들기 -> L_EMPNO, L_MGR, L_SAL, L_COMM, L_DATE, L_ID, EVENT
-- 3. INSERT, UPDATE, DELETE ==> INSERT -> I, UPDATE -> U, DELETE -> D

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;


-- EMP_LOG 테이블

CREATE TABLE EMP_LOG (
    L_EMPNO NUMBER,
    L_MGR VARCHAR2(40),
    L_SAL VARCHAR2(40),
    L_COMM NUMBER,
    L_DATE DATE,
    L_ID VARCHAR2(40),
    EVENT VARCHAR2(20)
);




---- EMP 트리거
CREATE OR REPLACE TRIGGER TRIGGER_TEST5 

    AFTER 
    
    INSERT OR UPDATE OR DELETE ON EMP                                              
    
    FOR EACH ROW                                                

BEGIN
    
--    IF TO_CHAR (SYSDATE, DY ) IN ('금', '토', '일') THEN      -- 금토일에는 EMP 테이블 수정 불가하도록 함
--        
--         IF INSERTING THEN 
--         raise_application_error(-20000,'금토일 사원 정보 추가 불가'); 
--         
--         ELSIF UPDATING THEN 
--         raise_application_error(-20000,'금토일 사원 정보 수정 불가'); 
--        
--         ELSIF DELETING THEN 
--         raise_application_error(-20000,'금토일 사원 정보 삭제 불가'); 
--         
--         ELSE
--         raise_application_error(-20000,'금토일 사원 정보 변경 불가'); 
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
--        VALUES(:OLD.EMPNO, :OLD.MGR, :OLD.SAL, :OLD.COMM                 -- 삭제를 할 때에는 새로운 값이 생기는게 아니기 때문에 OLD를 사용한다.
--               , SYSDATE, SYS_CONTEXT('USERTENV', 'SESSION_USER'), 'D');

        raise_application_error(-20000,'EMP 테이블은 삭제 불가');       -- 직접 에러코드를 짤 수 있다. //에러번호를 주면서 해당 테이블은 삭제가 불가능 하다는 문구를 띄워주는 코드이다
        
      
      END IF; 
    
END;
/



---- INSERT 조건
INSERT INTO STUDENT VALUES(SYSDATE, '김철수', '기계', 3, 'A', 'M', '185', '75');

---- UPDATE 조건
UPDATE EMP
SET SAL = SAL +10
WHERE EMPNO = '7369';


SELECT * FROM EMP_LOG;




--함수 만들기======================================================================================================

-- 해당 부서의 가장 높은 급여 값

CREATE OR REPLACE FUNCTION MAX_TEST                                     -- FUNCTION : 함수 만들 때 쓰는 코드
    (P_DEPTNO IN EMP.DEPTNO%TYPE)                                       -- 부서의 값을 받기 위해서 타입을 가져온다
    
    RETURN NUMBER                                                       -- RETURN 타입을 정해줘야 한다.

IS

    MAX_SAL EMP.SAL%TYPE;                                               -- MAX_SAL에 들어갈 타입을 EMP.SAL타입과 동일하게 한다.
    
BEGIN

    --쿼리 생성
    SELECT MAX(SAL) INTO MAX_SAL
    FROM EMP
    WHERE DEPTNO = P_DEPTNO;
    
    
    -- 검색 결과를 리턴해준다
    
    RETURN MAX_SAL;
    
END;
/


SELECT MAX_TEST(10)
FROM DUAL;


--문제 ======================================================================================================

-- DATE_TEST1(날짜데이터, 데이터 변환 종류);
-- 아래 데이터 종류를 정하면 지정한 타입이 나오게 할 것
-- 데이터변환 종류 => 'DATETIME' -> YYYY-MM-DD HH24:MI:SS
-- 데이터변환 종류 => 'DATE' -> YYYY-MM-DD 
-- 데이터변환 종류 => 'TIME' -> HH24:MI:SS


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










