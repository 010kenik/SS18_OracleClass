--  SYS --


SELECT TO_CHAR(  TO_DATE(  SUBSTR( ssn, 3, 4 ) ,   'MMDD' ) , 'TS')
   , TO_CHAR(  SYSDATE  , 'TS')
   , TO_CHAR(   TRUNC( SYSDATE ) , 'TS')
FROM insa;

-- (시험)
SELECT   TO_DATE(  '2021' , 'YYYY' )  -- 21     /10/01
, TO_DATE(  '2021-02' , 'YYYY-MM' )   -- 21/02/01
, TO_DATE(  '23' , 'DD' )   -- 22/10/23
FROM dual;
















