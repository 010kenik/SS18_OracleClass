-- SCOTT --
-- 미출석 : 김수민, 이태규
--------------------------------------------------------------------------------
-- 복습문제 
--------------------------------------------------------------------------------

  [실행결과]
       CLERK   SALESMAN  PRESIDENT    MANAGER    ANALYST
---------- ---------- ---------- ---------- ----------
         3          4          1          3          1

--1) GROUP BY job       + COUNT(*) 사용
        SELECT job, COUNT(*) "사원수"
        FROM emp
        GROUP BY job;

--2) 가로 출력
        SELECT
            COUNT (DECODE( job, 'CLERK', 1) ) CLERK
            ,COUNT (DECODE( job, 'SALESMAN', 1) ) SALESMAN
            ,COUNT (DECODE( job, 'PRESIDENT', 1) ) PRESIDENT
            ,COUNT (DECODE( job, 'MANAGER', 1) ) MANAGER
            ,COUNT (DECODE( job, 'ANALYST', 1) ) ANALYST
        FROM emp;


--[피봇 (PIVOT) / 언피봇(UNPIVOT) 함수]
    1. 오라클 11g부터 제공하는 함수
    2. 행과 열을 뒤집는 함수
    3. [형식]
        SELECT * 
        FROM (피벗 대상 쿼리문) -- 1. 서버쿼리(세로를 가로로 만들기)
        PIVOT (그룹함수(집계컬럼) FOR 피벗컬럼(대상) IN(피벗컬럼 값 AS 별칭...))
    4.  순서는
        1)피벗 대상 쿼리문
        2) IN(목록)
        3) FOR 피벗컬럼
        4) 그룹함수(집게컬럼)

        1) SELECT job FROM emp;
        2) IN(목록)
        3) FOR 피벗컬럼
        4) 그룹함수(집게컬럼)

    예)
        SELECT *
        FROM (
                SELECT job 
                FROM emp
              ) 
        PIVOT (COUNT(job) FOR job IN('CLERK', 'SALESMAN', 'PRESIDENT', 'MANAGER', 'ANALYST' ))









2. emp 테이블에서  [JOB별로] 각 월별 입사한 사원의 수를 조회 



  ㄱ. COUNT(), DECODE() 사용
  
  

  
  

JOB         COUNT(*)         1월         2월         3월         4월         5월         6월         7월         8월         9월        10월        11월        12월
--------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
CLERK              3          1          0          0          0          0          0          0          0          0          0          0          2
SALESMAN           4          0          2          0          0          0          0          0          0          2          0          0          0
PRESIDENT          1          0          0          0          0          0          0          0          0          0          0          1          0
MANAGER            3          0          0          0          1          1          1          0          0          0          0          0          0
ANALYST            1          0          0          0          0          0          0          0          0          0          0          0          1

SELECT job, COUNT(*)
    , COUNT(decode( to_char(hiredate, 'MM'), '01', 'O')) "01월"
    , count(decode( to_char(hiredate, 'mm'), '02', 'O')) "02월"
    , count(decode( to_char(hiredate, 'mm'), '03', 'O')) "03월"
    , count(decode( to_char(hiredate, 'mm'), '04', 'O')) "04월"
    , count(decode( to_char(hiredate, 'mm'), '05', 'O')) "01월"
    , count(decode( to_char(hiredate, 'mm'), '06', 'O')) "01월"
    , count(decode( to_char(hiredate, 'mm'), '07', 'O')) "01월"
    , count(decode( to_char(hiredate, 'mm'), '08', 'O')) "01월"
    , count(decode( to_char(hiredate, 'mm'), '09', 'O')) "01월"
    , count(decode( to_char(hiredate, 'mm'), '10', 'O')) "01월"
    , count(decode( to_char(hiredate, 'mm'), '11', 'O')) "01월"
    , count(decode( to_char(hiredate, 'mm'), '12', 'O')) "12월"
FROM emp
GROUP BY JOB;


SELECT job, EXTRACT( MONTH FROM hiredate) 월 , COUNT(*) 인원수
FROM emp
GROUP BY job, EXTRACT( MONTH FROM hiredate)
ORDER BY job, 월



  ㄴ. GROUP BY 절 사용

         월        인원수
---------- ----------
         1          1
         2          2
         4          1
         5          1
         6          1
         9          2
        11          1
        12          3

8개 행이 선택되었습니다. 

--1)
SELECT TO_NUMBER(TO_CHAR( hiredate, 'MM' ) )월, COUNT(*) 인원수
FROM emp
GROUP BY TO_NUMBER(TO_CHAR(hiredate, 'MM' ) )
ORDER BY TO_NUMBER(TO_CHAR(hiredate, 'MM' ) );

--2) EXTRACT
SELECT EXTRACT( MONTH FROM hiredate)월, COUNT(*) 인원수
FROM emp
GROUP BY EXTRACT( MONTH FROM hiredate)
ORDER BY 월;


 [문제]   피봇함수를 사용해서 아래와 같이 출력.
 JOB               1월          2          3          4          5          6          7          8          9         10         11         12
--------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
CLERK              1          0          0          0          0          0          0          0          0          0          0          2
SALESMAN           0          2          0          0          0          0          0          0          2          0          0          0
PRESIDENT          0          0          0          0          0          0          0          0          0          0          1          0
MANAGER            0          0          0          1          1          1          0          0          0          0          0          0
ANALYST            0          0          0          0          0          0          0          0          0          0  
    1) 피봇 대상 쿼리
      SELECT EXTRACT( MONTH FROM hiredate )  hire_month 
      FROM emp;
    2) IN ( 목록 )
       1,2,3,4,5,6,7,8,9, 10, 11, 12
    3) FOR 피봇 컬럼
          hire_month
    4) 집계함수(컬럼 ))
       COUNT( hire_month )
        -- 전체 사원들이 입사한 월별 사원수 파악
        SELECT *
        FROM (
                SELECT EXTRACT( MONTH FROM hiredate )  hire_month 
                FROM emp
              ) 
        PIVOT (COUNT(hire_month ) FOR hire_month  IN(1,2,3,4,5,6,7,8,9, 10, 11, 12 ));
        
        -- 전체 사원들이 입사한 월별 사원수 파악
        SELECT *
        FROM (
                SELECT  job,  EXTRACT( MONTH FROM hiredate )  hire_month 
                FROM emp
              ) 
        PIVOT (COUNT(hire_month ) FOR hire_month  IN(1 AS "1월",2,3,4,5,6,7,8,9, 10, 11, 12 ));
    
    -- [ UNPIVOT() 정리 ]

3. emp 테이블에서 각 부서별 급여 많이 받는 사원 2명씩 출력
  실행결과)
       SEQ      EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- ---------- --------- ---------- -------- ---------- ---------- ----------
         1       7839 KING       PRESIDENT            81/11/17       5000                    10
         2       7782 CLARK      MANAGER         7839 81/06/09       2450                    10
         1       7902 FORD       ANALYST         7566 81/12/03       3000                    20
         2       7566 JONES      MANAGER         7839 81/04/02       2975                    20
         1       7698 BLAKE      MANAGER         7839 81/05/01       2850                    30
         2       7654 MARTIN     SALESMAN        7698 81/09/28       1250       1400         30
   -- 1) TOP-N 방식
   -- 2) RANK 함수 
   SELECT t.*
   FROM (
       SELECT empno, ename, job, mgr, hiredate, sal , comm, deptno
           , RANK() OVER(  PARTITION BY deptno ORDER BY  sal + NVL(comm, 0)  ) SEQ
       FROM emp
   ) t
   WHERE seq <= 2;    
--------------------------------------------------------------------------------   
[피봇문제 1] emp 테이블에서 
                  1등급  2등급 ... 5등급
                  2     3          1
   -- 등급) salgrade 테이블  - grade, losal, hisal  + emp 테이블 조인
   --            부모,자식테이블 관계 X
   --            NON EQUI JOIN      조건   BETWEEN ~ AND 연산자
   SELECT empno, ename, sal , grade
   FROM emp e JOIN salgrade s  ON e.sal BETWEEN s.losal AND s.hisal;
    -- 각 sal등급의 인원수 몇 명인지 조회 ? 
    1) GROUP BY
    
    SELECT grade || '등급' , COUNT(*) 사원수
    FROM (
         SELECT empno, ename, sal , grade
         FROM emp e JOIN salgrade s  ON e.sal BETWEEN s.losal AND s.hisal
    ) t
    GROUP BY grade
    ORDER BY grade ASC;
    
    2) COUNT() + DECODE()
    
    SELECT 
          COUNT(  DECODE( grade, 1 , 'O'  ) ) "1등급"
        , COUNT(  DECODE( grade, 2 , 'O'  ) ) "2등급"
        , COUNT(  DECODE( grade, 3 , 'O'  ) ) "3등급"
        , COUNT(  DECODE( grade, 4 , 'O'  ) ) "4등급"
        , COUNT(  DECODE( grade, 5 , 'O'  ) ) "5등급"
    FROM (
         SELECT empno, ename, sal , grade
         FROM emp e JOIN salgrade s  ON e.sal BETWEEN s.losal AND s.hisal
    ) t;
    
    3) PIVOT()
       (1) 피봇대상
       SELECT *
       FROM ( 
            SELECT grade
            FROM emp e JOIN salgrade s  ON e.sal BETWEEN s.losal AND s.hisal
       )
       PIVOT( COUNT(grade) FOR grade IN ( 1 AS "1등급", 2, 3, 4, 5 ) );
    
   11:00 수업 시작~ 
[피봇문제 2] emp 테이블에서 년도별 입사사원수를 조회
         ( 1980, 1981, 1982 )
    SELECT DISTINCT TO_CHAR( hiredate, 'YYYY') YEAR
    FROM emp;

   1) GROUP BY
    SELECT TO_CHAR( hiredate, 'YYYY') HIRE_YEAR, COUNT(*) 사원수
    FROM emp
    GROUP BY TO_CHAR( hiredate, 'YYYY')
    ORDER BY HIRE_YEAR;
   
   2) COUNT(), DECODE()
   SELECT 
      COUNT(  DECODE( TO_CHAR( hiredate, 'YYYY'), 1980 , 'O' )   )  "1980년 사원수"
      , COUNT(  DECODE( TO_CHAR( hiredate, 'YYYY'), 1981 , 'O' )   )  "1981년 사원수"
      , COUNT(  DECODE( TO_CHAR( hiredate, 'YYYY'), 1982 , 'O' )   )  "1982년 사원수"
   FROM emp;
   
   3) PIVOT()
   SELECT *
   FROM (
            SELECT TO_CHAR( hiredate, 'YYYY') hire_year
            FROM emp
         )
   PIVOT( COUNT( hire_year )  FOR hire_year IN ( 1980, 1981, 1982 ));      
   
   --
   SELECT DISTINCT TO_CHAR( hiredate, 'YYYY') hire_year
   FROM emp;
   -- PIVOT()     IN (목록 서브쿼리 사용할 수 없다. ) X
   SELECT *
   FROM (
            SELECT TO_CHAR( hiredate, 'YYYY') hire_year
            FROM emp
         )
   PIVOT( COUNT( hire_year )  FOR hire_year IN ( SELECT DISTINCT TO_CHAR( hiredate, 'YYYY') hire_year   FROM emp )); 
   
--------------------------------------------------------------------------------   
-- [ ROLLUP 절과 CUBE 절 ]
   ㄴ GROUP BY절에서 사용되어 그룹별 소계를 추가로 보여주는 역할을 한다. 
   ㄴ  즉, 추가적인 집계 정보를 보여준다 .
 예) insa 테이블에서 남자사원수, 여자사원수를 조회  + 총사원수
   SELECT 
      CASE MOD(SUBSTR( ssn , -7, 1), 2)
         WHEN 1 THEN '남자'
         ELSE  '여자'
      END  gender
      , COUNT(*) 사원수
   FROM insa
   GROUP BY  MOD(SUBSTR( ssn , -7, 1), 2)
   UNION ALL
   SELECT '', COUNT(*) 
   FROM insa;
 
    -- GROUP BY + ROLLUP  사용..
    SELECT 
      CASE MOD(SUBSTR( ssn , -7, 1), 2)
         WHEN 1 THEN '남자'
         --ELSE  '여자'
         WHEN 0 THEN '여자'
      END  gender
      , COUNT(*) 사원수
   FROM insa
   GROUP BY ROLLUP( MOD(SUBSTR( ssn , -7, 1), 2) );
   
  -- 예) ROLLUP, CUBE 차이점 체크
  -- insa 테이블에서 부서별 1차 그룹핑
  --                  ㄴ 직급별 2차 그룹핑
  SELECT buseo, jikwi, COUNT(*) 사원수
  FROM insa
  GROUP BY buseo, jikwi
  ORDER BY buseo, jikwi;
  --  1) 각 부서별 사원수 추가 조회   
  SELECT buseo, jikwi, COUNT(*) 사원수
  FROM insa
  GROUP BY buseo, jikwi
  ORDER BY buseo, jikwi;SELECT buseo, jikwi, COUNT(*) 사원수
  FROM insa
  GROUP BY buseo, jikwi
  ORDER BY buseo, jikwi;
  -- 2)
  SELECT buseo, COUNT(*) 부서원수
  FROM insa
  GROUP BY buseo;
  -- 1) + 2) 출력.
  SELECT buseo, jikwi, COUNT(*) 사원수
  FROM insa
  GROUP BY buseo, jikwi  
  UNION ALL
  SELECT buseo, '' ,  COUNT(*) 부서원수
  FROM insa
  GROUP BY buseo
  UNION ALL
  SELECT '' ,'' , COUNT(*)
  FROM insa
  UNION ALL
  SELECT '' ,jikwi , COUNT(*)
  FROM insa
  GROUP BY jikwi
  
  --ORDER BY buseo, jikwi  ;
  -- ROLLUP 절 사용.
  SELECT buseo, jikwi, COUNT(*) 사원수
  FROM insa
  GROUP BY CUBE( buseo, jikwi )
  -- GROUP BY ROLLUP( buseo, jikwi )
  ORDER BY buseo, jikwi;
   

  -- 분할( parial) ROLLUP  
  SELECT buseo, jikwi, COUNT(*) 사원수
  FROM insa
  -- GROUP BY CUBE( buseo, jikwi )
  -- GROUP BY  buseo, ROLLUP(jikwi )  -- 전체사원수 60 X
  GROUP BY ROLLUP( buseo), jikwi   -- 전체사원수 60 X, 직위 부분집합 O, 부서 부분집합 X
  ORDER BY buseo, jikwi;
  
  -- 12:05 수업시작~
  -- +5  
  -- GROUPING SETS 함수GROUPING SETS 함수
  
  SELECT buseo , '' , COUNT(*)
  FROM insa
  GROUP BY buseo 
  UNION ALL
  SELECT '', jikwi , COUNT(*)
  FROM insa
  GROUP BY jikwi; 
 
   --
  SELECT buseo, jikwi , COUNT(*)
  FROM insa
  GROUP BY  GROUPING SETS( buseo, jikwi )
  ORDER BY buseo, jikwi;

--------------------------------------------------------------------------------
 -- 자바   :  임의의 수(난수)           0.0 <=  Math.random()  < 1.0
 -- 오라클 :  dbms_random 패키지 == 관련 함수, 프로시저 등등
 
 SELECT DBMS_RANDOM.VALUE   -- JAVA Math.random()
      , TRUNC( DBMS_RANDOM.VALUE(0,101) ) --  0<=   <101
      , FLOOR( DBMS_RANDOM.VALUE(0,101) ) --  0<=   <101
      , FLOOR(DBMS_RANDOM.VALUE(0, 45 )) + 1  -- 1<= <=45
      , DBMS_RANDOM.STRING('U', 5 ) -- 대문자 5개
      , DBMS_RANDOM.STRING('L', 5 ) -- 소문자 5개
      , DBMS_RANDOM.STRING('A', 5 ) -- 대소문자 5개
      , DBMS_RANDOM.STRING('', 5 ) -- 대소문자 5개 + 특수문자
 FROM dual;
 
 [문제] SMS 인증번호 숫자 6자리
    DBMS_RANDOM.VALUE 함수를 사용해서 
    
   SELECT 
       TRUNC( DBMS_RANDOM.VALUE( 100000 , 1000000 ) )  -- 100000 <=   <= 999999
       ,  LPAD(FLOOR(DBMS_RANDOM.VALUE(0, 1000000)), 6, '0') -- 1 <= 숫자 <=45
   FROM dual;
 
 -- [ 오라클 자료형 ( Data Type ))  정리 ]
 1) CHAR
   ㄱ) "고정길이" 문자 스트링에 사용된다.   <->      "가변길이" 
     예) 주민등록번호 저장 -> 모든 사람들이 14자리
   ㄴ. ['a']['b']['c']['']['']['']['']['']  
   ㄷ. [][][]  abcd 에러 발생
   ㄹ. DB 설정에 따라 1문자 1~4바이트 처리.
   ㅁ. 형식
     CHAR(SIZE [byte] | char])
     최대 2000바이트 문자를 저장한다.   
     
     예)   CHAR        == CHAR(1 BYTE) == CHAR(1)
           CHAR(3)     == CHAR(3 BYTE)
           CHAR(3 BYTE) -- 3바이트
           CHAR(3 CHAR) -- 3문자 
    ㅂ. 
      CREATE TABLE tbl_char (
         -- 컬럼명 자료형([크기])
          aa CHAR   -- CHAR(1) == CHAR(1 BYTE)
        , bb CHAR(3) -- CHAR(3 BYTE) 알파벳 3문자, 한글 1문자
        , cc CHAR(3 CHAR)
      ); 
     -- Table TBL_CHAR이(가) 생성되었습니다.
     SELECT *
     FROM tbl_char;
     --
     INSERT INTO tbl_char ( aa, bb, cc ) VALUES ( 'A','ABC','abc') ;
     COMMIT;
     INSERT INTO tbl_char ( aa, bb, cc ) VALUES ( '한','ABC','abc') ;
     -- ORA-12899: value too large for column "SCOTT"."TBL_CHAR"."AA" (actual: 3, maximum: 1)     
     INSERT INTO tbl_char ( aa, bb, cc ) VALUES ( '1','홍길','abc') ;
     
     INSERT INTO tbl_char ( aa, bb, cc ) VALUES ( '1','MBC','홍길동') ;
     INSERT INTO tbl_char ( aa, bb, cc ) VALUES ( '1','MBC','abc') ;
     --
     SELECT VSIZE('A'), VSIZE('한')
     FROM dual;
     COMMIT;
     --
     DROP TABLE tbl_char ;
     -- Table TBL_CHAR이(가) 삭제되었습니다.
 
    CHAR[( 3 [BYTE] | CHAR )] 고정길이  ['a'][blank][blank] 고정길이, 2000바이트
 2) NCHAR
    U[N]ICODE + CHAR  'A' '홍'  2바이트
    NCHAR(SIZE)
    NCHAR(3) 'abc' / '홍길동'  고정길이, 2000바이트
    NCHAR(1) == NCHAR
    
    고정길이 :  CHAR, NCHAR
      예) 주민등록번호    : CHAR(14 BYTE)
      예) 한글 고정 6자리 : NCHAR(6)
 3) NVARCHAR2(size)   4000 바이트  
 4) VARCHAR2(SIZE BYTE | CHAR )    4000 바잍트
    
      VAR+CHAR2(SIZE BYTE|CHAR) 가변길이
    N+VAR+CHAR2(size) 가변길이
 
   예) CHAR(12)        [a][b][c][blank][][][][][][][][blank]
      VARCHAR2(12 BYTE)[a][b][c]
 
   예) 게시글의 제목 :    CHAR / NCHAR
                      VARCHAR2 / N+VARCHAR2  가변길이 
  DESC EMP;
  ENAME             VARCHAR2(10)
  INSERT INTO emp ( empno , ename ) VALUES ( 9999, '홍길동님')
 
 5) VARCHAR  == VARCHAR2의 시노님
 6) LONG - 가변길이, 2GB 
--    자바 long   정수  -900경~ 900경
  예) 게시판 글 내용
     content LONG
 7)  NUMBER[(p[,s])] 숫자( 정수, 실수 )
    예)  p  : precision  전체 자리수(정밀도)   1~38
         s  : scale        소숫점자리수       -84~127
        NUMBER  ==  NUMBER( 38, 127 )
        NUMBER(3)   정수  == NUMBER(3, 0)
        NUMBER(5,2) 실수
   예) 
    CREATE TABLE tbl_number(
         name NVARCHAR2(10) -- 문자열 char,nchar,varchar,varchar2, nvarchar2, long
       , kor  NUMBER(3)-- NUMBER  0~100 정수   999 ~ -999
       , eng  NUMBER(3)
       , mat  NUMBER(3)
       , tot  NUMBER(3)
       , avg  NUMBER(5,2) -- 100.00
       , r NUMBER(2)  ---  99~99
    );
   -- Table TBL_NUMBER이(가) 생성되었습니다.
   INSERT INTO tbl_number VALUES 
     ( '홍길동', 90, 89, 100, null, null, null );
  INSERT INTO tbl_number VALUES 
     ( '윤재민', 90, 80.12, 78, null, null, null );     
   COMMIT;
   
   INSERT INTO tbl_number VALUES 
     ( '탁인혁', 90, 20, 78, null, null, null );     
  ROLLBACK;  
   
   -- 총점, 평균 계산 UPDATE
   UPDATE tbl_number
   SET  tot = kor+eng+mat , avg = ( kor +eng +mat)/3;
   -- WHERE
   COMMIT;
   
   [문제] R 등수 null  처리 UPDATE
   
   SELECT tot
      , ( SELECT COUNT(*) +1 FROM tbl_number WHERE tot > t1.tot ) r
   FROM tbl_number t1;
   
   -- 모든 학생들 등수 처리..
   UPDATE tbl_number t1
   SET r = ( SELECT COUNT(*) +1 FROM tbl_number WHERE tot > t1.tot );
   -- WHERE;
   COMMIT;
   
   SELECT  *
   FROM tbl_number;  
   
   ROLLBACK;

   3:01 수업 시작~~~ 
   
실제 데이터

NUMBER 선언

저장되는 값

123.89 NUMBER 123.89 
123.89 NUMBER(3) 124 
123.89 NUMBER(3,2) precision을 초과 
123.89 NUMBER(4,2) precision을 초과 
123.89 NUMBER(5,2) 123.89 
123.89 NUMBER(6,1) 123.9 
123.89 NUMBER(6,-2) 100 
.01234 NUMBER(4,5) .01234 
.00012 NUMBER(4,5) .00012 
.000127 NUMBER(4,5) .00013 
.0000012 NUMBER(2,7) .0000012 
.00000123 NUMBER(2,7) .0000012 
1.2e-4 NUMBER(2,5) 0.00012 
1.2e-5 NUMBER(2,5) 0.00001 

DESC emp;
DESC dept;
DESC salgrade;
DESC bonus;

 8) FLOAT(p) == 내부적으로는 NUMBER 처리된다. 
 9) DATE 
    ㄴ 날짜, 시간
    ㄴ 고정 길이   7 byte 저장.
    
    TIMESTAMP[(n)] == TIMESTAMP(6)
       00:00:00.000000000      나노세컨드 
    
    SELECT SYSDATE -- '23/03/23'    
    FROM dual;
    
    SELECT hiredate  -- 80/12/17
     , TO_CHAR( hiredate, 'TS')
    FROM emp;
   
   예) 게시판 작성일   : DATE O , TIMESTAMP X

 10) RAW(size)   2진데이터( 0,1 ) 2000바이트
     LONGRAW                     2GB
     
     RAW == 가공하지 않은 , 날것,    
     홍길동.gif  이미지파일 -> TABLE 저장
     01010111                          01010111   
    게시판 글 쓰기 + (첨부파일*3개)      특정 폴더  : 첨부파일 저장하고
                                      TABLE : 저장된 파일의 경로만 저장.
   
 11) BFILE    2진데이터 (0,1) , 외부 파일 형태로 저장
 
 12) LOB = [L]arge [OB]ject
        B   + LOB    = Binary(2진 데이터)
        C   + LOB    = Char
        NC  + LOB    = NChar
 
       게시판 글 내용(CONTENT )  CLOB/LONG/NVARCHAR2(2000)
   
 13) ROWID
     ROW(행) + ID(고유한값)
     SELECT ROWID, emp.*
     FROM emp;
--------------------------------------------------------------------------------

  오라클 문자 : char, nchar, varchar, varchar2, nvarchar2
               long, clob
       숫자 : number(p,s)   , float
       날짜 : date, timestamp
       
      이진데이터 :  RAW/LONGRAW , BFILE  , BLOB    
      LOB : blob, clob, nclob
      
--------------------------------------------------------------------------------
-- [ COUNT 함수 ]
    ㄴ 쿼리한 행의 수를 반환한다.
    ㄴ COUNT(컬럼명) 함수는 NULL이 아닌 행의 수를 출력하고 
       COUNT(*) 함수는 NULL을 포함한 행의 수를 출력한다.
   【형식】
	COUNT([* ¦ DISTINCT ¦ ALL] 컬럼명) [ [OVER] (analytic 절)]
   --  
   SELECT COUNT( DISTINCT buseo  )
   FROM insa;
   --  ORA-00937: not a single-group group function
   -- 복수행 함수 이기에  name, basicpay랑 같이 사용 X
   SELECT name, basicpay
    -- OVER절을 사용하면 누적된 수를 카운팅한다. 
          , COUNT(*) OVER( ORDER BY basicpay ASC )
   FROM insa;
   
   -- 부서로 그룹핑한 후 누적된 수를 조회...
    SELECT name, basicpay , buseo
          , COUNT(*) OVER( PARTITION BY buseo  ORDER BY basicpay ASC )
   FROM insa;
 
   -- SUM()
   -- basicpay의 누적된 합을 조회
   SELECT name, basicpay 
          , SUM(basicpay) OVER( ORDER BY basicpay ASC )
   FROM insa;
   
   -- 부서로 그룹핑한 후 누적된 수를 조회...
    SELECT name, basicpay , buseo
          , SUM(basicpay) OVER( PARTITION BY buseo  ORDER BY basicpay ASC )
   FROM insa;
 
   -- AVG()
   -- basicpay의 누적된 평균을 조회
   SELECT name, basicpay 
          , AVG(basicpay) OVER( ORDER BY basicpay ASC )
   FROM insa;
   
   -- 부서로 그룹핑한 후 누적된 평균를 조회...
    SELECT name, basicpay , buseo
          , AVG(basicpay) OVER( PARTITION BY buseo  ORDER BY basicpay ASC )
   FROM insa;

--------------------------------------------------------------------------------
4:03 수업 시작~~ 
테이블 생성/수정/삭제  CRUD  ~  + 제약조건
--------------------------------------------------------------------------------
[데이터 저장] - CRUD = 테이블(table)
***[ DB 모델링 ] ***
요구분석 -> 개념적 모델링 -> 논리적 모델링 -> 물리적모델링
                                         [오라클] 테이블생성
                                         MySQL
                                           ;
-- [회원정보]를 관리하는 테이블 생성 : 회원테이블
 컬럼명(열)  물리적컬럼명    자료형      크기        필수입력                주석
 아이디       id           VARCHAR2   10 BYTE    NOT NULL  PRIMARY KEY
 이름         name        NVARCHAR2   10 문자    NOT NULL  
 나이         age         NUMBER      3             
 전화번호      tel         CHAR        13        NOT NULL
                          010-1234-1234
 생일         birth        DATE
 기타         etc         NVARCHAR2   200
                           LONG  2GB
                           CLOB
                          
  :
  :
 재무상태(연봉,부..)
 회사/직급/연봉

-- 테이블 생성
【형식】
CREATE TABLE 테이블명
	(컬럼명 데이터타입 [, 컬럼명 데이터타입]...)
	[TABLESPACE tablespace명]
	[PCTFREE 정수]
	[PCTUSED 정수]
	[INITRANS 정수]
	[MAXTRANS 정수]
	[STORAGE storage절]
	[LOGGING ¦ NOLOGGING]
	[CACHE ¦ NOCACHE];



SELECT *
FROM emp;
-- 테이블 생성( 가장 단순한 방법 )
【형식】
    CREATE [GLOBAL TEMPORARY] TABLE [schema.] table {relational_table ¦ 
                                                     object_table ¦
                                                     XML_Type_table}

【relational_table의 형식】
   [(relational_properties) [ON COMMIT {DELETE ¦ PRESERVE} ROWS]
   [physical_properties] [table_properties];

【object_table의 형식】
   OF [schema.]object_type [object_table_substitution]
    [(object_properties) [ON COMMIT {DELETE ¦ PRESERVE} ROWS]
    [OID_clause] [OID_index_clause] [physical_properties] [table_properties];

【XMP_Type_table의 형식】
   OF XMLTYPE [(object_properties) [XMLTYPE XML_Type_storage] [XML_Schema_spec]
    [XML_Type_virtual_columns] [ON COMMIT {DELETE ¦ PRESERVE} ROWS]
    [OID_clause] [OID_index_clause] [physical_properities] [table_properities]

이 문을 실행하려면 자신의 스키마에서는 CREATE TABLE 시스템권한이 있어야 하고
    다른 사용자 스키마내에서 테이블을 생성하려면 CREATE ANY TABLE 시스템권한이 있어야 하며,
    테이블스페이스를 위해서 UNLIMITED TABLE 시스템권한이 있어야 한다.

【간단한형식】
    CREATE [GLOBAL TEMPORARY] TABLE [schema.] table
      ( 
        열이름  데이터타입 [DEFAULT 표현식] [제약조건] 
       [,열이름  데이터타입 [DEFAULT 표현식] [제약조건] ] 
       [,...]  
      ); 
  실습)
 
            
 
 
 기타         etc         NVARCHAR2   200
 
  CREATE TABLE  scott.tbl_member
  (
       id   VARCHAR2(10) NOT NULL PRIMARY KEY
     , name  NVARCHAR2(10)  NOT NULL
     , age   NUMBER(3)
     , tel   CHAR(13) NOT NULL
     , birth DATE
     , etc   NVARCHAR2(200)
  );
 -- Table SCOTT.TBL_MEMBER이(가) 생성되었습니다.
 1) 생성된 테이블 확인
 SELECT *
 FROM  tabs  -- user_tables
 WHERE REGEXP_LIKE(  table_name ,  'member' , 'i');
 WHERE table_name LIKE '%MEMBER%';

 2) 테이블 삭제.
 
 【형식】
     DROP TABLE [schema.]table [CASCADE CONSTRAINTS] [PURGE];
  PURGE(퍼지) : 사전적의지  깨끗이하다, 제거하다. 
  DROP TABLE scott.tbl_member PURGE;




   
         
