-- HR --
SELECT *
FROM emp;
-- ORA-00942: table or view does not exist
-- 왜 ?  emp 테이블의 소유주는 scott이다. 
--  소유주(scott)에 emp 테이블을 사용할 수 있는 허락(권한)부여....
SELECT *
FROM scott.emp;
FROM 스키마.테이블명

 SELECT  5+3 , 5-3, 5*3, 5/3 
 FROM dual;
 --
 SELECT *
 FROM arirang;
 
 
 
 
 
 
 
 
 
 
 