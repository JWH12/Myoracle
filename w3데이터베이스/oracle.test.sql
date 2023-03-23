/* 1. 
SELECT DISTINCT publisher, bookname  -- DISTINCT는 중복제거이다 하지만 해당 컬럼에 모두 해당되야한다. 

FROM book;  */

/* 
SELECT * FROM book
where price >= 10000;           -- book 컬럼 중 price가 10000원 이상인 값만 출력한다.     */
 
/*
SELECT * FROM book
where price = 13000 and publisher = '이상미디어';  -- 다른 조건을 붙일 때는 and 및 or을 붙인다. */

/*
SELECT * FROM book
where price BETWEEN 10000 and 20000  --BETWEEN은 두개의 값의 사이값을 출력한다. 즉, 10000원 이상 20000원 이하의 값을 출력하겠다. 위의 코드와 똑같은 값을 출력하는 코드이다 */


