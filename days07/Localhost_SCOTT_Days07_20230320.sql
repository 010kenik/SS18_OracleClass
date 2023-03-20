-- SCOTT --
-- 10:00 제출

--------------------------------------------------------------------------------------------------------------------------------
-- 복습문제 풀이
--------------------------------------------------------------------------------------------------------------------------------
-- [1] 풀이
1. emp 테이블에서 30번 부서만 PAY를 계산 후 막대그래프를 아래와 같이 그리는 쿼리 작성
   ( 필요한 부분은 결과 분석하세요~    PAY가 100 단위당 # 한개 , 반올림처리 )
[실행결과]
    DEPTNO ENAME PAY BAR_LENGTH      
    ---------- ---------- ---------- ----------
    30	BLAKE	2850	29	 #############################
    30	MARTIN	2650	27	 ###########################
    30	ALLEN	1900	19	 ###################
    30	WARD	1750	18	 ##################
    30	TURNER	1500	15	 ###############
    30	JAMES	950	    10	 ##########
    
    SELECT deptno, ename, sal + NVL(comm, 0) pay
         , ROUND( (sal + NVL(comm, 0)) / 100 )  BAR_LENGTH
         , RPAD( ' ',   ROUND( (sal + NVL(comm, 0)) / 100 )+ 1 , '#' ) BAR
    FROM emp
    WHERE deptno = 30
    ORDER BY pay DESC;
    
    (질문) 이 코딩의  ROUND( (sal + NVL(comm, 0)) / 100 )+ 1
          +1  왜했는지 한번만더 설명부탁드려요
    (답변) RPAD
         1) 기능   : 
         2) 매개변수 : 
             ' '    공백1개
             ROUND( (sal + NVL(comm, 0)) / 100 ) + 1   전체 자리수 
             '#'
         3) 반환값
    
    1-2. insa 테이블에서 주민등록번호를 123456-1******  형식으로 출력하세요 . 
    ( LPAD, RPAD 함수 사용  )
[실행결과]
    홍길동	770423-1022432	770423-1******
    이순신	800423-1544236	800423-1******
    이순애	770922-2312547	770922-2******
    
    SELECT name, ssn
         -- , SUBSTR( ssn, 0, 8)
         , RPAD(  SUBSTR( ssn, 0, 8), 14, '*'   )
         , SUBSTR( ssn, 0, 8) || '******'
         , CONCAT( SUBSTR( ssn, 0, 8) ,  '******' )
    FROM insa;

--------------------------------------------------------------------------------------------------------------------------------
-- [2] 풀이
2. SELECT  TRUNC( SYSDATE, 'YEAR' )
         , TRUNC( SYSDATE, 'MONTH' )      
        , TRUNC( SYSDATE  )
  FROM dual;
    위의 쿼리의 결과를 적으세요 . 
  
  ㄱ. TRUNC() 함수 이해  
       - 특정 위치에서 절삭  ( FLOOR() 함수와 차이점 )
      1) TRUNC( 숫자 ) 절삭
      2) TRUNC( 날짜 ) 절삭 ***
      
  ㄴ. SYSDATE 함수 - 현재 시스템의 날짜 + 시간을 반환하는 함수 
  SELECT SYSDATE                     --  '23/03/20'
      , TRUNC( SYSDATE , 'YEAR' )    --  '23' , '23[/01/01]'
      , TRUNC( SYSDATE , 'MONTH' )    --  '23/03' , '23/03[/01]'
      , TRUNC( SYSDATE  )  -- '23/03/20 00:00:00'
  FROM dual;
    
--------------------------------------------------------------------------------------------------------------------------------
-- [3] 풀이
3. emp 에서 평균PAY 보다 같거나 큰 사원들만의 급여합을 출력.
[실행결과]
NAME             SAL       COMM        PAY    AVG_PAY
---------- ---------- ---------- ---------- ----------
JONES            2975                  2975 2260.41667
MARTIN           1250       1400       2650 2260.41667
BLAKE            2850                  2850 2260.41667
CLARK            2450                  2450 2260.41667
KING             5000                  5000 2260.41667
FORD             3000                  3000 2260.41667

-- ORA-00937: not a single-group group function
-- 함수 : 단일행함수, 복수행(그룹)함수
  1) with절 사용
WITH 
 temp AS (
            SELECT ename name, sal, comm, sal + NVL(comm, 0) pay
            --     , ROUND(   AVG( sal + NVL(comm, 0) ), 5 ) avg_pay
                    , (SELECT  ROUND(   AVG( sal + NVL(comm, 0) ), 5 ) avg_pay FROM emp)  avg_pay
            FROM emp
         )
 SELECT t.*
 FROM temp t
 WHERE t.pay >= t.avg_pay
;
  2) inline-view 사용

SELECT  ROUND(   AVG( sal + NVL(comm, 0) ), 5 ) avg_pay
     , SUM( sal + NVL(comm, 0) )  tot_pay
     , COUNT( * )  tot_cnt
     ,  ROUND( SUM( sal + NVL(comm, 0) ) / COUNT( * ), 5 ) avg_pay
FROM emp;

--------------------------------------------------------------------------------------------------------------------------------
-- [4] 풀이
4. emp 테이블에서 각 부서별 급여를 가장 많이 받는 사원의 pay를 출력
    풀이 방법 1) 순위( RANK ) 함수
    풀이 방법 2) TOP-N 방식

  1) UNION SET연산자 사용
    -- ( 문제점 ) AND 조건절 추가
    10 최고급여자
    UNION
    20 최고급여자
    UNION
    30 최고급여자
    UNION
    40 최고급여자
    
  2) 상관서브쿼리 사용.
  SELECT *
  FROM emp a
  WHERE a.sal + NVL(a.comm, 0) = ( 
                                    SELECT   MAX( b.sal + NVL(b.comm,0 ) ) max_pay_depto
                                    FROM emp b
                                    WHERE  b.deptno = a.deptno
                                  )
  ORDER BY deptno ASC;
  --
  SELECT   MAX( b.sal + NVL(b.comm,0 ) ) max_pay_depto
                                    FROM emp b
                                    WHERE  b.deptno = 30;

--------------------------------------------------------------------------------------------------------------------------------
-- [5] 풀이
5. 이번 달이  몇일 까지 있는 지 출력하세요. 
   ( LAST_DAY 함수 )
  1) 로직 : '23/04/01' - 하루  '23/03/마지막날짜'  - 일만 얻어오면 
  SELECT SYSDATE
       , ADD_MONTHS(SYSDATE, 1)  ㄱ -- 1달 더하기
       , TRUNC( ADD_MONTHS(SYSDATE, 1) , 'MONTH') ㄴ  -- '23/04/01'
       -- 날짜 - 날짜 = 일수
       -- 날짜 + 일수 = 날짜
       -- 날짜 - 일수 = 날짜
       -- 날짜 + 수/24 = 날짜
       , TRUNC( ADD_MONTHS(SYSDATE, 1) , 'MONTH')  - 1   ㄷ
       , TO_CHAR( TRUNC( ADD_MONTHS(SYSDATE, 1) , 'MONTH')  - 1, 'DD' ) ㄹ
  FROM dual;
  
  2) LAST_DAY 함수 사용해서 처리
  SELECT  TO_CHAR(  LAST_DAY( SYSDATE ) , 'DD' ) ㄹ
  FROM dual;

11:06 풀이~
--------------------------------------------------------------------------------------------------------------------------------
-- [6] 풀이
6. 다음 주 월요일은 휴강일(가정)이다.. 몇 일인가요 ? 
  ( NEXT_DAY 함수 )
 SELECT SYSDATE
   ,  NEXT_DAY( SYSDATE, '월요일' )
 FROM dual;


--------------------------------------------------------------------------------------------------------------------------------
-- [7] 풀이
emp 테이블에서
   각 사원들의 입사일자를 기준으로 10년 5개월 20일째 되는 날 ? 
    [실행결과]
        HIREDATE ADD_MONT
        -------- --------
        80/12/17 91/06/06
        81/02/20 91/08/12
        81/02/22 91/08/14
        81/04/02 91/09/22
        81/09/28 92/03/18
        81/05/01 91/10/21
        81/06/09 91/11/29
        81/11/17 92/05/07
        81/09/08 92/02/28
        81/12/03 92/05/23
        81/12/03 92/05/23 
        82/01/23 92/07/12
        
        12개 행이 선택되었습니다.
  -- 10년 5개월 20일째
  SELECT hiredate      
        -- , hiredate + 20
        -- , ADD_MONTHS( hiredate, 5 )
        -- , ADD_MONTHS( hiredate, 5 ) + 20
        , ADD_MONTHS( hiredate, 12*10 + 5 ) + 20
  FROM emp;        
        
--------------------------------------------------------------------------------------------------------------------------------
-- [8] 풀이
8.  insa 테이블에서
    사원번호(num) 가  1002 인 사원의 주민번호의 월,일만을 오늘날짜로 수정하세요.
                              ssn = '80XXXX-1544236'    
-- 1002	80XXXX-1544236  ->    ssn = '800320-1544236'                            
SELECT num, ssn
FROM insa
WHERE num = 1002;
-- 오늘날짜에서 '0320' 월일 만 필요해요.
SELECT SYSDATE  -- 23/03/20
   , TO_CHAR( SYSDATE, 'YYYY') year
   , TO_CHAR( SYSDATE, 'MM') month
   , TO_CHAR( SYSDATE, 'DD') "DATE"
   , TO_CHAR( SYSDATE, 'MMDD' ) md
   , TO_CHAR( SYSDATE, 'DAY' ) day
FROM dual;
-- 수정
UPDATE insa
         --    80                        03                          20             -1544236        
-- SET ssn = SUBSTR( ssn, 0, 2) || TO_CHAR( SYSDATE, 'MM') || TO_CHAR( SYSDATE, 'DD') || SUBSTR( ssn, -8 )
         --    80                           0320             -1544236    
SET ssn = SUBSTR( ssn, 0, 2) || TO_CHAR( SYSDATE, 'MMDD')  || SUBSTR( ssn, -8 )
WHERE num = 1002;
COMMIT;

                              
8-2. insa 테이블에서 오늘을 기준으로 생일이 지남 여부를 출력하는 쿼리를 작성하세요 . 
     ( '지났다', '안지났다', '오늘 ' 처리 )

SELECT num, name , ssn
    -- , SUBSTR( ssn, 0, 6) 
    , SUBSTR( ssn, 3, 4) ㄱ -- MMDD
    , TO_CHAR(SYSDATE, 'MMDD') ㄴ
    -- 양수( 1 생일 지나지 않음 ), 음수( -1 생일 지남 ), 0 ( 오늘 생일)
    -- , SUBSTR( ssn, 3, 4) - TO_CHAR(SYSDATE, 'MMDD') 
    , SIGN(  SUBSTR( ssn, 3, 4) - TO_CHAR(SYSDATE, 'MMDD') ) ㄷ
    , REPLACE(REPLACE(REPLACE(SIGN(substr(ssn,3,4)-TO_CHAR(SYSDATE,'MMDD')),-1,'지남'),0,'오늘'),1,'안지남') ㄹ
FROM insa;     
     
--------------------------------------------------------------------------------------------------------------------------------
-- [9] 풀이
--------------------------------------------------------------------------------------------------------------------------------
-- [10] 풀이
10.  emp 테이블의 ename, pay , 최대pay값 5000을 100%로 계산해서
   각 사원의 pay를 백분률로 계산해서 10% 당 별하나(*)로 처리해서 출력
   ( 소숫점 첫 째 자리에서 반올림해서 출력 )

[실행결과]
    ename   pay     max_pay 퍼센트    별갯수
    SMITH	800	    5000	16%	2	 **
    ALLEN	1900	5000	38%	4	 ****
    WARD	1750	5000	35%	4	 ****
    JONES	2975	5000	59.5%	6	 ******
    MARTIN	2650	5000	53%	5	 *****
    BLAKE	2850	5000	57%	6	 ******
    CLARK	2450	5000	49%	5	 *****
    KING	5000	5000	100%	10	 **********
    TURNER	1500	5000	30%	3	 ***
    JAMES	950	    5000	19%	2	 **
    FORD	3000	5000	60%	6	 ******
    MILLER	1300	5000	26%	3	 ***
   
   SELECT t.*
        , (t.pay * 100 )/t.max_pay  || '%' percent
        , ROUND(  (t.pay * 100 )/t.max_pay / 10 ) 별갯수
        , RPAD( ' ', ROUND(  (t.pay * 100 )/t.max_pay / 10 ) + 1 , '*'   ) BAR
   FROM (
           SELECT ename, sal + NVL(comm, 0) pay 
                , (  SELECT MAX( sal +NVL(comm, 0) )  max_pay  FROM emp ) max_pay        
           FROM emp
       ) t; 

--------------------------------------------------------------------------------------------------------------------------------
 -- 오늘 수업 --
--------------------------------------------------------------------------------------------------------------------------------
SELECT   SYSDATE
      , CURRENT_DATE
      , CURRENT_TIMESTAMP
      , EXTRACT( YEAR  FROM SYSDATE )
FROM dual;

-- TO_CHAR( 숫자 또는 날짜) -> 문자  변환함수 
-- TO_TIMESTAMP(문자) -> 날짜(TIMESTAMP) 변환함수
-- TO_DATE(문자) -> 날짜(DATE) 변환함수
오라클 날짜 자료형 : DATE, TIMESTAMP

SELECT  TO_TIMESTAMP('2004-8-20 1:30:00', 'YYYY-MM-DD HH:MI:SS')
FROM  dual;

-- [ 변환 함수의 종류 ]
1) TO_NUMBER()    :  문자 -> 숫자로 변환하는 함수
2) TO_CHAR( 숫자 ) : 숫자 -> 문자로 변환
   TO_CHAR( 날짜 ) : 날짜 -> 문자로 변환
3) TO_DATE( 문자 ) : 문자 -> 날짜로 변환

4) CONVERT  : 문자  한 국가형식 -> 다른 국가 형식 변환 
5) HEXTORAW : 16진수 문자 -> 2진수 문자로 변환

-- 오라클  문자, 날짜는  '' 붙인다.
-- 1) TO_NUMBER()    :  문자 -> 숫자로 변환하는 함수
SELECT '12' "문자열12" , 12  "숫자12"
     , '12' - 12           -- 자동으로 숫자 12로 형 변환
     , TO_NUMBER( '12' ) - 12
     , 12 - 12
FROM dual;
-- Java :  Integer.parseInt("12" ) - 12
-- 오라클 문자(열) 자료형 : CHAR, VARCHAR2, NCHAR, NVARCHAR2 
SELECT name, ssn
     , SUBSTR( ssn, -7, 1) gender   -- '문자'
     , MOD(  TO_NUMBER( '1' ) , 2 ) 
     , MOD(  '1' , 2 ) 
FROM insa;

2) 
  12:09 수업시작~
  ㄱ. TO_CHAR( 숫자 ) : 숫자 -> 다양한 형식의 문자로 변환
  【형식】
      TO_CHAR( n [,'형식( format)' [,'nlsparam']])
  --    
  SELECT 12345    
    , TO_CHAR( 12345 )  ㄱ -- '12345'
    , TO_CHAR( 12345 , '99,999' )  ㄴ -- 세자리마다 콤마 찍어서 출력  '12,345'
    , TO_CHAR( 12345 , '99,999.00' )  ㄷ --   .   0           ' 12,345.00'
    , TO_CHAR( 12345 , 'L99,999' ) ㄹ -- L   '￦12,345'
    , TO_CHAR( 12345, 'S99999' ) ㅁ  -- '+12345'
     
  FROM dual; 
  -- sal+NVL(comm,0) *12  연봉
  SELECT ename, sal, comm
   , TO_CHAR(  sal+NVL(comm,0) *12 , '$99,999.99' ) 연봉
  FROM emp
  WHERE comm IS NOT NULL; 
  
  ㄴ. TO_CHAR( 날짜 ) : 날짜 -> 문자로 변환
  【형식】
 	TO_CHAR( date [,'fmt' [,'nlsparam']])

   -- [YY와 RR의 차이점]
   --  YY  두 자리의 년도 : 무조건 시스템 상의 년도를 붙인다. 
   --       [20]65/01/02
   --       [20]12/02/24
   
   --  RR  두 자리의 년도
   --       [19]65/01/02
   --       [20]12/02/24
   
   -- 현재 년도의 세기
   SELECT SYSDATE
      , TO_CHAR( SYSDATE, 'CC' )   -- 21세기
   FROM dual;
   
   -- 날짜형식 : RR/MM/DD
   
   SELECT ename, hiredate
   FROM emp;
    --      RR/MM/DD
    SMITH	[19]80/12/17
    ALLEN	[19]81/02/20
    WARD	[19]81/02/22
    JONES	[19]81/04/02
  --
  SELECT SYSDATE
  ,  TO_CHAR(SYSDATE, 'YYYY')a
  
  ,  TO_CHAR(SYSDATE, 'MM')  b
  ,  TO_CHAR(SYSDATE, 'MONTH')  b
  ,  TO_CHAR(SYSDATE, 'MON')  b
  
  ,  TO_CHAR(SYSDATE, 'DD')  c  -- 달의   년월[일]
  ,  TO_CHAR(SYSDATE, 'D')  c   -- 주의   [일]
  ,  TO_CHAR(SYSDATE, 'DDD')  c  -- 년의   [일]
  
  ,  TO_CHAR(SYSDATE, 'WW')  h  -- 년중 몇번째 주  12
  ,  TO_CHAR(SYSDATE, 'W')  h   -- 월중 몇번째 주  3
  ,  TO_CHAR(SYSDATE, 'IW')  h  -- 1년 중 몇째 주 12
  
  -- ( 복습 과제 :  WW와 IW 차이점 )
  
  ,  TO_CHAR(SYSDATE, 'MMDD')  d
  ,  TO_CHAR(SYSDATE, 'BC')  d
  , TO_CHAR(SYSDATE, 'Q') e -- 1~[3] 1분기  4~6 2분기 7~9 3분기 10~12 4분기
  
  
  ,  TO_CHAR(SYSDATE, 'HH')  f -- [시간],분,초
  ,  TO_CHAR(SYSDATE, 'HH24')  f -- [시간],분,초
  
  ,  TO_CHAR(SYSDATE, 'MI')  f -- 시간,[분],초
  
  ,  TO_CHAR(SYSDATE, 'SS')  f -- 시간,분,[초]
  
  ,  TO_CHAR(SYSDATE, 'SSSSS')  f -- 00:00:00 (자정)~ 지난 시간 (초)
  
  
  ,  TO_CHAR(SYSDATE, 'DY')  g --   월
  ,  TO_CHAR(SYSDATE, 'DAY')  g --  월요일
  FROM dual;
  
  SELECT 
      -- 2023년 3월 20일 월요일
      TO_CHAR( SYSDATE, 'DL' ) -- long date format
      -- 2023/03/20
     , TO_CHAR( SYSDATE, 'DS' ) -- short date format
  FROm dual;
  --
  SELECT ename, hiredate
  , TO_CHAR( hiredate, 'DS') 
  FROM emp;
  -- 'FF' 밀리세컨드 
  -- ORA-01821: date format not recognized\
  -- DATE : SYSDATE  밀리세컨드 X
  SELECT SYSDATE
      -- , TO_CHAR( SYSDATE, 'HH24:MI:SS.FF3' )
       , TO_CHAR(  CURRENT_TIMESTAMP , 'HH24:MI:SS.FF3' )
       , TO_CHAR(  SYSDATE , 'TS' ) -- 오후 12:52:35  (시간의 간략표기)
  FROM dual;
  -- 오후 수업 시작( 2:00 )
  
  [문제] 오늘 날짜를 TO_CHAR() 함수를 사용해서
   '2023년 03월 20일 오후 14:03:32 (월)' 형식으로 출력
   
   SELECT SYSDATE
     , TO_CHAR( SYSDATE ,'YYYY') || '년 ' || TO_CHAR( SYSDATE ,'MM') || '월 '  ㄱ
     -- " "  결과와 함께 출력할 문자열 
     , TO_CHAR( SYSDATE, 'YYYY"년" MM"월" DD"일" AM HH24:MI:SS (DY)' ) ㄴ
   FROm dual; 
   -- ORA-01821: date format not recognized
   --            날짜  형식이 인식되지 않는다. 
   
   -- SP 접미사를 붙이면  숫자(기수)를 영문으로 표시
   SELECT TO_CHAR( SYSDATE, 'DDSP' )
   FROm dual;
  
  -- ROUND( 날짜 ), TRUNC( 날짜 )에 사용할 FORMAT 형식.. 
  
  3) TO_DATE( 숫자, 문자 )  날짜로 변환하는 함수
  【형식】
     TO_DATE( char [,'fmt' [,'nlsparam']])
  
   [문제]우리가 수료일 ( 2023.7.10 ) 
    오늘부터 수료일 까지 남은 일수 ? 
    SELECT SYSDATE
        , '2023.7.10'  
        -- , SYSDATE - '2023.7.10'  "남은일수"
        , CEIL(ABS(  SYSDATE - TO_DATE( '2023.7.10' ) ) ) "남은일수"
        , CEIL(ABS(  SYSDATE - TO_DATE( '2023.7.10' , 'YYYY.MM.DD' ) ) ) "남은일수"
    FROM dual;
    -- ORA-01722: invalid number  왜 ? 날짜 - 날짜 = 일수
    -- 원인 : 날짜가 아니라 문자로 인식된다 ( '2023.7.10' )
    -- 해결 : 문자로 인식되는 '2023.7.10' 을    날짜로 변환
    --        TO_DATE( 문자 )
    
    
    -- 날짜 - 날짜 = 일수
    SELECT ename , hiredate, SYSDATE
       , CEIL( SYSDATE - hiredate ) 근무일수
    FROM emp;

 -- 4자리의 숫자 형식으로 0010, 0040 부서번호를 출력
 SELECT deptno
    , TO_CHAR( deptno,  '0999' )
 FROM dept;


-- [일반 함수 ] 
1) NVL
2) NVL2
3) NULLIF
4) NANVL 
--
5) COALESCE : 병합(합동,연합)하다
  나열해 놓은 값을 순차적으로 체크하여 NULL이 아닌 값을 리턴하는 함수
【형식】
        COALESCE(expr[,expr,...])

SELECT ename, sal + NVL(comm, 0) pay
      , COALESCE( sal + comm , sal , 0 ) pay
FROM emp;
 -- '' == NULL 로 처리한다. (기억)
SELECT COALESCE( '', '', 'arirang', 'Kunsan' )
FROM dual;

6) DECODE( 시험 )
  - 여러 개의 조건을 주어 조건에 맞을 경우 해당 값을 리턴하는 함수
  - 비교 연산은  = 만 가능하다.
  - PL/SQL 안에서 사용할 오라클 함수.
  - if(){} else if(){} ... else{}
  【형식】 
      DECODE(expr,  search1,result1
                  [,search2,result2,...] [,default] );


  -- 자바에서
  int x = 10;
  if( x == 11 ){
     return C;
  }
  -- 오라클 DECODE 사용해서
  DECODE( x , 11, C ) -- X가 11이라면 C를 반환한다. 
  

  -- 자바에서
  int x = 10;
  if( x == 11 ){
     return C;
  }else{
     return D;
  }
  -- 오라클 DECODE 사용해서
  DECODE( x , 11, C, D ) 
  
  -- 자바에서
  int x = 10;
  if( x == 11 ){
     return C;
  }else if( x == 12 ){
     return D;
  }else if( x == 13 ){
     return E;
  }else{
    return F;
  }
  -- 오라클 DECODE 사용해서
  DECODE( x , 11, C, 12, D, 13, E, F ) 
  
  [문제] insa 테이블에서 주민등록번호(ssn)를 가지고 "남자","여자"라고 출력.
  SELECT name, ssn
    ,  MOD(  SUBSTR( ssn, -7, 1 ), 2 ) gender
    -- DECODE( x , 11, C, D ) 
    ,  DECODE( MOD(  SUBSTR( ssn, -7, 1 ), 2 ) , 1, '남자', '여자')  gender
  FROM insa;
  
  3:00 수업 시작~
  [문제] 아침 복습문제 8-2번...
    insa 테이블에서 오늘을 기준으로 생일이 지남 여부를 출력하는 쿼리를 작성하세요 . 
       ( '지났다', '안지났다', '오늘 ' 처리 )
       ( DECODE 함수 사용해서 처리 ) 
  -- 1002 이순신	80[0320]-1544236	[1]?  왜 ? 해결  시간은 모두 절삭
  SELECT name, ssn
  , SIGN(  TRUNC(SYSDATE) - TO_DATE(  SUBSTR(ssn, 3,4 ) , 'MMDD' )  ) s
  , DECODE( SIGN(  TRUNC(SYSDATE) - TO_DATE(  SUBSTR(ssn, 3,4 ) , 'MMDD' )  ) , -1 ,'지X', 1 , '지O', 0 , '오늘'  ) ㄱ
  FROM insa;
  -- ( 기억)
  -- ORA-01861: literal does not match format string
  SELECT 
    -- TO_DATE('2023')
     TO_DATE('2023', 'YYYY')  -- 23/03/01 ( 기억 )
     , TO_DATE('04', 'MM')    -- 23/04/01  (기억)
     , TO_DATE('10', 'DD')    -- 23/03/10  (기억)
     , TO_DATE('0522', 'MMDD')    -- 23/05/22  (기억)
  FROM dual;
  
  [문제] emp 테이블에서 각 사원의 번호, 이름, 급여(pay) 출력.
    1) 10번 부서원은 15% 급여(pay) 인상
    2) 20번 부서원은 30% 급여(pay) 인상
    3) 그 외 부서원은 5% 급여(pay) 인상
    이 되는 쿼리 작성하세요.. 
    ( DECODE 함수 ) 
    
    SELECT deptno, empno, ename
      , COALESCE( sal + comm, sal , 0 ) pay
      , DECODE( deptno, 10,  15 , 20, 30,  5  ) || '%' 인상퍼센트
      , COALESCE( sal + comm, sal , 0 ) * DECODE( deptno, 10,  0.15 , 20, 0.3,  0.05  )  인금액
      , COALESCE( sal + comm, sal , 0 ) * DECODE( deptno, 10,  1.15 , 20, 1.3,  1.05  )  인금된금액
    FROM emp
    ORDER BY deptno ASC;
    
 
7) CASE  함수
   - 여러 개의 조건을 주어 조건에 맞을 경우 해당 값을 리턴하는 함수
   - DECODE 함수의 확장함수
   - 뭐가 확장되었나?  DECODE 함수는  비교 연산은  = 만 가능하다. + 다른 비교연산자도 사용가능하다.
   - 【형식】
	CASE 컬럼명|표현식 
           WHEN 조건1 THEN 결과1
		  [WHEN 조건2 THEN 결과2
                                ......
		  WHEN 조건n THEN 결과n
		  ELSE 결과4]
	END

   -- 예) CASE  
  [문제] insa 테이블에서 주민등록번호(ssn)를 가지고 "남자","여자"라고 출력.
   SELECT name, ssn
    ,  MOD(  SUBSTR( ssn, -7, 1 ), 2 ) gender 
    ,  DECODE( MOD(  SUBSTR( ssn, -7, 1 ), 2 ) , 1, '남자', '여자')  decode_gender
    ,  CASE  MOD(  SUBSTR( ssn, -7, 1 ), 2 )
              WHEN 1 THEN  '남자'
              --WHEN 0 THEN
              ELSE        '여자'
       END  case_gender
  FROM insa;
  
  [문제] 아침 복습문제 8-2번...
    insa 테이블에서 오늘을 기준으로 생일이 지남 여부를 출력하는 쿼리를 작성하세요 . 
       ( '지났다', '안지났다', '오늘 ' 처리 )
       ( CASE 함수 사용해서 처리 )  
  SELECT name, ssn
  , SIGN(  TRUNC(SYSDATE) - TO_DATE(  SUBSTR(ssn, 3,4 ) , 'MMDD' )  ) s
  , DECODE( SIGN(  TRUNC(SYSDATE) - TO_DATE(  SUBSTR(ssn, 3,4 ) , 'MMDD' )  ) , -1 ,'지X', 1 , '지O', 0 , '오늘'  ) ㄱ
  , CASE SIGN(  TRUNC(SYSDATE) - TO_DATE(  SUBSTR(ssn, 3,4 ) , 'MMDD' )  )
              WHEN -1 THEN '지X'
              WHEN 1 THEN  '지O'
              WHEN 0 THEN  '오늘'
    END ㄴ
  , CASE -- 컬럼명, 표현식 X
       WHEN TRUNC(SYSDATE) - TO_DATE(  SUBSTR(ssn, 3,4 ) , 'MMDD' ) < 0  THEN '지X'
       WHEN TRUNC(SYSDATE) - TO_DATE(  SUBSTR(ssn, 3,4 ) , 'MMDD' ) > 0 THEN  '지O'
       ELSE '오늘'
    END ㄷ
  FROM insa;
  
  4:06 수업 시작  
  [문제] emp 테이블에서 각 사원의 번호, 이름, 급여(pay) 출력.
    1) 10번 부서원은 15% 급여(pay) 인상
    2) 20번 부서원은 30% 급여(pay) 인상
    3) 그 외 부서원은 5% 급여(pay) 인상
    이 되는 쿼리 작성하세요.. 
    ( CASE 함수 ) 
    
    SELECT deptno, empno, ename
      , COALESCE( sal + comm, sal , 0 ) pay
      , DECODE( deptno, 10,  15 , 20, 30,  5  ) || '%' 인상퍼센트
      , COALESCE( sal + comm, sal , 0 ) * DECODE( deptno, 10,  0.15 , 20, 0.3,  0.05  )  인금액
      , COALESCE( sal + comm, sal , 0 ) * DECODE( deptno, 10,  1.15 , 20, 1.3,  1.05  )  decode_인금된금액
      , COALESCE( sal + comm, sal , 0 ) * CASE  deptno
                                               WHEN 10 THEN 1.15
                                               WHEN 20 THEN 1.3
                                               ELSE         1.05
                                            END  case_인금된금액
      , COALESCE( sal + comm, sal , 0 ) * CASE  
                                               WHEN deptno = 10 THEN 1.15
                                               WHEN deptno = 20 THEN 1.3
                                               ELSE         1.05
                                            END  case_인금된금액                                            
    FROM emp
    ORDER BY deptno ASC;  
     
-- [정규 표현식 함수 ] 
1) REGEXP_LIKE() 
2) REGEXP_INSTR() 
3) REGEXP_SUBSTR() 
2) REGEXP_REPLACE() 

-- [그룹 함수 ]
   - 그룹당 하나의 결과를 출력한다.
   - 그룹 함수는 SELECT절 및 HAVING 절에서 사용할 수 있다.
   - GROUP BY절은 행들을 그룹화 한다.
   - HAVING 절은 그룹을 제한한다.(비교: WHERE 절은 행(row)을 제한한다.)

1) AVG() : 평균
   총 사원 12명 : comm 이 NULL 인 사원이 8명
SELECT ename, comm
FROM emp;
  [문제]  sal 평균,  comm 평균 계산해서 출력
  SELECT AVG( sal )  sal_avg
        -- comm의 평균 계산 ( 주의  )
        , AVG( comm ) comm_avg               -- 550
        , SUM( comm ) / COUNT(*)   comm_avg  -- 183.3333
  FROM emp;
  -- 30명 학생       2명 중간 국어시험( null ) X
  --    28명   반 국어 평균 :  총합/30,   총합/28
  SELECT comm
  FROm emp;

2) COUNT : NULL이 아닌 행의 갯수 반환하는 함수

【형식】
	COUNT([* ¦ DISTINCT ¦ ALL] 컬럼명) [ [OVER] (analytic 절)] 

SELECT    COUNT( comm )   -- 4명   comm이 NULL인 사원 제외     8
        , COUNT( deptno ) -- 11명  deptno이 NULL인 사원 제외   1
        , COUNT( sal )    -- 12명  sal 이 NULL인 사원 제외     X
        , COUNT(  *  )  -- NULL을 포함한 행의 수 == 모든 사원수
FROM emp;

 [문제]  insa 테이블에서 부서의 수를 출력..   (  7개의 부서 )
 SELECT COUNT( DISTINCT buseo )
 FROM insa
 ORDER BY buseo ASC;

3) MAX
4) MIN

6) SUM : NULL을 제외한 n의 합계를 리턴한다.
  【형식】
	SUM ([DISTINCT ¦ ALL] expr) [OVER (analytic_clause)]
  [문제] emp 테이블의 모든 sal의 합
  SELECT SUM(sal) tot_sal
       , SUM(comm) tot_comm
  FROM emp;

5) STDDEV    표준편차
7) VARIANCE  분산

[문제] emp 테이블에서 각 부서의 사원수를 출력(조회) 
1번째 풀이방법) SET 연산자 ( UNION, UNION ALL )
SELECT '10' deptno , COUNT(*)
FROM emp
WHERE deptno = 10
UNION ALL
SELECT  '20' ,COUNT(*)
FROM emp
WHERE deptno = 20
UNION ALL
SELECT  '30' ,COUNT(*)
FROM emp
WHERE deptno = 30 
UNION ALL
SELECT  '40' ,COUNT(*)
FROM emp
WHERE deptno = 40
UNION ALL
SELECT 'NULL', COUNT(*)
FROM emp
WHERE deptno IS NULL;

2번째 풀이방법 ( 이해, 암기 )  COUNT(), DECODE()       ( 팀 스터디 )
  -- 부서가 없는 사원수 출력   X
SELECT 
       COUNT(*) "총 사원수"
     , COUNT(  DECODE( deptno, 10 , 'O' ) ) "10번 사원수"
     , COUNT(  DECODE( deptno, 20 , 'O' ) ) "20번 사원수"
     , COUNT(  DECODE( deptno, 30 , 'O' ) ) "30번 사원수"
     , COUNT(  DECODE( deptno, 40 , 'O' ) ) "40번 사원수"
FROM emp;

3번째 풀이방법)
-- ORA-00937: not a single-group group function
-- ORA-00979: not a GROUP BY expression
--SELECT deptno,  job,  COUNT(*) 

SELECT deptno,    COUNT(*) 
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;  -- 집계함수 MAX,MIN,AVG,SUM,COUNT등등
(문제점) 결과 확인해 보면   40  0 X
10	2
20	3
30	6
null	1

-- 집계함수 
-- 순위(RANK)함수
-- TOP - N 

-- 오라클 자료형( Data Type )
-- 테이블 생성, 수정, 삭제 + CRUD
-- 제약조건

-- 조인






















