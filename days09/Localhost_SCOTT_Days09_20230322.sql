-- SCOTT -- 
-- 결석 : 홍성철( 예비군 훈련 )
-- 미출석 : 진예림, 홍성철
-- [1] 저장 안해서 다 날림 ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ
1. emp , salgrade 테이블을 사용해서 아래와 같이 출력. [JOIN] 사용

    ename   sal    grade
    ---------------------
    SMITH	800	    1
    ALLEN	1900	3
    WARD	1750	3
    JONES	2975	4
    MARTIN	2650	4
    BLAKE	2850	4
    CLARK	2450	4
    KING	5000	5
    TURNER	1500	3
    JAMES	950	1
    FORD	3000	4
    MILLER	1300	2

   - JOIN(조인) == 결합
   - 정의 : 같거나 다른 2개 이상의 테이블 결합 -> 컬럼 조회(검색)
     사원테이블( deptno 컬럼 참조( FK )) 
     부서테이블( deptno 컬럼 (PK ) )
     
     부서T    ---관계--      사원T
     부모T                  자식T
     
     emp      :  ename, sal
     salgrade : grade
    
    - 조인 종류 : 8가지
      ㄴ EQUI JION      - 조인조건  부PK - 자FK 
      ㄴ [NON EQUI JION  - 조인조건       X ]  BETWEEN  AND
     -- 1)
     SELECT e.ename, e.sal, s.losal || ' ~ ' || s.hisal  , s.grade
     FROM emp e, salgrade s
     WHERE e.sal BETWEEN s.losal AND s.hisal;
     
     -- 2) JOIN  ~ ON 구문을 사용해서 수정
     SELECT ename, sal, losal || ' ~ ' || hisal  , grade
     FROM emp JOIN salgrade ON  sal BETWEEN  losal AND  hisal;
     
     --3) CASE 함수 사용.
     SELECT ename, sal
        , CASE
             WHEN sal BETWEEN 700 AND 1200 THEN 1
             :
             :
             :
             :             
          END grade
     FROM emp;

[문제] deptno, dname, ename, hiredate, sal , grade 컬럼 조회  ( JOIN ) 
  
  dept : [deptno(PK)], dname
  emp  : [deptno(FK)], ename, hiredate, sal
  salgrade : grade
  
  --
  SELECT d.deptno, dname, ename, hiredate, sal, grade
  FROM dept d, emp e , salgrade s
  WHERE d.deptno = e.deptno AND e.sal BETWEEN s.losal AND s.hisal;
  
  -- JOIN ~ ON 구문 수정
  SELECT d.deptno, dname, ename, hiredate, sal, grade
  FROM dept d JOIN  emp e      ON  d.deptno = e.deptno
              JOIN salgrade s  ON  e.sal BETWEEN s.losal AND s.hisal;
    
1-2. 위의 결과에서 등급(grade)가 1등급인 사원만 조회하는 쿼리 작성  
  X ( 조건 :  TOP-N 방식 사용 )

결과)
     EMPNO ENAME             SAL      GRADE
---------- ---------- ---------- ----------
      7369 SMITH             800          1
      7900 JAMES             950          1   
      
    emp :  empno , ename, sal
    salgrade : grade
    
    SELECT empno,  ename, sal, grade
    FROM emp  JOIN salgrade   ON  sal BETWEEN losal AND hisal
    WHERE grade = 1;
      
      
2. emp 에서 최고급여를 받는 사원의 정보 출력 ( JOIN ~ ON 구문 )
  ( 조건 : 아래 컬럼 출력 )
    DNAME          ENAME             PAY
    -------------- ---------- ----------
    ACCOUNTING     KING             5000
    
    dept : dname
    emp : ename ,   sal + NVL(comm,0) pay
    
    join 조건 : EQUI JION   dept.deptno(PK) = emp.deptno (FK) 
               INNER JION
    
    10:01 수업 시작~~ 
    -- 1) 
    SELECT dname, ename, sal + NVL(comm, 0) pay
    FROM dept d , emp e 
    WHERE d.deptno = e.deptno;
    -- max_pay  5000
    SELECT MAX(  sal + NVL(comm, 0 ) )  max_pay
    FROM emp;
    -- 왜 ? 부서 X KING 5000  행(레코드) 조인결과물 X
    --      
    SELECT dname, ename, sal + NVL(comm, 0) pay
    FROM dept d , emp e   -- RIGHT OUTER JOIN
    WHERE d.deptno(+) = e.deptno  -- JOIN 조건 , EQUI JOIN(내부조인) X , OUTER JOIN(외부조인)
         AND sal + NVL(comm, 0 ) = (
                             SELECT MAX(  sal + NVL(comm, 0 ) )  max_pay
                             FROM emp
                         ); 

    --    JOIN ON 구문 수정   
    SELECT dname, ename, sal + NVL(comm, 0) pay
    FROM dept d RIGHT OUTER JOIN  emp e  ON d.deptno = e.deptno
    WHERE sal + NVL(comm, 0 ) = (
                             SELECT MAX(  sal + NVL(comm, 0 ) )  max_pay
                             FROM emp
                         ); 
  [문제] RANK()
  [문제] DENSE_RANK()
  [문제] ROW_NUMBER()
  
  WITH 
    temp AS (
          SELECT dname, ename, sal + NVL(comm, 0) pay
             , RANK() OVER( ORDER BY sal + NVL(comm, 0) DESC ) "R"
             , DENSE_RANK() OVER( ORDER BY sal + NVL(comm, 0) DESC ) "D_R"
             , ROW_NUMBER() OVER( ORDER BY sal + NVL(comm, 0) DESC ) "R_N"
          FROM dept d RIGHT OUTER JOIN  emp e  ON d.deptno = e.deptno
   )
   SELECT t.*
   FROM temp t
   WHERE t.R BETWEEN 3 AND 5;
   WHERE t.R <= 3;
   WHERE t.R = 1;
  
  
  
  [문제] TOP-N 방식
        ROWNUM 의사컬럼 순번
        1) FROM  인라인뷰   급여순 정렬
        WHERE 1
      
      SELECT t.*, ROWNUM 순번
      FROM (   
              SELECT dname, ename, sal + NVL(comm, 0) pay
              FROM dept d RIGHT OUTER JOIN  emp e  ON d.deptno = e.deptno 
              ORDER BY pay DESC
           ) t
      WHERE  ROWNUM <= 3;   -- TOP-3       
      WHERE  ROWNUM = 1;    -- TOP-10     
        
              

2-2. emp 에서 [각 부서별] 최고급여를 받는 사원의 정보 출력 ( JOIN )

    DEPTNO DNAME          ENAME             PAY
---------- -------------- ---------- ----------
        10 ACCOUNTING     KING             5000
        20 RESEARCH       FORD             3000
        30 SALES          BLAKE            2850
   
   dept : [deptno], dname
   emp  : [deptno], ename, sal+NVL(comm,0) pay
   
    1) 상관 서브 쿼리     
    SELECT d.deptno, dname, ename, sal + NVL(comm, 0) pay
    FROM dept d FULL JOIN emp e ON d.deptno = e.deptno
    WHERE sal + NVL(comm, 0)  = (
        SELECT MAX( sal + NVL(comm, 0)  )
        FROM emp
        WHERE deptno = d.deptno
    );
    11:05 수업 시작~ 
    2) 
        
        
3. emp 에서 각 사원의 급여가 전체급여의 몇 %가 되는 지 조회.
       ( %   소수점 3자리에서 반올림하세요 )
            무조건 소수점 2자리까지는 출력.. 7.00%,  3.50%     

ENAME             PAY   TOTALPAY 비율     
---------- ---------- ---------- -------
SMITH             800      27125   2.95%
ALLEN            1900      27125   7.00%
WARD             1750      27125   6.45%
JONES            2975      27125  10.97%
MARTIN           2650      27125   9.77%
BLAKE            2850      27125  10.51%
CLARK            2450      27125   9.03%
KING             5000      27125  18.43%
TURNER           1500      27125   5.53%
JAMES             950      27125   3.50%
FORD             3000      27125  11.06%
MILLER           1300      27125   4.79%

12개 행이 선택되었습니다.         
        
4. emp 에서 가장 빨리 입사한 사원 과 가장 늦게(최근) 입사한 사원의 차이 일수 ?         
        
5. insa 에서 사원들의 만나이 계산해서 출력
  ( 만나이 = 올해년도 - 출생년도          - 1( 생일이지나지 않으면) )
  
6. insa 테이블에서 아래와 같이 결과가 나오게 ..
     [총사원수]      [남자사원수]      [여자사원수] [남사원들의 총급여합]  [여사원들의 총급여합] [남자-max(급여)] [여자-max(급여)]
---------- ---------- ---------- ---------- ---------- ---------- ----------
        60                31              29           51961200                41430400                  2650000          2550000
      
7. TOP-N 방식으로 풀기 ( ROWNUM 의사 컬럼 사용 )
   emp 에서 최고급여를 받는 사원의 정보 출력  
  
    DEPTNO ENAME             PAY   PAY_RANK
---------- ---------- ---------- ----------
        10 KING             5000          1
        
        
8.순위(RANK) 함수 사용해서 풀기 
   emp 에서 각 부서별 최고급여를 받는 사원의 정보 출력
   
    DEPTNO ENAME             PAY DEPTNO_RANK
---------- ---------- ---------- -----------
        10 KING             5000           1
        20 FORD             3000           1
        30 BLAKE            2850           1
   
9. emp테이블에서 각 부서의 사원수, 부서총급여합, 부서평균을 아래와 같이 출력하는 쿼리 작성.
결과)
    DEPTNO       부서원수       총급여합    	     평균
---------- ---------- 		---------- 	----------
        10          3      	 8750    	2916.67
        20          3     	  6775    	2258.33
        30          6     	 11600    	1933.33      
         
10-1.  emp 테이블에서 30번인 부서의 최고, 최저 SAL을 출력하는 쿼리 작성.
결과)
  MIN(SAL)   MAX(SAL)
---------- ----------
       950       2850

10-2.  emp 테이블에서 30번인 부서의 최고, 최저 SAL를 받는 사원의 정보 출력하는 쿼리 작성.

결과)
     EMPNO ENAME      HIREDATE        SAL
---------- ---------- -------- ----------
      7698 BLAKE      81/05/01       2850
      7900 JAMES      81/12/03        950      
      
11.  insa 테이블에서 
[실행결과]
부서명     총사원수 부서사원수 성별  성별사원수  부/전%   부성/전%   성/부%
개발부	    60	    14	      F	    8	    23.3%	  13.3%	    57.1%
개발부	    60	    14	      M	    6	    23.3%	  10%	    42.9%
기획부	    60	    7	      F	    3	    11.7%	5%	4       2.9%
기획부	    60	    7	      M	    4	    11.7%	6.7%	    57.1%
영업부	    60	    16	      F	    8	    26.7%	13.3%	    50%
영업부	    60	    16	      M	    8	    26.7%	13.3%	    50%
인사부	    60	    4	      M	    4	    6.7%	6.7%	    100%
자재부	    60	    6	      F	    4	    10%	    6.7%	    66.7%
자재부	    60	    6	      M	    2	    10%	    3.3%	    33.3%
총무부	    60	    7	      F	    3	    11.7%	5%	        42.9%
총무부	    60	    7	      M 	4	    11.7%	6.7%	    57.1%
홍보부	    60	    6	      F	    3	    10%	    5%	        50%
홍보부	    60	    6	      M	    3	    10%	    5%	        50%             


12. insa테이블에서 여자인원수가 5명 이상인 부서만 출력.  

13. insa 테이블에서 급여(pay= basicpay+sudang)가 상위 15%에 해당되는 사원들 정보 출력 

14. emp 테이블에서 sal의 전체사원에서의 등수 , 부서내에서의 등수를 출력하는 쿼리 작성
        
--         
        
    --    ORA-00979: not a GROUP BY expression ( 기억 ) *****
    select d.deptno, d.dname , count(*)
    from emp e join dept d on e.deptno = d.deptno
    where d.deptno not in (20,40)
    group by d.deptno, d.dname
    having count(*) >=3;      
        
    -- 
    SELECT buseo , jikwi, COUNT(*)
    FROM insa
    GROUP BY buseo , jikwi
    ORDER BY buseo , jikwi;
    --
    SELECT DISTINCT jikwi
    FROM insa;
과장
대리
부장
사원  
SELECT b.buseo, a.jikwi, nvl(b.cnt,0)
FROM (SELECT DISTINCT jikwi from INSA) a left join (SELECT buseo, jikwi, COUNT(jikwi) cnt 
                                                    FROM insa
                                                    GROUP BY buseo, jikwi) b 
PARTITION BY (b.buseo) on a.jikwi = b.jikwi                                
order by buseo, jikwi;

--참고사이트 :   
--https://blog.naver.com/pino93/222708884741
--https://blog.naver.com/blacksmail/222349045230
--https://jungmina.com/858
        
        
        
        
        
        
        
        
        
        
        
      