
SELECT * FROM T_BOARD;
SELECT * FROM T_BOARDCOMMENT;
SELECT * FROM T_BOARDFILE;

SELECT * FROM T_PRODUCT;


SELECT * FROM T_PRODUCT P
LEFT JOIN T_RIMAGE I  ON P.P_ID = I.P_ID
WHERE THUMBNAILYN = 'Y'
;


