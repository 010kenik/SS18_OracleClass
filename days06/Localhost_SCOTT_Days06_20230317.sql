-- SCOTT --
-- 미출석 : 이태규( 아파서 결석 )
-- 10:10 까지 제출 + 10분 쉬는 시간
-- 10:20 수업시작~

--------------------------------------------------------------------------------------------------------------------------------
-- 복습 문제 풀이 --
--------------------------------------------------------------------------------------------------------------------------------
1. dept 테이블에   deptno = 50,  dname = QC,  loc = SEOUL  로 새로운 부서정보 추가
  DML(INSERT) + [커밋COMMIT]/ROLLBACK
  INSERT INTO 테이블명 [( 컬럼명...)] VALUES ( 값 ... );
  --
  SELECT *
  FROM dept;
  -- (1) SQL 오류: ORA-00984: column not allowed here
  --                      열은 여기에 허용되지 않는다. 
  INSERT INTO dept (  deptno, dname, loc  ) VALUES ( 40, QC, SEOUL );
  -- 오라클 문자 또는 날짜는  '' 붙인다.         "" X
  -- (2) ORA-00001: unique constraint (SCOTT.PK_DEPT) violated
  --                 유일성  제약조건                      위배
  --                 deptno 부서번호 중복 X
  -- INSERT INTO dept (  deptno, dname, loc  ) VALUES ( 40, 'QC', 'SEOUL' );
  
  INSERT INTO dept (  deptno, dname, loc  ) VALUES ( 50, 'QC', 'SEOUL' );
  -- 1 행 이(가) 삽입되었습니다.
  COMMIT;
  -- 커밋 완료.
  
1-2. dept 테이블에 QC 부서를 찾아서 부서명(dname)과 지역(loc)을 
  dname = 현재부서명에 2를 추가,  loc = POHANG 으로 수정
  -- DML(UPDATE) + COMMIT
  UPDATE 테이블명
  SET 컬럼명=값,컬럼명=값...
  [WHERE] 생략되면 모든 레코등(행) 수정
  --
  SELECT *
  FROM dept
  WHERE dname = 'QC';
  WHERE dname = UPPER('qc');
  WHERE REGEXP_LIKE( dname, 'QC' );
  WHERE dname LIKE '%QC%';
  --
  UPDATE dept
  SET dname =  dname || 2 , loc = 'POHANG'   -- CONCAT(dname, 2)
  WHERE deptno = 50;
  COMMIT;
  
1-3. dept 테이블에서 QC2 부서를 찾아서 deptno(PK)를 사용해서 삭제
  -- DML(DELETE) + COMMIT
  DELETE FROM 테이블명
  [WHERE] 생략면 모든 레코드 삭제.
  
  -- ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
  --             무결성    제약조건                     위배된다.  - 자식 레코드(행) 찾았다.
  -- 10 -> emp  10번사원 존재  X
  -- 20 -> emp  20번사원 존재  X
  -- 30 -> emp  30번사원 존재  X
  -- 40 , 50 삭제 가능
  DELETE FROM dept
  WHERE deptno = 50 ;
  -- 1 행 이(가) 삭제되었습니다.
  COMMIT;
  -- 커밋 완료.

--------------------------------------------------------------------------------------------------------------------------------
2.  insa 테이블에서 남자는 'X', 여자는 'O' 로 성별(gender) 출력하는 쿼리 작성
    1. REPLACE() 사용해서 풀기
    SELECT t.name, t.ssn, t.gender
            , REPLACE(  REPLACE( t.gender, 1, 'X' ), 0 , 'O') gender
    FROM ( 
                SELECT name, ssn
                       , MOD( SUBSTR( ssn, -7, 1), 2 ) gender  -- 1=남자, 0=여자
                FROM insa
         ) t;
    
    
    2. 집계(SET)연산자 사용해서 풀기
    SELECT name, ssn
           --, MOD( SUBSTR( ssn, -7, 1), 2 ) gender  -- 1=남자 
           , 'X' gender
    FROM insa
    WHERE MOD( SUBSTR( ssn, -7, 1), 2 )  = 1 
    -- WHERE gender = 1;  -- ORA-00904: "GENDER": invalid identifier
    UNION   -- UNION ALL 동일한 값
    SELECT name, ssn 
           , 'O' gender
    FROM insa
    WHERE MOD( SUBSTR( ssn, -7, 1), 2 )  = 0;
    
    3. NULL 처리 함수 :  NVL() , NVL2(),  *** NULLIF() ***
    
    NULLIF( e1, e2 )      e1 = e2    NULL 반환
                          e1!= e2    e1 반환
    -- 예)
    SELECT ename , NULLIF( ename , 'SMITH' )
    FROM emp;
    -- 
    SELECT name, ssn
           -- , MOD( SUBSTR( ssn, -7, 1), 2 ) gender  -- 1=남자, 0=여자
           -- , NULLIF( MOD( SUBSTR( ssn, -7, 1), 2 ) , 1 ) 
           , NVL2( NULLIF( MOD( SUBSTR( ssn, -7, 1), 2 ) , 1 ) , 'O', 'X' ) gender
    FROM insa;
    
    NAME                 SSN            GENDER
    -------------------- -------------- ------
    홍길동               771212-1022432    X
    이순신               801007-1544236    X
    이순애               770922-2312547    O
    김정훈               790304-1788896    X
    한석봉               811112-1566789    X 
    
    SELECT name, ssn
           , MOD( SUBSTR( ssn, -7, 1), 2 ) gender  -- 1=남자, 0=여자
    FROM insa;
    
-- 11:09 수업 시작!~    
--------------------------------------------------------------------------------------------------------------------------------
3.  insa 테이블에서 2000년 이후 입사자 정보 조회하는 쿼리 작성
    1. TO_CHAR() 함수 사용해서 풀기
        SELECT name, ibsadate
           , TO_CHAR( ibsadate, 'YYYY' ) year
        FROM insa
        WHERE TO_CHAR( ibsadate, 'YYYY' ) >= 2000;
    
    2. EXTRACT() 함수 사용해서 풀기.
        SELECT name, ibsadate
           , EXTRACT( YEAR  FROM ibsadate ) year
        FROM insa
        WHERE EXTRACT( YEAR  FROM ibsadate ) >= 2000;
    
    3. WHERE 날짜도 비교연산자 사용 가능.
        SELECT name, ibsadate
        FROM insa
        WHERE ibsadate >= '2000.1.1';
    
    NAME                 IBSADATE
    -------------------- --------
    이미성               00/04/07
    심심해               00/05/05
    권영미               00/06/04
    유관순               00/07/07    
    
    SELECT name, ibsadate
    FROM insa; -- 60명의 사원
    
4. 지금까지 배운 [오라클 자료형]을 적으세요.
   ㄱ. NUMBER - 숫자(정수,실수)
   ㄴ. VARCHAR2 - 문자, 문자열
   ㄷ. DATE      - 날짜
   ㄹ. TIMESTAMP - 날짜
   
   DESC emp;
   
       이름       널?       유형           
    -------- -------- ------------ 
    EMPNO    NOT NULL NUMBER(4)    
    ENAME             VARCHAR2(10) 
    JOB               VARCHAR2(9)  
    MGR               NUMBER(4)    
    HIREDATE          DATE         
    SAL               NUMBER(7,2)  
    COMM              NUMBER(7,2)  
    DEPTNO            NUMBER(2)  

5. 현재 시스템의 날짜 출력하는 쿼리를 작성하세요. 
SELECT ( ㄱ ), ( ㄴ ), ( ㄷ )
FROM dual;
    ㄱ. SYSDATE 함수
    ㄴ. CURRENT_DATE
    SELECT SYSDATE        -- 23/03/17  현재 시스템의 날짜+시간,  게시판의 글쓰기 ( 작성일 )
          , CURRENT_DATE  -- 23/03/17  현재 세션(SESSION)의 날짜+시간
          , CURRENT_TIMESTAMP --       현재 세션의 날짜+시간 +타임존 등등
    FROM dual;
    
6. 시노님(synonym)에 대해서 간단히 설명하세요. 
    1) 정의 : 하나의 객체에 대한 다른 이름을 정의한 것.
              스키마.객체명           별칭(시노님)
              scott.emp           -> arirang
    2) 종류 : PRIVATE, PUBLIC
    3) 생성, 삭제 형식
    4) 조회 :  all_synonyms   모든 시노님 정보 조회
              user_synonyms  사용자가 만든 시노님 조회

7. SQL 집합(SET) 연산자의 종류와 설명을 하세요
  1) 종류 : UNION, UNION ALL(합집합), MINUS(차집합), INTERSECT(교지합)
         중복 제외,   중복 모두 포함
  2) 주의할 점 : 컬럼수 동일, 자료형 동일, ORDER BY 마지막 SELECT , 컬럼명은 첫번째 SELECT..

8.  insa 테이블에서  주민번호를 아래와 같이 '-' 문자를 제거해서 출력
 
    NAME    SSN             SSN_2
    홍길동	770423-1022432	7704231022432
    이순신	800423-1544236	8004231544236
    이순애	770922-2312547	7709222312547     
    
    SELECT name,ssn
         , SUBSTR(ssn, 1, 6)  || SUBSTR( ssn, -7 ) ssn
         , CONCAT(SUBSTR(ssn, 1, 6) , SUBSTR( ssn, -7 ) ) ssn
         , REPLACE( ssn , '-', '') ssn
         , REPLACE( ssn , '-' ) ssn
    FROM insa;

[숫자함수]
9. ROUND() 
   1) 함수 설명 :  특정위치에서 숫자값을 반올림해서 리턴하는 함수
   2) 형식 설명 : ROUND( n [, m] )
                   m 이 생략되면   0
                   m+1 자리에서 반올림이 된다.
                   m  음수를 사용할 수 있다.
   3) 쿼리 설명
        SELECT    3.141592
               , ROUND(  3.141592 )     a   -- 소수점 1번째 반올림
               , ROUND(  3.141592,  0 ) b
               , ROUND(  3.141592,  2 ) c    -- 2+1 자리에서 반올림
               , ROUND(  3.141592,  -1 ) d   -- 일의 자리에서 반올림
               , ROUND( 12345  , -3 )  e     -- 백의 자리에서 반올림
       FROM dual;

9-2. TRUNC()함수와 FLOOR() 함수에 대해서 설명하세요.        
9-3. CEIL() 함수에 대해서 설명하세요. 
9-4. 나머지 값을 리턴하는 함수 :  (   ㄱ    )
9-5. 절대값을 리턴하는 함수 :   (   ㄱ    )
9-6. SING() 함수에 대해서 설명하세요.

10.emp 테이블에서 급여와 평균급여를 구하고
   각 사원의 급여-평균급여를 소수점 3자리에서 올림,반올림,내림해서 아래와 
   같이 조회하는 쿼리를 작성하세요.
   --  ***  팀 프로젝트 할 때마다 질문 ***
   WITH 
     temp AS (
                   SELECT ename,  sal + NVL(comm,0) pay
                     --  , AVG( sal + NVL(comm,0) )  avg_pay  ORA-00937: not a single-group group function
                     --                                                   단일그룹 그룹함수가 아니다 
                     --  그룹함수를 사용해야하는데 group by를 사용하지 않아서요/...?
                     --  이유? 함수의 종류 2가지. 
                     --        1) 단일행 함수  
                     --        2) 복수행 함수 (그룹함수, 집계함수) 
                     --  일반 컬럼과 그룹함수는 같이 사용할 수 없다.
                     --   만약에) 일반컬럼 + 그룹함수같이 사용할 수 있는 경우 : group by 절을 사용하면
                     -- , 2260.42 avg_pay
                     ,  ( SELECT   AVG( sal + NVL(comm,0) )  avg_pay   FROM emp ) avg_pay
                     -- ORA-00936: missing expression  
                     --            누락된(빠진) 표현식
                   FROM emp
               )     
    SELECT   t.ename, t.pay
             , ROUND( t.avg_pay , 2 ) avg_pay       
             , t.pay - t.avg_pay  "평균급여와의 차액"
             -- , CEIL(  t.pay - t.avg_pay , 2 ) "올림"
             , CEIL(  ( t.pay - t.avg_pay) *100 )/100 "올림"
             , ROUND( t.pay - t.avg_pay , 2 )"반올림"
             , TRUNC( t.pay - t.avg_pay , 2 ) "내림"
    FROM temp t;               
   --
   SELECT   AVG( sal + NVL(comm,0) )  avg_pay   FROM emp;
   --
   SELECT
       SUM( sal + NVL(comm,0)  )   tot_pay
       , COUNT( * ) cnt
       , SUM( sal + NVL(comm,0)  )/COUNT( * )  avg_pay
       , AVG( sal + NVL(comm,0) )  avg_pay
   FROM emp;
   -- ORA-00909: invalid number of arguments
   --            잘못된 숫자      의      인자들(매개변수)
   
ENAME             PAY    AVG_PAY       차 올림      차 반올림       차 내림
---------- ---------- ---------- ---------- ---------- ----------
SMITH             800    2260.42   -1460.41   -1460.42   -1460.41
ALLEN            1900    2260.42    -360.41    -360.42    -360.41
WARD             1750    2260.42    -510.41    -510.42    -510.41
JONES            2975    2260.42     714.59     714.58     714.58
MARTIN           2650    2260.42     389.59     389.58     389.58
BLAKE            2850    2260.42     589.59     589.58     589.58
CLARK            2450    2260.42     189.59     189.58     189.58
KING             5000    2260.42    2739.59    2739.58    2739.58
TURNER           1500    2260.42    -760.41    -760.42    -760.41
JAMES             950    2260.42   -1310.41   -1310.42   -1310.41
FORD             3000    2260.42     739.59     739.58     739.58

ENAME             PAY    AVG_PAY       차 올림      차 반올림       차 내림
---------- ---------- ---------- ---------- ---------- ----------
MILLER           1300    2260.42    -960.41    -960.42    -960.41


12:11 수업 시작~~
10-2. emp 테이블에서 급여(sal)와 평균급여를 구하고
    각 사원의 급여가 평균급여 보다 많으면 "많다"
                   평균급여 보다 적으면 "적다"라고 출력
                                      "같다"    

  -- 평균급여 ( 2077.08 )
  SELECT ROUND( AVG(sal), 2 ) avg_sal  FROM emp;
  --
  SELECT SIGN(100), SIGN(-1000), SIGN(0)
  FROM dual;
  -- REPLACE() 함수 설명 -- 
  SELECT -1 , '-1'
      , REPLACE( -1 , 1 ,'X' )
  FROM dual;
  
  -- 2) 풀이
  SELECT t.*
        --, t.sal - t.avg_sal              diff
        --, SIGN(   t.sal - t.avg_sal )    s
        , '평균 sal보다 ' || REPLACE( REPLACE(  REPLACE(  SIGN(   t.sal - t.avg_sal ), -1 , '적다' ), 1, '많다') , 0 , '같다')   x       
        -- , REPLACE(  REPLACE(  SIGN(   t.sal - t.avg_sal ), 1 , '많다' ), -1, '적다')   x  원인파악~
  FROM (
            SELECT empno, ename, sal,  (SELECT ROUND( AVG(sal), 2 ) avg_sal  FROM emp) avg_sal
            FROM emp 
       ) t;
  
  -- 1) 풀이 - [ SET 연산자 ]
  SELECT ename, sal, '많다'
  FROM emp
  WHERE sal > 2077.08
  UNION
  SELECT ename, sal, '적다'
  FROM emp
  WHERE sal < 2077.08
  UNION
  SELECT ename, sal, '같다'
  FROM emp
  WHERE sal = 2077.08;
  --


11. insa 테이블에서 모든 사원들을 14명씩 팀을 만드면 총 몇 팀이 나올지를 쿼리로 작성하세요.
 ( 힌트 : 집계(그룹)함수 사용)
 SELECT COUNT( * ) "총 사원수"
       , 14 "팀 사원수" 
       , CEIL( COUNT( * )/14 ) "총 팀수" -- 절상(올림)
 FROM insa;

-- 풀이 중 ~~ 2:00 수업 : 박상범 
12. emp 테이블에서 최고 급여자, 최저 급여자 정보 모두 조회
                                            PAY(sal+comm)
7369	SMITH	CLERK	7902	80/12/17	800		    20  최고급여자
7839	KING	PRESIDENT		81/11/17	5000		10  최저급여자
-- 3번 풀이
-- ALL , ANY,  SOME,( 비교연산자 )                t/f EXISTS   SQL연산자.
--[ emp 테이블에서 최고 급여자  ]
SELECT e.* , '최고 급여자' 
FROM emp e
WHERE sal+NVL(comm, 0)  >= ALL(SELECT sal+NVL(comm, 0) pay FROM emp )
UNION
SELECT e.* , '최저 급여자' 
FROM emp e
WHERE sal+NVL(comm, 0)  <= ALL(SELECT sal+NVL(comm, 0) pay FROM emp );

-- 2번 풀이
SELECT *
FROM emp
WHERE sal+NVL(comm, 0) = (SELECT  MAX( sal+NVL(comm, 0) ) max_pay FROM emp )  -- 5000
UNION
SELECT *
FROM emp
WHERE sal+NVL(comm, 0) = (SELECT  MIN( sal+NVL(comm, 0) ) min_pay FROM emp ) ; --800;

-- 1번 풀이
SELECT *
FROM emp
ORDER BY sal+NVL(comm, 0) DESC;
-- ORA-00937: not a single-group group function
SELECT  MAX( sal+NVL(comm, 0) ) max_pay      , MIN( sal+NVL(comm, 0) ) min_pay FROM emp;
--
SELECT *
FROM emp
WHERE sal+NVL(comm, 0) IN ( 
                                 (SELECT  MAX( sal+NVL(comm, 0) ) max_pay FROM emp ) 
                             ,   (SELECT  MIN( sal+NVL(comm, 0) ) min_pay FROM emp )
                            );

WHERE sal+NVL(comm, 0) = ( SELECT  MAX( sal+NVL(comm, 0) ) max_pay FROM emp ) 
    OR sal+NVL(comm, 0) = (SELECT  MIN( sal+NVL(comm, 0) ) min_pay FROM emp );

WHERE sal+NVL(comm, 0) IN ( 5000, 800 );
WHERE sal+NVL(comm, 0) = 5000 OR sal+NVL(comm, 0) = 800;
--
SELECT *
FROM emp
WHERE sal+NVL(comm, 0) IN ( 
                              ( 
                                SELECT  MAX( sal+NVL(comm, 0) ) max_pay
                                    , MIN( sal+NVL(comm, 0) ) min_pay 
                                FROM emp 
                              )
                             );
-- ORA-00913: too many values
-- 355행, 31열에서 오류 발생
--  이유 ? 



13. emp 테이블에서 
   comm 이 400 이하인 사원의 정보 조회
  ( 조건 : comm 이 null 인 사원도 포함 )
    
                   [comm]     [comm >= 400]       LNNVL( comm >= 400 ) 
    SMITH	800	    null          null                 true                        O
    ALLEN	1600	300
    WARD	1250	500           true                 false                      X     
    JONES	2975    null	
    MARTIN	1250	1400
    BLAKE	2850    null	
    CLARK	2450    null	
    KING	5000    null	
    TURNER	1500	0
    JAMES	950	    null
    FORD	3000    null	
    MILLER	1300    null	                 
    
    -- 4번째 방법      LNNVL() 함수 사용.
                 NOT  true -> false
                      false -> true                      
                      null(unknow) -> true  X
                      
        WHERE  LNNVL(조건식)
                      true   ->  false
                             
                     false  ->  true
                     null(unknow) -> true *****
    SELECT ename, sal, comm
    FROM emp
    WHERE LNNVL( comm >= 400 );     --  == comm  <= 400 OR comm IS NULL;    
  
    -- 3번째 방법
    SELECT ename, sal, comm
    FROM emp
    WHERE NVL(comm, 0) <=400;
    
    -- 2번째 방법
    SELECT ename, sal, comm
    FROM emp
    WHERE comm  <= 400 OR comm IS NULL;
    
    -- 1번째 방법
    SELECT ename, sal, comm
    FROM emp
    WHERE comm  <= 400 
    UNION
    SELECT ename, sal, comm
    FROM emp
    WHERE comm IS NULL;
    
    ENAME   SAL    COMM
    SMITH	800	
    ALLEN	1600	300
    JONES	2975	
    BLAKE	2850	
    CLARK	2450	
    KING	5000	
    TURNER	1500	0
    JAMES	950	
    FORD	3000	
    MILLER	1300	
    
14. emp 테이블에서 [각 부서별] 급여(pay)를 가장 많이 받는 사원의 정보 출력.    
    ( 힌트 : Correlated Subquery 사용 가능, SET 연산자 사용 가능 )
  SELECT *
  FROM dept;  
  -- 10, 20, 30, 40
  -- 10번 부서원 중에 최고급여자.
  SELECT  MAX(sal + NVL(comm, 0))FROM emp  WHERE deptno = 10;  -- 5000
  SELECT  MAX(sal + NVL(comm, 0))FROM emp  WHERE deptno = 20; -- 3000
  SELECT  MAX(sal + NVL(comm, 0))FROM emp  WHERE deptno = 30; -- 2850
  SELECT  MAX(sal + NVL(comm, 0))FROM emp  WHERE deptno = 40; -- null
  --
  UPDATE emp
  SET deptno = 10
  WHERE empno = 7839;
  COMMIT;
  -- 2번째 방법( Correlated Subquery 상관 서브 쿼리)  main query 와 같이 연동.
  SELECT *
  FROM emp  p
  WHERE sal + NVL(comm, 0)  =  (
                                   SELECT MAX(sal + NVL(comm, 0))   
                                   FROM emp c
                                   WHERE c.deptno = p.deptno
                                ) ;
  
  -- 1번째 방법.( SET 연산자 )
  -- 문제점) 어떤 ?  10 번 부서의 최고 급여액 - 2000 이라고 가정하면
  --             10/2000,  20/2000, 30/2000
              7934	MILLER	CLERK	7782	82/01/23	1300(3000)		10
              UPDATE emp
              SET sal = 3000
              WHERE empno = 7934;
              ROLLBACK;
  -- 해결)       3:10  수업시작~
  SELECT *
  FROM emp
  WHERE sal + NVL(comm, 0)  =  (SELECT MAX(sal + NVL(comm, 0))   FROM emp WHERE deptno = 10) AND deptno = 10
UNION
  SELECT *
  FROM emp
  WHERE sal + NVL(comm, 0)  =  (SELECT MAX(sal + NVL(comm, 0))   FROM emp WHERE deptno = 20) AND deptno = 20
UNION  
  SELECT *
  FROM emp
  WHERE sal + NVL(comm, 0)  =  (SELECT MAX(sal + NVL(comm, 0))   FROM emp WHERE deptno = 30)  AND deptno = 30
UNION
  SELECT *
  FROM emp
  WHERE sal + NVL(comm, 0)  =  (SELECT MAX(sal + NVL(comm, 0))   FROM emp WHERE deptno = 40)  AND deptno = 40 ;
--  ORDER BY  deptno ASC  ;  -- ORA-00904: "DEPTNO": invalid identifier 

--------------------------------------------------------------------------------------------------------------------------------
-- [숫자 함수]
--------------------------------------------------------------------------------------------------------------------------------
1. POWER(a,b)
2. SQRT 제곱근
3. SIN(), COS(), TAN()
4. LOG()
   LN()  자연로그 - 밑수 e인 로그함수
   EXP() 지수함수 e의  n제곱값
SELECT POWER(2,3), POWER(2,-3)
      , SQRT(2)  -- 1.41421356237309504880168872420969807857
    
FROM dual;
--------------------------------------------------------------------------------------------------------------------------------
-- [문자 함수]
--------------------------------------------------------------------------------------------------------------------------------
1. UPPER(), LOWER(), INITCAP()
2. LENGTH()
3. CONCAT()   ||
4. SUBSTR()
SELECT ename 
    , UPPER( ename )
    , LOWER( ename )
    , INITCAP( ename )  -- 각 단어 첫번째 문자는 대문자, 나머지는 소문자로 변환
    , LENGTH( ename ) -- 문자열의 길이
FROM emp;

5. INSTR( 문자열, 찾고자문자열 [, 찾기시작할위치 [,발생] ] ) -- 문자값 중 지정된 문자값의 위치를 숫자로 리턴한다. 
SELECT ename
      , INSTR( ename , 'L' )  L_first
      , INSTR( ename , 'L', INSTR( ename , 'L' )+1 ) L_second
      , INSTR( ename , 'L', 1, 2)  L_second  
      , INSTR( ename , 'L', -1, 2)  L_second  -- ename 뒤에서 부터 두 번째 오는 L의 위치 찾겠다.
FROM emp;

6. RPAD()/LPAD()
   Right + PAD,   Left + PAD
   PAD = 패드, 덧 대는 것, 메워 넣는 것.\
   
   【형식】
      RPAD (expr1, n [, expr2] )
   
   
   SELECT ename, sal + NVL(comm, 0) pay
      , RPAD(  sal + NVL(comm, 0), 10, '*'   ) 
      , LPAD(  sal + NVL(comm, 0), 10, '*'   ) 
   FROM emp;   
   
   예) pay가 100일때  # 출력, .5 (반올림)
   SELECT ename, sal + NVL( comm, 0) pay
         , ROUND( (sal + NVL( comm, 0))/100 ) n
         , RPAD(' ', ROUND( (sal + NVL( comm, 0))/100 )+1 , '#' ) "bar"
   FROM emp;
   
4:12 수업 시작~    
7. RTRIM()/LTRIM()/TRIM() 문자값 중에서 우/좌측으로 부터 특정문자와 일치하는 문자값을 제거한다. 
【형식】
      RTRIM(char [,set] )
  -- 자바 Stirng.trim()  앞/뒤 공백 제거하는 함수
  SELECT '  admin   '
--      , '[' || RTRIM( '  admin   ',  ' ')  || ']'
      , '[' || RTRIM( '  admin   ' )  || ']'
      , '[' || LTRIM( '  admin   ',  ' ')  || ']'
      , '[' || TRIM( '  admin   ')  || ']'
  FROM dual;
  --
  SELECT  RTRIM('BROWINGyxXxy','xy') "RTRIM example" 
     , RTRIM('BROWINGyxXxyxxyy','xy') "BROWINGyxX" 
  FROM dual;
  --
  select RTRIM('BROWING: ./=./=./=./=.=/.=', '/=.') "RTRIM example" 
  from dual; 

8. ASCII() 
   SELECT ASCII('A'), ASCII('a'), ASCII('0')
   FROM dual;

9. CHR()
   SELECT CHR(65)
   FROM dual; 

10. GREATEST()  /  LEAST()
   SELECT GREATEST(1,4,3,5,2), LEAST(1,4,3,5,2)
   FROM dual;

   select GREATEST('KOREA','COREA','SEOUL') 
   from dual;
   
12. REPLACE()
13. VSIZE()  -- 지정된 문자열의 크기를 숫자값으로 리턴한다
-- 알파벳      1         한글   3
   SELECT VSIZE('a'), VSIZE('한')
   FROM dual;
    
--------------------------------------------------------------------------------------------------------------------------------
-- [날짜 함수]
--------------------------------------------------------------------------------------------------------------------------------   
1. SYSDATE
  SELECT SYSDATE  -- '23/03/17' 현재 시스템의 날짜 + (시간 포함)
  FROM dual;
  
2. ROUND( 날짜 )
   【형식】
	 ROUND( date [,format 형식] )
     
     SELECT SYSDATE          -- 23/03/17   16:30:27
         , ROUND( SYSDATE )  -- 23/03/18   날짜형식 없으면 가장 가까운 날을 출력 00:00:00
         , ROUND( SYSDATE , 'DD') -- 23/03/18                      일을 반올림할 때 정오를 넘으면 다음날 자정을 출력하고, 넘지 않 으면 그 날 자정을 출력한다
         , ROUND( SYSDATE , 'MONTH') --  17일 ,  15일 이상 23/04/01 월을 반올림하는 경우는 15일 이상이면 다음 달 1일을 출력하고, 넘지 않으~ 면 현재 달 1일을 출력한다. 
         , ROUND( SYSDATE , 'YEAR') -- 23/01/01   그해 1월 1        일년을 반올림하는 경우에는 6월을 넘으면 다음해 1월1일을 출력하고, 넘지 않으면 그 해 1월1일을 출력한다 .
     FROM dual;

3. TRUNC( 날짜 )  날짜 절삭  ***
     SELECT SYSDATE          
         , TRUNC( SYSDATE )          -- 23/03/17   16:30:27 가장 근접한 날로 절삭된다     )
         , TRUNC( SYSDATE , 'DD')    -- 23/03/17   시:분:초
         , TRUNC( SYSDATE , 'MONTH') -- 23/03/[01]
         , TRUNC( SYSDATE , 'YEAR')  --23/[01]/[01]
     FROM dual;

4. MONTHS_BETWEEN()  두 날짜 사이의 개월수
  - 각 사원들의 근무일수, 근무개월수 파악(조회)
  SELECT ename, hiredate , SYSDATE
          , ROUND( MONTHS_BETWEEN( SYSDATE, hiredate ), 1 ) 근무개월수
          , CEIL( SYSDATE - hiredate ) 근무일수 -- ( 날짜 - 날짜 = 일수 )
          , ROUND( MONTHS_BETWEEN(  SYSDATE, hiredate  ) / 12 , 2 )  근무년수
  FROM emp;
  
5. ADD_MONTHS()  -- '3/31'  - 한달 전 2/28,29
   SELECT SYSDATE
         , ADD_MONTHS(  SYSDATE, 1 ) 
         , ADD_MONTHS(  SYSDATE, -1 ) 
   FROM dual;

6. LAST_DAY  -- 특정 날짜가 속한 달의 가장 마지막 날짜를 리턴하는 함수
   SELECT SYSDATE
       , LAST_DAY( SYSDATE )  -- 23/03/31
   FROM dual;

7. NEXT_DAY -- 명시된 요일이 돌아오는 가장 최근의 날짜를 리턴하는 함수
【형식】
      NEXT_DAY(date,char)


   SELECT SYSDATE  -- 23/03/17
        , TO_CHAR( SYSDATE, 'YYYY') year
        , TO_CHAR( SYSDATE, 'MM') month
        , TO_CHAR( SYSDATE, 'DD') "DATE"
        , TO_CHAR( SYSDATE, 'DAY') DAY
        -- 다음 주 월요일 만나자 (약속)
        , NEXT_DAY( SYSDATE, '월요일'  ) -- 23/03/20
   FROM dual;
--------------------------------------------------------------------------------------------------------------------------------   
    날짜 + 숫자 = 날짜
    날짜 - 숫자 = 날짜
    날짜 + 숫자/24 = 날짜
    *** 날짜 - 날짜 = 일수
    
    SELECT SYSDATE
           , SYSDATE + 3   -- 3일 뒤에 만나자
           , SYSDATE - 10
           , SYSDATE + 2/24 -- 2시간 뒤의 날짜
    FROM dual;
    
--------------------------------------------------------------------------------------------------------------------------------   

Ora_Help    function 검색 한 후 datetime 종류 전까지 수업했다.
-- 남은 함수 설명
-- 오라클 자료형
-- 테이블 생성/수정/삭제/제약조건 + DML 문~

-- 확인--
SELECT  TO_DATE( '2022-02-01' )
   ,  ADD_MONTHS( TO_DATE( '02-01-2022', 'MM-DD-YYYY') , 1 ) a -- 문자를 날짜로 형변환 TO_DATE
  -- ORA-01830: [date format] picture ends before converting entire input string
  -- 전체 입력 문자열이 변환되기 전에  날짜 형식 사진이 종료되었다.
   ,  ADD_MONTHS( TO_DATE( '02-28-2022', 'MM-DD-YYYY') , 1 ) b --  2/28 + 한달
   ,  ADD_MONTHS( TO_DATE( '02-27-2022', 'MM-DD-YYYY') , 1 ) c --  2/27 + 한달
   ,  ADD_MONTHS( TO_DATE( '03-30-2022', 'MM-DD-YYYY') , -1 ) d --  3/31 + 한달
     -- 3/31~3/28       - 1 달 = 2/28
FROM dual;

-- 달력  : 년,월   마지막날짜.
SELECT TO_DATE( '2022-01-01' )-1        -- 22/01/31
FROM dual;
