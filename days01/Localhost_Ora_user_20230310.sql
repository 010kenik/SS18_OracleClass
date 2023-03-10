select * 
from tabs;
-- p 118
SELECT department_id, department_name
FROM departments  a
WHERE EXISTS ( 
                SELECT  *
                FROM employees b
                WHERE a.department_id = b.department_id AND b.salary > 3000
            );
-- p 135  TRANSLATE()
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를')
      , TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를')
FROM dual;

-- p 145 LNNVL()
SELECT  --employee_id, commission_pct
          COUNT(*)
FROM employees
WHERE NVL( commission_pct, 0)  < 0.2 ;
WHERE LNNVL( commission_pct >= 0.2 );

-- p 147 
SELECT GREATEST(3,5,2,4,1)
      ,  LEAST(3,5,2,4,1)
FROM dual;

-- p 155
-- 분산 = (평균-값)제곱의 평균 
-- 표준편차 = 분산값의 제곱근
SELECT VARIANCE( salary), STDDEV(salary)
FROM employees;

-- p 159
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, gubun
ORDER BY period;
--
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY  ROLLUP(period, gubun ); 
--
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period,  ROLLUP( gubun ); 
--
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY gubun, ROLLUP(period)  ; 
GROUP BY ROLLUP(period),   gubun ; 
-- CUBE
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY CUBE(period, gubun)  ; 
-- CUBE
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, CUBE( gubun)  ; 

-- p 171 GROUPING SETS 절
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY GROUPING SETS( period, gubun );
--201310		1087493.9
--201311		1095358.2
--	기타대출	1357199.3
--	주택담보대출	825652.8

-- p 172 GROUPING SETS 절
SELECT period, gubun,region, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
      AND region IN('서울','경기')
GROUP BY GROUPING SETS( period, (gubun, region) );

-- p 211 계층형 쿼리
SELECT department_id, LPAD(' ', 3 * ( LEVEL-1 )) || department_name, LEVEL
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id = parent_id;

-- p 216 계층형 쿼리
SELECT department_id, LPAD(' ', 3 * ( LEVEL-1 )) || department_name, LEVEL
 , CONNECT_BY_ROOT department_name AS root_name
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id = parent_id;


-- p 223 
SELECT department_id
       , emp_name
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id;
-- p 223 
SELECT department_id
       , LISTAGG( emp_name, ',') WITHIN GROUP ( ORDER BY emp_name ) as empnames
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

-- p 237
SELECT deptno, empno, sal
 , NTILE(4) OVER( PARTITION BY deptno ORDER BY sal  ) NTILES
FROM emp;

-- p 244
SELECT department_id, emp_name, salary
       ,  NTILE(4) OVER( PARTITION BY department_id ORDER BY salary  ) NTILES
       , WIDTH_BUCKET( salary, 1000, 10000, 4) widthbucket
FROM employees
WHERE department_id = 60;





