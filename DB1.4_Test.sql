SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;                                               -- 자주쓰는 코드를 하나의 테이블에 모아놓는 경우가 있다.


SELECT P.* , C.NAME 
FROM PRODUCT P
LEFT JOIN T_CODE C ON P.KIND = C.CODE AND C.KIND = 'CLOTH';   -- 코드 두개를 JOIN하여 키워드에 맞게 무엇을 뜻하는지 보여주는 코드


SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE; 

SELECT O.P_ID, O.ID , C.NAME, U.NAME
FROM ORDER_TABLE O
INNER JOIN T_USER U ON U.ID = O.ID
LEFT JOIN T_CODE C ON O.STATUS = C.CODE AND C.KIND = 'STATUS' 
--주문 확정 값만 보고 싶을 때
WHERE O.STATUS = 'E'
;


--1번 주문내역에서 유재석이 주문 한 배송------------------------------------------------------------------------
-- 제품 종류(상의인지 하의인지 등), 배송상태(배송전, 배송 후 등) 출력

SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;


SELECT U.NAME, P.P_NAME, P.S_PRICE,  C.NAME AS 제품종류, C2.NAME AS 배송상태
FROM T_USER U
INNER JOIN ORDER_TABLE O ON U.ID = O.ID
INNER JOIN PRODUCT P ON P.P_ID = O.P_ID
LEFT JOIN T_CODE C ON P.KIND = C.CODE AND C.KIND = 'CLOTH' 
LEFT JOIN T_CODE C2 ON O.STATUS = C2.CODE AND C2.KIND = 'STATUS'
WHERE  U.NAME = '유재석'
;



--2번 주문내역에서 '모자' 제품을 주문한 사람의 이름, 제품의 이름, 판매가격, 색깔, 제품종류, 결제방법, 배송상태 출력-------------------------
SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;

SELECT U.NAME AS 이름, P.P_NAME AS 제품이름, P.S_PRICE AS 판매가격, C.NAME AS 색깔, C2.NAME 제품종류, C3.NAME 배송상태, C4.NAME 배송상태
FROM T_USER U
INNER JOIN ORDER_TABLE O ON U.ID = O.ID 
INNER JOIN PRODUCT P ON P.P_ID = O.P_ID
LEFT JOIN T_CODE C ON O.COLOR = C.KIND AND C.KIND = 'COLOR'
LEFT JOIN T_CODE C2 ON P.KIND = C2.CODE AND C2.KIND = 'CLOTH' 
LEFT JOIN T_CODE C3 ON P.KIND = C3.CODE AND C3.KIND = 'PURCHASE'
LEFT JOIN T_CODE C4 ON O.STATUS = C4.CODE AND C4.KIND = 'STATUS'
WHERE P.KIND = 'C'
;


------------------------------------------------------------------------------
SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;

--3번 가장 재고가 많이 남은 제품의 제품명 , 제품 종류, 남은 갯수 출력---------------------------------------------------------

SELECT PR.P_NAME
FROM P_MANAGE P
INNER JOIN PRODUCT PR ON P.P_ID = PR.P_ID
GROUP BY PR.P_NAME

;








--4번 유재석이 구매한 '모자' 제품의 각 사이즈별 수량 구하기 ---------------------------------------------------------

SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;


SELECT U.NAME, C.NAME AS 제품종류, P2.P_SIZE, P2.COUNT
FROM T_USER U
INNER JOIN ORDER_TABLE O ON U.ID = O.ID
INNER JOIN PRODUCT P ON P.P_ID = O.P_ID
INNER JOIN P_MANAGE P2 ON P2.P_SIZE = O.P_SIZE
LEFT JOIN T_CODE C ON P.KIND = C.CODE AND C.KIND = 'CLOTH' 
LEFT JOIN T_CODE C2 ON O.STATUS = C2.CODE AND C2.KIND = 'STATUS'

WHERE  U.NAME = '유재석' AND P.KIND = 'C'
GROUP BY P2.P_SIZE

;



--5번 한번도 주문이 되지 않은 제품의 S사이즈 제품들 삭제---------------------------------------------------------









--6번 배송상태가 '환불'인 제품들의 재고량 구하기---------------------------------------------------------





