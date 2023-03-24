-- SCOTT -- 
-- 10:00 제출~
--------------------------------------------------------------------------------------------------------------------------------
-- 복습 문제 
--------------------------------------------------------------------------------------------------------------------------------
1. 오라클 각 DataType 에 대해 상세히 설명하세요
  ㄱ. 문자(열)  ''
    ㄴ 고정 길이  CHAR, [N]CHAR  2000바이트
    ㄴ 가변 길이  VARCHAR, VARCHAR2, NVARCHAR2  4000바이트    
    LONG 2GB
    
  ㄴ. 숫자(정수,실수)
     NUMBER(p,s)
      p 38
      s 127
      
     FLOAT  
  ㄷ. 날짜  ''
     DATE     날짜+시간(초)
     TIMESTAMP(n=6)           .[000000]000
  ㄹ. LOB( LARGE OBJECT )
     blob
     clob
     NCLOB
     
  - BFILE         외부파일  이진데이터 
  - RAW/LONGRAW  이진데이터
--------------------------------------------------------------------------------------------------------------------------------
2.  emp 테이블에서 [년도별] [월별] 입사사원수 출력.( PIVOT() 함수 사용 )

    [실행결과]
    1982	1	0	0	0	0	0	0	0	0	0	0	0
    1980	0	0	0	0	0	0	0	0	0	0	0	1
    1981	0	2	0	1	1	1	0	0	2	0	1	2
    
    가로출력 -> 세로 출력
    1) 피봇 대상 쿼리
    SELECT EXTRACT( YEAR FROM hiredate )  h_year
        , EXTRACT( MONTH FROM hiredate )  h_month
    FROM emp;
    
    2) IN ( 1,2,3,4,5,6,7,8,9,10,11,12 )
    3) FOR  h_month
    4) COUNT(컬럼)
    
    SELECT *
    FROM (
        SELECT EXTRACT( YEAR FROM hiredate )  h_year
            , EXTRACT( MONTH FROM hiredate )  h_month
        FROM emp
     )
     PIVOT( COUNT(*)   FOR h_month  IN ( 1,2,3,4,5,6,7,8,9,10,11,12 ) );

--------------------------------------------------------------------------------------------------------------------------------    
2-2.   emp 테이블에서 각 JOB별 입사년도별 1월~ 12월 입사인원수 출력.  ( PIVOT() 함수 사용 ) 
    [실행결과]
    ANALYST		1981	0	0	0	0	0	0	0	0	0	0	0	1
    CLERK		1980	0	0	0	0	0	0	0	0	0	0	0	1
    CLERK		1981	0	0	0	0	0	0	0	0	0	0	0	1
    CLERK		1982	1	0	0	0	0	0	0	0	0	0	0	0
    MANAGER		1981	0	0	0	1	1	1	0	0	0	0	0	0
    PRESIDENT	1981	0	0	0	0	0	0	0	0	0	0	1	0
    SALESMAN	1981	0	2	0	0	0	0	0	0       
    
    SELECT *
    FROM (
        SELECT 
             job
            , EXTRACT( YEAR FROM hiredate )  h_year
            , EXTRACT( MONTH FROM hiredate )  h_month
        FROM emp
     )
     PIVOT( COUNT(*)   FOR h_month  IN ( 1,2,3,4,5,6,7,8,9,10,11,12 ) )
     ORDER BY job ASC;

--------------------------------------------------------------------------------------------------------------------------------    
3. emp테이블에서 입사일자가 오래된 순으로 3명 출력 ( TOP 3 )
    [실행결과]
    1	7369	SMITH	CLERK	    7902	80/12/17	800		    20
    2	7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
    3	7521	WARD	SALESMAN	7698	81/02/22	1250	500	30    

   -- TOP-N 방식
   1) 입사일자 정렬 ASC + 서브쿼리

SELECT *
FROM emp
ORDER BY hiredate ASC;
   
   2) ROWNUM 의사컬럼   <=3
   SELECT ROWNUM, empno, ename, job, mgr, hiredate, sal, comm, deptno
   FROM (
        SELECT *
        FROM emp
        ORDER BY hiredate ASC
   )t
   WHERE  ROWNUM <= 3;
      
   -- RANK() 함수
   -- ORA-00936: missing expression
   SELECT t.*
   FROM (
           SELECT 
               RANK() OVER( ORDER BY hiredate ASC ) seq
              , emp.*
           FROM emp
   ) t
   WHERE seq <= 3;
   
    
--------------------------------------------------------------------------------------------------------------------------------    
4. SMS 인증번호  임의의  6자리 숫자 출력 ( dbms_random  패키지 사용 )
   
   -- JAVA- MATH.random() /    RANDOM 클래스
   -- ORACLE   DBMS_RANDOM 패키지 - 오라클객체( 함수, 프로시저, 트리거 등등 )
   
   SELECT dbms_random.value
       , FLOOR( dbms_random.value( 100000,1000000 ) )
       , dbms_random.string('L', 5)
   FROM dual
   CONNECT BY LEVEL <= 6;  -- CONNECT BY 조건절  ( 암기 )
   -- ( 단순 암기 )
   SELECT LEVEL
   FROM dual   
   CONNECT BY LEVEL <= 31;
   -- [ 2023년 3월 ] 1~31일 날짜 모두 출력.
   SELECT TRUNC( SYSDATE , 'MM' ) + LEVEL -1
   FROM dual
   CONNECT BY LEVEL <= TO_CHAR( LAST_DAY( SYSDATE ) , 'DD' );
   
   -- 달력 그리기 ( 팀별로 소스 분석 ) --
SELECT 
      NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 1, TO_CHAR( dates, 'DD')) ), ' ')  일
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 2, TO_CHAR( dates, 'DD')) ), ' ')  월
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 3, TO_CHAR( dates, 'DD')) ), ' ')  화
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 4, TO_CHAR( dates, 'DD')) ), ' ')  수
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 5, TO_CHAR( dates, 'DD')) ), ' ')  목
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 6, TO_CHAR( dates, 'DD')) ), ' ')  금
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 7, TO_CHAR( dates, 'DD')) ), ' ')  토
FROM (
        SELECT TO_DATE(:yyyymm , 'YYYYMM') + LEVEL - 1  dates
        FROM dual
        CONNECT BY LEVEL <= EXTRACT ( DAY FROM LAST_DAY(TO_DATE(:yyyymm , 'YYYYMM') ) )
)  t 
GROUP BY CASE 
               -- IW 가 50주 넘으면서 "일요일"
             WHEN TO_CHAR(dates, 'MM') = 1 AND  TO_CHAR(dates, 'D') = '1' AND TO_CHAR( dates, 'IW') > '50' THEN 1
             WHEN TO_CHAR(dates, 'MM') = 1 AND TO_CHAR(dates, 'D') != '1' AND TO_CHAR( dates, 'IW') > '50' THEN 0  
             WHEN TO_CHAR( dates , 'D') = 1 THEN TO_CHAR( dates , 'IW') + 1
             ELSE TO_NUMBER( TO_CHAR( dates , 'IW') )
          END   
ORDER BY   
         CASE 
             WHEN TO_CHAR(dates, 'MM') = 1 AND  TO_CHAR(dates, 'D') = '1' AND TO_CHAR( dates, 'IW') > '50' THEN 1
             WHEN TO_CHAR(dates, 'MM') = 1 AND TO_CHAR(dates, 'D') != '1' AND TO_CHAR( dates, 'IW') > '50' THEN 0  
             WHEN TO_CHAR( dates , 'D') = 1 THEN TO_CHAR( dates , 'IW') + 1
             ELSE TO_NUMBER( TO_CHAR( dates , 'IW') )
            END      ;   
--------------------------------------------------------------------------------------------------------------------------------
4-2. 임의의 대소문자 5글자 출력( dbms_random  패키지 사용 )


11:05 수업 시작~~
--------------------------------------------------------------------------------------------------------------------------------
5. 게시글을 저장하는 테이블 생성
   ㄱ.   테이블명 : tbl_board
   ㄴ.   컬럼
         글번호    seq            자료형  크기    널허용여부    고유키
         작성자    writer     
         비밀번호 passwd      
         글제목    title       
         글내용    content
         작성일    regdate   
    ㄷ.  글번호, 작성자, 비밀번호, 글 제목은 필수 입력 사항으로 지정
    ㄹ.  글번호가  기본키( PK )로 지정
    ㅁ.  작성일은 현재 시스템의 날짜로 자동 설정    DEFAULT 기본값
    
    CREATE TABLE tbl_board(
         seq      NUMBER       NOT NULL PRIMARY KEY
       , writer   VARCHAR2(20) NOT NULL
       , passwd   VARCHAR2(15) NOT NULL
       , title    VARCHAR2(100)NOT NULL
       , content  CLOB
       , regdate  DATE   DEFAULT SYSDATE
    );
    -- Table TBL_BOARD이(가) 생성되었습니다.
--------------------------------------------------------------------------------------------------------------------------------    
5-2. 조회수    read   컬럼을 추가 ( 기본값 0 으로  설정 ) 
    ALTER TABLE tbl_board
    ADD read NUMBER DEFAULT 0;
   -- Table TBL_BOARD이(가) 변경되었습니다.
--------------------------------------------------------------------------------------------------------------------------------
5-3. 테이블 구조 확인 
   DESC tbl_board;
   
   12:03 수업시작~ 
--------------------------------------------------------------------------------------------------------------------------------
5-4. CRUD  ( insert, select, update, delete ) 
   ㄱ. 임의의 게시글 5개를 추가 insert
   INSERT INTO 스키마.테이블명 ( 컬럼명,,,) VALUES ( 값...);
   
   INSERT INTO tbl_board (seq, writer, passwd,title, content, regdate, read ) 
                  VALUES ( 1 , '홍길동','123$', '첫 번째 게시글' , '내용 무', SYSDATE, 0 );
   
   --  content, regdate, read 컬럼값을 주지 않았어요. 왜 ? NULL, DEFAULT 
   -- SQL 오류: ORA-00947: not enough values
   INSERT INTO tbl_board (seq, writer, passwd,title, content, regdate, read ) 
                  VALUES ( 1 , '박현주','123$', '두 번째 게시글'   );   
   -- ORA-00001: unique constraint (SCOTT.SYS_C009645) violated
   --            유일성(유니크) 제약조건에                위배된다.
   INSERT INTO tbl_board (seq, writer, passwd,title ) 
                  VALUES ( 2 , '박현주','123$', '두 번째 게시글'   );  
                  
   -- seq, writer, passwd,title, content, regdate, read  컬럼 순으로 값을 주었다면 생략가능하다.
   INSERT INTO tbl_board VALUES ( 3 , '이태규','123$', '세 번째 게시글' , '내용 무', SYSDATE, 0 );   
   
 
   INSERT INTO tbl_board ( writer, seq, title,  passwd , content ) 
                  VALUES ( '박현주', 4 , '두 번째 게시글','123$' , '냉묵'  ); 
                  
    INSERT INTO tbl_board (seq, writer, passwd,title, content, regdate, read ) 
                  VALUES ( 5 , '홍길동','123$', '첫 번째 게시글' , null , null, null );                   
   COMMIT;             
                  
   ㄴ. 게시글 조회 select
   SELECT *
   FROM tbl_board
   ORDER BY seq DESC;
   
   ㄷ. 3번 게시글의 글 제목, 내용 수정 update
      3	이태규	123$	세 번째 게시글	내용 무	23/03/24	0
      
      UPDATE tbl_board
      SET  title = title || ' - 수정', content =  content || ' - 수정'
      WHERE seq = 5;
   
    -- 1 행 이(가) 업데이트되었습니다.

   ㄹ. 4번 게시글 삭제 delete
   
     DELETE FROM tbl_board
     WHErE seq = 4;
     COMMIT;
     
   [문제]  1번글의 제목,내용,작성일 -> 5번글의 제목,내용,작성일으로 수정하세요.  
   
    SELECT title FROM tbl_board WHERE seq =1 ;
    --
    UPDATE tbl_board
    SET    title  = ( SELECT title FROM tbl_board WHERE seq =1 )
        , content = ( SELECT content FROM tbl_board WHERE seq =1 )
        , regdate = ( SELECT regdate FROM tbl_board WHERE seq =1 )
    WHERE seq = 5 ;
    -- ( 기억 ) 
    UPDATE tbl_board
    SET (title, content, regdate) = (SELECT title, content, regdate FROM tbl_board WHERE seq =1)
    WHERE seq = 5;
    --
    ROLLBACK;
    COMMIT;
    -- 5  첫 번째 게시글 - 수정	 - 수정	
    SELECT * 
    FROM tbl_board;
--------------------------------------------------------------------------------------------------------------------------------
5-5. tbl_board 테이블 삭제  
    [DDL]
    CREATE TABLE
    ALTER TABLE
    DROP TABLE tbl_board PURGE; -- 완전 삭제
--------------------------------------------------------------------------------------------------------------------------------
-- 어제 복습 --
【간단한형식】
      CREATE [GLOBAL TEMPORARY] TABLE [schema.] table
      ( 
        열이름  데이터타입 [DEFAULT 표현식] [제약조건] 
       [,열이름  데이터타입 [DEFAULT 표현식] [제약조건] ] 
       [,...]  
      ); 
-- ㄱ. 
   SELECT *
   FROM tabs
   WHERE table_name LIKE '%MEMBER%';
   --
   DROP   TABLE  tbl_member2 PURGE;
   --
   ALTER  TABLE
   --
   CREATE TABLE  tbl_member2
   (
         id    VARCHAR2(10)  NOT NULL  PRIMARY KEY
       , name  VARCHAR2(20)  NOT NULL
       , age   NUMBER(3)
       , birth DATE
   );
   -- etc , tel 컬럼 빼고 테이블 생성
   -- Table TBL_MEMBER2이(가) 생성되었습니다.
   
   A)  tbl_member2에         새로운   etc , tel 컬럼  추가.
     만들어진 테이블에 2개의 컬럼을 추가한다는 의미 ==> 테이블 수정
     1) ALTER TABLE  ADD 컬럼,제약조건 추가
        tel, etc 두 개의 컬럼 추가...
        
        ㄱ. 새로운 2개의 컬럼을 추가하지 전에  INSERT문으로 레코드(행)을 추가했다면 
           새로 추가되는 컬럼의 값은  NULL 로 채워진다. 
        ㄴ.    【형식】컬럼추가
                ALTER TABLE 테이블명
                ADD (컬럼명 datatype [DEFAULT 값]
                [,컬럼명 datatype]...);
        예) 
        ALTER TABLE tbl_member2
        ADD  (
                tel  CHAR(13)
                , etc VARCHAR2(1000)
             );
        --  Table TBL_MEMBER2이(가) 변경되었습니다.
        DESC tbl_member2;
        
        ㄷ. 한 개의 컬럼을 추가할 때는  ADD  tel  CHAR(13)  괄호를 생략할 수 있다.
        ㄹ. 추가된 컬럼은 테이블의 마지막에 추가된다. 위치 수정 못한다. 
        
     2) ALTER TABLE  MODIFY 컬럼 수정
     3) ALTER TABLE  DROP 제약조건 삭제
     4) ALTER TABLE DROP 컬럼 삭제
  
   B) etc 컬럼의  VARCHAR2(1000) 크기  1000 -> 500 바이트 변경.
       【 형식】
        ALTER TABLE 테이블명
        MODIFY (컬럼명 datatype [DEFAULT 값]
               [,컬럼명 datatype]...);
      1) 데이터의 type, ***[size]***, default 값을 변경할 수 있다.  
      2) 변경 대상 컬럼에 데이터가 없거나 null 값만 존재할 경우에는 size를 줄일 수 있다.( 가능 )
      3) 데이터의 type, size, default 값을 변경할 수 있다.
       4) 변경 대상 컬럼에 데이터가 없거나 null 값만 존재할 경우에는 size를 줄일 수 있다.
    • 데이터 타입의 변경은 CHAR와 VARCHAR2 상호간의 변경만 가능하다.
    • 컬럼 크기의 변경은 저장된 데이터의 크기보다 같거나 클 경우에만 가능하다.
    • NOT NULL 컬럼인 경우에는 size의 확대만 가능하다.
    • 컬럼의 기본값 변경은 그 이후에 삽입되는 행부터 영향을 준다.
    • 컬럼이름의 직접적인 변경은 불가능하다.
    • 컬럼이름의 변경은 서브쿼리를 통한 테이블 생성시 alias를 이용하여 변경이 가능하다.
    • alter table ... modify를 이용하여 constraint를 수정할 수 없다.
     데이터 타입 변경 가능사항 SIZE 
    NULL 컬럼 문자 ↔ 숫자 ↔ 날짜 확대, 축소가능 
    NOT NULL 컬럼 CHAR ↔ VARCHAR2 확대만 가능 
    
    예) 
    ALTER TABLE tbl_member2
    MODIFY ( etc VARCHAR2(500) );
    -- Table TBL_MEMBER2이(가) 변경되었습니다.
    DESC tbl_member2;

   C) etc 컬럼명을 memo 컬럼명으로 수정(변경)
     1) 조회할때 별칭(alias) 사용하면 된다.
          SELECT etc AS memo
         FROM tbl_member2;
     2) 컬럼명 변경
     ALTER TABLE tbl_member2
     RENAME COLUMN etc TO memo; 
    -- Table TBL_MEMBER2이(가) 변경되었습니다.
    
   3) memo 컬럼 삭제..
   【형식】
        ALTER TABLE 테이블명
        DROP COLUMN 컬럼명; 

        • 컬럼을 삭제하면 해당 컬럼에 저장된 데이터도 함께 삭제된다.
        • 한번에 하나의 컬럼만 삭제할 수 있다.
        • 삭제 후 테이블에는 적어도 하나의 컬럼은 존재해야 한다.
        • DDL문으로 삭제된 컬럼은 복구할 수 없다.

        ALTER TABLE tbl_member2
        DROP COLUMN memo; 
        -- Table TBL_MEMBER2이(가) 변경되었습니다.
        
   4) 테이블명을 수정 ( tbl_member02 -> tbl_member03 )
   RENAME  tbl_member2 TO tbl_member02 ;
   -- 테이블 이름이 변경되었습니다.
--------------------------------------------------------------------------------------------------------------------------------
6-1. 오늘의 날짜와 요일 출력 
 [실행결과]
오늘날짜  숫자요일  한자리요일       요일
-------- ---        ------   ------------
22/04/15  6             금      금요일      

SELECT SYSDATE
      , TO_CHAR( SYSDATE, 'D' )
      , TO_CHAR( SYSDATE, 'DY' )
      , TO_CHAR( SYSDATE, 'DAY' )
FROM dual;
--------------------------------------------------------------------------------------------------------------------------------
6-2. 이번 달의 마지막 날과 날짜만 출력 
 [실행결과]
오늘날짜  이번달마지막날짜                  마지막날짜(일)
-------- -------- -- ---------------------------------
22/04/15 22/04/30 30                                30

  SELECT SYSDATE
  , LAST_DAY( SYSDATE )
  , TO_CHAR( LAST_DAY( SYSDATE ), 'DD' )
  FROM dual;
--------------------------------------------------------------------------------------------------------------------------------
6-3.
 [실행결과]
오늘날짜    월의주차 년의주차 년의 주차
--------    -       --      -- 
23/03/24      4     12       12 

  [ IW와 WW의 차이점 설명 ]
  SELECT SYSDATE
  , TO_CHAR( SYSDATE , 'W')
  , TO_CHAR( SYSDATE , 'IW')
  , TO_CHAR( SYSDATE , 'WW')
  FROM dual;

--------------------------------------------------------------------------------------------------------------------------------

-- [테이블 생성]
1) 테이블 생성하는 가장 단순하면서 일반적인 명령형식으로 생성
  CREATE TABLE 테이블명
  (
      컬럼명   자료형(크기) [DEFAULT 값] [제약조건들 ]
      , 컬럼명   자료형(크기) [DEFAULT 값] [제약조건들 ]
                     :
  );
2) 서브쿼리(subquery)를 이용한 테이블 생성하는 방법
  ㄱ. 이미 존재하는 테이블이 있고,
  ㄴ. SELECT ~ 서브쿼리를 이용해서
  ㄷ. 새로운 테이블 생성한다.
  ㄹ.  + 기존 테이블의 데이터 자동으로 추가된다. 
       + 하지만) 제약조건은 추가되지 않는다. 
  ㅁ. [형식]     
    CREATE TABLE 테이블명 [컬럼명...]
    AS
       서브쿼리;
       
  예) deptno, dname, empno, ename, hiredate, pay , grade 가진 테이블 생성.
   emp : [deptno], empno, ename, hiredate, pay
   salgrade : grade 
   dept : [deptno], dname
  이미 emp, salgrade 존재 -> 테이블 생성 (  tbl_empgrade )
  
  CREATE TABLE tbl_empgrade
  AS 
    (
      SELECT d.deptno, dname,  empno, ename, hiredate, sal + NVL(comm, 0) pay, grade
      FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
              JOIN dept d ON d.deptno = e.deptno
      );   
   -- Table TBL_EMPGRADE이(가) 생성되었습니다.
   
  SELECT *  
  FROM tbl_empgrade;
  -- 제약조건은 복사되지 않고, 데이터는 복사된다. 
  
  DESC tbl_empgrade;

이름       널? 유형           
-------- -- ------------ 
DEPTNO      NUMBER(2)      dept 동일
DNAME       VARCHAR2(14)   dept 동일
EMPNO       NUMBER(4)      emp 동일  
ENAME       VARCHAR2(10)   emp 동일 
HIREDATE    DATE           emp 동일 
PAY         NUMBER        sal + comm 가공해서 만든 컬럼    시스템이 자동으로 자료형을 부여했다.    
GRADE       NUMBER        salgrade 동일
 
 -- 만약에 기존의 테이블을 이용해서 새로운 테이블을 생성하고자 할 때 
 --                 데이터는 필요없다.   
--  emp -> 구조 그대로 -> tbl_empcopy 테이블로 복사 생성
 CREATE TABLE tbl_emp_copy
 AS
    SELECT * FROM emp
    WHERE 1 = 0; -- 데이터 복사 되지 않는다. 
    
SELECT * FROM     tbl_emp_copy;


  -- 예) emp 테이블의 사원번호,사원명, 입사일자, pay 컬럼만 가지는 테이블 생성
        +  10번 부서원만 데이터로 추가
   --CREATE TABLE tbl_emp10  -- [ 컬럼명, 컬럼명... ]    생략
   CREATE TABLE tbl_emp10  ( eno, name, hdate , pay  )
   AS (
      SELECT empno, ename, hiredate, sal + NVL( comm, 0 )  pay
      FROM emp
      WHERE deptno = 10
   );
   
-- 2:00 오후 수업 시작~~  
-- 간단한 일반적인 방법으로 테이블 생성
-- 서브쿼리를 사용하는 방법으로 테이블 생성 + 데이터 복사
CREATE TABLE tbl_emp_copy
AS 
   SELECT *
   FROM emp
   WHERE 1=0;

--[서브쿼리를 사용하는 INSERT문 ]
-- 오전에 emp 테이블을 데이터 X + 구조만 복사한 테이블 
SELECT *
FROM tbl_emp_copy; -- tbl_empcopy

-- tbl_emp_copy 테이블에 emp 중에 10번 부서원들을 SELECT해서 -> INSERT
-- INSERT INTO 스키마.테이블명 [( 컬럼명...)] VALUES ( 컬럼값...);
-- INSERT INTO 스키마.테이블명  ( 서브쿼리 )

INSERT INTO  tbl_emp_copy 
(
    SELECT *
    FROM emp
    WHERE deptno = 30
);
-- 6개 행 이(가) 삽입되었습니다.
COMMIT;
--
SELECT *
FROM tbl_emp_copy;
--
DROP TABLE tbl_emp_copy PURGE;
-- Table TBL_EMP_COPY이(가) 삭제되었습니다.

-- [ MULTITABLE(다중) INSERT 문 ]
-- 다중INSERT문 이란?  1 레코드 ->INSERT-> 1 테이블  X
         1 레코드 ->INSERT-> 1 테이블
                         -> 1 테이블
                         -> 1 테이블
                         -> 1 테이블
    서브쿼리
    1
    2
    3
  
1) unconditional insert all 
   ( 조건이 없는 다중 INSERT문 )
   ㄴ 조건과 상관없이 기술되어진 여러 개의 테이블에 데이터를 입력한다.
   • 서브쿼리로부터 한번에 하나의 행을 반환받아 각각 insert 절을 수행한다.
   • into 절과 values 절에 기술한 컬럼의 개수와 데이터 타입은 동일해야 한다.

  【형식】
	INSERT ALL | FIRST
	  [INTO 테이블1 VALUES (컬럼1,컬럼2,...)]
	  [INTO 테이블2 VALUES (컬럼1,컬럼2,...)]
	  .......
	Subquery;

  -- 1) INSERT INTO 테이블명 ( 컬럼명,,,) VALUES (값...)
  -- 2) INSERT INTO 테이블명 ( 서브 쿼리 );
  
  예) 
    SELECT *
    FROM emp;
    
    SELECT * FROM tbl_emp_20;
    tbl_emp20
    tbl_emp30
    tbl_emp40
    
    -- 서브쿼리를 사용해서 테이블 4개 생성.
    CREATE TABLE  tbl_emp_10    AS    (        SELECT *        FROM emp  WHERE 1=0   );
    CREATE TABLE  tbl_emp_20    AS    (        SELECT *        FROM emp  WHERE 1=0   );
    CREATE TABLE  tbl_emp_30    AS    (        SELECT *        FROM emp  WHERE 1=0   );
    CREATE TABLE  tbl_emp_40    AS    (        SELECT *        FROM emp  WHERE 1=0   );
   
    -- Unconditional INSERT ALL 문
    --  ALL 또는 FIRST 선택 차이점 ?
    INSERT ALL
       INTO tbl_emp_10 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno )
       INTO tbl_emp20 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno)
       INTO tbl_emp__30 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno)
       INTO tbl_emp_40 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno)
    SELECT *    FROM emp;      
    
    ROLLBACK;   
   
2) conditional  insert all 
   ( 조건이 있는 다중 INSERT문 )
    INSERT ALL
       WHEN deptno = 10 THEN
           INTO tbl_emp_10 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno )
       WHEN deptno = 20 THEN
          INTO tbl_emp_20 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno)
       WHEN deptno = 30 THEN
          INTO tbl_emp_30 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno)
       ELSE
       INTO tbl_emp_40 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno)
    SELECT *    FROM emp;  
   
   SELECT * FROM tbl_emp_10;
   SELECT * FROM tbl_emp_20;
   SELECT * FROM tbl_emp_30;
   SELECT * FROM tbl_emp_40;
   
   --  데이터 삭제
   X  DELETE FROM tbl_emp_10; COMMIT;
   
   -- 테이블 안의 모든 레코드를 삭제 + 자동 커밋/롤백
   TRUNCATE TABLE tbl_emp_10; 
   TRUNCATE TABLE tbl_emp_20; 
   TRUNCATE TABLE tbl_emp_30; 
   TRUNCATE TABLE tbl_emp_40; 
   
   
3) conditional first insert 
   ( 조건이 있는 첫번째 INSERT문)
 【형식】
INSERT FIRST
 WHEN 조건절1 THEN
  INTO [테이블1] VALUES (컬럼1,컬럼2,...)
 WHEN 조건절2 THEN
  INTO [테이블2] VALUES (컬럼1,컬럼2,...)
........
 ELSE
  INTO [테이블3] VALUES (컬럼1,컬럼2,...)
Sub-Query;

• conditional INSERT FIRST는 조건절을 기술하여 조건에 맞는 값들을 원하는 테이블에 삽입할 수 있다.
• 여러 개의 WHEN...THEN절을 사용하여 여러 조건 사용이 가능하다. 단, 첫 번째 WHEN 절에서 조건을 만족한다면, INTO 절을 수행한 후 다음의 WHEN 절들은 더 이상 수행하지 않는다.
• subquery로부터 한 번에 하나씩 행을 리턴 받아 when...then절에서 조건을 체크한 후 조건에 맞는 절에 기술된 테이블에 insert를 수행한다.
• 조건을 기술한 when 절들을 만족하는 행이 없을 경우 else절을 사용하여 into 절을 수행할 수 있다. else절이 없을 경우 리턴 딘 그행에 대해서는 아무런 작업도 발생하지 않는다.
  SELECT * 
  FROM emp
  WHERE deptno = 10 AND job = 'CLERK' ;
  
  --
  --INSERT FIRST
  INSERT ALL
       WHEN deptno = 10 THEN
           INTO tbl_emp_10 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno )
       WHEN job = 'CLERK' THEN
          INTO tbl_emp_20 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno)
       ELSE
          INTO tbl_emp_40 VALUES (  empno, ename, job, mgr, hiredate, sal, comm, deptno)
    SELECT *    FROM emp;  
   
   SELECT * FROM tbl_emp_10; -- MILLER
   SELECT * FROM tbl_emp_20; -- X
   SELECT * FROM tbl_emp_40; 
   
4) pivoting insert 
   피봇  
create table tbl_sales2(
   employee_id       number(6),
   week_id            number(2),
   sales_mon          number(8,2),
   sales_tue          number(8,2),
   sales_wed          number(8,2),
   sales_thu          number(8,2),
   sales_fri          number(8,2)
);
-- Table TBL_SALES2이(가) 생성되었습니다.

insert into TBL_SALES2 values(1101,4,100,150,80,60,120); 
insert into TBL_SALES2 values(1102,5,300,300,230,120,150);
COMMIT;

SELECT * FROM TBL_SALES2;

1101	4	100	150	80	60	120
1102	5	300	300	230	120	150
SELECT * FROM  tbl_sales_data2
ORDER BY employee_id;
--
create table tbl_sales_data2(
   employee_id        number(6),  -- 사원 1101
   week_id            number(2),  -- 주   4
   sales              number(8,2)  --  총판매랑
);
-- UC 다중 INSERT문
insert all
     into tbl_sales_data2 values(employee_id, week_id, sales_mon)
     into tbl_sales_data2 values(employee_id, week_id, sales_tue)
     into tbl_sales_data2 values(employee_id, week_id, sales_wed)
     into tbl_sales_data2 values(employee_id, week_id, sales_thu)
     into tbl_sales_data2 values(employee_id, week_id, sales_fri)
     
     select employee_id, week_id, sales_mon, sales_tue, sales_wed,
            sales_thu, sales_fri
     from tbl_sales2;
COMMIT;

3:05 수업 시작~ 
--------------------------------------------------------------------------------------------------------------------------------
[문제] insa 테이블에서 num, name 컬럼만을 복사해서 새로운 tbl_score 테이블 생성
  ( 조건 : num <=1005 )
-- 기존 테이블을 사용해서 테이블 생성 
CREATE TABLE tbl_score
AS
 SELECT num, name
 FROM insa
 WHERE num  <= 1005;
-- Table TBL_SCORE이(가) 생성되었습니다.
SELECT *
FROM tbl_score;

[문제] tbl_score 테이블에   kor, eng, mat, tot, avg, grade, rank 컬럼 추가.
  국어   NUMBER(3)
  영어
  수학  
  총점               기본값 0 컬럼 추가.  
  평균 
  
  등급(grade)   CHAR(1 CHAR)
  등수(rank)   NUMBER(3)
  -- 기존 테이블에   컬럼 6개 추가. ( 테이블 수정(변경) )
  *** ALTER TABLE  ADD  제약조건, 컬럼 추가
  ALTER TABLE  MODIFY  자료형, 크기, 등등 수정
  ALTER TABLE  DROP 제약조건, 컬럼 삭제
  --
  ALTER TABLE tbl_score
  ADD (
        kor   NUMBER(3) DEFAULT 0
      , eng   NUMBER(3) DEFAULT 0
      , mat   NUMBER(3) DEFAULT 0
      , tot   NUMBER(3) 
      , avg   NUMBER(5,2)
      , grade CHAR(1 CHAR)      -- A B C D F
      , rank  NUMBER(3)
  );
  -- 
  DESC tbl_score;
  
  [문제]  tbl_score 테이블에   num ( 1001~1005 ) 5명의    kor, eng, mat 점수를 임의의 값( 0~100) 수정.
  UPDATE tbl_score
  SET   kor = TRUNC( dbms_random.value(0, 101) )   -- 0<=  정수수  <101              100.8989 -> 반올림 -> NUMBER(3)
      , eng = TRUNC( dbms_random.value(0, 101) )
      , mat = TRUNC( dbms_random.value(0, 101) );
      
  -- SET  ( kor, eng, mat ) = (   SELECT TRUNC( dbms_random.value(0, 101) ),TRUNC( dbms_random.value(0, 101) ),TRUNC( dbms_random.value(0, 101) )  FROM dual )  
  -- WHERE
  --
  COMMIT;
  -- 
  SELECT * 
  FROM tbl_score;

 [문제] 모든 학생들의 총점, 평균 수정...
  UPDATE tbl_score
  SET   tot = kor + eng + mat
       , avg = (kor + eng + mat) / 3;
  -- WHERE

 [문제] 평균은 무조건 소숫점 2자리까지 출력...
 SELECT num, name, kor, eng, mat, tot,  TO_CHAR( avg , '999.00' ) avg   , grade, rank
 FROM tbl_score;
 
 [문제] 등급(grade)   평균 90 이상 A   80점이상 B 70점이상 C   D    F   수정
 UPDATE tbl_score
 SET  grade = CASE
                 WHEN avg >= 90 THEN 'A'
                 WHEN avg >= 80 THEN 'B'
                 WHEN avg >= 70 THEN 'C'
                 WHEN avg >= 60 THEN 'D'
                 ELSE 'F'
              END;
 UPDATE tbl_score
 SET  grade =  DECODE(  TRUNC(avg/10) , 10, 'A', 9, 'A', 8 , 'B', 7, 'C' , 6,'D',    'F'    ) ;
 
  COMMIT;
  -- 4:03 수업 시작~~        

  
[문제] tbl_score 테이블에서 rank 등수 처리. UPDATE
  UPDATE tbl_score  a
  SET rank = (    SELECT COUNT(*) + 1 FROM tbl_score WHERE tot > a.tot   );
  
[문제] 국어가 2개 정답이 없어요..
     모든 학생들의 국어점수를 10점 증가 ....
    53
    55
    85
    96
    22
    
    UPDATE tbl_score
    SET  kor = CASE 
                  WHEN  kor + 10 > 100 THEN 100
                  ELSE  kor + 10
               END     ;
    -- WHERE
   문제점) 한명의 모든학생이 kor 점수가 변경이 되면 총점,평균,등급,등수 전부 새로 수정.. ( 트리거 TRIGGER ) 

  COMMIT;
  -- 
  SELECT * 
  FROM tbl_score;

 [문제] tbl_score 테이블에서 여학생만 수학 점수를 3점 증가시킬께요..       + 수동으로 평,등,등,총 수정...
       ( 조건: insa테이블에  ssn  조인해서 여학생만 골라낼 수 있어요... )
       [수정 전.]
        1001	홍길동	63	98	21	182	60.67	D	2
        1002	이순신	65	10	34	109	36.33	F	5
        1003	이순애	95	14	31	140	46.67	F	4
        1004	김정훈	100	52	82	234	78	C	1
        1005	한석봉	32	30	89	151	50.33	F	3
       [수정 후.]
       
      UPDATE tbl_score
      SET  mat = CASE 
                  WHEN  mat + 3 > 100 THEN 100
                  ELSE  mat + 3
               END 
      WHERE num    = ANY  (         -- ANY       SQL 연산자를 사용해도 된다. 
                      SELECT num
                      FROM insa
                      WHERE MOD( SUBSTR( ssn, -7, 1), 2) = 0 AND num <= 1005
                     );
      -- 상관서브 쿼리.    ***  
        UPDATE tbl_score 
        SET eng = CASE 
                        WHEN  mat + 3 > 100 THEN 100
                        ELSE  mat + 3
                  END
        WHERE num = (
                    SELECT ts.num
                    FROM tbl_score ts,(
                                SELECT num, DECODE (MOD( SUBSTR(ssn, -7,1),2),0,'여자') gender  
                                FROM insa)i
                    WHERE ts.num = i.num AND gender IS NOT NULL
                    ) ;
      -- 
      WHERE  num IN  (
                      SELECT num
                      FROM insa
                      WHERE MOD( SUBSTR( ssn, -7, 1), 2) = 0 AND num <= 1005
                     )   ;  
      
      -- 1003 여학생
       ;

   *** 팀 : 오라클 팀 프로젝트 DB 모델링 ***


-- (월) 병합(MERGE),제약조건, 조인, 계층적 쿼리
-- (화) DB 모델링
-- (수)/(목) DB 모델링, PL/SQL 
-- (금) PL/SQL,   오라클 팀 프로젝트 
-- (토/일/[월~금]/토/일) 
-- (월) 발표..

















