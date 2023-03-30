SELECT * FROM T_USER;
SELECT * FROM T_BOARD;
SELECT * FROM T_BOARDCOMMENT;
SELECT * FROM T_BOARDFILE;


SET SERVEROUTPUT ON; 

--1. 문제==========================================================================================================
-- 1-1. 대상 : T_USER, 프로시저명 : UPDATE_USER1
-- 1-2. 호출방법 : EXECUTE UPDATE_USER (id-문자열, Point-숫자)
-- 1-3. 결과 : 해당 id를 가진 사람의 포인트를 입력한 point값으로 변경



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








--2. 문제==========================================================================================================
-- 2-1. 대상 : T_USER, 프로시저명 : SELECT_USER1
-- 2-2. 호출방법 : EXECUTE SELECT_USER (gender-문자열, Point-숫자)
-- 2-3. 결과 : 해당 성별을 가진 대상으로 입력한 point값보다 많은 사람들의 리스트를 출력(아이디. 닉네임, 포인트)


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

    --반복문 설정--    

    FOR USER_LIST IN ( SELECT ID, NICKNAME, POINT
                       FROM T_USER
                       WHERE GENDER = V_GENDER AND POINT > V_POINT) LOOP
                     
    i := i + 1;                
    ID_ARR(i) := USER_LIST.ID;
    NICK_ARR(i) := USER_LIST.NICKNAME;
    POINT_ARR(i) := USER_LIST.POINT;

END LOOP;   

    FOR CNT IN 1..i LOOP
    
    DBMS_OUTPUT.PUT_LINE('아이디 : ' || ID_ARR(CNT) );
    DBMS_OUTPUT.PUT_LINE('닉네임 : ' || NICK_ARR(CNT) );
    DBMS_OUTPUT.PUT_LINE('포인트 : ' || POINT_ARR(CNT) );
    DBMS_OUTPUT.PUT_LINE('====================================');

END LOOP;    

END SELECT_USER1;
/

EXECUTE SELECT_USER1('M', 500);

SELECT * FROM T_USER;



--묵시적 커서===================================================================================================================

-- SQL%ROWCOUNT : SQL 실행 후 영향받은 행의 수
-- SQL%FOUND : SQL 실행 후 영향받은 행이 있을 경우 TRUE 리턴
-- SQL%NOTFOUND : SQL 실행 후 영향받은 행이 없을 경우 TRUE 리턴


--아이디를 매개변수로 보내서 검색 결과가 있으면 포인트 10% 증가시키는 예시

CREATE OR REPLACE PROCEDURE CURSOR_TES2
    (P_ID IN T_USER.ID%TYPE )
IS
    V_POINT T_USER.POINT%TYPE;                   --포인트 결과를 먼저 찾는 변수 선언.
    V_CNT NUMBER;                                -- CNT는 컬럼에 포함이 안되어 있기 때문에 NUMBER로 타입을 정한다.

BEGIN

    SELECT POINT INTO V_POINT                    -- POINT 증가 값을 V_POINT에 담을 때 INTO를 사용한다.
    FROM T_USER
    WHERE ID = P_ID ;


    IF SQL%FOUND THEN                            -- 검색결과가 있을 때 밑의 내용을 출력하라는 뜻 // 컬럼에 없는 아이디를 보낼 때 사용하는 방법 //
        DBMS_OUTPUT.PUT_LINE('검색한 데이터의 포인트 : ' || V_POINT);
    
    END IF;
    
    UPDATE T_USER                                  -- 입력한 아이디의 포인트를 10% 증가.
    SET POINT = POINT * 1.1
    WHERE ID = P_ID ; 
    
    V_CNT := SQL%ROWCOUNT ;                         -- 업데이트 수의 따라서 V_CNT의 값이 변경된다.
    DBMS_OUTPUT.PUT_LINE('포인트 증가 인원수 : ' || V_CNT); 
    
    EXCEPTION                                      -- 예외처리
       WHEN NO_DATA_FOUND THEN                     -- 언제, 어떤 예외를 처리할 것인지에 대하여 조건을 걸어야 하기 때문에 IF가 아닌 WHEN THEN이 들어간다. 
        DBMS_OUTPUT.PUT_LINE('데이터 없음'); 

END;
/

EXECUTE CURSOR_TES2 ('test123');

SELECT * FROM T_USER;




--★ 명시적 커서===================================================================================================================
-- 커서는 쿼리가 실행 되었을 때 임시메모리 공간에 저장하는 용도이다.

-- 1. 커서 선언 → CURSOR 커서명
   --EX) CURSOR 커서명 IS SELECT 속성 FROM 테이블    // 결과가 커서명의 임시로 담긴다.
   
-- 2. 커서 열기 → OPEN 커서명                      
   --EX) OPEN 커서명
   
-- 3. 데이터 추출 → FETCH 커서명                    
   --EX) FETCH 커서명 INTO 변수
   
-- 4. 커서 종료 → CLOSE 커서명
   --EX) CLOSE 커서명



-- 문제 ===================================================================================================================
-- 30번 부서에 근무하고 있는 사람의 이름과 부서 번호 출력

DECLARE 
    V_ENAME EMP.ENAME%TYPE;
    V_DEPTNO EMP.DEPTNO%TYPE;
    
    CURSOR TEST_CUR IS                     --커서명 선언과 SELECT로 조건을 입력한다. 그렇게 되면 조건 값이 TEST_CUR로 임시로 저장된다.
        SELECT ENAME, DEPTNO
        FROM EMP
        WHERE DEPTNO = '30';

BEGIN
    OPEN TEST_CUR;                           -- 선언한 커서명을 오픈해줘야 한다.
    LOOP                                     -- 임시테이블을 사용하는 것이 아닌 반복문을 바로 사용 할 것이기 때문에 LOOP를 사용한다.
        FETCH TEST_CUR INTO V_ENAME, V_DEPTNO;  --
        
    EXIT WHEN TEST_CUR%NOTFOUND;                -- 반복문을 빠져나갈 조건을 묵시적 커서인 %NOTFOUND를 사용하여 데이터가 없을 경우  빠져나가게 한다.
        DBMS_OUTPUT.PUT_LINE('이름 : ' || V_ENAME);
        DBMS_OUTPUT.PUT_LINE('부서번호 : ' || V_DEPTNO);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
    END LOOP;
    
    CLOSE TEST_CUR;

END;
/


SELECT * FROM STUDENT;
SELECT * FROM ENROL;

--1. 문제 ===================================================================================================================
-- STUDENT 테이블
-- EXECUTE 프로시저명('컴퓨터정보');            --매개변수 학과
-- 해당 학과 학생들의 학번, 이름, 평균 점수 출력


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
        DBMS_OUTPUT.PUT_LINE('학번 : ' || V_STUNO);
        DBMS_OUTPUT.PUT_LINE('이름 : ' || V_STUNAME);
        DBMS_OUTPUT.PUT_LINE('평균점수 : ' || V_GRADE);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
     END LOOP;
    
    CLOSE D_TEST;


END;
/


EXECUTE DEPT_TEST ('컴퓨터정보');  




SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;

--2. 문제 ===================================================================================================================
-- 기준테이블 : ORDER_TABLE
-- EXECUTE 프로시저명('test123');            --매개변수 아이디
-- 해당 아이디를 가진 사람의 닉네임, 구매제품 이름, 배송상태 (배송중, 배송완료 등... T_CODE조언)


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
        DBMS_OUTPUT.PUT_LINE('닉네임 : ' || V_NICKNAME);
        DBMS_OUTPUT.PUT_LINE('구매제품 : ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('배송상태 : ' || V_KIND);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
     END LOOP;
        DBMS_OUTPUT.PUT_LINE('전체데이터수 : ' || O_TEST%ROWCOUNT);   -- 전체데이터수가 몇개인지 알려주는 문구를 출력 할 수 있다.
    
    CLOSE O_TEST;

END;
/

EXECUTE ORDER_TSET ('test123'); 




--2. 문제를 FOR문으로 푸는 방법 ===================================================================================================================
-- 변수 생략
-- FETCH, OPEN, CLOSE 생략 
-- 단순출력을 할 때는 FOR문 데이터 추가가 필요한 경우에는 원래의 방식을 사용한다.

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
                    
        DBMS_OUTPUT.PUT_LINE('닉네임 : ' || F_LIST.V_NICKNAME);
        DBMS_OUTPUT.PUT_LINE('구매제품 : ' || F_LIST.V_PNAME);
        DBMS_OUTPUT.PUT_LINE('배송상태 : ' || F_LIST.V_KIND);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
     END LOOP;
     
        DBMS_OUTPUT.PUT_LINE('전체데이터수 : ' || O_TEST%ROWCOUNT);   -- 전체데이터수가 몇개인지 알려주는 문구를 출력 할 수 있다.

END;
/

EXECUTE ORDER_TSET ('test123'); 





--2. 문제 ===================================================================================================================
-- 기준테이블 : EMP
-- EXECUTE 프로시저명('10'); --부서번호
-- 해당 부서번호 사람들의 사번, 이름, 급여 출력
-- FOR LOOP로 처리하기



CREATE OR REPLACE PROCEDURE DNO_TSET
    (V_DEPTNO IN EMP.DEPTNO%TYPE)

IS
   
    CURSOR D_TEST IS                  
            SELECT EMPNO, ENAME, SAL  
            FROM EMP
            WHERE DEPTNO = V_DEPTNO
            FOR UPDATE;                             -- CURSOR에 순차적으로 접근하면서 UPDATE를 시키는 코드

BEGIN

    FOR F_LIST IN D_TEST LOOP   
        UPDATE EMP
        SET SAL = SAL + 10                           -- 반복시킬수록 조건에 맞는 직원들의 SAL값을 계속 업데이트 시켜줌
        WHERE CURRENT OF D_TEST;
                    
        DBMS_OUTPUT.PUT_LINE('사번 : ' || F_LIST.EMPNO);
        DBMS_OUTPUT.PUT_LINE('이름 : ' || F_LIST.ENAME);
        DBMS_OUTPUT.PUT_LINE('급여 : ' || F_LIST.SAL);
        DBMS_OUTPUT.PUT_LINE('----------------------------'); 
    
     END LOOP;
  
END;
/

EXECUTE DNO_TSET ('10'); 

SELECT * 
FROM EMP
WHERE DEPTNO = '10';





                                                                                                                
