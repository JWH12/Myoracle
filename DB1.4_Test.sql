SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;                                               -- ���־��� �ڵ带 �ϳ��� ���̺� ��Ƴ��� ��찡 �ִ�.


SELECT P.* , C.NAME 
FROM PRODUCT P
LEFT JOIN T_CODE C ON P.KIND = C.CODE AND C.KIND = 'CLOTH';   -- �ڵ� �ΰ��� JOIN�Ͽ� Ű���忡 �°� ������ ���ϴ��� �����ִ� �ڵ�


SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE; 

SELECT O.P_ID, O.ID , C.NAME, U.NAME
FROM ORDER_TABLE O
INNER JOIN T_USER U ON U.ID = O.ID
LEFT JOIN T_CODE C ON O.STATUS = C.CODE AND C.KIND = 'STATUS' 
--�ֹ� Ȯ�� ���� ���� ���� ��
WHERE O.STATUS = 'E'
;


--1�� �ֹ��������� ���缮�� �ֹ� �� ���------------------------------------------------------------------------
-- ��ǰ ����(�������� �������� ��), ��ۻ���(�����, ��� �� ��) ���

SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;


SELECT U.NAME, P.P_NAME, P.S_PRICE,  C.NAME AS ��ǰ����, C2.NAME AS ��ۻ���
FROM T_USER U
INNER JOIN ORDER_TABLE O ON U.ID = O.ID
INNER JOIN PRODUCT P ON P.P_ID = O.P_ID
LEFT JOIN T_CODE C ON P.KIND = C.CODE AND C.KIND = 'CLOTH' 
LEFT JOIN T_CODE C2 ON O.STATUS = C2.CODE AND C2.KIND = 'STATUS'
WHERE  U.NAME = '���缮'
;



--2�� �ֹ��������� '����' ��ǰ�� �ֹ��� ����� �̸�, ��ǰ�� �̸�, �ǸŰ���, ����, ��ǰ����, �������, ��ۻ��� ���-------------------------
SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;

SELECT U.NAME AS �̸�, P.P_NAME AS ��ǰ�̸�, P.S_PRICE AS �ǸŰ���, C.NAME AS ����, C2.NAME ��ǰ����, C3.NAME ��ۻ���, C4.NAME ��ۻ���
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

--3�� ���� ��� ���� ���� ��ǰ�� ��ǰ�� , ��ǰ ����, ���� ���� ���---------------------------------------------------------

SELECT PR.P_NAME
FROM P_MANAGE P
INNER JOIN PRODUCT PR ON P.P_ID = PR.P_ID
GROUP BY PR.P_NAME

;








--4�� ���缮�� ������ '����' ��ǰ�� �� ����� ���� ���ϱ� ---------------------------------------------------------

SELECT * FROM T_USER;
SELECT * FROM PRODUCT;
SELECT * FROM P_MANAGE;
SELECT * FROM REVIEW;
SELECT * FROM ORDER_TABLE;
SELECT * FROM T_CODE;


SELECT U.NAME, C.NAME AS ��ǰ����, P2.P_SIZE, P2.COUNT
FROM T_USER U
INNER JOIN ORDER_TABLE O ON U.ID = O.ID
INNER JOIN PRODUCT P ON P.P_ID = O.P_ID
INNER JOIN P_MANAGE P2 ON P2.P_SIZE = O.P_SIZE
LEFT JOIN T_CODE C ON P.KIND = C.CODE AND C.KIND = 'CLOTH' 
LEFT JOIN T_CODE C2 ON O.STATUS = C2.CODE AND C2.KIND = 'STATUS'

WHERE  U.NAME = '���缮' AND P.KIND = 'C'
GROUP BY P2.P_SIZE

;



--5�� �ѹ��� �ֹ��� ���� ���� ��ǰ�� S������ ��ǰ�� ����---------------------------------------------------------









--6�� ��ۻ��°� 'ȯ��'�� ��ǰ���� ��� ���ϱ�---------------------------------------------------------





