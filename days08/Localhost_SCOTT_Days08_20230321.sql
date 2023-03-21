-- SCOTT -- 
--------------------------------------------------------------------------------
-- 10:30 복습 문제 풀이~
--------------------------------------------------------------------------------
1.  TO_CHAR( ,  'format') 함수에서 'format'에 사용되는 기호를 적으세요.
  ㄱ. 년도 : Y, YY, YYY, [YYYY], IY,IYY, IYYY, IYYYY, YEAR, SYEAR, RR, RRRR
  ㄴ. 월 : MM, MONTH, MON
  ㄷ. 월의 일 : DD
      주의 일 : D
      년의 일 : DDD
  ㄹ. 요일 : DY, DAY
  ㅁ. 월의 주차 : W
      년의 주차 : WW, IW
  ㅂ. 시간/24시간 : HH, HH12, HH24
  ㅅ. 분 : MI
  ㅇ. 초 : SS
  ㅈ. 자정에서 지난 초 : SSSSS
  ㅊ. 오전/오후 : AM,  PM

--------------------------------------------------------------------------------
2. 본인의 생일로부터 오늘까지 살아온 일수, 개월수, 년수를 출력하세요..
 SELECT SYSDATE  ㄱ
       , '1993.12.10'   ㄴ
       --      날짜 - 날짜 = 일수 
       -- , SYSDATE - '1993.12.10'
       -- ORA-01722: invalid number
       -- '1993.12.10' 을 날짜로 형 변환
       --  문자열  -> 날짜   변환 함수 ? TO_DATE()
       --【형식】
       -- TO_DATE( char [,'fmt' [,'nlsparam']])
       --, SYSDATE -  TO_DATE( '1993.12.10' ,'YYYY.MM.DD' ) ㄷ
       , CEIL( SYSDATE -  TO_DATE( '1993.12.10' ) ) "살아온 일수"
       , ROUND( MONTHS_BETWEEN( SYSDATE, TO_DATE( '1993.12.10' ) ), 2 ) "개월수"
       , ROUND( MONTHS_BETWEEN( SYSDATE, TO_DATE( '1993.12.10' ) ) /12, 2 ) "년수"
 FROM dual;
 
   반올림 : ROUND
   절상(올림) : CEIL
   절삭(내림) : TRUNC, FLOOR 차이점

--------------------------------------------------------------------------------
3. IW와 WW 의 차이점.
ㅁ.   월의 주차 : W
      년의 주차 : WW, IW
      
      WW  : 1일~7일을 기준으로 주차 표시
        1~7 1주차
        8~14 2주차
        :
      IW  : 일요일을 기점으로 주차 표시

      
      [2022.1]
  일 월 화 수 목 금 토
                   [1   -- WW 1주차 ,  IW 52주차
  <2          7]    9>  -- IW 1주차
  10              16
  17              23
  24              30
  31 
  
  '2022.01.01'         IW
SELECT   TO_CHAR(  TO_DATE('2022.01.01') , 'IW' )   -- 년중의 52주차   토
         , TO_CHAR(  TO_DATE('2022.01.02') , 'IW' )   -- 년중의 52주차 일
  2022/01
26  27  28  29 30 31  1
2   3                 9
10

--        , TO_CHAR(  TO_DATE('2022.01.01') , 'WW' )  -- 년중의 1주차
--        , TO_CHAR(  TO_DATE('2022.01.07') , 'WW' )  -- 년중의 1주차
--        , TO_CHAR(  TO_DATE('2022.01.08') , 'WW' )  -- 년중의 2주차
FROM dual;
 
 11:05 수업 시작~
--------------------------------------------------------------------------------
4-1. 이번 달이 몇 일까지 있는 확인. (
  ㄱ. LAST_DAY() 마지막 날짜 얻어올 수 있고, 
SELECT SYSDATE
       , LAST_DAY( SYSDATE )
       , TO_CHAR(  LAST_DAY( SYSDATE ) , 'DD' )   --  문자 반환
       , EXTRACT(  DAY   FROM LAST_DAY( SYSDATE ) ) -- 숫자 반환
   -- ㄴ. 다음 달 1일  날짜 생성 '2023.04.01'  
       -- 날짜 - 일수 = 날짜
       , TO_CHAR(SYSDATE , 'YYYY.MM' )
       , ADD_MONTHS( SYSDATE, 1 )
       , TO_CHAR(  ADD_MONTHS( SYSDATE, 1 ) , 'YYYY.MM')
       -- ORA-01861: literal does not match format string
       -- , TO_DATE( '2023.04' , 'YYYY.MM' ) -- 23/04/01
       , TO_DATE( TO_CHAR(  ADD_MONTHS( SYSDATE, 1 ) , 'YYYY.MM')  , 'YYYY.MM' ) -- 23/04/01
       , TO_DATE( TO_CHAR(  ADD_MONTHS( SYSDATE, 1 ) , 'YYYY.MM')  , 'YYYY.MM' ) - 1
FROM dual;

4-2. 오늘이 년중 몇 째 주, 월중 몇 째주인지 확인. 

SELECT SYSDATE
      , TO_CHAR( SYSDATE, 'W' ) -- 그 달의 몇 번째 주
      , TO_CHAR( SYSDATE, 'IW' ) -- 그 해의 몇 번째 주
      , TO_CHAR( SYSDATE, 'WW' ) -- 그 해의 몇 번째 주
FROM dual;

--------------------------------------------------------------------------------
5. emp 에서  pay 를 NVL(), NVL2(), COALESCE()함수를 사용해서 출력하세요.

SELECT 
   --  sal + comm pay     NULL 연산 -> NULL
   --  NULL 처리 함수사용해서 
   sal + NVL(comm, 0) pay
   , sal + NVL2( comm, comm, 0) pay
   , COALESCE( sal + comm, sal , 0 ) pay
   , sal  + COALESCE( comm, 0) pay
FROM emp;

5-2. emp테이블에서 mgr이 null 인 경우 -1 로 출력하는 쿼리 작성
      ㄱ. nvl()
      ㄴ. nvl2()
      ㄷ. COALESCE()
      
   SELECT deptno, ename
        ,  NVL( mgr  , -1 ) mgr
        ,  NVL2( mgr , mgr , -1 ) mgr
        ,  COALESCE(mgr, -1) mgr
   FROM emp;   
      
--------------------------------------------------------------------------------
6. insa 에서  이름,주민번호, 성별( 남자/여자 ), 성별( 남자/여자 ) 출력 쿼리 작성-
    *** ㄱ. DECODE()
    *** ㄴ. CASE 함수
    
    SELECT name, ssn
        , SUBSTR( ssn, -7, 1 ) ㄱ
        , MOD( SUBSTR( ssn, -7, 1 ), 2 ) ㄴ  -- 1(남자) , 0(여자)
        -- , DECODE( MOD( SUBSTR( ssn, -7, 1 ), 2 ) , 1 , '남자', 0 , '여자')
        , DECODE( MOD( SUBSTR( ssn, -7, 1 ), 2 ) , 1 , '남자', '여자') gender
        -- , DECODE( MOD( SUBSTR( ssn, -7, 1 ), 2 ) , 1 , '남자' ) gender
        , CASE  MOD( SUBSTR( ssn, -7, 1 ), 2 )
                WHEN 1 THEN '남자'
                ELSE '여자'
          END gender
        , CASE 
                WHEN  MOD( SUBSTR( ssn, -7, 1 ), 2 ) = 1 THEN '남자'
                ELSE '여자'
          END gender  
    FROM insa;    
    
--------------------------------------------------------------------------------
7. emp 에서 평균PAY 보다 같거나 큰 사원들만의 급여합을 출력.
  ( DECODE, CASE 사용해서 풀이 ) 
  SELECT SUM( sal + NVL(comm, 0) ) tot_pay  -- 27125
  FROM emp;
  -- 평균 PAY 확인
  SELECT AVG(  sal + NVL(comm, 0) )   avg_pay  -- 2260.416666666666666666666666666666666667
  FROM emp;
  -- 평균 PAY보다 많이 받는 사원 조회.
  WITH 
    temp AS (
              SELECT  empno, ename, sal + NVL(comm, 0) pay
              FROM  emp
              WHERE sal + NVL(comm, 0) >= ( 
                                           SELECT AVG(  sal + NVL(comm, 0) )   avg_pay  -- 2260.416666666666666666666666666666666667
                                           FROM emp 
                                          )
                              
     )   
   SELECT SUM(   t.pay  )  -- 18925
   FROM temp t;
  
   -- 2번째 방법
   WITH 
    temp AS (
              SELECT  empno, ename, sal + NVL(comm, 0) pay
                      , (  SELECT AVG( sal + NVL(comm, 0 )) FROM emp ) avg_pay 
              FROM  emp       
     )   
     -- t.pay - t.avg_pay 음수가 나오면 평균 PAY보다 작다.
    -- ORA-00942: table or view does not exist
   SELECT  
     SUM( DECODE(  SIGN( t.pay - t.avg_pay ) , -1, NULL, t.pay ) )  -- 18925
     ,SUM(  
            CASE SIGN( t.pay - t.avg_pay )
               WHEN -1 THEN NULL
               ELSE   t.pay
            END
        )
      ,SUM(  
            CASE 
               WHEN SIGN( t.pay - t.avg_pay ) >= 0  THEN t.pay
               -- ELSE   NULL
            END
        )  
   FROM temp t;
 
12:00 수업 시작 
[문제] insa 테이블에서 남자사원수, 여자사원수 출력(조회)  
SELECT name, ssn
      --, SUBSTR( ssn, -7, 1) 
      , MOD( SUBSTR( ssn, -7, 1) , 2 )  gender
FROM insa;

 -- 첫 번째 방법
 SELECT '총 사원수', COUNT(*) 
 FROM insa
 UNION ALL
 SELECT '남자 사원수',COUNT(*) 
 FROM insa
 WHERE MOD( SUBSTR( ssn, -7, 1) , 2 ) = 1
 UNION ALL
 SELECT '여자 사원수',COUNT(*) 
 FROM insa
 WHERE MOD( SUBSTR( ssn, -7, 1) , 2 ) = 0;
 -- 두 번째 방법
 
 SELECT 
     COUNT(*) "총 사원수"
    , COUNT( DECODE( MOD( SUBSTR( ssn, -7, 1) , 2 ), 1, 100 ) ) "남자 사원수"
    -- , COUNT( DECODE( MOD( SUBSTR( ssn, -7, 1) , 2 ), 0, 100 ) ) "여자 사원수"
    , COUNT( 
       CASE  MOD( SUBSTR( ssn, -7, 1) , 2 )
             WHEN 0 THEN 'F'   -- ORA-00907: missing right parenthesis 괄호 누락되었다..
             ELSE        NULL
       END
    ) "여자 사원수"
 FROM insa;
 
 -- 세 번째 방법
 SELECT MOD( SUBSTR( ssn, -7, 1) , 2 ), COUNT(*) "사원수"
 FROM insa
 GROUP BY MOD( SUBSTR( ssn, -7, 1) , 2 );
 [ 결과 ]
                      성별        사원수
----------------------- ----------
                      남자         31
                      여자         29
 SELECT  DECODE(  MOD( SUBSTR( ssn, -7, 1) , 2 ) , 1 , '남자', '여자') "성별"
       , COUNT(*) "사원수"
 FROM insa
 GROUP BY MOD( SUBSTR( ssn, -7, 1) , 2 );
  
    [문제] emp 테이블에서 각 부서별 사원수 조회(출력 )
    -- 1) UNION ALL ( SET 연산자 )
    SELECT COUNT(*)
    FROM emp
    WHERE deptno = 10 
    UNION ALL
    SELECT COUNT(*)
    FROM emp
    WHERE deptno = 20   
    UNION ALL
    SELECT COUNT(*)
    FROM emp
    WHERE deptno = 30 
    UNION ALL
    SELECT COUNT(*)
    FROM emp
    WHERE deptno = 40 
    UNION ALL
    SELECT COUNT(*)
    FROM emp
    WHERE deptno IS NULL;
    
    -- 2) COUNT, DECODE
    SELECT COUNT(*)
        , COUNT( DECODE(  deptno, 10 , 'O'  )  )  "10"
        , COUNT( DECODE(  deptno, 20 , 'O'  )  )  "20"
        , COUNT( DECODE(  deptno, 30 , 'O'  )  )  "30"
        , COUNT( DECODE(  deptno, 40 , 'O'  )  )  "40"
        , COUNT( DECODE(  deptno, NULL , 'O'  )   ) "NULL"
    FROM emp;
    
    -- 3) GROUP BY 
    --   문제점 ) 사원이 존재하지 않는 부서 정보는 출력(조회)되지 않는다. 
    --   추가 ) 전체 사원수 출력  : UNION ALL ( SET 연산자 )
    SELECT deptno , COUNT(*) 
    FROM emp
    GROUP BY deptno    
    UNION ALL
    SELECT 0 deptno, COUNT(*)
    FROM emp 
    UNION ALL
    SELECT 40 deptno, COUNT(*)
    FROM emp
    WHERE deptno = 40
    ORDER BY deptno;  -- ORA-00904: "DEPTNO": invalid identifier
    
    10	2
    20	3
    30	6
	null 1    
    *** 40  0 ***          OUTER JOIN ( 조인 )
    
    [확인] 각 부서별  총사원수, 총급여합, 최고급여액, 최저급여핵
    SELECT 
        deptno
        , COUNT(*) "사원수"
        , SUM(  sal + NVL(comm, 0)  ) "총급여합"
        , MAX(  sal + NVL(comm, 0)  ) "최고급여합"
        , MIN(  sal + NVL(comm, 0)  ) "최저급여합"
        , AVG(  sal + NVL(comm, 0)  ) "평균급여합"
    FROM emp
    GROUP BY deptno
    ORDER BY deptno;
    
--------------------------------------------------------------------------------  
8. emp 에서  사원이 존재하는 부서의 부서번호만 출력            40
SELECT deptno, dname, loc
FROM dept;
-- 10	ACCOUNTING	NEW YORK
-- 20	RESEARCH	DALLAS
-- 30	SALES	CHICAGO
-- 40	OPERATIONS	BOSTON

SELECT *
FROM emp
ORDER BY deptno;

  [문제] 사원이 존재하지 않는 부서번호만 출력.
-- SET 연산자  ( MINUS )
SELECT deptno 
FROM dept 
MINUS
SELECT DISTINCT deptno
FROM emp;

 -- OUTER JOIN( 외부 조인) --
    SELECT d.deptno --, COUNT(e.ename) 사원수
    FROM dept d LEFT OUTER JOIN emp e ON d.deptno = e.deptno
    GROUP BY d.deptno
    HAVING COUNT(e.ename) = 0 ;
    
  -- JOIN (조인 == 결합하다.)  (암기) --    
  [문제] emp 테이블에서 사원 정보 조회
    ( 부서번호, 부서명, 사원번호, 사원명, 입사입자 ) 
                 X
  SELECT deptno, empno, ename, hiredate
  FROM emp;  
  -- dept(부서) 테이블에   dname 컬럼으로 부서명이 존재..
  SELECT *
  FROM dept;
  
  -- dept 과 emp 을 결합(JOIN)해야지 우리가 원하는 컬럼 정보를 조회할 수 있다. 
  -- dept  : deptno, dname
  -- emp   : deptno, empno, ename, hiredate
  
  -- ORA-00918: column ambiguously defined
  --        deptno  컬럼  애매모호하게 정의(선언)되었다. 
  --  왜 ? dept - deptno, emp - deptno
  SELECT dept.deptno, dept.dname,   emp.empno, emp.ename,emp.hiredate
  FROM dept, emp
  WHERE dept.deptno = emp.deptno;
  --
  SELECT d.deptno, d.dname,   e.empno, e.ename, e.hiredate
  FROM dept d, emp e 
  WHERE d.deptno = e.deptno;
  -- d.deptno, e.deptno  (EQUI JOIN) 
  SELECT e.deptno, dname, empno, ename, hiredate
  FROM dept d, emp e 
  WHERE d.deptno = e.deptno;
  
  -- 위의 쿼리랑 똑같은 쿼리
  SELECT e.deptno, dname, empno, ename, hiredate
  FROM dept d JOIN emp e  ON d.deptno = e.deptno;
  

--------------------------------------------------------------------------------
9. 아래 코딩을  DECODE()를 사용해서 표현하세요.
    ㄱ. [자바]
        if( A == B ){
           return X;
        }
        
        DECODE( A, B, X )
    
    ㄴ. [자바]
        if( A==B){
           return S;
        }else if( A == C){
           return T;
        }else{
           return U;
        }
        
        DECODE( A, B, S, C, T, U )
    
    ㄷ.  [자바]
        if( A==B){
           return XXX;
        }else{
           return YYY;
        }
        
        DECODE( A, B, XXX, YYY )
--------------------------------------------------------------------------------
10. insa테이블에서 1001, 1002 사원의 주민번호의 월/일 만 오늘 날짜로 수정하는 쿼리를 작성 
 SELECT SYSDATE
     , TO_CHAR(  SYSDATE,  'MMDD' )  -- '0321'
 FROM dual;
 --
 SELECT num, name , ssn 
 FROM insa
 WHERE num IN ( 1001, 1002 );
 --
 UPDATE insa
 SET  ssn = SUBSTR(ssn, 0,2 ) || TO_CHAR(  SYSDATE,  'MMDD' ) || SUBSTR( ssn, 7 ) 
 WHERE num IN ( 1001, 1002 );
 
 COMMIT;

10-2. insa테이블에서 오늘('2023.03.21')을 기준으로 아래와 같이 출력하는 쿼리 작성.  
   ( DECODE, CASE 함수 사용 )
결과)
장인철	780506-1625148	생일 후
김영년	821011-2362514	생일 전
나윤균	810810-1552147	생일 후
김종서	751010-1122233	오늘 생일
유관순	801010-2987897	오늘 생일
정한국	760909-1333333	생일 후

-- 3:00 수업 시작~
;
-- 생일 전 == 생일이 지나지 않았다.
-- 생일 후 == 생일이 지났다.  3/3
SELECT name, ssn
--  , SUBSTR( ssn , 3, 4) 
--  , TO_CHAR(  SYSDATE, 'MMDD')
 , SUBSTR( ssn , 3, 4) - TO_CHAR(  SYSDATE, 'MMDD') 
  , SIGN( SUBSTR( ssn , 3, 4) - TO_CHAR(  SYSDATE, 'MMDD')  ) s
  , DECODE( SIGN( SUBSTR( ssn , 3, 4) - TO_CHAR(  SYSDATE, 'MMDD')  ), 0 , '오늘 생일', 1 , '생일 전', -1 , '생일 후' ) ㄱ
  , CASE
       WHEN  SUBSTR( ssn , 3, 4) - TO_CHAR(  SYSDATE, 'MMDD') > 0 THEN  '생일 전'
       WHEN  SUBSTR( ssn , 3, 4) - TO_CHAR(  SYSDATE, 'MMDD') < 0 THEN  '생일 후'
       ELSE  '오늘 생일'
    END  ㄴ
FROM insa; 

10-3. insa테이블에서 오늘('2023.03.21')기준으로 이 날이 생일인 사원수,지난 사원수, 안 지난 사원수를 출력하는 쿼리 작성. 
       
[실행결과]
  생일 전 사원수   생일 후 사원수  오늘 생일 사원수
---------- ---------- ----------
        48         12          0  
 -- 첫 번째 방법
-- ORA-00923: FROM keyword not found where expected
SELECT    COUNT( DECODE( s, 0 , 'O' ) ) "오늘 생일 사원수"
        , COUNT( DECODE( s, -1 , 'O' ) ) "생일 후 사원수"
        , COUNT( DECODE( s, 1 , 'O' ) ) "생일 전 사원수"        
FROM (        
        SELECT  num, name, ssn ,   SIGN( SUBSTR( ssn , 3, 4) - TO_CHAR(  SYSDATE, 'MMDD')  )   s     
        FROM insa
      ) t ;
      
 -- 두 번째 방법
 SELECT
       CASE s 
           WHEN 0 THEN '오늘 생일'
           WHEN 1 THEN '생일 전'
           WHEN -1 THEN '생일 후'
       END ㄱ_case
       , DECODE( s , 0 , '오늘 생일', 1 , '생일 전', '생일 후' )  ㄴ_decode
       , COUNT(*) "사원수"
 FROM (        
        SELECT  num, name, ssn ,   SIGN( SUBSTR( ssn , 3, 4) - TO_CHAR(  SYSDATE, 'MMDD')  )   s     
        FROM insa
      ) t 
 GROUP BY    s   ; 

--------------------------------------------------------------------------------
11.  emp 테이블에서 10번 부서원들은  급여 15% 인상
                20번 부서원들은 급여 10% 인상
                30번 부서원들은 급여 5% 인상
                40번 부서원들은 급여 20% 인상
  하는 쿼리 작성.     
  SELECT deptno, ename, sal , comm, sal + NVL(comm, 0) pay
         , DECODE( deptno, 10, 15, 20, 10, 30, 5, 40, 20 ) || '%' "인상율"
         , comm, (sal + NVL(comm, 0)) * DECODE( deptno, 10, 0.15, 20, 0.1, 30, 0.05, 40, 0.2 ) "인상액"
         , (sal + NVL(comm, 0)) * CASE deptno
                                   WHEN 10 THEN 0.15
                                   WHEN 20 THEN 0.1
                                   WHEN 30 THEN 0.05
                                   WHEN 40 THEN 0.2
                               END "인상액"
  FROM emp;
--------------------------------------------------------------------------------
12. emp 테이블에서 각 부서의 사원수를 조회하는 쿼리
  ( 힌트 :  DECODE, COUNT 함수 사용 )
  -- 첫 번째 방법 : GROUP BY절
  SELECT deptno, COUNT(*)
  FROM emp
  GROUP BY deptno;
  -- 문제점 40번 부서 X
  -- [EQUI JOIN ==INNER JOIN]
  --  OUTER JOIN
  --   1) LEFT [OUTER] JOIN
  --   2) RIGHT [OUTER] JOIN
  --   3) FULL [OUTER] JOIN
  SELECT d.deptno , COUNT(ename) 
  FROM dept d FULL OUTER JOIN emp e  ON d.deptno = e.deptno
  GROUP BY d.deptno
  ORDER BY d.deptno ASC;
  
--------------------------------------------------------------------------------
13. emp, salgrade 두 테이블을 참조해서 아래 결과 출력 쿼리 작성.

    ENAME   SAL     GRADE
    ----- ----- ---------
    SMITH	800	    1
    ALLEN	1900	3
    WARD	1750	3
    JONES	2975	4
    MARTIN	2650	4
    BLAKE	2850	4
    CLARK	2450	4
    KING	5000	5
    TURNER	1500	3
    JAMES	950	    1
    FORD	3000	4
    MILLER	1300	2

 SELECT *
 FROM salgrade;
   GRADE      LOSAL      HISAL
---------- ---------- ----------
         1        700       1200
         2       1201       1400
         3       1401       2000
         4       2001       3000
         5       3001       9999

  -- 첫 번째 방법         
  SELECT ename, sal 
      , CASE
           WHEN sal BETWEEN 700 AND 1200 THEN 1
           WHEN sal BETWEEN 1201 AND 1400 THEN 2
           WHEN sal BETWEEN 1401 AND 2000 THEN 3
           WHEN sal BETWEEN 2001 AND 3000 THEN 4
           WHEN sal BETWEEN 3001 AND 9999 THEN 5
        END grade
  FROM emp;       
  
  -- 두 번째 방법 ( NON-EQUI JOIN  )   ( 암기 ) 
  SELECT  ename,  sal
          , losal || ' ~ ' || hisal grade_range
          , grade
  FROM emp e , salgrade s
  WHERE  e.sal BETWEEN s.losal AND s.hisal; 
 
--------------------------------------------------------------------------------
14. emp 테이블에서 급여를 가장 많이 받는 사원의 empno, ename, pay 를 출력.
SELECT empno, ename, sal + NVL(comm, 0) pay
FROM emp
WHERE sal >= ALL( SELECT sal+NVL(comm,0) pay FROM emp ) ;
WHERE sal = ( SELECT MAX( sal + NVL(comm, 0)) max_pay  FROM emp );

  -- RANK 순위 함수
  -- TOP -N 방식... 

4:00 수업 시작~ 
14-2. emp 테이블에서 각 부서별 급여를 가장 많이 받는 사원의 pay를 출력
 1) UNION ALL 사용해서 풀기
 2) GROUP BY  사용해서 풀기
         SELECT deptno , MAX( sal + NVL(comm, 0)) max_pay
         FROM emp
         GROUP BY deptno 
         ORDER BY deptno;
         
         --
         SELECT d.deptno , NVL( MAX( sal + NVL(comm, 0)) , 0 ) max_pay
         FROM emp e FULL OUTER JOIN dept d      ON  d.deptno = e.deptno
         GROUP BY d.deptno 
         ORDER BY d.deptno;
 
 3) 상관 서브쿼리 사용해서 풀기 + 조인
 SELECT deptno, ename, sal + NVL(comm, 0) pay
 FROM emp a
 WHERE  sal + NVL(comm, 0) = ( 
                                 SELECT MAX( sal + NVL(comm, 0)) deptno_max_pay    
                                 FROM emp b 
                                 WHERE b.deptno = a.deptno 
                             ); 
--------------------------------------------------------------------------------
-- [문제] emp 테이블에서 pay를 많이 받는 3명 정보를 조회 ( TOP-N 방식)
SELECT  ROWNUM, t.*
FROM (
            SELECT empno, ename, hiredate, sal + NVL(comm, 0) pay, deptno
            FROM emp
            ORDER BY pay DESC
      ) t
WHERE  ROWNUM BETWEEN 3 AND 5 ;     -- 중간의 순번(ROWNUM)은 가져올 수 없다. (주의 )
WHERE  ROWNUM <= 5 ;

-- [ TOP-N 방식]
1) 최대값이나 최소값을 가진 컬럼을 질의할 때 유용하게 사용되는 분석방법.
2) inline view에서 ORDER BY 절을 사용할 수 있으므로 
   데이터를 원하는 순서로 정렬도 가능하다.
3) ROWNUM 컬럼은 subquery에서 반환되는 
   각 행에 순차적인 번호를 부여하는 의사(pseudo)컬럼이다   .
4) n값은 < 또는 >=를 사용하여 정의하며, 반환될 행의 개수를 지정한다.
5) 형식】
	SELECT 컬럼명,..., ROWNUM
	FROM (
          SELECT 컬럼명,... from 테이블명
	      ORDER BY top_n_컬럼명
          )
        WHERE ROWNUM <= n; 
--------------------------------------------------------------------------------
-- 순위(RANK) 함수 
-- [문제] emp 테이블에서 pay를 많이 받는 3명 정보를 조회 ( 순위(RANK) 함수 )
-- 1) DENSE_RANK
-- 2) PERCENT_RANK
-- 3) RANK
-- 4) FIRST / LAST
-- *** 5) ROW_NUMBER  ***
    - 분석(analytic) 함수.
    - 분할별로 정렬된 결과에 대해 순위를 부여하는 기능이다.
    - 분할은 전체 행을 특정 컬럼을 기준으로 분리하는 기능으로 
       GROUP BY 절에서 그룹화하는 방법과 같은 개념이다.
    - 【형식】
      ROW_NUMBER () 
                   OVER ([query_partition_clause] order_by_clause )
   SELECT t.*
   FROM ( 
           SELECT deptno, ename, sal + NVL(comm, 0) pay
                 , ROW_NUMBER() OVER( ORDER BY  sal + NVL(comm, 0) DESC ) 순위
           FROM emp
   ) t
   WHERE 순위 BETWEEN 3 AND 5;
   WHERE 순위 <= 1;
   WHERE 순위 <= 3; 

--------------------------------------------------------------------------------
[문제] 각 부서별로 최고 급여를 받는 사원 1명을 조회. 
SELECT t.*
FROM ( 
          SELECT buseo, name, basicpay + sudang  pay
             , ROW_NUMBER() OVER( PARTITION BY buseo   ORDER BY basicpay + sudang DESC ) 순위
          FROM insa
     )  t 
WHERE     순위 = 2;        
WHERE     순위 = 1;     
WHERE     순위 <= 3;
  --
  SELECT DISTINCT buseo
  FROM insa;
    총무부
    개발부
    영업부
    기획부
    인사부
    자재부
    홍보부
 --
--------------------------------------------------------------------------------
-- DENSE_RANK
     - 그룹 내에서 차례로 된 행의 rank를 계산하여 NUMBER 데이터타입으로 순위를 반환한다.
     - 해당 값에 대한 우선순위를 결정(중복 순위 계산 안함) 

【Aggregate 형식】
      DENSE_RANK ( expr[,expr,...] ) WITHIN GROUP
        (ORDER BY expr [[DESC ¦ ASC] [NULLS {FIRST ¦ LAST} , expr,...] )
   

【Analytic 형식】
      DENSE_RANK ( ) OBER ([query_partion_clause] order_by_clause )


-- RANK
    이 함수는 그룹 내에서 위치를 계산하여 반환한다.
    해당 값에 대한 우선순위를 결정(중복 순위 계산함)
    
    반환되는 데이터타입은 NUMBER이다.
    
    
    【Aggregate 형식】
            RANK(expr[,...]) WITHIN GROUP
                (ORDER BY {expr [DESC ¦ ASC] [NULLS {FIRST ¦ LAST}]
                          } )
    
    【Analytic 형식】
        RANK() OVER( [query_partition_clause] order_by_clause


--  ROW_NUMBER

--------------------------------------------------------------------------------
   SELECT empno, ename, sal
       , RANK()  OVER( ORDER BY sal DESC )      rank_순위              -- 중복 순위 계산 O
       , DENSE_RANK() OVER( ORDER BY sal DESC ) dense_rank_순위    -- 중복 순위 계산 X  DENSE == 밀집한
       , ROW_NUMBER() OVER( ORDER BY sal DESC ) row_number_순위
   FROM emp;

7654	MARTIN	1250	9	9	9
7521	WARD	1250	9	9	10
7900	JAMES	950	    11	10	11
--------------------------------------------------------------------------------
SELECT deptno, empno, ename, sal
       , RANK()  OVER( PARTITION BY deptno ORDER BY sal DESC )      rank_순위              -- 중복 순위 계산 O
       , DENSE_RANK() OVER( PARTITION BY deptno ORDER BY sal DESC ) dense_rank_순위    -- 중복 순위 계산 X  DENSE == 밀집한
       , ROW_NUMBER() OVER( PARTITION BY deptno ORDER BY sal DESC ) row_number_순위
   FROM emp;
   
--------------------------------------------------------------------------------
[ 참고 ] 자바에서 처럼 등수 처리 
        한명 총점 -> 등수를 1등씩 증가
  
  SELECT deptno, ename, sal 
       , ( SELECT COUNT(*) FROM emp b  WHERE b.sal >   a.sal     ) +1  순위
  FROM emp  a    

--------------------------------------------------------------------------------
 [문제] emp 테이블에서 sal가 상위 20% 사원 정보 조회.
-------------------------------------------------------------------------------- 
SELECT t.*
FROM ( 
        SELECT deptno, ename, sal 
             , RANK() OVER( ORDER BY sal DESC ) r
        FROM emp
    ) t
WHERE r <= ( SELECT COUNT(*) FROM emp )*0.2   ;
 
   


















 




















