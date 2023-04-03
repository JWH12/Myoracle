--DB 테스트 문제 ========================================================
--1번 문제는 가상테이블 문제와 비슷하게 냄
--2번 기존 테이블로 가상테이블문제 2번과 비슷하게 냄


-- 가상테이블
--조건 1. T_BOOK 테이블에는 다음과 같은 컬럼이 있다.
--	BOOK_NO(PK), BOOK_NAME(책 이름), BOOK_AUTHOR(저자), PRICE(가격)

--조건 2. T_USER 테이블에는 다음과 같은 컬럼이 있다.
--	USER_ID(PK), USER_NAME(이름), USER_ADDR(주소)

--조건 3. T_ORDER 테이블에는 다음과 같은 컬럼이 있다.
--	BOOK_NO(FK), USER_ID(FK), S_DATETIME(판매일시)




--문제 1. 유저별 평균 책 구매 금액을 구하는 쿼리를 작성하시오.(출력 컬럼 : 유저 이름, 구매 평균 금액)


SELECT AVG(PRICE), USER_ID, USER_NAME
FROM T_BOOK B
INNER JOIN T_USER U ON U.USER_ID = O.USER_ID
INNER JOIN T_ORDER O ON B.BOOK_ID = O.BOOK_ID
GROUP BY USER_ID, USER_NAME;



--문제 2. T_USER 테이블에는 USER_NAME이 '홍길동'인 레코드가 있다. 해당 유저가 구매한 책의 수 보다 많은 책을 구매한
--	사람의 정보를 출력하는 쿼리를 작성하시오. (출력 컬럼 : 유저 이름, 구매한 책의 수)
--	단, 유저의 이름 '홍길동'은 중복된 데이터가 없다고 가정한다.

SELECT COUNT(*), USER_NAME
FROM T_ORDER O
INNER JOIN T_USER U ON U.USER_ID = O.USER_ID
GROUP BY USER_NAME
HAVING COUNT(*) > (
            SELECT COUNT(*)
            FROM T_ORDER O
            INNER JOIN T_USER U ON U.USER_ID = O.USER_ID
            WHERE USER_NAME = '홍길동')
;




--트리거를 작성하고 T_BOARD 테이블을 대상으로 INSERT, UPDATE, DELETE를 한번 이상씩 실핼 후 결과를 출력하시오
-- 조건 1. BOARD_TRIGGER 테이블 생성
-- (컬럼 : L_BOARDNO, L_DATETIME, L_EVENT, L_USER)

-- 조건 2. 트리거 실행 시 T_BOARD 테이블을 참조하여 BOARD_TRIGER 테이블에 데이터를 INSERT 할 것
--(참고 1. BOARD_NO -> L_BOARDNO, 현재시간 -> L_DATETIME, 실행 종류 -> L_EVENT, 사용자아이디 -> L_USER)
--(참고 2. 실행 종류는 다음과 같음. INSERT => I, UPDATE -> U, DELETE -> D)


CREATE TABLE BOARD_LOG(
    L_BOARDNO NUMBER,
    L_DATETIME DATE,
    L_EVENT VARCHAR2(40),
    L_USER VARCHAR2(40)
    
);



CREATE OR REPLACE TRIGGER BOARD_TRIGGER

    AFTER
    
    INSERT OR UPDATE OR DELETE ON T_BOARD
    
    FOR EACH ROW 
    
BEGIN
    IF INSERTING THEN
       INSERT INTO BOARD_LOG
        VALUES(:NEW.BOARD_NO, SYSDATE, 'I', SYS_CONTEXT('USERENV','SESSION_USER'));
        
    ELSIF UPDATING THEN
        INSERT INTO BOARD_LOG
        VALUES(:NEW.BOARD_NO, SYSDATE, 'U', SYS_CONTEXT('USERENV','SESSION_USER'));
        
    ELSIF DELETING THEN
        INSERT INTO BOARD_LOG
        VALUES(:OLD.BOARD_NO, SYSDATE, 'D', SYS_CONTEXT('USERENV','SESSION_USER'));
        
    END IF;
    
END BOARD_TRIGGER;
/


INSERT INTO T_BOARD (BOARD_NO, TITLE, CONTENT, ID, CDATETIME, UDATETIME, CNT, KIND) 
    VALUES('3', '테스트', '하하이', 'test125', NULL, NULL, '0', '4');


UPDATE T_BOARD
SET CNT = CNT + 1
WHERE BOARD_NO = '3';

    
DELETE FROM T_BOARD
WHERE BOARD_NO = '3';


SELECT * FROM BOARD_LOG;

SELECT * FROM T_BOARD;

