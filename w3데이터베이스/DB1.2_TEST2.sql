
SELECT * FROM book ;
SELECT * FROM customer ;
SELECT * FROM ORDERS ;

-- 1. 책 평균 구매 금액이 10000 이하인 사람의 핸드폰 번호를 1로 변경

UPDATE CUSTOMER
    SET PHONE = 1
    
    WHERE CUSTID IN(
            SELECT CUSTID 
            FROM(SELECT ROUND (AVG(SALEPRICE), 2) AS TOTAL ,C.CUSTID
                 FROM ORDERS O
                 INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
                 GROUP BY C.CUSTID
             )T WHERE T.TOTAL < 10000
    
                ) ;
SELECT * FROM CUSTOMER ;

--서브쿼리
SELECT ROUND (AVG(SALEPRICE), 2),C.CUSTID
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
GROUP BY C.CUSTID
;



-- 2. 책 평균 구매 금액이 가장 낮은 사람의 핸드폰 번호를 2로 변경

UPDATE CUSTOMER
    SET PHONE = 2
    WHERE CUSTID IN (
            SELECT MIN(T.TOTAL)
            FROM(SELECT AVG(SALEPRICE) AS TOTAL, C.CUSTID
                 FROM ORDERS O
                 INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
                 GROUP BY C.CUSTID
             )T 
                    )
;    
SELECT * FROM CUSTOMER;

--서브쿼리
SELECT ROUND (AVG(SALEPRICE), 2),C.CUSTID
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
GROUP BY C.CUSTID
;





-- 3. 학생들의 평균 성적이 가장 높은 학생과 가장 낮은 학생의 차이 구하기

SELECT MAX(ENR_GRADE) - MIN(ENR_GRADE) AS TOTAL
FROM enrol E
INNER JOIN STUDENT S ON E.STU_NO = S.STU_NO
;






-- 4. 2개의 수업을 들은 학생들의 평균점수와 1개의 수업을 들은 학생들의 평균점수의 차이 구하기



    SELECT AVG(ENR_GRADE)
    FROM STUDENT S 
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO
    WHERE S.STU_NO IN (                                                                                                 
        SELECT STU_NO
        FROM (                                                                 
            SELECT COUNT(*) AS CNT, STU_NO 
            FROM ENROL  
            GROUP BY STU_NO
        ) T
        WHERE T.CNT >= 2
    )
;





SELECT * FROM ENROL;
SELECT * FROM SUBJECT;
SELECT * FROM STUDENT;


-- 5. 컴퓨터 학과보다 평균이 낮은 학과와 점수 출력

SELECT STU_DEPT, ENR_GRADE
FROM ENROL E
INNER JOIN STUDENT S ON S.STU_NO = E.STU_NO
WHERE ENR_GRADE < (
        SELECT AVG(ENR_GRADE) CAVG
        FROM ENROL E
        INNER JOIN STUDENT S ON S.STU_NO = E.STU_NO
        WHERE STU_DEPT = '컴퓨터정보' 
      ) 
;


--서브쿼리
SELECT AVG(ENR_GRADE)
FROM ENROL E
INNER JOIN STUDENT S ON S.STU_NO = E.STU_NO
WHERE STU_DEPT = '컴퓨터정보'

;



-- 6. 컴퓨터 개론 수업을 듣는 학생들의 평균 점수보다 높은 점수를 가지고 있는 컴퓨터정보과 학생 출력








