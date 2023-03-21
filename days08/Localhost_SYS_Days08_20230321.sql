--  SYS --
1.  TO_CHAR( ,  'format') 함수에서 'format'에 사용되는 기호를 적으세요.
  ㄱ. 년도 : Y, YY, YYY, [YYYY],  IY, IYY, IYYY, IYYYY, YEAR, SYEAR, RR, RRRR
  ㄴ. 월 : MM, MONTH, MON
  ㄷ. 월의 일 :  DD
      주의 일 :  D
      년의 일 :  DDD
  ㄹ. 요일 :  DY,   DAY
  ㅁ. 월의 주차 :   W
      년의 주차 :   WW, IW
  ㅂ. 시간/24시간 : HH, HH24, HH12
  ㅅ. 분 : MI 
  ㅇ. 초 : SS
  ㅈ. 자정에서 지난 초 :  SSSSS
  ㅊ. 오전/오후 :  AM,   PM
  
  TS  시간 오후 3:12:33
  DS  날짜 
  DL  날짜 
  
2. 본인의 생일로부터 오늘까지 살아온 일수, 개월수, 년수를 출력하세요..
  SELECT  TO_DATE(  '1993.12.10'  )
         , SYSDATE         
         , CEIL( ABS( TO_DATE(  '1993.12.10'  ) - SYSDATE ) ) 일수
         , MONTHS_BETWEEN( SYSDATE,  TO_DATE(  '1993.12.10'  )  )  개월수
         , MONTHS_BETWEEN( SYSDATE,  TO_DATE(  '1993.12.10'  )  ) / 12  년수
  FROM dual;

   절상  CEIL
   반올림  ROUND
   절삭   FLOOR, TRUNC

3. IW와 WW 의 차이점. *****

-- 'WW' : 1일-7일을 기준으로 주차 표시
-- 'IW' : 일요일을 기점으로 주차 표시

-- WW : ~> 요일에 관계 없이 7일을 기준으로 주차를 구분
-- 01~07일 까지 1주차
-- 08~14일 까지 2주차
-- 15~21일 까지 3주차
-- 
--
--IW : ~> 요일(월화수목금토일 순)을 기준으로 주차를 구분                 ISO 표준
--일~월요일 넘어가면서 주차가 바뀐다.
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

4-1. 이번 달이 몇 일까지 있는 확인.
  SELECT  SYSDATE
     , LAST_DAY( SYSDATE )
     , TO_CHAR( LAST_DAY( SYSDATE ),  'DD'   )   -- 문자
     , EXTRACT( DAY   FROM LAST_DAY( SYSDATE ) )  -- 숫자
  FROM dual;
  
4-2. 오늘이 년중 몇 째 주, 월중 몇 째주인지 확인. 
 SELECT  SYSDATE
     , TO_CHAR( SYSDATE, 'WW' ) -- 년중 몇 째주
     , TO_CHAR( SYSDATE, 'IW' )  --    "
     , TO_CHAR( SYSDATE, 'W' )    -- 그 달의 몇 째주 
  FROM dual;

5. emp 에서  pay 를 NVL(), NVL2(), COALESCE()함수를 사용해서 출력하세요.
    SELECT 
        sal + NVL( comm, 0 ) pay
      , sal + NVL2( comm, comm, 0 ) pay
      , COALESCE( sal + comm , sal , 0 ) pay
      , sal + COALESCE( comm ,   0 ) pay
    FROM emp;

5-2. emp테이블에서 mgr이 null 인 경우 -1 로 출력하는 쿼리 작성
      ㄱ. nvl()
      ㄴ. nvl2()
      ㄷ. COALESCE()

mgr 컬럼 : 직속상사의 사원번호(empno)
mgr 이 널(null) 이라말은 직속상사 X ,  CEO  
      
      SELECT  NVL( mgr, -1)
      , NVL2( mgr, mgr , -1)
      , COALESCE( mgr , -1 )
      FROM emp
      -- WHERE mgr IS [NOT] NULL;      

6. insa 에서  이름,주민번호, 성별( 남자/여자 ), 성별( 남자/여자 ) 출력 쿼리 작성-
    ㄱ. DECODE()
    ㄴ. CASE 함수
 
        SELECT name, ssn
             , DECODE(   MOD( SUBSTR( ssn, -7, 1) , 2 ) , 1, '남자', '여자' ) gender
             , CASE  -- DECODE 함수의 확장. = + if~
                   WHEN MOD( SUBSTR( ssn, -7, 1) , 2 ) = 1 THEN '남자'
--                  WHEN 조건식 THEN
--                  WHEN THEN    
--                    :
                   ELSE '여자'                   
               END gender
             
             , CASE MOD( SUBSTR( ssn, -7, 1) , 2 )
                   WHEN  1 THEN '남자'
                   ELSE     '여자'                 
               END gender
        FROM insa; 

7. emp 에서 평균PAY 보다 같거나 큰 사원들만의 급여합을 출력.
  ( DECODE, CASE 사용해서 풀이 ) 
WITH 
   temp AS (
          SELECT  ename, sal+NVL(comm,0) pay
                , (  
                     SELECT AVG( sal+NVL(comm,0) )
                     FROM emp
                   )  avg_pay
          FROM emp
  )
  SELECT 
    --t.*
    SUM( DECODE(  SIGN( pay - avg_pay ), -1, null, t.pay ) )
    ,SUM( CASE
                 WHEN pay >= avg_pay  THEN   pay
                 -- ELSE null
          END
      )
    , SUM(CASE SIGN( pay - avg_pay )
          WHEN -1 THEN null
          ELSE         pay
       END
       )
  FROM temp t;
  
 --
 SELECT   SUM(   sal + NVL( comm, 0 ) ) tot_pay
         , COUNT( *) 
         , SUM(   sal + NVL( comm, 0 ) ) /  COUNT( *)  avg_pay
         , AVG(   sal + NVL( comm, 0 )  ) avg_pay 
 FROM emp;
-- 2260.416666666666666666666666666666666667

 SELECT  SUM(   sal + NVL( comm, 0 ) )
 FROM emp  -- 인라인뷰
 WHERE sal + NVL( comm, 0 )  >= (SELECT AVG(   sal + NVL( comm, 0 )  ) FROM emp);   -- 중첩 서브쿼리
 
 -- ORA-00934: group function is not allowed here
 --  WHERE sal + NVL( comm, 0 )  >= AVG(   sal + NVL( comm, 0 )  ); 
 WHERE sal + NVL( comm, 0 )  >= 2260.416666666666666666666666666666666667;  

   -- 11:06 수업 시작~
   -- 서브쿼리 사용하지 말고 DECODE(), CASE() 사용해서 처리.
   
   
   (문제) insa 테이블에서 남자 사원수, 여자 사원수 출력(조회)
   SELECT '총사원수' , COUNT(*)
   FROM insa 
   UNION ALL
   SELECT '남자사원수' , COUNT(*)
   FROM insa
   WHERE MOD( SUBSTR( ssn, -7, 1) , 2) = 1
   UNION ALL
   SELECT '여자사원수' ,COUNT(*)
   FROM insa
   WHERE MOD( SUBSTR( ssn, -7, 1) , 2) = 0;
   
   -- DECODE 사용 : MOD(), SUBSTR(), DECODE(), COUNT()               암기
   SELECT 
    COUNT(*) 총사원수
      ,  COUNT( DECODE(MOD( SUBSTR( ssn, -7, 1) , 2), 1, 100) ) 남자사원수
      , COUNT( DECODE(MOD( SUBSTR( ssn, -7, 1) , 2), 0, 0) ) 여자사원수
   FROM insa;
   
   -- 1) COUNT( )   NULL 포함되지 않는다. ***
   -- 2) DECODE(          A,                  B,  C )    null
        DECODE(MOD( SUBSTR( ssn, -7, 1) , 2), 1, 100)
        
    (문제)   CASE 함수 사용해서 코딩.
    SELECT
        COUNT(*) 총사원수
       ,COUNT(
         CASE  MOD( SUBSTR( ssn, -7, 1) , 2)
          WHEN  1 THEN  '남자'
          -- ELSE NULL
         END
       ) 남자사원수
       ,COUNT(
         CASE  MOD( SUBSTR( ssn, -7, 1) , 2)
          WHEN  0 THEN  '여자'
          -- ELSE NULL
         END
         ) 여자사원수
    FROM insa;
    
    (문제) emp 테이블에서 각 부서별 사원수 출력(조회)  - DECODE 함수 사용
    
    
    SELECT COUNT(*)
    FROM emp
UNION ALL
    SELECT COUNT(*)
    FROM emp
    WHERE deptno =10
UNION ALL
    SELECT COUNT(*)
    FROM emp
    WHERE deptno = 20
UNION ALL
    SELECT COUNT(*)
    FROM emp
    WHERE deptno =30
UNION ALL
    SELECT COUNT(*)
    FROM emp
    WHERE deptno =40;
    
    -- DECODE
    SELECT
        COUNT(*)  총사원수
       ,  COUNT(DECODE( deptno, 10, 'O' )) "10사원수" 
       ,  COUNT(DECODE( deptno, 20, 'O' )) "20사원수"
       ,  COUNT(DECODE( deptno, 30, 'O' )) "30사원수" 
       ,  COUNT(DECODE( deptno, 40, 'O' )) "40사원수"
       -- 각 부서별 총 급여합 출력
       ,SUM(DECODE(  deptno, 10, sal + NVL(comm, 0) ))  급여합_10
       ,SUM(DECODE(  deptno, 20, sal + NVL(comm, 0) ))  급여합_20
       ,SUM(DECODE(  deptno, 30, sal + NVL(comm, 0) ))  급여합_30
       ,NVL( SUM(DECODE(  deptno, 40, sal + NVL(comm, 0) )) , 0 )   급여합_40
    FROM emp;
    
    -- int 1kor = 100;
    
    SELECT SUM( sal + NVL(comm, 0))  tot_pay
    FROM emp
    WHERE deptno = 10;
    
   -- 각 부서별 총 급여합 출력
   SELECT
        SUM(DECODE(  deptno, 10, sal + NVL(comm, 0) ))  급여합_10
       ,SUM(DECODE(  deptno, 20, sal + NVL(comm, 0) ))  급여합_20
       ,SUM(DECODE(  deptno, 30, sal + NVL(comm, 0) ))  급여합_30
       ,NVL( SUM(DECODE(  deptno, 40, sal + NVL(comm, 0) )) , 0 )   급여합_40
   FROM emp;
      

8. emp 에서  사원이 존재하는 부서의 부서번호만 출력
SELECT deptno
FROM dept;
--
SELECT DISTINCT deptno
FROM emp;

-- 비전공자 --
SELECT deptno
FROM (
    SELECT deptno  , COUNT(*) a
    FROM emp
    GROUP BY deptno
)
WHERE a IS NOT NULL;
--
SELECT deptno 
FROM emp
GROUP BY deptno

  (문제) 사원이 존재하지 않는 부서번호만 출력.
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

10. insa테이블에서 1001, 1002 사원의 주민번호의 월/일 만 오늘 날짜로 수정하는 쿼리를 작성 
77[1212]-1022432
80[1004]-1544236
SELECT TO_CHAR(SYSDATE, 'MMDD')
FROM dual;
--
UPDATE insa
SET ssn = SUBSTR( ssn, 0, 2)  ||  TO_CHAR(SYSDATE, 'MMDD')  ||   SUBSTR( ssn, -8)
WHERE num IN ( 1001, 1002);

COMMIT;

10-2. insa테이블에서 오늘을 기준으로 아래와 같이 출력하는 쿼리 작성.  

결과)
장인철	780506-1625148	생일 후
김영년	821011-2362514	생일 전
나윤균	810810-1552147	생일 후
김종서	751010-1122233	오늘 생일
유관순	801010-2987897	오늘 생일
정한국	760909-1333333	생일 후

SELECT name, ssn
  , TO_DATE(  SUBSTR( ssn, 3, 4) , 'MMDD' ) 
  , TRUNC(  SYSDATE )
  , DECODE(  SIGN( TO_DATE(  SUBSTR( ssn, 3, 4) , 'MMDD' )  -  TRUNC(  SYSDATE ) )
               , 0 , '오늘 생일'
               , 1 , '생일 전'
               , -1, '생일 후' 
               ) a
  , CASE  SIGN( TO_DATE(  SUBSTR( ssn, 3, 4) , 'MMDD' )  -  TRUNC(  SYSDATE ) )
      WHEN 1 THEN '생일 전'
      WHEN -1 THEN '생일 후' 
      ELSE  '오늘 생일'
    END b
FROM insa;

10-3. insa테이블에서 '2022.10.05'기준으로 이 날이 생일인 사원수,지난 사원수, 안 지난 사원수를 출력하는 쿼리 작성. 

-- 1)
SELECT 
            COUNT(  DECODE( s , 1 , 1 ) ) "생일 전 사원수"
          , COUNT(  DECODE( s , -1, 1 ) ) "생일 후 사원수"
          , COUNT(  DECODE( s , 0, 1 ) ) "오늘 생일 사원수"
FROM (
            SELECT name, ssn
                , SIGN( TO_DATE(  SUBSTR( ssn, 3, 4) , 'MMDD' )  -  TRUNC(  SYSDATE ) ) s
            FROM insa
) t;

--2)
SELECT s
       , CASE   s 
              WHEN 1 THEN  '생일 전 사원수'
              WHEN 0 THEN  '오늘 생일 사원수'
              WHEN -1 THEN '생일 후 사원수'
           END "사원수"
       , COUNT(*) 
FROM (
            SELECT name, ssn
                , SIGN( TO_DATE(  SUBSTR( ssn, 3, 4) , 'MMDD' )  -  TRUNC(  SYSDATE ) ) s
            FROM insa
) t
GROUP BY  s ; -- 1 , 0 , -1

11.  emp 테이블에서 10번 부서원들은  급여 15% 인상
                20번 부서원들은 급여 10% 인상
                30번 부서원들은 급여 5% 인상
                40번 부서원들은 급여 20% 인상
  하는 쿼리 작성.
 -- ORA-00972: identifier is too long
  SELECT deptno, ename, sal + NVL(comm, 0) pay
         ,   DECODE( deptno, 10 , 15 , 20, 10, 30, 5, 40, 20)  || '%'  "인상률"
         ,   (sal + NVL(comm, 0)) * DECODE( deptno, 10 , 15 , 20, 10, 30, 5, 40, 20) /100  "인상액"
 --        ,   (sal + NVL(comm, 0)) + (sal + NVL(comm, 0)) * DECODE( deptno, 10 , 15 , 20, 10, 30, 5, 40, 20) /100  "인상된 Pay"
 --        ,   (sal + NVL(comm, 0))*(1 +  DECODE(deptno, 10, 15, 20, 10, 30, 5, 40, 20) / 100)  "인상된 Pay"         
         ,   (sal + NVL(comm, 0)) *DECODE( deptno, 10 , 1.15 , 20, 1.10, 30, 1.05, 40, 1.20)  "인상된 Pay"   
  FROM emp
  ORDER BY deptno ASC;  
          
12. emp 테이블에서 각 부서의 사원수를 조회하는 쿼리
결과)

SELECT COUNT(*)
   , COUNT(  DECODE(deptno, 10, 1) )  부서10
   , COUNT(  DECODE(deptno, 20, 1) )  부서20
   , COUNT(  DECODE(deptno, 30, 1) )  부서30
   , COUNT(  DECODE(deptno, 40, 1) )  부서40
FROM emp;
--
-- 1) 총사원수 , 2) 사원이 존재하지 않는 부서 정보 X ( 40 0 ) 출력. -  전공자들..

-- ORA-00904: "DEPTNO": invalid identifier
--       컬럼갯수, 자료형 동일( 주의사항 )
--       첫 번째 SELECT 0 deptno 컬럼명 또는 별칭,  COUNT(*)
SELECT 0 deptno,  COUNT(*)
FROM emp
UNION ALL
SELECT deptno, COUNT(*) 
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

-- 답 : OUTER JOIN ( 면접 실기 )
  3:25 SELECT 문제 
--  TOP N 방식 == 상위 N
  4:10 수업 시작~ ( 답 )
SELECT 0  deptno,  COUNT(*)
FROM emp
UNION ALL
SELECT  deptno, COUNT(*) 
FROM emp  
GROUP BY deptno
ORDER BY deptno ASC;        
-- 40  0 X
--INNER JOIN , OUTER JOIN
--  ORA-00918: column ambiguously defined
--             컬럼이    애매모호하게 선언되었다.
-- ( 조인 할 때 공통적인 컬럼명은   별칭.컬럼명 )
-- ( 암기 )
SELECT  d.deptno, COUNT(   e.deptno    ) 
FROM emp e ,   dept  d  -- RIGHT OUTER JOIN
-- FROM [ dept d ], emp e  LEFT [OUTER] JOIN
WHERE  e.deptno(+) = d.deptno -- 조인조건
GROUP BY d.deptno 
ORDER BY d.deptno ASC;   

-- [ JOIN ] 시험
-- 부서명,사원명, 잡, 입사일자 조회(출력)
--  dept : dname
--  emp  : ename, job, hiredate
-- RDBMS    dept    소속관계          emp
--         PK:deptno      참조        FK:deptno
--  부모의 PK  와 자식의 FK  조인조건이된다. 
SELECT deptno, ename, job,hiredate
FROM emp;
 +
SELECT deptno, dname, loc
FROM dept;

--
--SELECT d.dname, e.ename, e.job, e.hiredate
-- 조인 첫 번째 방법
SELECT dname, ename, job, hiredate
FROM emp  e , dept  d
WHERE  d.deptno   = e.deptno;  -- 조인 조건
-- 조인 두 번째 방법 (  JOIN  ~  ON  구문 )
SELECT dname, ename, job, hiredate
FROM emp  e JOIN dept  d    ON  d.deptno   = e.deptno; 

--
SELECT dname
FROM dept
WHERE deptno = emp.deptno
 

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

1	700	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
-- (내일 시험)
SELECT ename, sal
    , CASE 
          WHEN sal >= 700 AND sal <= 1200 THEN 1
          WHEN sal BETWEEN 1201 AND 1400 THEN 2
          WHEN sal BETWEEN 1401 AND 2000 THEN 3
          WHEN sal BETWEEN 2001 AND 3000 THEN 4
          WHEN sal BETWEEN 3001 AND 9999 THEN 5
      END GRADE
FROM emp; 
-- (내일 시험) JOIN

-- 조인 첫 번째 방법
SELECT ename, sal, losal || ' ~ ' || hisal, grade
FROM emp , salgrade
WHERE  sal BETWEEN losal AND hisal;  -- 조인 조건

-- 조인 두 번째 방법
SELECT ename, sal, losal || ' ~ ' || hisal, grade
FROM emp JOIN salgrade ON sal BETWEEN losal AND hisal;  -- 조인 조건


14. emp 테이블에서 급여를 가장 많이 받는 사원의 empno, ename, pay 를 출력.
SELECT empno, ename, sal
FROM emp
WHERE sal >= ALL ( SELECT sal  FROM emp );
WHERE sal = ( SELECT MAX(sal)  FROM emp );

14-2. emp 테이블에서 각 부서별 급여를 가장 많이 받는 사원의 pay를 출력
 1) UNION ALL
 2) GROUP BY
SELECT  deptno, MAX(sal + NVL(comm, 0 )) max_pay
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
  3) 상관 서브쿼리
  -- 596행, 3열에서 오류 발생   ORA-00907: missing right parenthesis
  SELECT deptno, ename, sal + NVL( comm,0 )
  FROM emp  a
  WHERE sal + NVL( comm,0 ) = ( 
                                SELECT MAX( sal + NVL( comm,0 ) )  
                                FROM emp b  
                                WHERE b.deptno = a.deptno    
                              ) ;
 
 
  SELECT MAX( sal + NVL( comm,0 ) )   FROM emp  WHERE deptno = 10;












   












