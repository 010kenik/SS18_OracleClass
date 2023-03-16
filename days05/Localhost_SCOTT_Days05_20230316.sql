-- SCOTT --
-----------------------   
8-3. insa 테이블에서 연락처(tel)가 없는 사원은 '연락처 등록 안됨' 출력하는 쿼리를 작성. 
   ㄱ.  IS [NOT] NULL     SQL연산자
   ㄴ.  NVL()             NULL처리함수
SELECT i.* ,  NVL( tel , '연락처 등록 안됨') tel
FROM insa  i
WHERE tel IS NULL;
WHERE tel = NULL;

8-4. insa 테이블에서 개발부만 num, name, tel 컬럼 출력할 때 연락처(tel) 없는 사람은 X, O 출력하는 쿼리 작성.
  -- 자바    if~ else 문   ( 제어문 )              PL/SQL
  --         ?  :   삼항 연산자 X
  -- NVL2() / NVL()  함수  - 차이점
SELECT num, name, tel
     , NVL2( tel, 'O', 'X')
FROM insa
WHERE buseo = '개발부';
WHERE buseo LIKE '%개발%';

8-5.insa 테이블에서 남자는 'X', 여자는 'O' 로 성별(gender) 출력하는 쿼리 작성

    NAME                 SSN            GENDER
    -------------------- -------------- ------
    홍길동               771212-1022432    X
    이순신               801007-1544236    X
    이순애               770922-2312547    O
    김정훈               790304-1788896    X
    한석봉               811112-1566789    X 
    -- SUBSTR() 함수
    -- MOD() 함수    13579 남자
    -- REPLACE() 함수
    -- 첫 번째 방법
    SELECT t.name, t.ssn
       -- , if 1 O  0 X       PL/SQL
          , REPLACE(  REPLACE( t.gender, 1 , '남자' ) , 0 , '여자') gender
    FROM (  -- 인라인뷰(inline-view)
                SELECT name, ssn
                    ,  MOD(  SUBSTR( ssn,-7, 1  ) , 2 ) gender   -- 1(남자), 0(여자)
                FROM insa
        ) t;
    
    -- 두 번째 방법
    -- NULLIF() 함수  + NVL2() 함수
    【형식】
        NULLIF(expr1, expr2)
        expr1 == expr2     NULL
        expr1 != expr2     expr1
    -- HR    
    SELECT *        
    FROM tabs;    
    -- JOB_HISTORY 테이블 :  잡(업무) 히스토리
    SELECT *
    FROM job_history
    ORDER BY employee_id ASC;
    -- [고려] START_DATE(시작일자의 년도)와 END_DATE( 년도) 같으면 NULL 출력, 다르면 시작일자 출력
    SELECT employee_id    
    , TO_CHAR( start_date, 'YYYY') start_year
    , TO_CHAR( end_date, 'YYYY') end_year
    , NULLIF( TO_CHAR( start_date, 'YYYY') ,  TO_CHAR( end_date, 'YYYY')   )
    FROM job_history;
    
    -- NULLIF() , NVL2() 사용 두번째 방법.
    SELECT name, ssn
        ,  NVL2( NULLIF( MOD(  SUBSTR( ssn,-7, 1  ) , 2 ) , 1  ) ,  '여자' , '남자' )  gender   
    FROM insa;

9. employees 테이블에서  아래와 같이 출력되도록 쿼리 작성하세요. 
   
    FIRST_NAME          LAST_NAME                   NAME                                           
    -------------------- ------------------------- -----------------------------
    Samuel               McCain                    Samuel McCain                                  
    Allan                McEwen                    Allan McEwen                                   
    Irene                Mikkilineni               Irene Mikkilineni                              
    Kevin                Mourgos                   Kevin Mourgos                                  
    Julia                Nayer                     Julia Nayer   
    :
SELECT *
FROM tabs
WHERE table_name LIKE 'EMP%';  

DESC employees;

SELECT first_name, last_name
      , first_name || ' ' || last_name  name  --- **** ---
      , CONCAT( CONCAT(first_name, ' ' ) , last_name ) name
FROM employees;

10. emp 테이블에서  아래와 같은 조회 결과가 나오도록 쿼리를 작성하세요.

     EMPNO ENAME             SAL       COMM        PAY
---------- ---------- ---------- ---------- ----------
      7369 SMITH             800          0        800
      7499 ALLEN            1600        300       1900
      7521 WARD             1250        500       1750
      7566 JONES            2975          0       2975
      7654 MARTIN           1250       1400       2650
      7698 BLAKE            2850          0       2850
      7782 CLARK            2450          0       2450
      7839 KING             5000          0       5000
      7844 TURNER           1500          0       1500
      7900 JAMES             950          0        950
      7902 FORD             3000          0       3000
      7934 MILLER           1300          0       1300

	12개 행이 선택되었습니다.  
    
    SELECT EMPNO,  ENAME,             SAL
    ,      NVL(  COMM,  0) comm
    ,      NVL2( comm, comm, 0)  comm
    ,      sal + NVL(  COMM,  0)   PAY
    FROM emp   ;

11.   emp 테이블에서 10번 부서원 정보 조회
SELECT * 
FROM emp
WHERE deptno = 10;

11-2. emp 테이블에서 10번 부서원을 제외한 사원 정보를 조회(출력)
SELECT * 
FROM emp
WHERE deptno  IN (20,30,40) ;
WHERE deptno > 10;
WHERE deptno <> 10;
WHERE deptno ^= 10;
WHERE deptno != 10;

-- 10,20,30, 40    -  10
SELECT deptno
FROM dept;


11-3. emp 테이블에서 10번 또는 20번 부서원 정보를 조회
SELECT * 
FROM emp
WHERE deptno <= 20;
WHERE deptno = 10 OR deptno 20;
WHERE deptno  IN (20,10 ) ;

12. 사원명이 king 인 사원의 정보 조회
SELECT *
FROM emp
WHERE  REGEXP_LIKE( ename, '^king$' , 'i' );
WHERE ename = UPPER('king');
WHERE ename = 'KING';
WHERE ename = 'king';
-- ORA-00904: "NAME": invalid identifier

13. insa 테이블에서 출생지역이 수도권 아닌 사원의 정보를 조회.
  -- 수도권 ? 서울,인천,경기
  SELECT *
  FROM insa
  WHERE city NOT IN ( '서울','인천','경기' );  
  -- 형식 )   [NOT] IN ( list )  SQL 연산자.

14.  emp 테이블에서 comm 이  확인되지 않은 사원의 정보 조회
 (   comm 이    null 인 사원의 정보 조회 )
14-2. emp 테이블에서 comm 이  null 이 아닌 사원의 정보 조회  

15. HR 계정의 생성 시기와 [잠금상태]를 확인하는 쿼리를 작성하세요.
   dba_XXX
   all_XXX
   user_XXX

  SELECT username, account_Status, created
  FROM dba_users;

   dba_users ***
   all_users
   user_users
   
   dba_tables
   all_tables
   user_tables == tabs    / tab

[문제] KING 사원을 부서번호 null 로 수정하세요.
 -- 수정/삭제를 하기 전에  검색
 SELECT empno  --고유한키(PK)
 FROM emp
 WHERE ename = 'KING';

 UPDATE emp
 SET deptno = null
 WHERE empno = 7839;
 COMMIT;
 -- WHERE 조건절 이 없으면 모든 레코드를 수정
 ROLLBACK;
 SELECT * 
 FROM emp;

16.  emp테이블에서
   각 부서별로 오름차순 1차 정렬하고 급여(PAY)별로 2차 내림차순 정렬해서 조회하는 쿼리를 작성하세요.    
   -- ORDER BY 절
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
   ORDER BY 1 ASC, 3 DESC; 
   ORDER BY deptno ASC, pay DESC; 
   

17. emp 테이블에서 부서번호가 10번이고, 잡이 CLERK  인 사원의 정보를 조회하는 쿼리 작성.
    WHERE   deptno =10 AND job = 'CLERK'

17-2. emp 테이블에서 잡이 CLERK 이고, 부서번호가 10번이 아닌 사원의 정보를 조회하는 쿼리 작성.
    WHERE   deptno !=10 AND job = 'CLERK'

10:05 수업 시작~
17-3.  emp 테이블에서 부서번호가 30번이고, 커미션이 null인 사원의 정보를 조회하는 쿼리 작성.
  ( ㄱ.  deptno, ename, sal, comm,  pay 컬럼 출력,  pay= sal+comm )
  ( ㄴ. comm이 null 인 경우는 0으로 대체해서 처리 )
  ( ㄷ. pay 가 많은 순으로 정렬 ) 
  
18. Alias 를 작성하는 3가지 방법을 적으세요.
   SELECT deptno, ename 
     , sal + comm   (ㄱ)  AS "pay"
     , sal + comm   (ㄴ)  pay
     , sal + comm   (ㄷ)  "pay"
    FROM emp;
    
--------------------------------------------------------------------------------
오라클 연산자 ( operator )
오라클 함수 ( function )
오라클 자료형 ( data type )
--------------------------------------------------------------------------------
SQL - DQL(SELECT), DDL(CREATE, DROP, ALTER), DML(INSERT,UPDATE,DELETE), DCL(GRANT, REVOKE), TCL(COMMIT, ROLLBACK)
PL/SQL

11:02 수업 시작~ 
--------------------------------------------------------------------------------
오라클 연산자 ( operator )
--------------------------------------------------------------------------------
1. 비교 연산자 :  숫자, 문자, 날짜  
   =
   != <> ^= 
   > <
   >= <=   
   SQL연산자 : ANY, SOME, ALL  + [서브쿼리(subquery)]

2. 논리 연산자 : WHERE 절에서 여러 개의 조건을 결합할 경우
                AND, OR, NOT
   [AND]                
   TRUE NULL   NULL 
   NULL FALSE  FALSE
   [OR]
   TRUE NULL   TRUE
   NULL FALSE  NULL

3. SQL 연산자
    [NOT] IN ( list )
    [NOT] BETWEEN a AND b
    [NOT] LIKE
    IS [NOT] NULL
    
    ANY, SOME, ALL,                   EXISTS
    
 -- EXISTS 연산자    
    SELECT p.ename,p.job, p.sal , p.deptno
    FROM emp p
    WHERE EXISTS (                -- 상관서브쿼리 주로 사용, TRUE/FALSE
                     SELECT 'x' 
                     FROM dept 
                     WHERE deptno=p.deptno
                 );
FALSE
SELECT 'x' 
 FROM dept 
 WHERE deptno=10;
-- 12:03 수업 시작~ 

[문제] emp 테이블에서 급여를 가장 많이 받는 사원의 정보를 조회.
-- ( 비교연산자 + ALL SQL연산자 )
SELECT e.*,   sal + NVL(comm, 0) pay
FROM emp e
ORDER BY pay DESC; 
--
SELECT e.*,   sal + NVL(comm, 0) pay
FROM emp e 
WHERE sal + NVL(comm, 0) <= ALL(  SELECT sal + NVL(comm, 0) FROM emp   );
WHERE sal + NVL(comm, 0) >= ALL(  SELECT sal + NVL(comm, 0) FROM emp   );
-- PL/SQL
-- 변수 max_pay = SELECT   MAX( sal + NVL( comm, 0 )  ) max_pay                                 FROM emp
SELECT e.* 
FROM emp e
WHERE sal + NVL(comm, 0) = (
                                SELECT   MAX( sal + NVL( comm, 0 )  ) max_pay 
                                FROM emp
                            );
WHERE sal + NVL(comm, 0) = 5000;
-- 사원중 급여 가장 많이 받는 급여 조회
-- MAX()/MIN() 함수
SELECT  MAX(   sal  )   max_sal
      , MIN(   sal   )  min_sal
      , MAX( sal + NVL( comm, 0 )  ) max_pay
      , MIN( sal + NVL( comm, 0 )  ) min_pay
FROM emp;  -- 289행, 1열에서 오류 발생
-- ORA-00907: missing right parenthesis

SELECT   MAX( sal + NVL( comm, 0 )  ) max_pay 
FROM emp; 

4. NULL 연산자
5. SET(집합)연산자. 
  1) 합집합(UNION, UNION ALL) 연산자
    (1) 개발부  조회
    SELECT name, city, buseo 
    FROM insa
    WHERE buseo = '개발부';
    (2) 인천    조회
    SELECT name, city, buseo 
    FROM insa
    WHERE city = '인천';
    -- (1) 14 + (2) 9 합집합  = 23 X  -> 17
    -- (1)(2) : 6명
    SELECT name, city, buseo   -- , ssn
    FROM insa
    WHERE buseo = '개발부'
    --UNION
    UNION ALL
    SELECT name, city, buseo 
    FROM insa
    WHERE city = '인천'
    UNION 
    SELECT ename, job, job   --, deptno
    FROM emp
    WHERE deptno = 20;
    
   
   -- 여러 라인을 선택한 후 Ctrl + / 주석처리
--   SQL 문에서 집합 연산자를 사용하기 위해서는 집합 연산의 대상이 되는 두 테이블의 컬럼 수가 같고,
--   대응되는 컬럼끼리 데이터 타입이 동일해야 한다
--   컬럼 이름은 달라도 상관 없으며, 집합 연산의 결과로 출력되는 컬럼의 이름은 첫 번째 SELECT 절의 컬럼 이름을 따른다.
    
   -- ORA-01789: query block has incorrect number of result columns
   -- 쿼리블록에 잘못된 수의 결과 열이 있다.
   
   -- ORA-01790: expression must have same datatype as corresponding expression
   -- 수식은  해당 식과 데이터 형식이 같아야 한다. 
  
  -- 2:00 수업 시작~~ 
  2) 차집합(MINUS) 연산자
  
    SELECT name, city, buseo   -- 14명
    FROM insa
    WHERE buseo = '개발부'
    MINUS   -- SET 집합연산자
    SELECT name, city, buseo 
    FROM insa
    WHERE city = '인천';
    
    --
    SELECT name, city, buseo 
    FROM insa
    WHERE buseo = '개발부' AND city != '인천';
    
  
  3) 교집합(INTERSECT) 연산자  -- 6명
    SELECT name, city, buseo   --  
    FROM insa
    WHERE buseo = '개발부'
    INTERSECT    -- SET 집합연산자
    SELECT name, city, buseo 
    FROM insa
    WHERE city = '인천';
    --
    SELECT name, city, buseo    
    FROM insa
    WHERE buseo = '개발부' AND city = '인천';

6. multiset 연산자 
  1) MULTISET EXCEPT      : 첫 중첩 테이블에 있는 것 중에서 둘째 중첩테이블에 있는 것은 제외.
  2) MULTISET INTERSECT   : 두 중첩 테이블에 공통으로 있는 것만
  3) MULTISET UNION       : 두 중첩 테이블에 중복되지 않는 모든 것
 
7. 계층적 질의 연산자    
   PRIOR, CONNECT_BY_ROOT

8. 연결연산자     :   ||    
   - first_name   ||  last_name
     컬럼        연결      컬럼
   SELECT ename   || '님은 ' -- 산술표현식 또는 상수값과 연결.
   FROM emp;  

9. 산술연산자
 SELECT  5+3 , 5-3, 5*3, 5/3 
         , MOD( 5, 3)        --    5 - 3 * FLOOR(5/3)
         , REMAINDER( 5,3)   --    5 - 3 * ROUND(5/3)  X
 FROM dual;
 FROM dept; -- 레코드 수 (4개)
 FROM  emp; -- 레코드 수 ( 12개)
 
9-2. dual ?     
  - 오라클을 설치하면 자동으로 생성되는 테이블. 
  - [SYS 사용자]가 소유하는 오라클의 표준 테이블.
  - 한 행(row)
DESC dual;
  - 한 열(column)    ( DUMMY    VARCHAR2(1)  )
  - 일시적인 산술연산이나 날짜 연산을 위하여 주로 쓰인다
  -  SYS 사용자가 모든 사용자들에게 사용할 수 있도록 이 테이블에 "PUBLIC synonym(시노님)"을 주었기 때문이다.

  -- scott.emp 스키마.테이블명  -> 대신할 별칭 간단히 부여해서 사용하자.. --> 시노님(synonym)
예)
오라클 날짜 자료형 :  DATE , TIMESTAMP
SELECT  SYSDATE        -- 23/03/16   게시판 글 쓰기( 작성일 SYSDATE INSERT) 
      , CURRENT_DATE  -- 23/03/16
      , CURRENT_TIMESTAMP -- 23/03/16 14:37:48.000000000 ASIA/SEOUL
FROM dual;

9-3. 시노님( synonym == 동의어 ) 이란? 
  -  시노님의 종류
     private synonym  소유자( Owner )만 사용.
     public  synonym  모두가...
  -  시노님의 생성
  【형식】
	CREATE [PUBLIC] SYNONYM [schema.]synonym명
  	FOR [schema.]object명;
   - 디폴트는 private 시노님이다.
   - PUBLIC 시노님은 모든 사용자가 접근 가능한 시노님을 생성한다.
   - PUBLIC 시노님은 모든 사용자가 접근 가능하기 때문에 생성 및 삭제는 오직 DBA만이 할 수 있다.
   
   -- 실습   3:05 수업시작~~
   - PUBLIC 시노님의 생성 순서
        1) SYSTEM 권한으로 접속한다.
        2) PUBLIC 옵션을 사용하여 시노님을 생성한다.
        3) 생성된 시노님에 대해 객체 소유자로 접속한다.
        4) 시노님에 권한을 부여한다.
  
   실습) scott 소유자이기에 hr ( select ) 권한 부여.
   GRANT SELECT ON  emp  TO hr;
   
   --시노님의 삭제
   - public 시노님은 DBA만이 삭제할 수 있다.
      (public 시노님 생성과 삭제는 DBA만 가능)
    
   SELECT * 
   FROM user_synonyms;
   FROM all_synonyms;  
  
10. 사용자 연산자 
    CREATE OPERATOR 문 사용해서 연산자 생성.

11.floating point condition  
   (  부동 소수점     조건)   
   IS [NOT] NAN     Not A Number
   IS [NO] INFINITE 무한대
  
  SELECT -- 10/0
         -- MOD(10,0)
         -- 'a' / 2
  FROM dual;  
    
--------------------------------------------------------------------------------
오라클 함수 ( function )
--------------------------------------------------------------------------------    

1. 함수 ? 복잡한 쿼리문을 간단하게 해주고 데이터의 값을 조작하는데 사용되는 것 
2. 함수의 종류
   1) 단일행 함수 : 테이블에 저장되어 있는 개별 행을 대상으로 함수를 적용하여 하나의 결과를 반환하는 함수이다
     emp 테이블에 사원 12명 
     _
     _
     _
     SELECT UPPER( ename )
     FROM emp
     예) 문자 함수, 숫자 함수, 날짜 함수, 변환함수
     
     (1) 숫자 함수 
      -- ㄱ.   ROUND(number) 특정위치에서  반올림
      【형식】
	   ROUND ( n [,integer 특정위치])
       
       SELECT 3.141592 PI
            , ROUND( 3.541592 ) a  
            , ROUND( 3.141592 ) a  -- 3
            , ROUND( 3.141592, 0 ) b  -- 3    b+1자리   반올림
            , ROUND( 3.141592, 2 ) c  --  소수점 3자리 반올림.
       FROM dual;
       
       SELECT 12345.6789
            , ROUND(12345.6789, -1 ) -- 일의 자리 12350
            , ROUND(12345.6789, -2 ) -- 십의 자리 12300
            , ROUND(12345.6789, -3 ) -- 백의 자리 12000
       FROM dual;
   
   [문제] emp 테이블에서 pay(sal+comm)
          총급여합(27125)
          총사원수(12)
          평균 급여를 소숫점 3번째 자리에서 반올림한 평균급여를 출력하세요. 
          -- 평균 급여 : 2260.41[6]666666666666666666666666666666667
          SELECT 27125/12
            , ROUND( (SELECT SUM( sal + NVL(comm, 0) ) total_pay FROM emp) /( SELECT COUNT(*) FROM emp ),   2 ) avg_pay
          FROM dual;
         -- ORA-00936: missing expression
         4:05 수업 시작~~
     
     -- ㄴ. TRUNC(a, b)  특정위치 지정  절삭
                  b+1 자리에서 절삭
            FLOOR()        무조건 소수점 첫번째 자리 절삭
            
      SELECT 3.141592 PI
          -- , PI/3 -- ORA-00904: "PI": invalid identifier
          , TRUNC( 3.141592 ) a
          , TRUNC( 3.141592, 0 ) b
          , FLOOR(   3.141592) d
          , TRUNC( 3.141592, 2 ) c  -- 2+1 자리에서 절삭
      FROM dual;
       
      -- ㄷ. 반올림, 절삭(버림), [  절상(올림)  ]
      SELECT 3.141592 PI
            , CEIL( 3.141592 ) a -- 특정위치 X, 무조건 소수점 1번째 자리
      FROM dual;
      
      [문제] 위의 쿼리를 소수점 3자리에서 올림하세요..
      SELECT 3.141592  
            , CEIL( 3.141592 * 100 ) / 100
      FROM dual;
      
      [문제]
      총 게시글수 154개
      한 페이지에 출력할 게시글수 15개
      총 페이지수 ? 
      
      SELECT  CEIL( 154 / 15 ) "총페이지수"
      FROM dual;
      
      -- 절대값
      SELECT ABS(10), ABS(-10)   Absolute
           , ABS(11.2), ABS(-11.2)
           -- , ABS('A')  ORA-01722: invalid number
      FROM dual;
      
      -- SIGN() : 숫자값의 부호에 따라 1, 0, -1의 값을 리턴한다.
      SELECT SIGN(0)   -- 0
             , SIGN(10)  -- 양수 1
             , SIGN(100)-- 양수 1
             , SIGN(-1)  -- 음수 -1
             , SIGN(-111)-- 음수 -1
      FROM dual;
      
      [문제] emp 테이블의 평균 급여를 구해서
       각 사원의 급여가 평균급여보다 많으면  "평균 급여보다 많다." 출력
                                 적으면  "평균 급여보다 적다."   출력                         
       -- NULLIF() 함수 , SIGN() 함수, ROUND( , 2)
       SELECT  ROUND( SUM(  sal + NVL(comm, 0)  ) / COUNT(*), 2)  avg_pay
       FROM emp;
       
       SELECT  ROUND( AVG(  sal + NVL(comm, 0)  ) ,2 )   avg_pay
       FROM emp;
       
       SELECT ename, pay, avg_pay
              , pay - avg_pay 차액
              , SIGN( pay - avg_pay ) s
              , NVL2( NULLIF( SIGN( pay - avg_pay ), 1), '평균 급여보다 적다', '평균 급여보다 많다')
       FROM (
               SELECT ename, sal+NVL(comm, 0) pay
                     , ( SELECT  ROUND( AVG(  sal + NVL(comm, 0)  ) ,2 )   avg_pay   FROM emp ) avg_pay
               FROM emp
            );
       
       
       

      
     
   2) 복수행 함수 ( 그룹함수 ) : 조건에 따라 여러 행을 그룹화하여 그룹별로 결과를 하나씩 변환하는 함수
     예) MAX() MIN() , SUM(), COUNT(), AVG()
     
     총사원수 조회
     SELECT COUNT(*)
     FROM emp;
     
     총급여합 조회
     SELECT SUM( sal + NVL(comm, 0) ) total_pay
     FROM emp;
   











    
   
