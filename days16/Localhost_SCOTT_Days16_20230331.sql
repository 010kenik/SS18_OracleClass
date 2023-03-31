-- SCOTT --

-- 1) WHILE
DECLARE
  vdan NUMBER(2):=2 ;
  vi NUMBER(2) := 1 ;
BEGIN
   WHILE (vdan <= 9)
   LOOP
      vi  := 1;  -- *****
      WHILE( vi <= 9)
      LOOP
          DBMS_OUTPUT.PUT( vdan || '*' || vi || '=' || RPAD( vdan*vi, 4, ' ' ) );
          vi := vi + 1; -- 10
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('');
      
      vdan := vdan + 1;
   END LOOP; 
--EXCEPTION
END;

-- 2) FOR
DECLARE
  -- vdan NUMBER(1) ;
  -- vi NUMBER(1) ;
BEGIN

   FOR vdan IN 2.. 9
   LOOP 
      FOR vi IN 1.. 9
      LOOP
        -- System.out.printf("format")
        DBMS_OUTPUT.PUT( vdan || '*' || vi || '=' || RPAD( vdan*vi, 4, ' ' ) );
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('');
   END LOOP;

--EXCEPTION
END;

-- 3) LOOP
DECLARE
  vdan NUMBER(1):= 2 ;
  vi NUMBER(1) := 1 ;
BEGIN
 
   LOOP 
      vi := 1;
      LOOP
        DBMS_OUTPUT.PUT( vdan || '*' || vi || '=' || RPAD( vdan*vi, 4, ' ' ) );
        EXIT WHEN vi = 9;
        vi := vi + 1;        
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('');
      EXIT WHEN vdan = 9;
      vdan := vdan + 1;
   END LOOP;

--EXCEPTION
END;

--------------------------------------------------------------------------------------------------------------------------------
미출석 : 김수민, 김예지, 박상범, 이예진, 이혜진, 진예림
--------------------------------------------------------------------------------------------------------------------------------
-- %TYPE형 변수
-- %ROWTYPE형 변수
-- RECORD형 변수

-- [익명 프로시저]
DECLARE
   vdeptno NUMBER(2);
   vdname  dept.dname%TYPE;
   vempno  emp.empno%TYPE;
   vename  emp.ename%TYPE;
   vpay   NUMBER;
BEGIN
  SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay 
       INTO vdeptno, vdname, vempno, vename, vpay
  FROM dept d JOIN emp e ON d.deptno = e.deptno
  WHERE empno = 7369;
  
  DBMS_OUTPUT.PUT_LINE( vdeptno || ', ' || vdname  
    || ', ' ||  vempno  || ', ' || vename  || ', ' ||  vpay );
--EXCEPTION
END;

-- [익명 프로시저]    %ROWTYPE형 변수
DECLARE
   vdrow dept%ROWTYPE; -- %ROWTYPE형 변수
   verow emp%ROWTYPE;
   vpay   NUMBER;
BEGIN
  SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay 
       INTO vdrow.deptno, vdrow.dname, verow.empno, verow.ename, vpay
  FROM dept d JOIN emp e ON d.deptno = e.deptno
  WHERE empno = 7369;
  
   DBMS_OUTPUT.PUT_LINE( vdrow.deptno || ', ' || vdrow.dname  
    || ', ' ||  verow.empno  || ', ' || verow.ename  || ', ' ||  vpay );
--EXCEPTION
END;


-- [익명 프로시저]   RECORD형 변수  
DECLARE
   
   -- 사용자 정의 구조체(자료형,타입) 선언
    TYPE EmpDeptType IS RECORD 
    ( 
       deptno NUMBER(2),
       dname  dept.dname%TYPE,
       empno  emp.empno%TYPE,
       ename  emp.ename%TYPE,
       pay   NUMBER
    );
      
    vedrow   EmpDeptType;    
BEGIN
  SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay 
       INTo vedrow.deptno, vedrow.dname, vedrow.empno, vedrow.ename  , vedrow.pay
  FROM dept d JOIN emp e ON d.deptno = e.deptno
  WHERE empno = 7369;
  
    DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname  
    || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  || ', ' ||  vedrow.pay );
--EXCEPTION
END;

-- [익명 프로시저]   
-- 01422. 00000 -  "exact fetch returns more than requested number of rows"
-- PL/SQL : 여러 행의 레코드를 처리(가져오기)할 때는 반드시 "커서(CURSOR)"를 사용한다.
DECLARE 
   -- 사용자 정의 구조체(자료형,타입) 선언
    TYPE EmpDeptType IS RECORD 
    ( 
       deptno NUMBER(2),
       dname  dept.dname%TYPE,
       empno  emp.empno%TYPE,
       ename  emp.ename%TYPE,
       pay   NUMBER
    );
      
    vedrow   EmpDeptType;    
BEGIN
  SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay 
       INTo vedrow.deptno, vedrow.dname, vedrow.empno, vedrow.ename  , vedrow.pay
  FROM dept d JOIN emp e ON d.deptno = e.deptno;
  
    DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname  
    || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  || ', ' ||  vedrow.pay );
--EXCEPTION
END;

-- 커서(CURSOR) --
1. CURSOR란? 
    PL/SQL 블럭 내에서 실행되는 SELECT 문을 의미한다.
2. 오라클에서는 하나의 레코드가 아닌
   여러 레코드로 구성된 작업영역에서 SQL문을 실행하고 
   그 과정에 생긴 정보를 저장하기 위해서 CURSOR를 사용한다. 
3. 커서 2가지 종류
  1) implicit cursor (묵시적)  == (자동)  ==  SELECT 결과 1개 ROW
  2) explicit cursor (명시적)  == SELECT   결과 여러 개의 ROW
     ㄱ. 명시적 커서를 사용하는 순서..
         (1) CURSOR 선언 ⇒   실행하려는 SELECT 문을 작성
         (2) OPEN ⇒          SELECT문의           실행 
         (3) FETCH ( 가져오다 ) ⇒   LOOP...END LOOP  한개씩 행(ROW) 처리
         (4) CLOSE            SELECT 문의 선언을    종료 
4. 커서의 속성     
  1)%ROWCOUNT :  커서를 사용해서 읽힌 행의 수
  2)%FOUND    :  커서에 검색된 행이 있는지 유무
  3)%NOTFOUND    :  커서에 검색된 행이 없는지 유무
  4)%ISOPEN    : 커서 현재 OPEN 상태 반환 t/f

-- 1번째 형식
DECLARE 
   -- 사용자 정의 구조체(자료형,타입) 선언
    TYPE EmpDeptType IS RECORD 
    ( 
       deptno NUMBER(2),
       dname  dept.dname%TYPE,
       empno  emp.empno%TYPE,
       ename  emp.ename%TYPE,
       pay   NUMBER
    );
      
    vedrow   EmpDeptType;    
    
    -- 1) 커서 선언
    -- 형식) CURSOR [커서명] IS [SELECT절];
    CURSOR edcursor IS (
            SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay 
            FROM dept d JOIN emp e ON d.deptno = e.deptno
                );
    
BEGIN
    -- 2) 커서 실행 OPEN
    -- 형식) OPEN [커서명];
    OPEN edcursor;
  
   
    -- 3) 반복문을 사용해서  FETCH 
    LOOP
         FETCH edcursor  INTO vedrow;
    
        DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname  
        || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  || ', ' ||  vedrow.pay );
        
      EXIT WHEN edcursor%NOTFOUND;
    END LOOP;

    --4) 커서 종료 CLOSE
    -- 형식) CLOSE [커서명];
    CLOSE edcursor;
    
--EXCEPTION
END;

-- 2번째 형식 ( FOR 수정) 
DECLARE  
    TYPE EmpDeptType IS RECORD 
    ( 
       deptno NUMBER(2),
       dname  dept.dname%TYPE,
       empno  emp.empno%TYPE,
       ename  emp.ename%TYPE,
       pay   NUMBER
    ); 
    vedrow   EmpDeptType;   
    CURSOR edcursor IS (
            SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay 
            FROM dept d JOIN emp e ON d.deptno = e.deptno
                ); 
BEGIN 
    -- 10:12 수업 시작
    -- FOR  vedrow IN  [REVERSE]  시작값.. 끝값
    FOR  vedrow IN  edcursor
    LOOP
      DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname  
        || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  || ', ' ||  vedrow.pay );
    END LOOP;
    
--EXCEPTION
END;

-- 2-2번째 형식 ( FOR 수정) 
DECLARE  
    -- FOR 에서 사용되는 반복변수(vedrow)는 선언하지 않아도 된다.
    CURSOR edcursor IS (
            SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay 
            FROM dept d JOIN emp e ON d.deptno = e.deptno
                ); 
BEGIN  
    FOR  vedrow IN  edcursor
    LOOP
      EXIT WHEN  edcursor%ROWCOUNT > 5 OR edcursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname  
        || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  || ', ' ||  vedrow.pay );
    END LOOP;
    
--EXCEPTION
END;

-- PL/SQL 6가지 종류 중에 가장 대표적인 .. STORED PROCEDURE(저장 프로시저)
 1) PL/SQL 언어 중에서 가장 대표적인 구조.
 2) 개발자가 [자주 실행]해야 하는 업무 흐름을 이 문법에 의해 [미리 작성]하여 
    데이터베이스 내에 저장해 두었다가 필요할 때마다 [호출하여 실행]할 수 있다.
    SQL 쿼리 실행 처리 과정 :  [ 구문검색(파싱) -> 실행 계획 -> 메모리상 컴파일 저장 ] -> 실행
 3) 형식
    CREATE [OR REPLACE] PROCEDURE [프로시저이름]
     (argument1 [mode] data_type1,
      argument2 [mode] data_type2,
         ...............
      IS [AS]
      BEGIN
        ......
      EXCEPTION
        ......
      END;

    DROP PROCEDURE [프로시져이름];
  4) 저장 프로시저를 실행하는 3가지 방법
     (1) EXECUTE 문
     (2) anonymous procedure에서 호출에 의한 실행
     (3) 또 다른  stored procedure에서 호출에 의한 실행 
  
  실습)    개발자가 [자주 실행]해야 하는 업무    ?  
      사원번호를 입력받아서 emp 테이블에서 그 해당 사원을 삭제하는 쿼리 자주 사용 한다. 
      -- 
      CREATE TABLE tbl_emp
      AS
         (SELECT * FROM emp );
      --
      SELECT * 
      FROM tbl_emp
      WHERE deptno = ??;
      -- 저장 프로시저
      CREATE PROCEDURE up_delEmp
      (
         -- 파라미터(매개변수, 인자, ) 선언   p 접두사
         -- IN 입력용 파라미터 ( 생략 )
         -- OUT 출력용 파라미터
         -- IN OUT 입,출력용 파라미터
         
         -- 자료형 크기 안붙인다.
         -- 콤마 구분자로 구분한다. 
         -- pempno IN  NUMBER
         pempno IN  emp.empno%TYPE
      )
      IS
         -- 변수선언 DECLARE      v 접두사
      BEGIN 
         DELETE FROM emp
         WHERE empno = pempno;
         COMMIT;
      -- EXCEPTION 
      END;
         
   -- Procedure UP_DELEMP이(가) 컴파일되었습니다.

   실습)저장 프로시저를 실행하는 3가지 방법
     (1) EXECUTE 문
        
        EXECUTE UP_DELEMP( 7369 );
        
        SELECT *
        FROM Emp;
     
     (2) anonymous procedure에서 호출에 의한 실행
     
     DECLARE
     BEGIN
        UP_DELEMP( 7654 );
     -- EXCEPTION
     END;
     
     (3) 또 다른  stored procedure에서 호출에 의한 실행 

 
       CREATE PROCEDURE up_delEmp_test 
       IS         
       BEGIN 
             UP_DELEMP( 7698 );
          -- EXCEPTION 
       END;
-- Procedure UP_DELEMP_TEST이(가) 컴파일되었습니다.

      EXEC UP_DELEMP_TEST;

--------------------------------------------------------------------------------------------------------------------------------
 SELECT * 
 FROM tbl_dept;
[문제1] tbl_dept 테이블에 새로운 부서를 추가하는 저장 프로시저 생성 + 테스트 ( UP_INSDEPT )
   1) 새로 추가되는 부서의 deptno 
   SELECT  MAX( deptno ) + 10
   FROM tbl_dept;
   2) 
   INSERT INTO tbl_deptno ( deptno, dname, loc ) VALUES ( ??, ??, ?? );
   INSERT INTO tbl_deptno ( deptno, loc ) VALUES ( ??,  ?? );
   INSERT INTO tbl_deptno ( deptno, dname  ) VALUES ( ??, ??  );
   
   11:00 수업시작~ 
   -- UP_INSDEPT
   
   CREATE OR REPLACE PROCEDURE UP_INSDEPT
   (
      pdname tbl_dept.dname%TYPE := NULL
      , ploc   tbl_dept.loc%TYPE  DEFAULT NULL
   )
   IS
      -- vdeptno tbl_dept.deptno%TYPE;
   BEGIN
       /*
       SELECT  MAX( deptno ) + 10  INTO vdeptno
       FROM tbl_dept;   
       INSERT INTO tbl_dept ( deptno, dname, loc ) VALUES ( vdeptno , pdname, ploc );
       */
       
       INSERT INTO tbl_dept ( deptno, dname, loc ) 
       VALUES (  SEQ_TBLDEPT_DEPTNO.NEXTVAL  , pdname, ploc );
       
      COMMIT;
   --EXCEPTION
   END;
   
   -- Procedure UP_INSDEPT이(가) 컴파일되었습니다.
   
   EXEC UP_INSDEPT('QC', 'SEOUL');
   EXEC UP_INSDEPT(ploc =>'SEOUL', pdname =>'QC');
   EXEC UP_INSDEPT( pdname => 'QC2');    -- 부서명 QC2
   EXEC UP_INSDEPT( ploc => 'POHANG'); -- 지역명 포항
  
  SELECT * FROM tbl_dept;

[문제2] tbl_dept 테이블에 부서를 수정하는  저장 프로시저 생성 + 테스트 ( UP_UPDDEPT)
   50	QC	SEOUL  -> 부서명, 지역명 모두 수정
                   -> 부서명만 수정 + 원래 지역명은 그대로 유지
                   -> 지역명만 수정 + 원래 부서명은 그대로 유지
    -- 
    CREATE OR REPLACE PROCEDURE UP_UPDDEPT
    (  
        pdeptno IN tbl_dept.deptno%TYPE
      , pdname  IN tbl_dept.dname%TYPE := NULL
      , ploc    IN tbl_dept.loc%TYPE  DEFAULT NULL
    )
    IS
      vdname  IN tbl_dept.dname%TYPE ;
      vloc    IN tbl_dept.loc%TYPE  ;
    BEGIN
       -- 수정 전의 원래 부서명, 지역명을 변수에 저장.
       SELECT dname, loc  INTO vdname, vloc
       FROM tbl_dept
       WHERE deptno = pdeptno;
       
       IF pdname IS NULL THEN  -- 지역만 수정
          UPDATE tbl_dept
          SET dname = vdname, loc = ploc
          WHERE deptno = pdeptno; 
       ELSIF ploc IS NULL  THEN -- 부서명만 수정
          UPDATE tbl_dept
          SET dname = pdname, loc = vloc
          WHERE deptno = pdeptno;
       ELSE   -- 부서명, 지역명 모두 수정
          UPDATE tbl_dept
          SET dname = pdname, loc = ploc
          WHERE deptno = pdeptno;
       END IF; 
       
       
       -- COMMIT;
    -- EXCEPTION
    END;
    
    --  12:05 수업 시작~ 
    CREATE OR REPLACE PROCEDURE UP_UPDDEPT
    (  
        pdeptno IN tbl_dept.deptno%TYPE
      , pdname  IN tbl_dept.dname%TYPE := NULL
      , ploc    IN tbl_dept.loc%TYPE  DEFAULT NULL
    )
    IS       
    BEGIN        
          UPDATE tbl_dept
          SET dname = NVL(pdname, dname) 
              , loc = CASE 
                             WHEN ploc IS NULL THEN loc
                             ELSE ploc
                      END
          WHERE deptno = pdeptno;       
          COMMIT;
    -- EXCEPTION
    END;
    
    ROLLBACK;
    SELECT *
    FROM tbl_dept;
    
    EXEC UP_UPDDEPT( 50, 'XX', 'YY' );
    EXEC UP_UPDDEPT( pdeptno => 50, pdname => 'XX' );
    EXEC UP_UPDDEPT( pdeptno => 50, ploc => 'YY' ); 

[문제3] tbl_dept 테이블에 부서를 삭제하는  저장 프로시저 생성 + 테스트 ( UP_DELDEPT )
        ( 파라미터로 삭제할 부서번호 : 10/50 )
   CREATE OR REPLACE PROCEDURE  UP_DELDEPT
   (
      pdeptno tbl_dept.deptno%TYPE
   )
   IS
   BEGIN
      DELETE FROM tbl_dept
      WHERE deptno = pdeptno;
      
      COMMIT;
   -- EXCEPTION
   END;
  
   -- Procedure UP_DELDEPT이(가) 컴파일되었습니다.
   
   EXEC UP_DELDEPT( 70 );
   EXEC UP_DELDEPT( 80 );
 
   SELECT *
   FROM tbl_dept;

[문제4] tbl_dept 테이블에 부서를 조회하는  저장 프로시저 생성 + 테스트  ( UP_SELDEPT )
  SELECT *
  FROM tbl_dept;
  ( 커서를 사용해서 UP_SELDEPT 안에서 출력하는 작업 )
  
  12:17 풀이~ 
  1) 묵시적 커서
  2) 명시적 커서
     커서 선언   - 작성  
     커서 OPEN   - 실행
     LOOP FETCH  - 처리
     커서 CLOSE   - 종료
   --
   CREATE OR REPLACE PROCEDURE  UP_SELDEPT
   IS
      CURSOR vcursor IS ( 
                        SELECT *
                        FROM tbl_dept
                      );
      vrow tbl_dept%ROWTYPE;                
   BEGIN
     OPEN vcursor;     
     LOOP
        FETCH   vcursor  INTO vrow;
        EXIT WHEN  vcursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(  vrow.deptno || ', ' || vrow.dname || ', ' || vrow.loc );
     END LOOP;     
     CLOSE vcursor;
   --EXCEPTION
   END;
-- Procedure UP_SELDEPT이(가) 컴파일되었습니다.

  EXEC UP_SELDEPT;

 -- 묵시적 커서
   CREATE OR REPLACE PROCEDURE  UP_SELDEPT
   IS      
   BEGIN
     FOR vrow IN    ( 
                        SELECT *
                        FROM tbl_dept
                      )
     LOOP        
        DBMS_OUTPUT.PUT_LINE(  vrow.deptno || ', ' || vrow.dname || ', ' || vrow.loc );
     END LOOP;     
     
   --EXCEPTION
   END;

--------------------------------------------------------------------------------------------------------------------------------
-- 입력용 파라미터만 사용 IN
-- 출력용 파라미터도 사용 OUT
--------------------------------------------------------------------------------------------------------------------------------
[문제] 주민등록번호를 입력용 매개변수로 저장프로시저를 호출한다.
       출력용 매개변수로   123456-******* 담아서 ........

CREATE OR REPLACE PROCEDURE up_insarrn
(
    pnum  IN insa.num%TYPE
    , pcrrn OUT VARCHAR2
)
IS
   vssn insa.ssn%TYPE;
BEGIN
   SELECT ssn INTO vssn
   FROM insa
   WHERE num = pnum;   
   pcrrn :=  CONCAT(  SUBSTR( vssn, 1, 6 ) , '-*******');
-- EXCEPTION
END;

-- Procedure UP_INSARRN이(가) 컴파일되었습니다.
-- 출력용 매개변수 익명프로시저 테스트  ----
DECLARE
    vcrrn VARCHAR2(14);
BEGIN
    UP_INSARRN( 1001, vcrrn );    
    DBMS_OUTPUT.PUT_LINE(   vcrrn );
END;
----------------------------------------
SELECT *
FROM insa;

-- 2:00 풀이~~~
-- [문제] tbl_score 테이블에   번호/이름/국어/영어/수학 을 파라미터로
--       UP_INSTBLSCORE 프로시저를 호출하면  총점,평균, 등급, 등수 처리해서 INSERT
SELECT *
FROM tbl_score;

--
CREATE OR REPLACE PROCEDURE UP_INSTBLSCORE
(
     pnum  IN  tbl_score.num%TYPE
   , pname IN  tbl_score.name%TYPE
   , pkor  IN  tbl_score.kor%TYPE
   , peng  IN  tbl_score.eng%TYPE
   , pmat  IN  tbl_score.mat%TYPE
)
IS 
   vtot tbl_score.tot%TYPE := 0;    
   vavg tbl_score.avg%TYPE ;
   vgrade tbl_score.grade%TYPE;
BEGIN
   vtot := pkor + peng + pmat;
   vavg := vtot / 3 ;
   
   IF vavg >= 90 THEN  
      vgrade := 'A';
   ELSIF vavg >= 80 THEN
      vgrade := 'B';
    ELSIF vavg >=70 THEN
      vgrade := 'C';
   ELSIF vavg >=60 THEN
      vgrade := 'D';
   ELSE
      vgrade := 'F';   
   END IF;
  
   INSERT INTO tbl_score  ( num, name, kor, eng, mat      , tot, avg, grade, rank )
   VALUES                  (pnum, pname, pkor, peng, pmat , vtot,vavg, vgrade, 1 );
   
   -- 모든 학생의 등수를 수정
   UPDATE tbl_score a
   SET rank = (  SELECT COUNT(*)+1 FROM tbl_score b WHERE  b.tot > a.tot   );
   
   COMMIT;
--EXCEPTION
END;

-- Procedure UP_INSTBLSCORE이(가) 컴파일되었습니다

1001	홍길동	63	98	21	182	60.67	D	2
1002	이순신	65	10	34	109	36.33	F	5
1003	이순애	95	14	34	143	47.67	F	4
1004	김정훈	100	52	82	234	 78	    C	1
1005	한석봉	32	30	89	151	50.33	F	3

EXEC UP_INSTBLSCORE( 1006, '윤재민', 89, 77, 76 );
EXEC UP_INSTBLSCORE( 1007, '홍성철', 23, 44, 75 );

SELECT *
FROM tbl_score;

[문제] 학생성적 정보를 수정하는 저장 프로시저  :  UP_UDPTBLSCORE

EXEC UP_UDPTBLSCORE( 1006, 34, 45, 90 );
EXEC UP_UDPTBLSCORE( 1006, pkor =>34 );
EXEC UP_UDPTBLSCORE( 1006, pkor =>34, pmat => 90 );
EXEC UP_UDPTBLSCORE( 1006, peng =>45, pmat => 90 );

2:27 풀이~
--
CREATE OR REPLACE PROCEDURE UP_UDPTBLSCORE
(
     pnum  IN  tbl_score.num%TYPE
   , pkor  IN  tbl_score.kor%TYPE  := NULL
   , peng  IN  tbl_score.eng%TYPE  := NULL
   , pmat  IN  tbl_score.mat%TYPE  := NULL
)
IS 
   vtot tbl_score.tot%TYPE := 0;    
   vavg tbl_score.avg%TYPE ;
   vgrade tbl_score.grade%TYPE;
   
   vkor   tbl_score.kor%TYPE ;
   veng    tbl_score.eng%TYPE ;
   vmat    tbl_score.mat%TYPE ;
BEGIN
    SELECT kor, eng, mat  INTO  vkor, veng, vmat
    FROM tbl_score
    WHERE num = pnum;

   vtot := NVL( pkor, vkor) + NVL(peng, veng) + NVL( pmat, vmat);
   vavg := vtot / 3 ;
   
   IF vavg >= 90 THEN  
      vgrade := 'A';
   ELSIF vavg >= 80 THEN
      vgrade := 'B';
    ELSIF vavg >=70 THEN
      vgrade := 'C';
   ELSIF vavg >=60 THEN
      vgrade := 'D';
   ELSE
      vgrade := 'F';   
   END IF;
  
   UPDATE tbl_score
   SET    kor = NVL( pkor, vkor)
        , eng = NVL(peng, veng)
        , mat = NVL( pmat, vmat)
       , tot = vtot
       , avg = vavg
       , grade=vgrade
   WHERE num = pnum; 
   
   -- 모든 학생의 등수를 수정
   UPDATE tbl_score a
   SET rank = (  SELECT COUNT(*)+1 FROM tbl_score b WHERE  b.tot > a.tot   );
   
   COMMIT;
--EXCEPTION
END;

-- Procedure UP_UDPTBLSCORE이(가) 컴파일되었습니다.


2:45 풀이~
[문제] 학생 정보를 삭제하는 저장 프로시저  :  UP_DELTBLSCORE

SELECT * 
FROM tbl_score;

EXEC UP_DELTBLSCORE( 1006 );
  1006 학생 삭제 되고, 나머지 학생들의 등수는 변경
  
CREATE OR REPLACE PROCEDURE UP_DELTBLSCORE
(
     pnum  IN  tbl_score.num%TYPE
)
IS   
BEGIN
   DELETE FROM tbl_score 
   WHERE num = pnum; 
   
   -- 모든 학생의 등수를 수정
   UPDATE tbl_score a
   SET rank = (  SELECT COUNT(*)+1 FROM tbl_score b WHERE  b.tot > a.tot   );
   
   COMMIT;
--EXCEPTION
END;

3:06 풀이 수업시작~
-- [문제] tbl_score 테이블의 모든 학생 정보를 조회-> DBMS_OUTPUT 출력하는 프로시저 생성
   ( UP_SELTBLSCORE )
   조건: 명시적 커서 사용해서   1) 2) 3) 4)
CREATE OR REPLACE PROCEDURE  UP_SELTBLSCORE
   IS
      CURSOR vcursor IS ( 
                        SELECT *
                        FROM tbl_score
                      );
      vrow tbl_score%ROWTYPE;                
BEGIN
     OPEN vcursor;     
     LOOP
        FETCH   vcursor  INTO vrow;
        EXIT WHEN  vcursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(  
           vrow.num || ', ' || vrow.name || ', ' || vrow.kor
           || vrow.eng || ', ' || vrow.mat || ', ' || vrow.tot
           || vrow.avg || ', ' || vrow.grade || ', ' || vrow.rank
        );
     END LOOP;     
     CLOSE vcursor;
--EXCEPTION
END;   

EXEC UP_SELTBLSCORE;

-- PL/SQL 1 종류 : 익명 프로시저( Anonymous Procedure )
-- PL/SQL 2 종류 : 저장 프로시저( Stored Procedure )
-- PL/SQL 3 종류 : 저장 함수( Stored Function )
   ㄴ 차이점 : 저장 함수는 리턴값이 있고, 저장 프로시저는 리턴값이 없다. 
   ㄴ 형식
   CREATE OR REPLACE FUNCTION UF_함수명
   ()
   RETURN 리턴자료형
   IS
   BEGIN
      
      RETURN ( 리턴값 );
      -- RETURN  리턴값 ;
   EXCEPTION
   END;
   
   문제) 남자/여자 리턴하는 저장함수 선언해서 UF_GENDER
   CREATE OR REPLACE FUNCTION UF_GENDER
   ( 
       prrn VARCHAR2
   )
   RETURN VARCHAR2  -- '남자' '여자'
   IS
     vgender VARCHAR2(6) ;
   BEGIN
      
      IF  MOD( SUBSTR( prrn , -7, 1) , 2 ) = 1 THEN
         vgender := '남자';
      ELSE
         vgender := '여자';
      END IF;
      
      RETURN vgender ;
      -- RETURN  (리턴값) ;
   -- EXCEPTION
   END;
--  Function UF_GENDER이(가) 컴파일되었습니다.  

   실습)
   SELECT num , name, ssn 
       , SCOTT.UF_GENDER( ssn )
   FROM insa;
   
  문제)  주민등록번호를 넣어주면 만나이를 계산하는 쿼리 작성.
  
  [ days09.SCOTT.sql  문제 5번 ]
   ------------------------------------------
SELECT t.name, t.ssn
     , ㄱ - ㄴ + 1 counting_age
     , ㄱ - ㄴ + DECODE( ㄷ, -1, -1, 0 ) american_age
FROM (
SELECT name, ssn
     , TO_CHAR( SYSDATE, 'YYYY' ) ㄱ
--   , TO_CHAR( TO_DATE( SUBSTR( ssn, 0, 2 ), 'RR' ), 'YYYY' ) ㄴ
     , SUBSTR( ssn, 0, 2 ) + CASE
        WHEN SUBSTR( ssn, -7, 1 ) IN (1,2,5,6) THEN 1900
        WHEN SUBSTR( ssn, -7, 1 ) IN (3,4,7,8) THEN 2000
        WHEN SUBSTR( ssn, -7, 1 ) IN (9,0) THEN 1800
       END ㄴ
     , SIGN( TO_CHAR( SYSDATE, 'MMDD' ) - SUBSTR( ssn, 3, 4 ) ) ㄷ
FROM insa
    ) t;
    ------------------------------------------
    -- 1 세는나이
    -- 0 만나이 
    CREATE OR REPLACE FUNCTION UF_AGE
   ( 
       prrn VARCHAR2
       , ca NUMBER
   )
   RETURN NUMBER
   IS
     ㄱ NUMBER(4); -- 올해 년도 2023
     ㄴ NUMBER(4); -- 생일 년도
     ㄷ NUMBER(1); -- 생일 지남 여부 -1 0 1 
     vcounting_age NUMBER(3);
     vamerican_age NUMBER(3);
   BEGIN     
      ㄱ := TO_CHAR( SYSDATE, 'YYYY' ); 
      ㄴ := SUBSTR( prrn, 0, 2 ) + CASE
                                    WHEN SUBSTR( prrn, -7, 1 ) IN (1,2,5,6) THEN 1900
                                    WHEN SUBSTR( prrn, -7, 1 ) IN (3,4,7,8) THEN 2000
                                    WHEN SUBSTR( prrn, -7, 1 ) IN (9,0) THEN 1800
                                   END;
      ㄷ := SIGN( TO_CHAR( SYSDATE, 'MMDD' ) - SUBSTR( prrn, 3, 4 ) );
      
      vcounting_age :=  ㄱ - ㄴ + 1 ;
      -- 오류(95,36): PLS-00204: function or pseudo-column 'DECODE' may be used inside a SQL statement only
      -- vamerican_age := ㄱ - ㄴ + DECODE( ㄷ, -1, -1, 0 ) ;  -- PL/SQL에서는 사용할 수 없다.
      vamerican_age := ㄱ - ㄴ + CASE  ㄷ
                                     WHEN -1 THEN -1  
                                     ELSE 0
                                 END;  
      
      IF ca = 1 THEN
         RETURN vcounting_age;
      ELSE
         RETURN vamerican_age;
      END IF;   
   -- EXCEPTION
   END;
    
  실습)
   SELECT num , name, ssn 
       , SCOTT.UF_GENDER( ssn )
       , SCOTT.UF_AGE( ssn, 1) 세는나이
       , SCOTT.UF_AGE( ssn, 0) 만나이
   FROM insa;

-- 4:00 수업시작
[문제] UF_BIRTH
  주민등록번호를 매개변수로   '1980.01.20(화)' 생일을 반환하는 함수 UF_BIRTH 구현해서 테스트.

CREATE OR REPLACE FUNCTION UF_BIRTH
(
   prrn VARCHAR2
)
RETURN VARCHAR2
IS
   vbirth VARCHAR2(20);
   vcentry NUMBER(2);  -- 19, 20, 18
BEGIN
   vbirth := SUBSTR( prrn, 1, 6 );   --  '19771005'
   vcentry :=  CASE
                WHEN SUBSTR( prrn, -7, 1 ) IN (1,2,5,6) THEN 19
                WHEN SUBSTR( prrn, -7, 1 ) IN (3,4,7,8) THEN 20
                WHEN SUBSTR( prrn, -7, 1 ) IN (9,0) THEN 18
               END;
   vbirth := vcentry || vbirth;  --  '19771005'
   -- '1980.01.20(화)'
   vbirth := TO_CHAR( TO_DATE( vbirth, 'YYYYMMDD' ), 'YYYY.MM.DD(DY)');
   RETURN vbirth;
-- EXCEPTION
END;
  
--   Function UF_BIRTH이(가) 컴파일되었습니다.
SELECT name, ssn, SCOTT.UF_BIRTH( ssn )
FROM insa;
홍길동	771005-1022432	1977.10.05(수)
이순신	800320-1544236	1980.03.20(목)
이순애	770922-2312547	1977.09.22(목)

-- [ IN, OUT,  [IN OUT] 매개변수 사용 예제 ]
--- 저장 프로시저 생성 (주민등록번호 14자리 -> 주민등록번호 6자리만 출력)
CREATE OR REPLACE PROCEDURE up_rrn
(
   prrn14 IN VARCHAR2
   ,prrn6 OUT VARCHAR2 
)
IS
BEGIN  
    prrn6 :=  SUBSTR( prrn14, 0, 6 );
--EXCEPTION
END;
-- Procedure UP_RRN이(가) 컴파일되었습니다.

DECLARE
  vrrn14 VARCHAR2(14) := '771005-1022432';
  vrrn6 VARCHAR2(6);
BEGIN
   UP_RRN( vrrn14, vrrn6 ); 
   DBMS_OUTPUT.PUT_LINE( vrrn6 );
END;

-- [ IN, OUT,  [IN OUT] 매개변수 사용 예제 ]
--- 저장 프로시저 생성 (주민등록번호 14자리 -> 주민등록번호 6자리만 출력)
CREATE OR REPLACE PROCEDURE up_rrn
(
   prrn IN OUT VARCHAR2 -- 입출력용 매개변수로 선언.
)
IS
BEGIN  
    prrn :=  SUBSTR( prrn, 0, 6 );
--EXCEPTION
END;
-- Procedure UP_RRN이(가) 컴파일되었습니다.

DECLARE
  vrrn VARCHAR2(14) := '771005-1022432'; 
BEGIN
   UP_RRN( vrrn ); 
   DBMS_OUTPUT.PUT_LINE( vrrn );
END;

--------------------------------------------------------------------------------------------------------------------------------
-- 시퀀스( SEQUENCE )
--------------------------------------------------------------------------------------------------------------------------------
 1) 시퀀스? 은행 번호표 뽑는 기계(기기)
 2) DB모델링   많은 테이블들이 PK로 1,2,3,4,5 순번(seq)을 
 3) 하나의 시퀀스로 여러 테이블에서 사용가능합니다. 
    시퀀스.NEXTVAL  의사컬럼
    시퀀스.CURRVAL  의사컬럼

 CREATE SEQUENCE 
 ALTER  SEQUENCE 
 DROP   SEQUENCE 

  4) 시퀀스 조회
  SELECT * 
  FROM user_sequences;
  FROM user_constraints;
  FROM user_tables;  == tabs
  
  

SELECT *
FROM tbl_dept;
형식】
	CREATE SEQUENCE 시퀀스명
	[ INCREMENT BY 정수] 10 얼마씩 증가 ,  부서번호   10씩 증가
	[ START WITH 정수]  70
	[ MAXVALUE n ¦ NOMAXVALUE]  100
	[ MINVALUE n ¦ NOMINVALUE]
	[ CYCLE ¦ NOCYCLE]
	[ CACHE n ¦ NOCACHE];


CREATE SEQUENCE seq_tbldept_deptno      
	  INCREMENT BY 10   -- 1 씩 증가
	  START WITH 70     -- 1 부터시작
	   MAXVALUE  90     -- 999999999999999
       NOCYCLE 
       NOCACHE;
-- Sequence SEQ_TBLDEPT_DEPTNO이(가) 생성되었습니다.       

-- 월 : 트리거 (오전) ***
-- 화 : 동적쿼리  ***
-- 수 : 뷰, 
-- 목 : 암호화
-- 금 : 

5시    1조 팀장 소모임
       2조   "
       3조   "
















