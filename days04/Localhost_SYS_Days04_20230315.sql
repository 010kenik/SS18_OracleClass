-- SYS --
-- 심성환(예비군훈련)
-- 1)
SELECT *
FROM dba_role_privs
WHERE grantee = 'DBA';
-- 2) RR/YY 차이점
SELECT
    '05/01/10'
    , TO_CHAR(  TO_DATE( '05/01/10', 'RR/MM/DD'), 'YYYY' ) a
    , TO_CHAR(  TO_DATE( '05/01/10', 'YY/MM/DD'), 'YYYY' ) b
    , TO_CHAR(  TO_DATE( '95/01/10', 'RR/MM/DD'), 'YYYY' ) a
    , TO_CHAR(  TO_DATE( '95/01/10', 'YY/MM/DD'), 'YYYY' ) b
FROM emp;
-- 3) 
SELECT *
FROM GV$RESERVED_WORDS 
-- FROM V$RESERVED_WORDS ;
WHERE keyword LIKE '%MONTH%';
-- 4) SYS 계정 
SELECT * 
FROM DICTIONARY
WHERE table_name LIKE '%WORDS%';
--  date 키워드 확인
SELECT *
FROM V$RESERVED_WORDS
WHERE keyword = UPPER( 'date' );

-- 5)
SELECT * 
FROM user_indexes;
FROM ind;