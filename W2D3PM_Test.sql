-- 조건 1. 게시판의 종류는 공지사항, 문의게시판, 자유게시판
-- 조건 2. 공지사항 및 자유게시판은 첨부파일(이미지, txt파일 등)을 저장하는 기능이 있음
-- 조건 3. 게시판을 클릭 시 공통적으로 가지고 있는 내용은 제목, 내용, 작성자, 게시일, 조회수
-- 조건 4. 각 게시글에는 댓글을 달 수 있음. 단, 댓글에는 이미지 및 첨부파일 불가
-- 조건 5. 게시판의 메인 테이블의 경우 pk를 시퀀스로 자동 지정 되도록 함.
-- 기타 조건 1. 메인 테이블 명은 T_BOARD. 테이블 추가가 필요할 경우 T_BOARDXXX로 정의할 것.
-- 기타 조건 2. 오라클, mysql 원하는 db툴 사용
-- 기타 조건 3. 회원테이블은 기존 T_USER 테이블을 사용할 것


SELECT * FROM T_USER;
SELECT * FROM T_BOARD;
SELECT * FROM T_BOARDCOMMENT;
SELECT * FROM T_BOARDFILE;


-- 2번 게시글의 제목, 내용, 작성자 닉네임, 댓글 내용, 댓글 작성자 닉네임 출력

SELECT  TITLE, B.CONTENT, U.NICKNAME AS 게시글작성자, BC.CONTENT AS 댓글, U2.NICKNAME 댓글작성자, F.* --하나의 댓글의 두개의 첨부파일을 넣어주는 상황이 되기 때문에 같은 댓글이 나온다.
FROM T_BOARD B
INNER JOIN T_BOARDCOMMENT BC ON B.BOARD_NO = BC.BOARD_NO
INNER JOIN T_USER U ON B.ID = U.ID
INNER JOIN T_USER U2 ON BC.ID = U2.ID
INNER JOIN T_BOARDFILE F ON B.BOARD_NO = F.BOARD_NO 
;














