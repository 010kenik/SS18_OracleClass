--  SYS --

 -- FIRST / LAST 함수
SELECT MIN(sal) KEEP ( DENSE_RANK FIRST ORDER BY sal DESC )  "min_pay"
    , MAX(sal) KEEP ( DENSE_RANK LAST ORDER BY sal )  "max_pay"
    , SUM(sal) KEEP ( DENSE_RANK FIRST ORDER BY sal )  "min_pay"
    , AVG(sal) KEEP ( DENSE_RANK LAST ORDER BY sal )  "max_pay"
FROM emp;

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
PARTITION BY (b.buseo) on a.jikwi = b.jikwi                                
order by buseo, jikwi;

--참고사이트 :   
--https://blog.naver.com/pino93/222708884741
--https://blog.naver.com/blacksmail/222349045230
--https://jungmina.com/858

ORACLE 10g  PARTITION OUTER JOIN 구문 ㅠㅠ