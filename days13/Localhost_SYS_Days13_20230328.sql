--  SYS --








 -- FIRST / LAST 함수
SELECT MIN(sal) KEEP ( DENSE_RANK FIRST ORDER BY sal DESC )  "min_pay"
    , MAX(sal) KEEP ( DENSE_RANK LAST ORDER BY sal )  "max_pay"
    , SUM(sal) KEEP ( DENSE_RANK FIRST ORDER BY sal )  "min_pay"
    , AVG(sal) KEEP ( DENSE_RANK LAST ORDER BY sal )  "max_pay"
FROM emp;
--------------------------------------------------------------------------------------------------------------------------------
-- 조민경 --
SELECT d.deptno
    , COUNT(e.deptno) 부서원수
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno 
GROUP BY d.deptno
ORDER BY d.deptno ASC;
--
SELECT b.buseo, a.jikwi, nvl(b.cnt,0)
FROM (SELECT DISTINCT jikwi from INSA) a left join (SELECT buseo, jikwi, COUNT(jikwi) cnt 
                                                    FROM insa
                                                    GROUP BY buseo, jikwi) b 
PARTITION BY (b.buseo) 
on a.jikwi = b.jikwi                                
order by buseo, jikwi;

--참고사이트 :   
--https://blog.naver.com/pino93/222708884741
--https://blog.naver.com/blacksmail/222349045230
--https://jungmina.com/858

ORACLE 10g  PARTITION OUTER JOIN 구문 ㅠㅠ
--------------------------------------------------------------------------------------------------------------------------------
[ 문제 ]
SELECT year, m.month,  NVL( COUNT( empno ), 0) n
FROM 
   ( SELECT  empno, TO_CHAR(hiredate,'YYYY') year, TO_NUMBER(TO_CHAR(hiredate,'MM')) month  FROM emp ) e 
PARTITION BY ( e.year  )   
RIGHT JOIN 
   (SELECT LEVEL month FROM dual CONNECT BY LEVEL <= 12) m    
ON e.month = m.month
GROUP BY year, m.month
ORDER BY year, m.month;
--
SELECT LEVEL  FROM dual CONNECT BY LEVEL <= 12;

YEAR      MONTH          N
---- ---------- ----------
1980          1          0
1980          2          0
1980          3          0
1980          4          0
1980          5          0
1980          6          0
1980          7          0
1980          8          0
1980          9          0
1980         10          0
1980         11          0

YEAR      MONTH          N
---- ---------- ----------
1980         12          1
1981          1          0
1981          2          2
1981          3          0
1981          4          1
1981          5          1
1981          6          1
1981          7          0
1981          8          0
1981          9          2
1981         10          0

YEAR      MONTH          N
---- ---------- ----------
1981         11          1
1981         12          2
1982          1          1
1982          2          0
1982          3          0
1982          4          0
1982          5          0
1982          6          0
1982          7          0
1982          8          0
1982          9          0

YEAR      MONTH          N
---- ---------- ----------
1982         10          0
1982         11          0
1982         12          0

36개 행이 선택되었습니다. 
--------------------------------------------------------------------------------------------------------------------------------
[문제]
SELECT FLOOR(DBMS_RANDOM.VALUE(1,46))
FROM dual
CONNECT BY LEVEL <=6;

[문제]
SELECT deptno
     , LISTAGG( ename , '/') WITHIN GROUP ( ORDER BY ename )  as enames    
FROM emp
GROUP BY deptno;
10	CLARK/MILLER
20	FORD/JONES/SMITH
30	ALLEN/BLAKE/JAMES/MARTIN/TURNER/WARD
	KING
--------------------------------------------------------------------------------------------------------------------------------
[문제] insa에서 부서별, 직위별, 사원수 
SELECT buseo, jikwi, COUNT( num ) tot_count
FROM insa
GROUP BY buseo, jikwi
ORDER BY buseo, jikwi;
-- 부서별 직위별 최소사원수, 최대사원수 파악
WITH 
  t1 AS (
     SELECT buseo, jikwi, COUNT( num ) tot_count
     FROM insa
     GROUP BY buseo, jikwi
  ),
  t2 AS (
     SELECT buseo, MIN( tot_count ) buse_min_count,  MAX( tot_count ) buse_max_count
     FROM t1
     GROUP BY buseo 
  )
SELECT a.buseo
 , b.jikwi 최소부서, b.tot_count 최소사원수
 , c.jikwi 최대부서, c.tot_count 최대사원수
FROM t2 a, t1 b, t1 c
WHERE a.buseo = b.buseo AND a.buse_min_count = b.tot_count
    AND a.buseo = c.buseo AND a.buse_max_count = c.tot_count
ORDER BY 1, 2   ; 
개발부	부장	1	사원	9
기획부	부장	2	대리	3
기획부	사원	2	대리	3
영업부	과장	1	사원	8
인사부	과장	1	사원	2
인사부	대리	1	사원	2
자재부	과장	1	사원	4
자재부	부장	1	사원	4
총무부	부장	1	사원	4
홍보부	과장	1	사원	3
-- FIRST / LAST 분석함수
WITH 
  temp AS (
     SELECT buseo, jikwi, COUNT( num ) tot_count
     FROM insa
     GROUP BY buseo, jikwi
  )
SELECT t.buseo
   ,MIN(t.jikwi) KEEP ( DENSE_RANK FIRST ORDER BY t.tot_count ) 최소부서 
   , MIN(t.tot_count) 최소사원수
   ,MAX(t.jikwi) KEEP ( DENSE_RANK LAST ORDER BY t.tot_count ) 최대부서
   , MAX(t.tot_count) 최대사원수
FROM temp t
GROUP BY t.buseo
ORDER BY 1, 2;
개발부	부장	1	사원	9
기획부	부장	2	대리	3
영업부	과장	1	사원	8
인사부	과장	1	사원	2
자재부	과장	1	사원	4
총무부	부장	1	사원	4
홍보부	과장	1	사원	3
--------------------------------------------------------------------------------------------------------------------------------



-- 1
SELECT  mgr, empno,  ename, LEVEL
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;
-- 2  TOP-DOWN
SELECT  mgr, empno, LPAD( ' ', (LEVEL-1)*3) ||  ename, LEVEL
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;
-- 3 
SELECT deptno, mgr, empno 
     , LPAD( ' ', (LEVEL-1)*3) ||  ename, LEVEL
FROM emp e
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr
      AND deptno = 30;
-- 4 
SELECT deptno, mgr, empno 
     , LPAD( ' ', (LEVEL-1)*3) ||  ename, LEVEL
FROM emp e
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr
ORDER SIBLINGS BY deptno;

-- 5 
SELECT deptno, mgr, empno 
     , LPAD( ' ', (LEVEL-1)*3) ||  ename, LEVEL
     , CONNECT_BY_ROOT ename -- 최상위 루트 로우를 반환하는 연산자
FROM emp e
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr
ORDER SIBLINGS BY deptno;

-- 6 
SELECT deptno, mgr, empno 
     , LPAD( ' ', (LEVEL-1)*3) ||  ename, LEVEL
     , CONNECT_BY_ROOT ename CEO -- 최상위 루트 로우를 반환하는 연산자
     , CONNECT_BY_ISLEAF LEAF-- 해당 로우가 최하위 로우면 1 , 0 
     , SYS_CONNECT_BY_PATH(ename, '/') -- 루트노드에서 시작해서 자신의 행까지 연결된 경로 정보 반환
FROM emp e
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr
ORDER SIBLINGS BY deptno;

-- 7 
SELECT deptno, mgr, empno 
     , LPAD( ' ', (LEVEL-1)*3) ||  ename, LEVEL
     , CONNECT_BY_ISCYCLE IsLoop  -- 현재 로우가 자식을 갖고 있는데  동시에 그 자식 로우가 부모로우이면 1, 그렇지 않으면 0
FROM emp e
START WITH mgr IS NULL
CONNECT BY NOCYCLE  PRIOR empno = mgr;

-- 8
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 31;
