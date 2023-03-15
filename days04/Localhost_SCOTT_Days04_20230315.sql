-- SCOTT --
--9:50~10:00 쉬는 시간
--10:30 제출해 주세요 
SELECT *
FROM tabs;
--------------------------------------------------------------------------------
-- 복습 문제 풀이 --
--------------------------------------------------------------------------------
 * 서브쿼리(subquery) ?  쿼리(sql) 속에 쿼리
   쿼리가 또다른 SQL 문으로 nested된 것을 subquery라 한다.
   즉 SQL 문 속에 또 다른 SQL문이 넣어져 있는 경우이다
  * main(parent) query
    sub(child) query
    (1) main query와 sub query 가 관계가 없는 경우
    (2)              "                  있는 경우 - [상관 서브 쿼리(correlated subquery)]
  * 종류
    (1) 일반 서브쿼리
    (2) 인라인 뷰    - FROM 절 + 서브쿼리
    (3) 중첩(NESTED) 서브쿼리 - WHERE 절  + 서브쿼리
  
1. 인라인뷰(inline view)에 대해서 설명하세요.
   - subquery 뒤에는 반드시 alias를 준다. ( 조인할 경우 )
   - FROM절에 위치한 subquery는 하나의 테이블처럼 사용된다.
   
2. WITH 절에 대해서 설명하세요.
    • 자주 사용되는 query를 사용하기 전에 with 절로 미리 query block으로 정의한 후 사용한다.
    • 서브쿼리문에서 sub query에 의해 실행된 결과에 의해 main query가 실행되기 때문에 서브쿼리문은 성능이 저하된다.
    • With 절을 통해 서브쿼리를 보다 쉽고 간편하게 사용할 수 있게 한다.
    • WITH 절은 여러 개의 sub query가 하나의 main query에서 사용될 때 생기는 복잡성을 보다 간결하게 정의하여 사용함으로써 서브쿼리에서 발생할 수 있는 성능저하 현상을 방지할 수 있다.
    • 먼저, 하나의 main query에 정의될 sub query를 with 절과 함께 선언하고, 각각의 sub query가 정의될 때 sub query를 대신할 인라인 뷰의 이름을 사용자가 적절히 정의한다. 여러 개의 sub query가 사용된다면 순서대로 선언하면 된다.
    • sub query의 선언이 끝나면, 실제로 실행될 main query절을 작성하는데, 필요한 sub query는 인라인 뷰의 이름으로 새로운 sub query를 작성하여 사용한다. 
    【형식】
        WITH  query1이름 AS (subquery1),
              query2이름 AS (subquery2), ...
    
    •• with절 속에 반드시 select 문이 있어야 함
    •• query명과 기존의 테이블명이 동일하게 사용되는 경우, 쿼리 블럭명이 우선함
    •• 하나의 with절에 여러 개의 query block 사용이 가능하다.
    •• with절을 불러서 사용하는 body 영역에서는 block명이 우선되므로 테이블명은 사용할 수 없다.
    •• with절 내에 또 다른 with절을 포함할 수 없다.
    •• set operator를 사용한 쿼리에서는 사용할 수 없다.

3. 어제까지 배운 [Oracle 함수]를 적고 설명하세요 .
  ㄱ. UPPER(), LOWER()
  ㄴ. NVL(), NVL2()
  ㄷ. TO_CHAR()
  ㄹ. SUBSTR()
  ㅁ. CONCAT()
  
11:02 수업시작~~   
3-2. 어제까지 배운 오라클의 연산자(operator)를 적으세요.  
  ㄱ.  비교연산자    =   != <>  ^=  >=  <=
  ㄴ.  논리연산자    AND OR NOT
  ㄷ.  SQL 연산자
        [NOT] IN( list )
        [NOT] BETWEEN a AND b
        IS [NOT] NULL

4.insa 테이블에서 사원들이 속한 부서명을 중복되지 않게 아래와 같이
    부서명 오름차순 정렬( ASC )해서 출력하세요.    
SELECT 문 :    DISTINCT , ALL,  AS  사용가능
    
SELECT DISTINCT buseo    
FROM insa
ORDER BY buseo; 
ORDER BY buseo ASC;    
ORDER BY 1 ASC;    
    
5.insa테이블에서 ssn 컬럼을 통해서 year, month, date, gender 출력
-- date 키워드(예약어)
-- 1) 오라클 예약어 확인 - date 예약어 확인.
    -- 4) SYS 계정 
    SELECT * 
    FROM DICTIONARY
    WHERE table_name LIKE '%WORDS%';
    --  date 키워드 확인
    SELECT *
    FROM V$RESERVED_WORDS
    WHERE keyword = UPPER( 'date' );
    -- WHERE keyword = UPPER( :kw );
    ; -- 사전

SELECT ssn
    , SUBSTR( ssn, 0, 2)  AS "YEAR"    --    , SUBSTR( ssn, 1, 2)
    , SUBSTR( ssn, 3, 2)  month
    -- ORA-00923: FROM keyword not found where expected
    , SUBSTR( ssn, 5, 2) "DATE"
    , SUBSTR( ssn, 8, 1) gender
FROM insa;

      SSN          YEAR MONTH DATE GENDER  
    ---------- ------ ---- ----- -----
    771212-1022432	77	12	12	1
    801007-1544236	80	10	07	1
    770922-2312547	77	09	22	2
    790304-1788896	79	03	04	1
    811112-1566789	81	11	12	1
    :
    60개 행이 선택되었습니다. 
    
5-2. emp 테이블에서 입사년도 컬럼에서 년,월,일 찾아서 출력
    ㄱ. 년도 찾을 때는 TO_CHAR() 함수 사용
    ㄴ. 월 찾을 때는 SUBSTR() 함수 사용
    
    NUMBER   숫자
    VARCHAR2 '문자' 또는 '문자열' 
    DATE     '날짜'
    
SELECT ename, hiredate
    , TO_CHAR(  hiredate, 'YYYY'  )   year  --DATE -> YEAR    '1980'
    , EXTRACT(  YEAR  FROM hiredate ) year -- 1980
    , SUBSTR( hiredate, 4, 2)  month
    , TO_CHAR(  hiredate, 'MM'  ) month
    , EXTRACT(  MONTH  FROM hiredate ) month
    , SUBSTR( hiredate, -2)  "DATE"
    , TO_CHAR(  hiredate, 'dd'  )  "DATE"
    , EXTRACT(  DAY  FROM hiredate )  "DATE"
FROM emp;
    
    ENAME      HIREDATE YEAR MONTH DATE
    ---------- -------- ---- -- --
    SMITH      80/12/17 1980 12 17
    ALLEN      81/02/20 1981 02 20
    WARD       81/02/22 1981 02 22
    JONES      81/04/02 1981 04 02
    MARTIN     81/09/28 1981 09 28
    BLAKE      81/05/01 1981 05 01
    CLARK      81/06/09 1981 06 09
    KING       81/11/17 1981 11 17
    TURNER     81/09/08 1981 09 08
    JAMES      81/12/03 1981 12 03
    FORD       81/12/03 1981 12 03
    MILLER     82/01/23 1982 01 23

12개 행이 선택되었습니다.    
    
5-3.insa 테이블에서 70년대생 남자사원만 아래와 같이 주민등록번호로 정렬해서 출력하세요.
DESC insa;

SELECT name
--    , ssn
    , SUBSTR( ssn, 0, 8 ) || '******'  rrn
    , CONCAT( SUBSTR( ssn, 0, 8 ) ,   '******' )  rrn
FROM insa;

    NAME                 RRN           
    -------------------- --------------
    문길수               721217-1******
    김인수               731211-1******
    김종서               751010-1******
    허경운               760105-1******
    정한국               760909-1******
    최석규               770129-1******
    지재환               771115-1******
    홍길동               771212-1******
    산마루               780505-1******
    장인철               780506-1******
    박문수               780710-1******
    이상헌               781010-1******
    김정훈               790304-1******
    박세열               790509-1******
    이기상               790604-1******
    
    15개 행이 선택되었습니다. 
    
    
12:03 수업 시작~~~     
6. insa 테이블에서 70년대 12월생 모든 사원 아래와 같이 주민등록번호로 정렬해서 출력하세요.

    NAME                 SSN           
    -------------------- --------------
    문길수               721217-1951357
    김인수               731211-1214576
    홍길동               771212-1022432   

SELECT name, ssn    
FROM insa
WHERE ssn LIKE '7_12%';
WHERE ssn LIKE '__12%';
WHERE ssn LIKE '7%';

WHERE SUBSTR( ssn, 1, 1) = 7  AND SUBSTR( ssn, 3, 2) = 12;    
WHERE SUBSTR( ssn, 1, 1) = '7';    

   ㄱ. LIKE            SQL연산자
       (1) 와일드카드(  %  _  기호)만 사용가능하다. 
            %  :  문자 개수에 상관없음      *
            _  : 한 개의 문자     
       (2) 문자열의 패턴 검사.
       (3) 와일드 카드를 일반문자 처럼 쓰고 싶은 경우에는  "ESCAPE 옵션"을 사용한다.
   
   상품테이블
   상품명 컬럼
   인기상품순
   
   SELECT *
   FROM 상품테이블
   WHERE 상품명 LIKE '%아이패드%' OR 상품명 LIKE '%갤럭시탭%'
   ORDER BY 판매가격 DESC;  -- 높은가격순
   ORDER BY 판매가격 ASC;  -- 낮은가격순
   ORDER BY 제조일자 DESC; -- 신상품순
   ORDER BY 판매수량 DESC; -- 인기순
   
   [문제] insa 테이블에서 성이 김씨,이씨만 출력하세요. 
   SELECT name, ssn
   , SUBSTR( name, 0, 1)
   FROM insa
   WHERE name  LIKE '%김%';
   WHERE name  LIKE '_김%';
   WHERE name LIKE '김%' OR name LIKE '이_%'; -- 와일드카드(%,_)
   WHERE SUBSTR( name, 0, 1) IN ( '김' , '이' ) ;
   WHERE SUBSTR( name, 0, 1) = '김' OR SUBSTR( name, 0, 1) = '이';
   
   -- [LIKE  ESCAPE 옵션 설명 ]
   SELECT *
   FROM dept; -- 부서 테이블
    부서번호 부서명    지역명
    deptno   dname   loc
    10	ACCOUNTING	NEW YORK
    20	RESEARCH	DALLAS
    30	SALES	CHICAGO
    40	OPERATIONS	BOSTON
    
    -- 새로운 부서를 추가 : DML문   INSERT , UPDTE, DELETE  + COMMIT(암기)    
    -- [ INSERT  형식 ]
    INSERT INTO 테이블명 [( 컬럼명... )] VALUES ( 값... );
    COMMIT;
    --  오라클에서 날짜,문자열은  '' 사용
    INSERT INTO dept ( deptno, dname, loc ) VALUES ( 50, 'QC100%T' , 'SEOUL' );
    COMMIT;
    
    -- 2:00 수업 시작~~~ 
    -- ORA-00001: unique constraint (SCOTT.PK_DEPT) violated
    --            유일성 제약조건(PK_DEPT)            위배된다. 
    INSERT INTO dept VALUES(50,'한글_나라','COREA');
    INSERT INTO dept VALUES(60,'한글_나라','COREA');
    COMMIT;
    -- 1 행 이(가) 삽입되었습니다
    SELECT *
    FROM dept;
    
    -- [문제] dept 테이블에서  부서명에   '_' 해당 부서를  조회
    SELECT *
    FROM dept
    WHERE dname LIKE  '%\_%' ESCAPE '\'  ; 
    WHERE dname LIKE  '%_%'  ;  --  _ 와일드카드( _ ) : 한 문자
    
    -- [문제] dept 테이블에서  부서명에   '%' 해당 부서를  조회
    SELECT *
    FROM dept
    WHERE dname LIKE  '%\%%' ESCAPE '\'  ; 
    
    -- DML (데이터 조작언어 ) : INSERT 문, [UPDATE 문(수정)]    + COMMIT;
    
    [형식]
    UPDATE [스키마.]테이블명
    SET 수정할컬럼명=수정할값,수정할컬럼명=수정할값...
    [WHERE 조건절];
    
    실습) 지역명( loc )   'Corea' -> 'Korea' 수정
    SELECT *
    FROM dept
    WHERE loc = UPPER( 'Corea' ) ;
    -- WHERE 조건절을 생략하면 모든 레코드(행 == 부서)의 지역명(loc)가 수정된다.
    ROLLBACK;
    --
    UPDATE dept
    SET loc = 'KOREA'
    WHERE loc = UPPER( 'Corea' ) ;
    WHERE deptno = 60; -- 고유한 키(PK 열쇠)인 deptno 컬럼값을 사용해서 수정, 삭제 자주 일어난다. 
    COMMIT;
    -- DML (데이터 조작언어 ) : INSERT 문, UPDATE 문(수정) , [DELETE 문]   + COMMIT;
    
    -- [형식]
    -- WHERE 조건절을 생략하면 모든 레코드(행)이 삭제된다. 
    DELETE FROM 테이블명
    [WHERE 조건절 ];
    -- 50, 60 부서번호를 삭제.
    -- ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
    --            무결성     제약조건(포린키==참조키)        위배     - 자식 레코드 찾았다.
    -- 왜 ? 
    -- EMP(사원)테이블  -<소속 관계>-   DEPT(부서)테이블 
    SELECT *
    FROM dept;
    
    ROLLBACK;
    --  40, 50, 60 부서를 부서테이블에서 삭제
    DELETE FROM dept
    WHERE deptno >= 50;    
    WHERE deptno IN ( 40, 50, 60);
    WHERE deptno = 40 OR deptno = 50 OR deptno = 60;
    
    COMMIT;
    
    -- CRUD( CreateReadUpdateDelete )  SELECT, INSERT, UPDATE, DELETE 
    
    [문제] deptno = 30 부서의 부서명을 'SA%LES'으로 수정하는 쿼리 작성...
    UPDATE 테이블명
    SET   수정할컬럼=값...
    WHERE 조건절;
    --
    UPDATE dept
    SET   dname = 'SA%LES'
    WHERE deptno = 30;
    COMMIT;
    
    [문제] deptno = 30 부서의 부서명에 % 를 제거하는 쿼리 작성.
    -- 자바  String dname = "SA%LES";
    --              % 제거
    --      dname =  dname.replace("%","");
    --       syso( dname );
    UPDATE dept
    -- SET   dname =  dname  % 제거한 후
    SET   dname =  REPLACE(  dname , '%' , '')
    WHERE deptno = 30;
    COMMIT;
    
    [문제] emp 테이블에서 sal 의 10%를 comm에 추가하는 수정 쿼리 작성하세요.
    SELECT *
    FROM emp;
ROLLBACK;
    UPDATE emp
    SET   comm =   NVL(comm, 0)  +  sal * 0.1   ;  --  null 모든 연산 => null 처리..
    
    
    -- 3:05 수업 시작~
       LIKE  SQL연산자
   ㄴ. REGEXP_LIKE()   함수
     --  정규표현식을 사용하는 LIKE 함수
     -- [문제] insa테이블에서 성이 김씨,이씨  조회.
     -- [문제] insa테이블에서 성이 김씨,이씨가 아닌 사원 정보  조회.
     SELECT *
     FROM insa
     WHERE  REGEXP_LIKE( name , '[경자]$' )  ;
     
     WHERE  REGEXP_LIKE( name , '^[^김이]' )  ;
     WHERE  NOT  REGEXP_LIKE( name , '^[김이]' )  ;
     WHERE name NOT LIKE '이%' AND name NOT LIKE '김%';
     
     WHERE  NOT (  REGEXP_LIKE( name , '^[김이]' )  );
     WHERE  NOT ( name LIKE '이%' OR name LIKE '김%' );
     
     WHERE REGEXP_LIKE( name , '^[김이]' ) ;
     WHERE name LIKE '이%' OR name LIKE '김%';
     
     --
     SELECT name, ssn            
     FROM insa
     WHERE REGEXP_LIKE( ssn , '^7\d12' );
     WHERE REGEXP_LIKE( ssn , '^7[0-9]12' );
     --WHERE ssn LIKE '7_12%';
     
     [문제] insa 테이블에서 70년대 남자 사원만 조회.
     -- 1) LIKE 연산자
     -- 2) REGEXP_LIKE() 함수
     
     4:05 수업 시작~
     -- 자바 남자 :  1/3/5/7/9 
     --            int gender = 3;
     --             gender % 2 == 1  남자.. 홀수라면 .. 
     -- 오라클 나머지를 구하는 연산자  %         X 없다.
     --                     함수   MOD( a, b )   == a % b   
     SELECT 4+5, 4-5, 4*5, 4/5 -- 산술연산자
      --     , 4 % 5   -- ORA-00911: invalid character
            , MOD(4, 5 )
     FROM dual;
     
     
     SELECT name, ssn
     FROM insa
     WHERE REGEXP_LIKE(  ssn ,  '^7.{6}[13579]' );
     WHERE REGEXP_LIKE(  ssn ,  '^7\d{5}-[13579]' );
     
     WHERE ssn LIKE '7%' AND  MOD(  SUBSTR(ssn, 8, 1) , 2 ) = 1 ;
     WHERE ssn LIKE '7%' AND SUBSTR(ssn, 8, 1) IN ( 1,3,5,7,9 );
     
     WHERE REGEXP_LIKE(  ssn ,  '^7\d{5}-1' );
     WHERE ssn LIKE '7_____-1%';
     -- WHERE ssn LIKE '7%' AND ssn LIKE '______-1%'  --  ( % _  )와일드 카드 

    [문제] emp 테이블에서 사원명(ename) 속에  'la' 문자열을 포함하는 사원 정보를 조회(출력)
    --                    la   La  lA  LA
    【형식】
        regexp_like (search_string, pattern [,match_option])
        match_option   i(대소문자구분X) , c(대소문자구분O) , n , m( multi lines), x ( 공백문자 무시 )
        
    SELECT empno, ename,    REPLACE( ename , 'LA', '<sapn style="color:red">LA</span>')
    FROM emp
    WHERE REGEXP_LIKE( ename ,  'la', 'i'  );  -- (암기)
    WHERE REGEXP_LIKE( ename ,  '[lL][aA]'  );
    WHERE REGEXP_LIKE( ename ,  UPPER('la')  );
    WHERE REGEXP_LIKE( ename , 'LA'  );
    WHERE ename LIKE '%' || UPPER('La') || '%'; --  (암기)
    WHERE ename LIKE '%LA%';
    
7. emp 테이블에서
   pay(sal+comm)  1000 이상~ 3000 이하 받는  
   30부서원을 제외한 모든 사원들만 
   ename을 기준으로 오름차순 정렬해서 조회하는 쿼리를 작성하세요.  
    ㄱ. 일반 쿼리 사용.    
    SELECT deptno, empno, ename, sal, comm, sal + NVL(comm,0) pay
    FROM emp
    WHERE ( sal + NVL(comm,0) BETWEEN 1000 AND 3000 ) AND deptno != 30
    ORDER BY ename ASC ;
    
    ㄴ. inline view 사용 
    SELECT t.*
    FROM (     -- 인라인뷰
                SELECT deptno, empno, ename, sal, comm, sal + NVL(comm,0) pay
                FROM emp
          ) t
    WHERE  ( t.pay BETWEEN 1000 AND 3000 )  AND t.deptno != 30
    ORDER BY t.ename ASC ;
    
    ㄷ. with 절 사용   
    WITH  
        temp AS (
                SELECT deptno, empno, ename, sal, comm, sal + NVL(comm,0) pay
                FROM emp
        )
    SELECT temp.*
    FROM  temp
    WHERE( temp.pay BETWEEN 1000 AND 3000 )  AND temp.deptno != 30
    ORDER BY temp.ename ASC ;  
    
8. emp 테이블에서 직속상사(mgr)가 없는  사원의 정보를 조회하는 쿼리 작성.
   SELECT *
   FROM emp
   WHERE mgr IS NULL;
   -- WHERE mgr = NULL;

8-2. emp 테이블에서 직속상사(mgr)가 없는  사원의 mgr을 'CEO'로 출력하는 쿼리 작성.
  -- ORA-00923: FROM keyword not found where expected
  -- ORA-01722: invalid number
   -- SELECT e.* , NVL( mgr, 'CEO') 
   
   -- mgr 숫자 -> 문자열 변환
   SELECT e.* , NVL( TO_CHAR( mgr ), 'CEO') 
   FROM emp e
   WHERE e.mgr IS NULL;
   
   DESC emp;
   MGR               NUMBER(4)    
   
   5:03 수업 ~~
-----------------------   
8-3. insa 테이블에서 연락처(tel)가 없는 사원은 '연락처 등록 안됨' 출력하는 쿼리를 작성. 
8-4. insa 테이블에서 개발부만 num, name, tel 컬럼 출력할 때 연락처(tel) 없는 사람은 X, O 출력하는 쿼리 작성.

9. employees 테이블에서  아래와 같이 출력되도록 쿼리 작성하세요. 
   
    FIRST_NAME          LAST_NAME                   NAME                                           
    -------------------- ------------------------- -----------------------------
    Samuel               McCain                    Samuel McCain                                  
    Allan                McEwen                    Allan McEwen                                   
    Irene                Mikkilineni               Irene Mikkilineni                              
    Kevin                Mourgos                   Kevin Mourgos                                  
    Julia                Nayer                     Julia Nayer   
    :

10. emp 테이블에서  아래와 같은 조회 결과가 나오도록 쿼리를 작성하세요.

     EMPNO ENAME             SAL       COMM        PAY
---------- ---------- ---------- ---------- ----------
      7369 SMITH             800          0        800
      7499 ALLEN            1600        300       1900
      7521 WARD             1250        500       1750
      7566 JONES            2975          0       2975
      7654 MARTIN           1250       1400       2650
      7698 BLAKE            2850          0       2850
      7782 CLARK            2450          0       2450
      7839 KING             5000          0       5000
      7844 TURNER           1500          0       1500
      7900 JAMES             950          0        950
      7902 FORD             3000          0       3000
      7934 MILLER           1300          0       1300

	12개 행이 선택되었습니다.  

11.   emp 테이블에서 10번 부서원 정보 조회
11-2. emp 테이블에서 10번 부서원을 제외한 사원 정보를 조회(출력)
11-3. emp 테이블에서 10번 또는 20번 부서원 정보를 조회

12. 사원명이 king 인 사원의 정보 조회

13. insa 테이블에서 출생지역이 수도권 아닌 사원의 정보를 조회.

14.  emp 테이블에서 comm 이  확인되지 않은 사원의 정보 조회
 (   comm 이    null 인 사원의 정보 조회 )
14-2. emp 테이블에서 comm 이  null 이 아닌 사원의 정보 조회  

15. HR 계정의 생성 시기와 [잠금상태]를 확인하는 쿼리를 작성하세요.

16.  emp테이블에서
   각 부서별로 오름차순 1차 정렬하고 급여(PAY)별로 2차 내림차순 정렬해서 조회하는 쿼리를 작성하세요.    

17. emp 테이블에서 부서번호가 10번이고, 잡이 CLERK  인 사원의 정보를 조회하는 쿼리 작성.
17-2. emp 테이블에서 잡이 CLERK 이고, 부서번호가 10번이 아닌 사원의 정보를 조회하는 쿼리 작성.
17-3.  emp 테이블에서 부서번호가 30번이고, 커미션이 null인 사원의 정보를 조회하는 쿼리 작성.
  ( ㄱ.  deptno, ename, sal, comm,  pay 컬럼 출력,  pay= sal+comm )
  ( ㄴ. comm이 null 인 경우는 0으로 대체해서 처리 )
  ( ㄷ. pay 가 많은 순으로 정렬 ) 
  
18. Alias 를 작성하는 3가지 방법을 적으세요.
   SELECT deptno, ename 
     , sal + comm   (ㄱ)  
     , sal + comm   (ㄴ)  
     , sal + comm   (ㄷ)  
    FROM emp;
--------------------------------------------------------------------------------

