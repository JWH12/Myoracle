SELECT * FROM STUDENT;
SELECT * FROM SUBJECT;
SELECT * FROM ENROL;


SET SERVEROUTPUT ON; 


--1번 문제===========================================================================================================================
--1. 프로시저 이름 : UPDATE_TEST1 --------------------------------------------------
--2. 호출 방법 : EXECUTE UPDATE_TEST1(101, 5); 
--3. 결과 : ENROL 테이블의 SUB_NO가 101인 학생들의 GRADE를 5증가 


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




--2번 문제===========================================================================================================================
--1. 프로시저 이름 : INSERT_TEST1 --------------------------------------------------
--2. 호출 방법 : EXECUTE INSERT_TEST1(20201234 , '홍길동', '기계', 1, C, M); 
--3. 결과 : STUDENT 테이블에 STU_NO, STU_NAME, STU_DEPT, STU_GRADE, 
--		STU_CLASS, STU_GENDER 순으로 저장

CREATE OR REPLACE PROCEDURE INSERT_TEST1
       ( V_STUNO IN STUDENT.STU_NO%TYPE, 
         V_STUNAME IN STUDENT.STU_NAME%TYPE,
         V_STUDEPT IN STUDENT.STU_DEPT%TYPE,
         V_STUGRADE IN STUDENT.STU_GRADE%TYPE,
         V_STUCLASS  IN STUDENT.STU_CLASS%TYPE,    
         V_STUGENDER IN STUDENT.STU_GENDER%TYPE )
IS

BEGIN

    INSERT INTO STUDENT (STU_NO, STU_NAME, STU_DEPT, STU_GRADE, STU_CLASS, STU_GENDER)        -- 값을 받아 넣을 테이블을 명히하고 컬럼들을 ()안에 넣는다.
    VALUES (V_STUNO, V_STUNAME, V_STUDEPT, V_STUGRADE, V_STUCLASS, V_STUGENDER );       -- 위에서 받은 값을 선언한 변수들 안에 넣는다는 뜻
    COMMIT;
    
     DBMS_OUTPUT.PUT_LINE('학번 : ' || V_STUNO);
     DBMS_OUTPUT.PUT_LINE('이름 : ' || V_STUNAME);
     DBMS_OUTPUT.PUT_LINE('학과 : ' || V_STUDEPT);
     DBMS_OUTPUT.PUT_LINE('학년 : ' || V_STUGRADE);
     DBMS_OUTPUT.PUT_LINE('교실 : ' || V_STUCLASS);
     DBMS_OUTPUT.PUT_LINE('성별 : ' || V_STUGENDER);
     
END INSERT_TEST1;
/    
        
EXECUTE INSERT_TEST1(20201234 , '홍길동', '기계', 1, 'C', 'M');    
        
SELECT * FROM STUDENT;        



--반복문===========================================================================================================================
-- 부서번호를 받아서 해당 부서의 사람 사번, 이름, 급여 정보 출력
--

CREATE OR REPLACE PROCEDURE LOOP_TEST1                  --프로시저 이름
    (V_DEPTNO IN EMP.DEPTNO%TYPE)                       --부서번호를 받을 변수 선언
    
IS
    --3가지의 배열을 순차적으로 선언한 것과 같다
    TYPE EMPNO_TABLE IS TABLE OF EMP.EMPNO%TYPE       -- TYPE 테이블명 IS TABLE OF 테이블타입  // 배열이라고 생각 할 것 
    INDEX BY BINARY_INTEGER;                          -- 위 배열에 대한 인덱스 설정 // INTEGER 타입의 배열로 관리하겠다는 것을 선언
    
    TYPE ENAME_TABLE IS TABLE OF EMP.ENAME%TYPE       -- 이름(EMP.ENAME) 타입을 관리 한다는 선언 즉, 자바에서의 클래스 선언과 같다
    INDEX BY BINARY_INTEGER;
    
    TYPE SAL_TABLE IS TABLE OF EMP.SAL%TYPE           -- 급여(EMP.SAL) 타입을 관리한다는 선언
    INDEX BY BINARY_INTEGER;

    
    EMPNO_ARR EMPNO_TABLE;                           -- 위에있는 테이블을 참조해서 객채로 만든것이다.
    ENAME_ARR ENAME_TABLE;
    SAL_ARR SAL_TABLE;    
    
    
    i BINARY_INTEGER := 0;                           -- 반복문에 사용할 변수 선언 및 인데스 초기값을 0으로 설정 
                                                     -- BINARY_INTEGER의 경우 NUMBER랑 다르게 저장공간을 많이 안 잡아먹기 때문에 연산속도가 빠르다
BEGIN
    -- 반복문 / FOR ~ LOOP , END LOOP  반복문의 시작과 끝을 명시해야한다.
    FOR EMP_LIST IN (SELECT EMPNO, ENAME, SAL                      -- EMP_LIST는 임시 테이블이다 // 반복문이 한번 돌때마다 EMP_LIST에 저장한다.
                     FROM EMP
                     WHERE DEPTNO = V_DEPTNO) LOOP                 -- DEPPTNO = V_DEPTNO 될때까지 반복하겠다는 뜻 / LOOP를 작성하여 반복문을 완성한다.

        i := i + 1;                                                -- 위에서 설정한 인덱스 변수를 사용하여 반복문이 한번 돌때마다 인덱스 값을 1씩 높여준다
        EMPNO_ARR(i) := EMP_LIST.EMPNO;                            -- EMP_LIST는 임시 테이블이다
        ENAME_ARR(i) := EMP_LIST.ENAME;                            -- 반복문이 3번 반복되면 EMPNO_ARR(7369, 7499, 7521) 순으로 저장되어 있다
        SAL_ARR(i) := EMP_LIST.SAL;


END LOOP;                                                          -- END LOOP를 입력하여 반복문을 종료한다.

    -- 반복문을 출력하기 위한 FOR문
    FOR CNT IN 1..i   LOOP                                       -- CNT는 위의 배열 숫자를 담을 임시 변수이다. / 1부터 i번째의 숫자까지 도달할때까지 반복한다.
    
        DBMS_OUTPUT.PUT_LINE('사원번호 : ' || EMPNO_ARR(CNT) );   -- CNT는 순차적으로 반복문이 돌게 하는 변수이다
        DBMS_OUTPUT.PUT_LINE('사원이름 : ' || ENAME_ARR(CNT) ); 
        DBMS_OUTPUT.PUT_LINE('사원급여 : ' || SAL_ARR(CNT) ); 
        DBMS_OUTPUT.PUT_LINE('-----------------------------------'); 
         
END LOOP;    
END;

/

EXECUTE LOOP_TEST1(10);

SELECT * FROM STUDENT;


--FOR문 문제=====================================================================================================================
--STUDENT 테이블
-- 프로시저 이름 : LOOP_TEST2
-- EXECUTE LOOP_TEST2('M'); OR EXCUTE LOOK_TEST2('F'); //남학생 또는 여학생의 값을 출력해라
-- 출력결과 : 학번, 이름, 학과
-- 전기전자과 확과를 전기과로 출력

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
     
    
--반복문 설정--    

    FOR STU_LIST IN ( SELECT STU_NO, STU_NAME, STU_DEPT
                    FROM STUDENT
                    WHERE STU_GENDER = V_STUGENDER ) LOOP
                    
     i := i + 1;                
    STUNO_ARR(i) := STU_LIST.STU_NO;
    STUNAME_ARR(i) := STU_LIST.STU_NAME;
    STUDEPT_ARR(i) := STU_LIST.STU_DEPT;

END LOOP;   
    
    FOR CNT IN 1..i   LOOP
    
    DBMS_OUTPUT.PUT_LINE('학번 : ' || STUNO_ARR(CNT) );
    DBMS_OUTPUT.PUT_LINE('이름 : ' || STUNAME_ARR(CNT) );
    
    -- IF문 추가해서 조건을 건다
    IF '전기전자' = STUDEPT_ARR(CNT) THEN
        DBMS_OUTPUT.PUT_LINE('학과 : ' || '전기과');
    ELSE
        DBMS_OUTPUT.PUT_LINE('학과 : ' || STUDEPT_ARR(CNT));
    
    END IF;
    DBMS_OUTPUT.PUT_LINE('-------------------------------');
    
END LOOP;    

END;
/

EXECUTE LOOP_TEST2('F');

SELECT * FROM STUDENT;

        
        
        
        
--반복문2===========================================================================================================================        
--LOOP, END LOO  
--반복하면서 데이터를 삽입(EMP 테이블에 삽입)

DECLARE                 
    CNT NUMBER := 1000;     -- 반복문 변수 선언

BEGIN
    LOOP 
        INSERT INTO EMP(EMPNO, ENAME, DEPTNO)              -- EMP(EMPNO, ENAME, DEPTNO)의 CNT조건에 만족할 때 까지 설정한 내용들을 순차적으로 넣는다
            VALUES(CNT, 'HONG' || CNT, 40);       
        CNT := CNT +1 ;                                    -- CNT 값을 1씩 증가시킨다
        
    EXIT WHEN CNT > 1010;                                  -- EXIT WHEN 조건; : 조건을 주고 반복문을 빠져나가게 하는 코드    
    END LOOP;     
END;
/

SELECT * FROM EMP; 

DELETE FROM EMP WHERE DEPTNO = '40';


--문제===========================================================================================================================   
-- 1부터 100까지 계속 더하기

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
        
    EXIT WHEN CNT > 100;    --100이 될 때까지 반복해라                                  
    END LOOP; 
    
    DBMS_OUTPUT.PUT_LINE(EVEN_SUM);
    DBMS_OUTPUT.PUT_LINE(ODD_SUM);
    
END;
/


--MOD================================================================================
-- 첫번째 값에서 두번 째 값을 나누고 나머지 값을 출력한다.

SELECT MOD(11,2)
FROM DUAL;



--WHILE ~ LOOP===========================================================================================================================   
-- 자바에서의 FOR문과 비슷하다.

DECLARE                 
    CNT NUMBER := 1;     
    ODD_SUM NUMBER := 0;   
    EVEN_SUM NUMBER := 0;   
        
BEGIN
    WHILE CNT <= 100 LOOP  -- WHILE 조건 LOOP // CNT 값이 100이 될때까지 반복해라
             
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

        
--문제================================================================================        
-- 1. 반복을 하면서 EMP테이블에 데이터를 삽입 (EMPNO, ENAME -> 'HONG', DEPTNO -> 40)        
-- 2. 시퀀스(PL-SEQ) - 1000부터 시작하는 시퀀스 만들기
-- 3. EMPNO 값은 시퀀스로 채우기
-- 4. CNT는 1부터 시작해서 10번 반복

-- EMPNO 즉 PK 값이 중복이 안되기 때문에 필요에 따라서 값을 증가 시킬 수 있다.
        
CREATE SEQUENCE PL_SEQ
INCREMENT BY 1              -- 1씩 증가    
START WITH 1000
MINVALUE 1000               -- 최소값
MAXVALUE 10000              -- 최대값
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
        
        
        
        
        
        
        
        
        
        
        
        
        