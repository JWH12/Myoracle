--[질의 4-1] -78과 +78의 절댓값을 구하시오.

SELECT ABS (-78), 
       ABS (+78)
FROM DUAL;


--[질의 4-2] 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오.

SELECT ROUND(4.875 , 2 )
FROM DUAL;



--[질의 4-3] 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.

SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER;

SELECT ROUND(AVG(SALEPRICE), 2), C.CUSTID
FROM CUSTOMER C 
INNER JOIN ORDERS O ON C.CUSTID = O.CUSTID
GROUP BY C.CUSTID
;



--[질의 4-4] 도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록을 보이시오.


UPDATE BOOK
 SET BOOKNAME = '농구'  
    WHERE BOOKNAME LIKE '%야구%' 

;



--[질의 4-6] 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.







--[질의 4-8] 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.


SELECT O.ORDERID AS 주문번호, TO_CHAR(ORDERDATE, 'YYYY-MM-DD') AS 주문일 , C.CUSTID AS 고객번호, BOOKID  AS 도서번호
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
WHERE ORDERDATE = '20/07/07'
;




--[질의 4-10] 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시하시오.

SELECT NAME, NVL(PHONE, '연락없음' )
FROM CUSTOMER
;




--[질의 4-11] 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.

SELECT CUSTID, NAME, PHONE
FROM CUSTOMER 
WHERE ROWNUM <= 2
;




--[질의 4-12] 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.

SELECT ORDERID, SALEPRICE
FROM ORDERS
WHERE SALEPRICE <= (
                SELECT AVG(SALEPRICE)
                FROM ORDERS
                )
;




--[질의 4-13] 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.

SELECT ORDERID, O.CUSTID, SALEPRICE
FROM ORDERS O
INNER JOIN (
                SELECT ROUND(AVG(SALEPRICE), 2) AVG_PRI, CUSTID
                FROM ORDERS
                GROUP BY CUSTID
                ) A ON O.CUSTID = A.CUSTID
WHERE SALEPRICE > A.AVG_PRI
;




--[질의 4-14] ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.


SELECT SUM(SALEPRICE) AS 총판매액
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
WHERE ADDRESS LIKE '대한민국%'
;



--[질의 4-15] 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.

SELECT ORDERID, SALEPRICE
FROM ORDERS
WHERE SALEPRICE > ( 
                    SELECT MAX(SALEPRICE)
                    FROM ORDERS O
                    INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
                    WHERE O.CUSTID = '3' 

                    )
;



--[질의 4-17] 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력).

SELECT C.NAME AS 고객이름, SUM(SALEPRICE) AS 판매액
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
GROUP BY C.NAME
;



--[질의 4-19] 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).

SELECT C.NAME AS 고객이름, SUM(SALEPRICE) AS 판매액
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
WHERE O.CUSTID <= 2 
GROUP BY C.NAME
;



--[질의 4-20] 주소에 ‘대한민국’을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.

SELECT * FROM BOOK;
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER;


CREATE OR REPLACE VIEW vw_Customer
AS
    SELECT CUSTID
         , NAME
         , ADDRESS
         , PHONE
      FROM CUSTOMER
    WHERE ADDRESS LIKE '대한민국%'  
    
;

SELECT * FROM vw_Customer;



--[질의 4-21] Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, ‘김연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.

CREATE OR REPLACE VIEW VI_ORDER

AS        
        SELECT   C.NAME
               , B.BOOKNAME 
               , B.BOOKID
        FROM ORDERS O
        INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
        INNER JOIN BOOK B ON O.BOOKID = B.BOOKID
;
        
SELECT * FROM VI_ORDER;


SELECT O.ORDERID, BOOKNAME, SALEPRICE
FROM ORDERS O
INNER JOIN VI_ORDER VI ON O.BOOKID = VI.BOOKID
WHERE NAME = '김연아'
;
W2D5AM_Test


--[질의 4-22] [질의 4-20]에서 생성한 뷰 vw_Customer는 주소가 ‘대한민국’인 고객을 보여준다. 






--[질의 4-23] 앞서 생성한 뷰 vw_Customer를 삭제하시오.











