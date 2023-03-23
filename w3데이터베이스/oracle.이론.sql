/*
 
INNER JOIN은 양쪽에 데이터가 있을 때 출력되지만 
LEFT JOIN은 주가 되는(FROM) 테이블에 데이터가 있다면 서브쪽 테이블에 데이터가 없어도 NULL값으로 출력을 해준다.


INSERT INTO 테이블명 
VALUSE() = 보유하고 있는 컬럼의 수에따라 값을 넣는다.

*/

--LEFT JOIN 예시
SELECT *
FROM SUBJECT S  --주가 되는 데이터
LEFT JOIN ENROL E ON E.SUB_NO = S.SUB_NO; --서브가 되는 데이터


SELECT * FROM SUBJECT;
SELECT * FROM ENROL WHERE SUB_NP =111;


--INSERT INTO 예시
INSERT INTO BOOK                                   -- 모든 컬럼에 값을 넣을 때
VALUES(12, '스포츠미학', '한솔의학서적', 90000);

INSERT INTO BOOK (BOOKID, BOOKNAME, PUBLISHER)      -- VALUES 값에 원하는 컬럼 수만큼의 데이터를 넣을 때
VALUES(12, '스포츠미학', '한솔의학서적');


INSERT INTO BOOK (BOOKID, BOOKNAME, PUBLISHER)
VALUES(13, '스포츠123', '한솔');

SELECT * FROM BOOK;



DELETE FROM BOOK WHERE PRICE IS NULL;  --PRICE 컬럼에 NULL 데이터를 가진 값을 삭제시킨다.

INSERT INTO BOOK (BOOKID, BOOKNAME, PRICE, PUBLISHER)  -- INSERT INTO의 컬럼순서를 바꾸면 VALUES 순서도 똑같이 바꿔야 한다.
VALUES(13, '스포츠123', 90000 ,'한솔');



--
SELECT * FROM Imported_Book;




INSERT INTO BOOK (BOOKID, BOOKNAME, PUBLISHER, PRICE)
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
FROM Imported_Book;


SELECT * FROM Book;

--DUAL을 이용하면 임시로 테이블을 만들 수 있다. 즉 임시로 데이터를 출력하여 결과를 확인 할 수 있다.
SELECT ABS(-78), ABS(78), ROUND(4.852, 2)
FROM DUAL;


-- 특정 조건을 검색 할 때 사용함 --------------------------
SELECT SUBSTR(NAME, 1, 1) "성", COUNT(*) "인원"            
FROM CUSTOMER
GROUP BY SUBSTR(NAME, 1, 1);






--현재 날짜를 가져오는 코드
SELECT SYSDATE
FROM DUAL;





















