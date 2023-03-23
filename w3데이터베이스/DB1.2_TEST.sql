/*
SELECT * FROM BOOK;                                                     -- UPDATE 할 때는 PK값을 줘서 중복없이 실행하며 조건을 걸어서 바꿀 데이터를 명시한다. 

UPDATE BOOK                                                             -- 여러 곳을 수정할 때는 ,를 찍어 바꿀 데이터를 추가한다. 
SET
   BOOKNAME = '축구의 역사'
   , PRICE = 7000
WHERE 
  BOOKID = 1 ;        */
  
  
  
SELECT * FROM STUDENT; -- 학생 정보

SELECT * FROM ENROL;   -- 과목번호 학번 및 성적

SELECT * FROM Subject;  -- 과목명 및 관련 정보

  
  
  
  
--1번 20153075 학번 학생의 반을 B로 변경---------------------------------------------------
SELECT *
FROM STUDENT;

UPDATE STUDENT 
    SET STU_CLASS = 'B'
    
WHERE STU_NO = '20153075'
;



  
  
--2번 전체 평균보다 작은 키를 가진 학생의 키 1 증가--------------------------------------------------
SELECT *
FROM STUDENT;

UPDATE STUDENT
    SET STU_HEIGHT = STU_HEIGHT +1

 WHERE STU_HEIGHT < (
            SELECT AVG(STU_HEIGHT)
            FROM STUDENT ) ;



--서브쿼리
SELECT AVG(STU_HEIGHT) 
FROM STUDENT ;




 
--3번 평균점수가 65점 이하인 학생들의 몸무게 1증가----------------------------------------
SELECT *
FROM STUDENT;

UPDATE STUDENT
    SET STU_WEIGHT = STU_WEIGHT +1
    WHERE STU_NO IN (
                SELECT STU_NO
                FROM (
                    SELECT AVG(ENR_GRADE) AS STU_AVG, E.STU_NO
                    FROM ENROL E
                    INNER JOIN STUDENT S ON S.STU_NO = E.STU_NO
                    GROUP BY E.STU_NO
                )
                WHERE STU_AVG <= 65
            )
;
            
--서브쿼리 -- 평균점수
SELECT AVG(ENR_GRADE) AS STU_AVG, E.STU_NO
FROM ENROL E
INNER JOIN STUDENT S ON S.STU_NO = E.STU_NO
GROUP BY E.STU_NO  ;
  
  
  
  
--4번 컴퓨터개론 수업을 듣는 학생들의 키와 몸무게를 1씩 감소-------------------------------------------------------
SELECT *
FROM STUDENT;

UPDATE STUDENT 
SET
    STU_HEIGHT = STU_HEIGHT - 1
    , STU_WEIGHT = STU_WEIGHT - 1
WHERE STU_NO IN(
    SELECT S.STU_NO
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    INNER JOIN SUBJECT S2 ON S2.SUB_NO = E.SUB_NO
    WHERE S2.SUB_NAME = '컴퓨터개론'
)
;
  
--서브쿼리
SELECT S.STU_NO 
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT S2 ON S2.SUB_NO = E.SUB_NO
WHERE S2.SUB_NAME = '컴퓨터개론';
  
  
  
  
  
  
--5번 책 총 구매 비용이 가장 높은 사람의 이름, 주소, 총 구매액 출력------------------------------------------------------- 
  
SELECT NAME, ADDRESS, P_SUM
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
INNER JOIN (
    SELECT P_SUM, CUSTID
    FROM (
        SELECT SUM(SALEPRICE) AS P_SUM, CUSTID
        FROM ORDERS
        GROUP BY CUSTID
        ORDER BY P_SUM DESC                                                        -- DESC 내림차순 ARC 오름차순
    )
    WHERE ROWNUM = 1                                                                -- 값 중 최상단 하나의 값만 출력한다.
) A ON O.CUSTID = A.CUSTID
GROUP BY NAME, ADDRESS, P_SUM                                                      --GROUP BY에 여러 값을 넣을 경우 여러 값이 모두 동일한 값을 가져야 한다.
;-- DISTINCT를 사용하면 GROUP BY 를 마지막에 사용하지 않아도 된다.



--서브쿼리
SELECT SUM(SALEPRICE) AS P_SUM, CUSTID
FROM ORDERS
GROUP BY CUSTID
ORDER BY P_SUM DESC;


--6번 책 총 구매 비용이 가장 높은 사람과 가장 낮은 사람의 차이 구하기-------------------------------------------------------
SELECT MAX(P_SUM) - MIN(P_SUM)                                                      -- MAX 값에서 MIN 값을 뺀다.
FROM (
  
        SELECT SUM(SALEPRICE) AS P_SUM, CUSTID
        FROM ORDERS
        GROUP BY CUSTID
        ORDER BY P_SUM DESC
    );


--서브쿼리
SELECT SUM(SALEPRICE) AS P_SUM, CUSTID
FROM ORDERS
GROUP BY CUSTID
ORDER BY P_SUM DESC;


--7번 3개의 책을 구매한 사람의 이름, 주소, 책 구매 갯수 출력-------------------------------------------------------

SELECT NAME, ADDRESS, CNT
FROM ORDERS O
INNER JOIN CUSTOMER C ON C.CUSTID = O.CUSTID
INNER JOIN (
    SELECT CUSTID, CNT
    FROM (
        SELECT COUNT(*) AS CNT, CUSTID
        FROM ORDERS
        GROUP BY CUSTID
    ) WHERE CNT = 3
) A ON O.CUSTID = A.CUSTID
GROUP BY NAME, ADDRESS, CNT
;


--서브쿼리 
SELECT COUNT(*) AS CNT, CUSTID
FROM ORDERS
GROUP BY CUSTID;




--8번 책 총 구매 금액이 32000원 이하인 사람의 핸드폰 번호를 1234로 변경-------------------------------------------------------

UPDATE CUSTOMER
SET
    PHONE = '1234'
WHERE 
    CUSTID IN (
        SELECT CUSTID
        FROM (
            SELECT SUM(SALEPRICE) AS P_SUM, CUSTID
            FROM ORDERS
            GROUP BY CUSTID
            ORDER BY P_SUM DESC
        )
        WHERE P_SUM <= 32000
    );
    
   









SELECT * FROM book ;
SELECT * FROM customer ;
SELECT * FROM ORDERS ;










  
  
  
  
  
  
  
  