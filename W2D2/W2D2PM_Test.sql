-- 트리거 -> UPDATE, DELETE, INSERT 등 활동을 할 때 로그기록을 남기는 역할을 한다.

-- PLSQL 프로그래밍을 한다.
-- DECLARE 변수 및 상수를 선언한다
-- BEGIN 실행 할 수 있도록 하는 역할을 한다.
-- EXCEPTION(예외처리) / END

SET SERVEROUTPUT ON;                -- 오라클을 켰을 때 최초 한번 실행해야 한다.

--변수선언 코드
DECLARE 
    NAME VARCHAR2(10) := '홍길동' ;                                          -- DECLARE 작성법 : 컬럼명, 타입, := , '' ;
           BEGIN                                                                       -- 실행 문인 BEGIN 입력
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);                                 -- JAVA의 SYSTEM.OUT.PRINTLN();와 같다
END;                                                             -- END 문으로 끝을 낸다.    
/                                                                           -- 작성 후 /를 입력해야 중복으로 실행이 안된다.


-- 프로시저 ======================================================================



-- EMP테이블에서 EMPNO를 입력 받아서 받은 요소의 SAL값을 100 추가

CREATE OR REPLACE PROCEDURE UPDATE_PRO
    (V_EMPNO IN NUMBER)                                              --매개변수를 하나를 지정하여 받는다
    IS 
    BEGIN                                                            -- 실행문        
        UPDATE EMP
        SET SAL = SAL+100
        WHERE EMPNO = V_EMPNO;                                      -- 입력 받는 원본테이블을 명시해줘야 한다.
        COMMIT;     
    END UPDATE_PRO;                                                -- 종료 할 프로시저를 명시해줘야 한다.


--호출 명령어
EXECUTE UPDATE_PRO(7369);

SELECT * FROM EMP;




--

DECLARE 
    V_ENAME EMP.ENAME%TYPE;                                       -- EMP 테이블에 있는 ENAME의 컬럼의 타입과 동일하게 설정하는 방법 
    V_DEPTNO EMP.DEPTNO%TYPE;                                    -- EMP 테이블에 있는 DEPTNO의 컬럼의 타입과 동일하게 설정하는 방법              

BEGIN                                                             -- 실행 문인 BEGIN 입력

    SELECT ENAME, DEPTNO  INTO V_ENAME, V_DEPTNO                   -- SELECT 통해서 입력받을 값을 INTO로 불러온다       
    FROM EMP
    WHERE EMPNO  = '7369';
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_ENAME);                     -- JAVA의 SYSTEM.OUT.PRINTLN();와 같다
    DBMS_OUTPUT.PUT_LINE('부서 : ' || V_DEPTNO);
END;                                                                        -- END 문으로 끝을 낸다.    
/                                                                           -- 작성 후 /를 입력해야 중복으로 실행이 안된다.


SELECT * FROM EMP;


-- 프로시저 문제=================================================================
-- 프로시저 이름 : INERT_PRO
-- INERT_PRO(1234, 'HONG', 'SALESMAN', 7698, SYSDATE, 3000, 100, 30)
-- 프로시저 이름 : DELETE_PRO
-- DELETE_PRO(1234)



--INERT_PRO 프로시저

-- EMP.EMPNO%TYPE은 EMP테이블의 타입을 참고하겠다는 뜻이다.
-- V_가 들어간 값들은 변수 선언을 한것이다.
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
    INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)        -- 값을 받아 넣을 테이블을 명히하고 컬럼들을 ()안에 넣는다.
    VALUES (V_EMPNO, V_ENAME, V_JOB, V_MGR, V_HIREDATE, V_SAL,V_COMM, V_DEPTNO ); -- 위에서 받은 값을 선언한 변수들 안에 넣는다는 뜻
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('사원부서 : ' || V_DEPTNO);
    DBMS_OUTPUT.PUT_LINE('데이터 입력 성공');
END INSERT_PRO;
/

EXECUTE INSERT_PRO('1234', 'HONG', 'SALSEMAN', 7698, SYSDATE, 3000, 100, 30);




--DELETE_PRO 프로시저
--CREATE OR REPLACE PROCEDURE DELETE_PRO 
--     (V_EMPNO IN EMP.EMPNO%TYPE)
--IS
--
--BEGIN
--    
--
----    END; DELETE_PRO;



--2번 문제----------------------------------------------------------------------
-- SELECT_STUDENT
-- EXCUTE SELECT_STUDENT(170, 50)
-- 키가 170 몸무게가 50이상 학생의 학번, 이름, 학과, 성별 출력

CREATE OR REPLACE PROCEDURE SELECT_STUDENT      -- 프로시저를 새로 만들거나 대채해야 할 때  CREATE OR REPLACE를 사용한다.
    (V_HEIGHT IN STUDENT.STU_HEIGHT%TYPE,       -- 입력받는 요소
    V_WEIGHT IN STUDENT.STU_WEIGHT%TYPE)
IS
    V_STUNO STUDENT.STU_NO%TYPE;                -- 매개변수에 넣어 놓는 용도
    V_STUNAME STUDENT.STU_NAME%TYPE;
    V_STUDEPT STUDENT.STU_DEPT%TYPE;
    V_STUGENDER STUDENT.STU_GENDER%TYPE;

BEGIN 
    SELECT STU_NO, STU_NAME, STU_DEPT, STU_GENDER
      INTO V_STUNO, V_STUNAME, V_STUDEPT, V_STUGENDER 
    FROM STUDENT
    WHERE STU_HEIGHT >= V_HEIGHT AND STU_WEIGHT >= V_WEIGHT AND ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('학번 : ' || V_STUNO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_STUNAME);
    DBMS_OUTPUT.PUT_LINE('학과 : ' || V_STUDEPT);
    DBMS_OUTPUT.PUT_LINE('성별 : ' || V_STUGENDER);
    
END; 
/

EXECUTE SELECT_STUDENT(170, 50);





--%ROWTYPE은 해당 타입의 정보를 모두 가져온다=========================================================================================
--%TYPE은 컬럼 정보를 가져온다

-- EMP테이블에서 사번, 이름, 부서번호 출력

CREATE OR REPLACE PROCEDURE SELECT_ROW
    (P_EMPNO IN EMP.EMPNO%TYPE)
IS
    V_EMP EMP%ROWTYPE;                                        -- EMP테이블에 있는 컬럼들이 모두 V_EMP에 들어간다/ 특정 컬럼을 불러오고 싶으면 V_EMP.ENAME, V_EMP.DEPNO 으로 접근이 가능하다
BEGIN 
    SELECT EMPNO, ENAME, DEPTNO
        INTO V_EMP.EMPNO, V_EMP.ENAME,V_EMP.DEPTNO
    FROM EMP
    WHERE EMPNO  = P_EMPNO;
    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_EMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || V_EMP.DEPTNO);
END;
/

SELECT * FROM EMP;

EXECUTE SELECT_ROW(7369);



-- IF문 =====================================================================================================
-- 사번입력 -> 해당 사번에 속한 부서이름 출력
-- 부서이름 출력은 JOIN (X), DECODE (X), IF문으로만 출력

CREATE OR REPLACE PROCEDURE TEST_IF
    (P_EMPNO IN EMP.EMPNO%TYPE)
IS 
    V_DEPTNO EMP.DEPTNO%TYPE;
BEGIN 
    SELECT DEPTNO
        INTO V_DEPTNO
    FROM EMP
    WHERE EMPNO = P_EMPNO;
    IF V_DEPTNO = 10 THEN                                     -- V_DEPRNO 값이 10일 때 THEN(출력하라)
        DBMS_OUTPUT.PUT_LINE('부서는 ACC');
    ELSIF V_DEPTNO = 20 THEN                                                    --ELSIF = ELSE IF
         DBMS_OUTPUT.PUT_LINE('부서는 RCC');
    ELSIF V_DEPTNO = 30 THEN     
         DBMS_OUTPUT.PUT_LINE('부서는 SAL');
    ELSE    
         DBMS_OUTPUT.PUT_LINE('몰라');
    END IF;                                                        -- IF문은 종료시점을 알려주는 코드를 입력해서 마무리해줘야 한다.  
END;
/

SELECT * FROM EMP;
EXECUTE TEST_IF(7369);


--IF문제 ------------------------------------------------------------------------
--STUDENT 테이블 프로시저 생성
--호출은 학번으로
--STU_GRADE가 1이면 '신입생', 2이면 '2학년', 3이면 '졸업예정'이 출력되게 할 것


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
     DBMS_OUTPUT.PUT_LINE('신입생');
    ELSIF V_STUGRADE = 2 THEN
     DBMS_OUTPUT.PUT_LINE('2학년');
    ELSIF V_STUGRADE = 3 THEN
     DBMS_OUTPUT.PUT_LINE('졸업예정');
     ELSE    
     DBMS_OUTPUT.PUT_LINE('몰라');
     END IF;
END;

EXECUTE TEST_GRADE(20131001);

SELECT * FROM STUDENT;
















