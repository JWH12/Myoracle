--[���� 4-1] -78�� +78�� ������ ���Ͻÿ�.

SELECT ABS (-78), 
       ABS (+78)
FROM DUAL;


--[���� 4-2] 4.875�� �Ҽ� ù° �ڸ����� �ݿø��� ���� ���Ͻÿ�.

SELECT ROUND(4.875 , 2 )
FROM DUAL;



--[���� 4-3] ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.

SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER;

SELECT ROUND(AVG(SALEPRICE), 2), C.CUSTID
FROM CUSTOMER C 
INNER JOIN ORDERS O ON C.CUSTID = O.CUSTID
GROUP BY C.CUSTID
;



--[���� 4-4] ���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ����� ���̽ÿ�.


UPDATE BOOK
 SET BOOKNAME = '��'  
    WHERE BOOKNAME LIKE '%�߱�%' 

;



--[���� 4-6] ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.







--[���� 4-8] ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. �� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.


SELECT O.ORDERID AS �ֹ���ȣ, TO_CHAR(ORDERDATE, 'YYYY-MM-DD') AS �ֹ��� , C.CUSTID AS ����ȣ, BOOKID  AS ������ȣ
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
WHERE ORDERDATE = '20/07/07'
;




--[���� 4-10] �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� ǥ���Ͻÿ�.

SELECT NAME, NVL(PHONE, '��������' )
FROM CUSTOMER
;




--[���� 4-11] ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.

SELECT CUSTID, NAME, PHONE
FROM CUSTOMER 
WHERE ROWNUM <= 2
;




--[���� 4-12] ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.

SELECT ORDERID, SALEPRICE
FROM ORDERS
WHERE SALEPRICE <= (
                SELECT AVG(SALEPRICE)
                FROM ORDERS
                )
;




--[���� 4-13] �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.

SELECT ORDERID, O.CUSTID, SALEPRICE
FROM ORDERS O
INNER JOIN (
                SELECT ROUND(AVG(SALEPRICE), 2) AVG_PRI, CUSTID
                FROM ORDERS
                GROUP BY CUSTID
                ) A ON O.CUSTID = A.CUSTID
WHERE SALEPRICE > A.AVG_PRI
;




--[���� 4-14] �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.


SELECT SUM(SALEPRICE) AS ���Ǹž�
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
WHERE ADDRESS LIKE '���ѹα�%'
;



--[���� 4-15] 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.

SELECT ORDERID, SALEPRICE
FROM ORDERS
WHERE SALEPRICE > ( 
                    SELECT MAX(SALEPRICE)
                    FROM ORDERS O
                    INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
                    WHERE O.CUSTID = '3' 

                    )
;



--[���� 4-17] ���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).

SELECT C.NAME AS ���̸�, SUM(SALEPRICE) AS �Ǹž�
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
GROUP BY C.NAME
;



--[���� 4-19] ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).

SELECT C.NAME AS ���̸�, SUM(SALEPRICE) AS �Ǹž�
FROM ORDERS O
INNER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
WHERE O.CUSTID <= 2 
GROUP BY C.NAME
;



--[���� 4-20] �ּҿ� �����ѹα����� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�.

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
    WHERE ADDRESS LIKE '���ѹα�%'  
    
;

SELECT * FROM vw_Customer;



--[���� 4-21] Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, ���迬�ơ� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.

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
WHERE NAME = '�迬��'
;
W2D5AM_Test


--[���� 4-22] [���� 4-20]���� ������ �� vw_Customer�� �ּҰ� �����ѹα����� ���� �����ش�. 






--[���� 4-23] �ռ� ������ �� vw_Customer�� �����Ͻÿ�.











