-- SCOTT --


  [DQL(Query)  조회 : SELECT문 ]
  1. SELECT, 서브쿼리(subquery)를 이용하여 
    하나 이상의   테이블 [테이블(table), 객체 테이블(object table)]
               , 뷰    [뷰(view), 객체 뷰(object view), 물리적 뷰( materialized view )]으로 부터
     
    데이터를 가져오는데 사용된다.
  2. 테이블, 뷰가 자신의 소유이거나, SELECT 권한이 있어야 된다.
  3. SYS -> SELECT ANY TABLE 시스템권한 부여 -> SCOTT 
  
【형식】
  [subquery_factoring_clause] subquery [for_update_clause];

【subquery 형식】
   {query_block ¦
    subquery {UNION [ALL] ¦ INTERSECT ¦ MINUS }... ¦ (subquery)} 
   [order_by_clause] 

【query_block 형식】
   SELECT [hint] [DISTINCT ¦ UNIQUE ¦ ALL] select_list
   FROM {table_reference ¦ join_clause ¦ (join_clause)},...
     [where_clause] 
     [hierarchical_query_clause] 
     [group_by_clause]
     [HAVING condition]
     [model_clause]

【subquery factoring_clause형식】
   WITH {query AS (subquery),...}
   
   4. SELECT문에서 사용되는 절(clause) [암기]  +  절 처리되는 순서[암기]
   
   (1) WITH 절                      1
   ***(2) SELECT 절                          6
   ***(3) FROM 절                      2  
   (4) WHERE 절                     3
   (5) GROUP BY 절                  4
   (6) HAVING 절                    5
   (7) ORDER BY 절                        7 
   
   -> 처리 순서대로 코딩을 하는 습관...
   
-----------------------------------------------   
1) SCOTT 계정이 소유하고 있는 테이블 목록 조회. (SELECT문 사용)  
SELECT * 
SELECT TABLE_NAME
FROM user_tables;
FROM user_users;
FROM 테이블 또는 뷰(View);

 현재 scott 사용자는 소유하고 있는 테이블이 존재하지 않는다. 

2) user_tables의 구조 확인
DESCRIBE
DESC user_tables;
이름                        널?       유형           
------------------------- -------- ------------ 
TABLE_NAME                NOT NULL VARCHAR2(30) 
TABLESPACE_NAME                    VARCHAR2(30) 
CLUSTER_NAME                       VARCHAR2(30) 
IOT_NAME                           VARCHAR2(30) 
STATUS                             VARCHAR2(8)  
PCT_FREE                           NUMBER       
PCT_USED                           NUMBER       
INI_TRANS                          NUMBER       
MAX_TRANS                          NUMBER       
INITIAL_EXTENT                     NUMBER       
NEXT_EXTENT                        NUMBER       
MIN_EXTENTS                        NUMBER       
MAX_EXTENTS                        NUMBER       
PCT_INCREASE                       NUMBER       
FREELISTS                          NUMBER       
FREELIST_GROUPS                    NUMBER       
LOGGING                            VARCHAR2(3)  
BACKED_UP                          VARCHAR2(1)  
NUM_ROWS                           NUMBER       
BLOCKS                             NUMBER       
EMPTY_BLOCKS                       NUMBER       
AVG_SPACE                          NUMBER       
CHAIN_CNT                          NUMBER       
AVG_ROW_LEN                        NUMBER       
AVG_SPACE_FREELIST_BLOCKS          NUMBER       
NUM_FREELIST_BLOCKS                NUMBER       
DEGREE                             VARCHAR2(40) 
INSTANCES                          VARCHAR2(40) 
CACHE                              VARCHAR2(20) 
TABLE_LOCK                         VARCHAR2(8)  
SAMPLE_SIZE                        NUMBER       
LAST_ANALYZED                      DATE         
PARTITIONED                        VARCHAR2(3)  
IOT_TYPE                           VARCHAR2(12) 
TEMPORARY                          VARCHAR2(1)  
SECONDARY                          VARCHAR2(1)  
NESTED                             VARCHAR2(3)  
BUFFER_POOL                        VARCHAR2(7)  
FLASH_CACHE                        VARCHAR2(7)  
CELL_FLASH_CACHE                   VARCHAR2(7)  
ROW_MOVEMENT                       VARCHAR2(8)  
GLOBAL_STATS                       VARCHAR2(3)  
USER_STATS                         VARCHAR2(3)  
DURATION                           VARCHAR2(15) 
SKIP_CORRUPT                       VARCHAR2(8)  
MONITORING                         VARCHAR2(3)  
CLUSTER_OWNER                      VARCHAR2(30) 
DEPENDENCIES                       VARCHAR2(8)  
COMPRESSION                        VARCHAR2(8)  
COMPRESS_FOR                       VARCHAR2(12) 
DROPPED                            VARCHAR2(3)  
READ_ONLY                          VARCHAR2(3)  
SEGMENT_CREATED                    VARCHAR2(3)  
RESULT_CACHE                       VARCHAR2(7) 

   3) scott 사용자가 수업 중에 사용할 테이블을 생성 + 데이터 추가.
   scott.sql 파일을 샘플로 찾아왔습니다.
   
   3:12 수업시작~ 
-------------------------------------------------------------   
C:\Users\redke>sqlplus sys/ss123$ as sysdba
SQL> @C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
SQL> _

 -- SCOTT이 소유하고 있는 모든 테이블 정보 조회..
SELECT *
FROM user_tables;   
-- DEPT, EMP, SALGRADE, BONUS 4개의 테이블 생성

-- 모든 사용자 정보 조회 --
SELECT *
FROM dba_users;  -- dba_XXX 뷰를 사용하려면 DBA( 관리자 )만 사용할 수 있는 뷰이다. 
[ 오류 발생]
    ORA-00942: table or view does not exist        테이블 , 뷰(dba_users)가 존재하지 않는다. 
    00942. 00000 -  "table or view does not exist"
    *Cause:    
    *Action:
    131행, 6열에서 오류 발생
-- 오류가 안 나는 것도 문제인가요? X

FROM all_users;
-- HR	43	14/05/29    계정이 오라클 설치할 때 샘플 계정 존재 O .
-- The account   is   locked. 계정이 잠겨져 있다..
-- 모든 사용자 계정의 상태 확인 ( 잠김 ) 조회

all_users -- username, user_id, created 3개 정보 확인
dba_users --                            + 더 많은 정보 확인     
   
------------------- SCOTT -------------------------------

-- scott.sql 스크립트 파일 @ 실행~ 
-- emp, dept, salgrade, bonus 4개 테이블 생성
-- 1) emp 사원 정보 테이블
-- 2) dept 부서 정보 테이블
-- 3) salgrade 기본급 + 등급 테이블
-- 4) bonus  보너스 테이블

-- SELECT 문 설명 --
   
   
(1) 모든 사원 정보를 조회.( SELECT 문 )
SELECT * -- 모든 컬럼 정보  *
FROM emp;
-- 12명의 사원 존재.
empno   ename   job      mgr     hiredate   sal     comm    deptno
7369	SMITH	CLERK	7902(FORD)	80/12/17	800		        20(RESEARCH)
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30
7566	JONES	MANAGER	7839	81/04/02	2975		20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	7839	81/05/01	2850		30 
:

2) deptno = 20      20	RESEARCH	DALLAS
SELECT *   
FROM dept;

(2) 모든 사원의  사원명 입사일자 정보만  조회
         --               80(RR)/12(MM)/17(DD)
         --                 년       월      일
         --                  YY
         -- 도구 / 환경설정 / 데이터베이스 / NLS 클릭 (National Language Support)
         -- 날짜형식 설정 : RR/MM/DD
SELECT ename, hiredate
FROM emp;

(3) 모든 사원의 정보를 조회
   ( 조건 : 사원번호, 사원명, 입사일자  )
   ( 조건 : 월급(pay) =        기본급(sal) + 커미션(comm)  )
SELECT    empno, ename, hiredate
         , sal
         , comm
         , sal + comm
FROM emp;

  문제점) comm 이 null 값인 경우에는   sal + null = null 이더라.
         sal 라도 출력이 되도록 하자.
         null 처리는 어떻게 하는가 ? 
  10분 휴식 + 새로운 팀 + 팀장/팀명 + 인사 











   
   
   
   
   
   
   
   
