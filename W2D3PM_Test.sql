-- ���� 1. �Խ����� ������ ��������, ���ǰԽ���, �����Խ���
-- ���� 2. �������� �� �����Խ����� ÷������(�̹���, txt���� ��)�� �����ϴ� ����� ����
-- ���� 3. �Խ����� Ŭ�� �� ���������� ������ �ִ� ������ ����, ����, �ۼ���, �Խ���, ��ȸ��
-- ���� 4. �� �Խñۿ��� ����� �� �� ����. ��, ��ۿ��� �̹��� �� ÷������ �Ұ�
-- ���� 5. �Խ����� ���� ���̺��� ��� pk�� �������� �ڵ� ���� �ǵ��� ��.
-- ��Ÿ ���� 1. ���� ���̺� ���� T_BOARD. ���̺� �߰��� �ʿ��� ��� T_BOARDXXX�� ������ ��.
-- ��Ÿ ���� 2. ����Ŭ, mysql ���ϴ� db�� ���
-- ��Ÿ ���� 3. ȸ�����̺��� ���� T_USER ���̺��� ����� ��


SELECT * FROM T_USER;
SELECT * FROM T_BOARD;
SELECT * FROM T_BOARDCOMMENT;
SELECT * FROM T_BOARDFILE;


-- 2�� �Խñ��� ����, ����, �ۼ��� �г���, ��� ����, ��� �ۼ��� �г��� ���

SELECT  TITLE, B.CONTENT, U.NICKNAME AS �Խñ��ۼ���, BC.CONTENT AS ���, U2.NICKNAME ����ۼ���, F.* --�ϳ��� ����� �ΰ��� ÷�������� �־��ִ� ��Ȳ�� �Ǳ� ������ ���� ����� ���´�.
FROM T_BOARD B
INNER JOIN T_BOARDCOMMENT BC ON B.BOARD_NO = BC.BOARD_NO
INNER JOIN T_USER U ON B.ID = U.ID
INNER JOIN T_USER U2 ON BC.ID = U2.ID
INNER JOIN T_BOARDFILE F ON B.BOARD_NO = F.BOARD_NO 
;














