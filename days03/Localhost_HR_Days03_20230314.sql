-- HR --
-- CTRL + F7  키워드 대문자로 변환.
SELECT *
FROM all_users;
--
SELECT *
FROM user_users;
--
SELECT * 
FROM user_tables;
-- 
DESCRIBE
DESC employees;
-- 자바    "길동" + "홍"  문자열 연결연산자, concat()
-- ORA-01722: invalid number
-- Ora_Help 에서 오라클 연산자 ./ 검색
-- CONCAT(문자열1, 문자열2) - 문자열1과 문자열2를 연결하며, 합성 연산자 '||'와 동일합니다.
-- ORA-00904: " ": invalid identifier(식별자)  빈문자열
-- 오라클에서   문자열 또는 문자는     ''
-- 오라클에서는 날짜 와  문자(열)은    '' 를 사용한다. 
SELECT  first_name  -- AS "f_name"  -- 컬럼명의 별칭을 설정. 주의  "별칭명"
        , last_name -- "l name"   --  [AS] 별칭명   "" 생략가능하다. 
--      , first_name || " " || last_name
        , first_name || ' ' || last_name  AS name
        , CONCAT(  CONCAT( first_name, ' ' ) , last_name ) name
FROM employees;

-- 사용자가 소유 + 허가 받은 모든 테이블 정보를 조회
SELECT *
FROM tabs;
FROM user_tables;

-- ORA-01722: invalid number
--SELECT first_name + last_name
--FROM employees;




