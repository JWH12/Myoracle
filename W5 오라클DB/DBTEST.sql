--DB �׽�Ʈ ���� ========================================================
--1�� ������ �������̺� ������ ����ϰ� ��
--2�� ���� ���̺�� �������̺��� 2���� ����ϰ� ��


-- �������̺�
--���� 1. T_BOOK ���̺��� ������ ���� �÷��� �ִ�.
--	BOOK_NO(PK), BOOK_NAME(å �̸�), BOOK_AUTHOR(����), PRICE(����)

--���� 2. T_USER ���̺��� ������ ���� �÷��� �ִ�.
--	USER_ID(PK), USER_NAME(�̸�), USER_ADDR(�ּ�)

--���� 3. T_ORDER ���̺��� ������ ���� �÷��� �ִ�.
--	BOOK_NO(FK), USER_ID(FK), S_DATETIME(�Ǹ��Ͻ�)




--���� 1. ������ ��� å ���� �ݾ��� ���ϴ� ������ �ۼ��Ͻÿ�.(��� �÷� : ���� �̸�, ���� ��� �ݾ�)


SELECT AVG(PRICE), USER_ID, USER_NAME
FROM T_BOOK B
INNER JOIN T_USER U ON U.USER_ID = O.USER_ID
INNER JOIN T_ORDER O ON B.BOOK_ID = O.BOOK_ID
GROUP BY USER_ID, USER_NAME;



--���� 2. T_USER ���̺��� USER_NAME�� 'ȫ�浿'�� ���ڵ尡 �ִ�. �ش� ������ ������ å�� �� ���� ���� å�� ������
--	����� ������ ����ϴ� ������ �ۼ��Ͻÿ�. (��� �÷� : ���� �̸�, ������ å�� ��)
--	��, ������ �̸� 'ȫ�浿'�� �ߺ��� �����Ͱ� ���ٰ� �����Ѵ�.

SELECT COUNT(*), USER_NAME
FROM T_ORDER O
INNER JOIN T_USER U ON U.USER_ID = O.USER_ID
GROUP BY USER_NAME
HAVING COUNT(*) > (
            SELECT COUNT(*)
            FROM T_ORDER O
            INNER JOIN T_USER U ON U.USER_ID = O.USER_ID
            WHERE USER_NAME = 'ȫ�浿')
;




--Ʈ���Ÿ� �ۼ��ϰ� T_BOARD ���̺��� ������� INSERT, UPDATE, DELETE�� �ѹ� �̻� ���� �� ����� ����Ͻÿ�
-- ���� 1. BOARD_TRIGGER ���̺� ����
-- (�÷� : L_BOARDNO, L_DATETIME, L_EVENT, L_USER)

-- ���� 2. Ʈ���� ���� �� T_BOARD ���̺��� �����Ͽ� BOARD_TRIGER ���̺� �����͸� INSERT �� ��
--(���� 1. BOARD_NO -> L_BOARDNO, ����ð� -> L_DATETIME, ���� ���� -> L_EVENT, ����ھ��̵� -> L_USER)
--(���� 2. ���� ������ ������ ����. INSERT => I, UPDATE -> U, DELETE -> D)


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
    VALUES('3', '�׽�Ʈ', '������', 'test125', NULL, NULL, '0', '4');


UPDATE T_BOARD
SET CNT = CNT + 1
WHERE BOARD_NO = '3';

    
DELETE FROM T_BOARD
WHERE BOARD_NO = '3';


SELECT * FROM BOARD_LOG;

SELECT * FROM T_BOARD;

