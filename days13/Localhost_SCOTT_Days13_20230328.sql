-- SCOTT -- 
-- 9:50 제출
--------------------------------------------------------------------------------
-- 복습 문제 
--------------------------------------------------------------------------------
1. book, panmai, danga, gogaek 조인하여 다음을 출력 한다.
  -- 책이름(title) 고객명(g_name) 년도(p_date) 수량(p_su) 단가(price) 금액(p_su*price)
  -- 단, 년도 내림차순 출력
  
 book   : title
 gogaek : g_name
 panmai : p_date , p_su
 danga  : price 
 
 SELECT title, g_name, p_date, p_su, price  , p_su * price 
 FROM book b  JOIN danga d ON b.b_id = d.b_id  -- INNER JOIN, EQUI JOIN
              JOIN panmai p ON b.b_id = p.b_id
              JOIN gogaek g ON p.g_id = g.g_id
ORDER BY   p_date DESC            ;

TITLE            G_NAME               P_DATE         P_SU      PRICE         금액
---------------- -------------------- -------- ---------- ---------- ----------
운영체제         강남서점             21/11/03          5        450       2250
엑셀             서울서점             21/11/03         31        321       9951
데이터베이스     강북서점             21/11/03         26        300       7800
데이터베이스     강남서점             21/11/03         17        300       5100
엑세스           강남서점             21/11/03         21        510      10710
운영체제         우리서점             21/11/03         13        450       5850
데이터베이스     우리서점             00/10/10         10        300       3000
데이터베이스     강북서점             00/10/10         15        500       7500
워드             서울서점             00/07/07          5        320       1600
데이터베이스     도시서점             00/03/04         20        300       6000

2. book 테이블, panmai 테이블, gogaek 테이블을 b_id 필드와 g_id 필드를 기준으로 조인하여 
다음의 필드 출력 한다. 
단, book 테이블의 모든 행은 출력 되도록 한다.(OUTER 조인)
  ( 판매가 안된 책 정보도 출력 )
 
book   : b_id, title
gogaek : g_id, g_name
panmai : p_su
-- ORA-00918: column ambiguously defined
 SELECT b.b_id, title, g.g_id, g_name, p_su
 FROM book b  LEFT JOIN panmai p ON b.b_id = p.b_id
              LEFT JOIN gogaek g ON p.g_id = g.g_id;
  
책ID       제목                     G_ID G_NAME                     판매수량
---------- ------------------- ---------- -------------------- ----------
b-1        운영체제                     1 우리서점                     13
a-1        데이터베이스                 1 우리서점                     10
a-1        데이터베이스                 2 도시서점                     20
d-1        엑셀                         4 서울서점                     31
c-1        워드                         4 서울서점                      5
b-1        운영체제                     6 강남서점                      5
a-1        데이터베이스                 6 강남서점                     17
f-1        엑세스                       6 강남서점                     21
a-2        데이터베이스                 7 강북서점                     15
a-1        데이터베이스                 7 강북서점                     26
e-1        파워포인트                                                     
f-2        엑세스                                                        
b-2        운영체제                                                      



3. 년도, 월별 판매 현황 구하기

년도   월        판매금액( p_su * price )
---- -- ----------
2000 03       6000
2000 07       1600
2000 10      10500
2021 11      41661

panmai : p_date    , p_su
danga  : price 
GROUP BY 년도별,  월별   + SUM(판매금액 )
-- ORA-00979: not a GROUP BY expression
-- SELECT p_date,   SUM(  p_su * price )  총판매금액
SELECT TO_CHAR( p_date, 'YYYY' ), TO_CHAR( p_date, 'MM' ),   SUM(  p_su * price )  총판매금액
FROM panmai p JOIN danga d ON  p.b_id = d.b_id
GROUP BY  TO_CHAR( p_date, 'YYYY' ), TO_CHAR( p_date, 'MM' );
 

4. 서점별 년도별 판매현황 구하기 

 panmai : p_date , p_su
 gogaek : g_id, g_name
 danga  : price
-- ORA-00979: not a GROUP BY expression
-- SELECT p_date, g.g_id, g_name, SUM(  price * p_su )

SELECT  TO_CHAR( p_date, 'YYYY') 년도, g.g_id, g_name , SUM( p_su * price ) 총판매금액
FROM panmai p JOIN danga d  ON p.b_id = d.b_id
              JOIN gogaek g ON g.g_id = p.g_id
GROUP BY TO_CHAR( p_date, 'YYYY'), g.g_id, g_name
ORDER BY TO_CHAR( p_date, 'YYYY') , g_name ;          

년도         서점ID 서점명                판매금액
---- ---------- -------------------- ----------
2000          7 강북서점                   7500
2000          2 도시서점                   6000
2000          4 서울서점                   1600
2000          1 우리서점                   3000
2021          6 강남서점                  18060
2021          7 강북서점                   7800
2021          4 서울서점                   9951
2021          1 우리서점                   5850

8개 행이 선택되었습니다. 
 

 11:06~ 

5. 2021년 가장 판매가 많은 책(수량을 기준으로) 

책ID       제목       권수
---------- ----------------
a-1        데이터베이스  43
 
-- TOP-N 방식, RANK() 함수

book   : b_id, title
panmai : p_su
-- 1)
SELECT b.b_id, title, p_su , p_date
FROM book b  JOIN panmai p ON b.b_id = p.b_id
-- WHERE TO_CHAR(SYSDATE, 'YYYY') = TO_CHAR( p_date, 'YYYY');
WHERE 2021 = TO_CHAR( p_date, 'YYYY');

-- 2)
SELECT b.b_id, title, SUM( p_su  ) 총권수
FROM book b  JOIN panmai p ON b.b_id = p.b_id 
WHERE 2021 = TO_CHAR( p_date, 'YYYY')
GROUP BY b.b_id, title 
ORDER BY 총권수 DESC;

-- 3)TOP-N   
   (1) 정렬 + 서브쿼리
   (2) ROWNUM 의사컬럼으로 순위 매겨서 ...
--SELECT ROWNUM , t.*
SELECT   t.*
FROM ( 
        SELECT b.b_id, title, SUM( p_su  ) 총권수
        FROM book b  JOIN panmai p ON b.b_id = p.b_id 
        WHERE 2021 = TO_CHAR( p_date, 'YYYY')
        GROUP BY b.b_id, title 
        ORDER BY 총권수 DESC
) t
WHERE ROWNUM = 1;
 
  -- RANK() 순위 함수 
  WITH 
    temp AS (
          SELECT b.b_id, title, SUM( p_su  ) 총권수
             , RANK() OVER( ORDER BY SUM( p_su  ) DESC ) 순위
          FROM book b  JOIN panmai p ON b.b_id = p.b_id 
          WHERE 2021 = TO_CHAR( p_date, 'YYYY')
          GROUP BY b.b_id, title 
  )
  SELECT *
  FROM temp
  WHERE 순위 = 1;
         
  
 
6. 서점별 판매현황 구하기

서점코드  서점명  판매금액합  비율(소수점 둘째반올림)  
---------- -------------------------- ----------------
7	    강북서점	15300		26%
4	    서울서점	11551		19%
2	    도시서점	6000		10%
6	    강남서점	18060		30%
1	    우리서점	8850		15%

gogaek : g_id, g_name
panmai : p_su
danga  : price
GROUP BY   SUM()
-- 1)
SELECT g.g_id,g_name, p_su , price
FROM gogaek g JOIN panmai p ON g.g_id = p.g_id
              JOIN danga  d ON d.b_id = p.b_id; 

-- 2) PL/SQL
SELECT t.g_id, t.g_name, t.서점별_총판매금액 , ROUND(  t.서점별_총판매금액/t.전체_총판매금액 *100 ) || '%'  
FROM ( 
    SELECT g.g_id,g_name, SUM(  p_su * price ) 서점별_총판매금액
       , (SELECT SUM( p_su * price )FROM panmai p JOIN danga  d ON d.b_id = p.b_id)  전체_총판매금액
    FROM gogaek g JOIN panmai p ON g.g_id = p.g_id
                  JOIN danga  d ON d.b_id = p.b_id
    GROUP BY  g.g_id,g_name  
 ) t; 

SELECT SUM( p_su * price )
FROM panmai p JOIN danga  d ON d.b_id = p.b_id;  


7. 모든  책 중에 가장 적게 판매가 된 책의 정보를 조회( TOP-1 )
   ( 책ID, 제목, 가격, 총판매량 )


8. 총 판매권수가 10권 이상 판매된 책의 정보 조회 (  - HAVING 절 )
   ( 책ID, 제목, 가격, 총판매량 )  
   
  b_id, title, price,   SUM(p_su) 
  -- 1) 
  SELECT b.b_id, title, price , p_su
  FROM book b JOIN danga d ON b.b_id = d.b_id
              JOIN panmai p ON b.b_id = p.b_id;
              
  -- 2) 
  SELECT b.b_id, title, price , SUM( p_su ) 총판매량
  FROM book b JOIN danga d ON b.b_id = d.b_id
              JOIN panmai p ON b.b_id = p.b_id
  GROUP BY     b.b_id, title, price        
  HAVING SUM( p_su ) >= 10 ;              
   
--------------------------------------------------------------------------------
-- 계층적 질의 
--------------------------------------------------------------------------------
 - 관계형 데이터베이스는 2차원 테이블 구조에 의해 모든 데이터를 저장한다.
 - 하지만,
    실무에서는 기업의 조직도
            , 집안의 족보처럼 
    계층적인 데이터 구조를 많이 사용하고 있다.
  - 테이블에서 기업의 조직도와 같은 계층적인 데이터 자체를 저장하기는 어렵다. 
    하지만, 관계형 데이터베이스에서도 데이터간의 
     [부모-자식 관계를 표현할 수 있는 컬럼을 지정하여 
     계층적인 관계를 표현할 수 있다.
하나의 테이블에서 계층적인 구조를 표현하는 관계를 순환관계(recursive relationship)라고 한다.
 
   -SELECT 문에서 
     1) START WITH 조건절 와
     2) CONNECT BY 조건절을 이용하여        부모 - 자식  ( 컬럼 )
     데이터를 계층적인 형태로 출력할 수 있다.

  -- ORA-01788: CONNECT BY clause required in this query block
  SELECT LEVEL
  FROM dual
  CONNECT BY LEVEL <= 31;  -- ( 암기 )
  -- 
  SELECT *
  FROM emp;
  
  12:03 수업 시작~ 
  -- 계층적 질의문에서는 계층적인 출력 형식과 시작 위치를 제어할 수 있다. 계층적인 출력 형식은 top-down 또는 bottom-up 형식이 가능하다. 
  -- 하지만 계층적 질의문은 조인문  X 이나 뷰(View) X 에서는 사용할 수 없으며,
     CONNECT BY 절에서는 서브쿼리 X 절을 포함할 수 없다.
 
【형식】 
	SELECT 	[LEVEL] {*,컬럼명 [alias],...}
	FROM	테이블명
	WHERE	조건
	START WITH 계층적인 출력 형식을 표현하기 위한 [최상위 행 조건절]
	CONNECT BY [NOCYCLE][PRIOR 컬럼1명  비교연산자  컬럼2명]
		또는 
		   [컬럼1명 비교연산자 PRIOR 컬럼2명]

  PRIOR == 이전의 , 앞의, 중요한~ 
  
  -- 예  (TOP-DOWN 방식 )
  SELECT mgr, empno, ename, LEVEL
  FROM emp
  START WITH mgr IS NULL
  CONNECT BY PRIOR empno = mgr;
                 사원번호       상사사원번호
                 자식

 -- 예  (TOP-DOWN 방식 )
SELECT  mgr, empno
    ,  LPAD( ' ', (LEVEL-1)*3 ) ||  ename, LEVEL
FROM emp
START WITH mgr IS NULL
-- CONNECT BY  PRIOR mgr = empno  ;
CONNECT BY PRIOR empno = mgr;

 -- 예  (TOP-DOWN 방식 )
SELECT  mgr, empno
    ,  LPAD( ' ', (LEVEL-1)*3 ) ||  ename, LEVEL
FROM emp
START WITH empno = 7698
CONNECT BY PRIOR empno = mgr;

 -- 예  (TOP-DOWN 방식 )
SELECT  deptno , mgr, empno
    ,  LPAD( ' ', (LEVEL-1)*3 ) ||  ename, LEVEL
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr  AND deptno = 30;

 -- 예  (TOP-DOWN 방식 )
 -- CONNECT_BY_ROOT 연산자 : 최상위 루트 행(row)를 반환하는 연산자.
SELECT  deptno , mgr, empno
    ,  LPAD( ' ', (LEVEL-1)*3 ) ||  ename, LEVEL
    , CONNECT_BY_ROOT ename -- 
    , CONNECT_BY_ISLEAF leaf-- 해당 행이 최하위 행이냐? 1  / 0 연산자 
    -- 루트노드에서 시작해서 자신의 행까지의 연결된 경로 정보 반환
    , SYS_CONNECT_BY_PATH( ename, '/') path
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr ;
-- 
SELECT  deptno , mgr, empno
    ,  LPAD( ' ', (LEVEL-1)*3 ) ||  ename, LEVEL  
    -- 현재 행이 자식을 갖고 있는 데 동시에 그 자식 행이 부모행이면   1, 그렇지 않으면 0
    , CONNECT_BY_ISCYCLE isLoop
FROM emp
START WITH mgr IS NULL
CONNECT BY NOCYCLE PRIOR empno = mgr ; -- 
--------------------------------------------------------------------------------
-- 예제에 사용되는 계층구조  empno-mgr
DROP TABLE tbl_test PURGE;

create table tbl_test(
  deptno number(3) not null primary key,
  dname varchar2(24) not null,
  college number(3),
  loc varchar2(10)
);
-- Table TBL_TEST이(가) 생성되었습니다.

---------- -------------------- ---------- ----------
INSERT INTO tbl_test VALUES        ( 101,  '컴퓨터공학과', 100,  '1호관');
INSERT INTO tbl_test VALUES        (102,  '멀티미디어학과', 100,  '2호관');
INSERT INTO tbl_test VALUES        (201,  '전자공학과 ',   200,  '3호관');
INSERT INTO tbl_test VALUES        (202,  '기계공학과',    200,  '4호관');
INSERT INTO tbl_test VALUES        (100,  '정보미디어학부', 10 , null );
INSERT INTO tbl_test VALUES        (200,  '메카트로닉스학부',10 , null);
INSERT INTO tbl_test VALUES        (10,  '공과대학',null , null);
COMMIT;

SELECT *
FROM tbl_test;
-- TOP-DOWN
SELECT deptno,dname,college,LEVEL
FROM tbl_test
START WITH deptno=10
CONNECT BY PRIOR deptno=college;

--
select deptno,dname,college,level
from tbl_test
start with deptno=102
connect by prior college=deptno;
-- 
SELECT LPAD(' ', (LEVEL-1)*2) || dname 조직도
FROM tbl_test
START WITH dname='공과대학'
CONNECT BY PRIOR deptno=college;
--   (차이점)
SQL> SELECT deptno,college,dname,loc,LEVEL
  2  FROM test
  3  WHERE dname != '정보미디어학부'   -- 가지 제거 의미
  4  START WITH college IS NULL
  5  CONNECT BY PRIOR deptno=college;
--
SQL> SELECT deptno,college,dname,loc,LEVEL
  2  FROM test
  3  START WITH college IS NULL
  4  CONNECT BY PRIOR deptno=college
  5  AND dname != '정보미디어학부';  -- 가지 제거 의미

--------------------------------------------------------------------------------
-- *** 데이터베이스 모델링(DB모델링) *** + PL/SQL
--------------------------------------------------------------------------------
1. 데이터베이스 모델링 정의 
  1) 데이터베이스 ?  서로 관련된 데이터의 집합(모임)
  2) 데이터베이스 모델링 ? 현실 세계의 업무적인 프로세스를 물리적으로 데이터베이스화
                        시키기 위한 과정.
    예) 스타벅스에서 음료 주문 ( 현실 세계의 업무적인 프로세스 )
        음료(상품) 검색 -> 주문 -> 결재 -> 대기 -> ...
        
2. 데이터베이스 모델링 과정(순서)
   
     1) 업무 프로세스     →  2) 개념적 DB 모델링
        요구분석서작성               ERD
            ↑ 일치성 검토            ↓
     4) 물리적 DB 모델링 ←   3) 논리적 DB 모델링  
        타입,크기                   정규화
        역정규화          DBMS
        인덱스          (오라클)
        
2-2. 데이터베이스 모델링 과정
   2) 개념적 DB 모델링 -  업무 분석 후 개체(Entity) 추출, 속성(Attribute)과 관계(R) 정의를 통해  ER-Diagram 작성(구성)하는 단계
       Entity 추출
       Attriubte 추출             -> ERD 작성
       관계 추출
   
   3) 논리적 DB 모델링 
       - ERD -> 매핑규칙(mapping rule)-> "스키마"를 설계.
       - "정규화 과정"
   
   4)  물리적 DB 모델링
      - 컬럼 : 타입, 크기 
      - 데이터의 사용량 분석을 해서 효율적인 데이터베이스가 될 수 있도록  역정규화 작업
      - 인덱스 처리.

2-3. 앱/웹 애플리케이션 개발...

3. 앱/웹 애플리케이션 개발 과정
  1) 계획
  2) 요구분석
  3) 설계
  4) 구현
  5) 테스트
  6) 유지보수
  7) 배포
  8) 버젼관리

--------------------------------------------------------------------------------
 [ DB 모델링 - 첫 번째 단계 ]  업무 분석 *****
  1. 관련 분야에 대한 기본 지식과 상식 필요 예) 회계프로그램( 대차대조표, 자산, 손실... )
  2. 신입 사원 입장으로  업무 자체와 프로세스 파악에 초점을 두고 분석 필요.
  3. 요령 
      -  데이터로 관리되어지는 항목들을 정확히 파악. : 문서( 서류, 장표, 보고서 )  
      -  담당자와 인터뷰.
      - 백그라운드 프로세스 파악.
      - 사용자 요구 파악 + 분석
      
   => [ 요구 분석서 작성 ]   
 
--------------------------------------------------------------------------------
 [ DB 모델링 - 두 번째 단계 ]  개념적 DB 모델링
  1) 요구분석 -> 요구분석서 작성
  2) 요구 분석을 통해서 얻어진 현실 세계의 정보를 사람들이 이해할 수 있는 명확한 형태로 
     표현 단계 - 개념적 DB 모델링.
  3) ER-Diagram   
     개체(E) - 관계(R) 다이어그램 작성
  4) E-R   Model
     ㄱ. 1976년 p.chen이 제한한 것.
     ㄴ. 개체 관계 모델
         개체 - 사각형
         속성 - 타원
         객체간의 관계 - 마름모
         연결...
         
    3:00 수업시작~~     
  5)  ER - Diagram 의 용어 
	1) 실체(Entity) - [사각형]
       (1) 업무 수행을 위한 유형/무형의
          데이터로 관리되어져야 하는 
          사람,사물,장소,사건 등을 "실체"라고 한다. 
       (2) 실체는 학생, 교수  - 유형     
                 과목, 학과  - 무형
       (3) 실체는 테이블로 정의된다. 
       (4) 실체는 인스턴스라 불리는 개별적인 객체들의 집합이다. 
          예) 과목 실체 : 자료 구조, 데이터베이스, 프로그래밍 등등의 인스턴스들의 집합.
              학과 실체 : 컴퓨터공학과, 전자공학과 등등 인스턴스들의 집합.
       (5) 실체를 파악하기 위해서  관련 업무에 대한 지식( 가장 중요 )    
       
       (예제) 실체 파악하는 예제 
	     담당자미팅(요구분석 ) :  학원에서는 학생들의 출결상태와 성적들을 과목별로 관리하기를 원하고 있다.          
            실체 ?    학원(O), 학생,  출결상태,  성적, 과목 , 강사 등등
                      각종 서류를 이용 + 담당자 미팅 -> 실체 파악하는 것 좋은 방법...
                     
       
	2) 속성(Attribute)
       (1) 속성이란 ?  실체에 대한 특징(정보)
                      실체에 대해서 저장할 필요가 있는 정보
       (2) 속성은 실체의  성질, 분류, 수량, 상태, 특성, 특징, 등등의 세부 항목을 의미한다. 
       (3) 속성은 컬럼으로 정의된다.
       
       (예제) 학생 실체로부터 속성을 파악
          - 학번 , 학생명, 연락처, 주소, 이메일 , 주민등록번호(기초속성) , 가족관계 등등
             나이 , 생년월일(추출속성), 성별  XXX
             
             
       (4)  속성의 유형 - 타원
          ㄱ. 기초 속성 : 원래 갖고 있는 속성
          ㄴ. 추출 속성 : 기초 속성으로 얻어올 수 있는 속성
                        주민등록번호(기초속성) => 예) 생년월일, 나이, 성별
                     - 자료의 중복성, 무결성 확보를 위해 초소화 하는 것이 바람직하다.
                     예) 총판매금액 SUM( p_su * price )
                     
          ㄷ. 설계 속성 : 실제로 존재하지는 않으나 시스템의 효율성을 위해 
                       설계자가 임의로 부여한 속성
               예) 주문상태( 주문의 진행 상태 : 주문, 결제 완료, 배송전, 배송 중, 배송완료, 취소 )
       (5) 속성 도메인 설정
          ㄱ. 속성이 가질 수 있는 값들의 범위를  "속성의 도메인 설정"이라고 한다. 
            즉, 속성에 대한 세부적인 업무, 제약조건 및 특성을 정의해 주는 것.
          ㄴ. 도메인 설정(정의) 시에는 속성의 이름, 자료형, 크기, 형식, 제약조건, 유일성, 널 여부
            , 유효한 값범위, 디폴트(초기값) 파악...
          ㄷ. 도메인 무결성 ?  데이터의 입력 형식이나 입력값 등을 정의함을써
                잘못된 데이터가 입력되는 경우의 수를 방지 하기 위해 설정하는 것. 
           
	3) 식별자(Identifier) - 밑줄
       (1) 식별자 ?  한 실체 내에서 각각의 인스턴스를 구분할 수 있는 단일 속성, 또는 속성 그룹
           예) 학생 실체 - 속성( 학번 O, 이름, 연락처, 주소, 이메일, 주민등록번호 등등 )
            학생 실체의 인스턴스 - 홍길동, 김지은, 하동호 ~~~
        (2) 식별자 없으면 데이터를 수정/삭제할 수 없다. 
           그래서 모든 실체는 하나 이상의 식별자를 가져야 한다. ( 반드시 )
        (3) 식별자의 5가지 종류
           ㄱ. 후보키( Candiate Key )
               학생 실체- 속성( 학번, 주민등록번호 , 이메일 , 폰번호 등등 )
           ㄴ. 기본키( Praimry key ) -  후보키 중에 가장 적합한 키 ( 학번 )
                활용도, 성능, 실체 대표 여부 파악해서 ...
                PK - NOT NULL, UNIQUE,  인덱스(index) 설정.
           ㄷ. 대체키(  Alternate Key ) = 후보키 - 기본키
           ㄹ. 복합키(Composite Key)
               하나의 속성으로 기본키가 될 수 없는 경우, 
               둘 이상의 속성을 묶어서 식별자로 정의 한 경우
               예)  사원급여 지급 테이블
            (역정규화)     
         지급순서(seq)PK        [사원번호  +  지급일]   급여액
               CONSTRAINT PK_사원급여 지급 테이블_컬럼 PRIMARY KEY( 사원번호, 지급일)
               UPDATE
               SET  급여액 = 급여액 + 100000
               WHERE 사원번호  +  지급
               
           ㅁ.  대리키(Surrogate Key)  
              - 일련번호
              - 식별자가 너무 길거나 여러 개의 복합키로 구성되는 경우
                성능을 위해서 인위적으로 추가한 식별자
              - 역정규화  작업. ( 성능 )  
              
	4) 관계(Relational)  - 마름모   
      (1) 실체와 실체의 업무적인 연관성
      예)  [학생(E)]-------<수강관계>------[과목(E)]
           [회원(E)]        <주문>          [상품(E)]
      
      4:03 수업 시작~ 
      (2) 관계 표현 - 실체   실선     실체
          ㄱ. 관계 차수 표현
              1 - 1 관계  :  부서 - 부서장
              1 - N(다) 관계 : 부서  - 사원
              N다-M다 관계 :  고객 - 상품
              
              a) 새발(crow-feet)표기법    1- ∈
              b) 그래픽 표기법            1 - N
              
          ㄴ. 선택성 표현   1    0
          
          예)    [사원(E)]------<소속관계>------[부서(E)]
          
          1명사원이 여러 부서 소속X
           부서       사원 소속O
             1      N 관계
          
[문제1] 다음은 현업 담담자와의 면담 자료이다. 
   지금까지 알아본 개념을 바탕으로 다음에서 실체와 주요 속성을 추출해 다이어 그램을 그리시오.

    나는 교육센터의 관리자이다.
    우리는 여러 과정을 가르치는 데, 각 과정은 코드,이름 및 수강료를 갖고 있다. 
    'VB'과 'Java' 는 인기 있는 과정이다. 과정들은 1일~4일간으로 기간은 다양하다. 
    박찬호와 박신양은 우리의 가장 훌륭한 강사들이다. 
    우리는 각 강사의 이름과 전화번호를 필요로 한다. 
    학생들은 시간에 따라 여러 개의 과정을 이수할 수 있는 데 많은 학생들이 이렇게 하고 있다. 
    우리는 각 학생들의 이름과 전화번호를 알고 싶다.  
--------------------------------------------------------------------------------
   [교육센타(E)] : 지점번호(I), 원장, 주소, 연락처 등등
   [직원(E)] : (사원번호(I)), 사원명, 직급, 부서, 폰번호, 이메일 등등 속성 파악   
   [과정(E)] 과정코드(I) 지점번호, 과목코드, 강사코드 , 기간 속성, 개강일/종강일//  강의장   
   [과목(E)] 과목코드(I) 과목명, 과목설명, 내용(목차)   
   [강사(E)] 강사코드(I) , 강의 경력, 이름, 전화번호 등등   
   [강의실(E)] 지점코드(I), 인원수, 빔,컴,등등 / 공공/시계/ wife 등등   
   [고객(E)] 고객코드(I), 이름, 전화번호.......
   
   
   고객(E)-------<수강>-------과정(E)
         0|∈               0|∈
                   일련번호(I), 코고코,과코,신청,결재,수강...
                   1   홍길동   과정1   23/1/1  카드  이수
                   2   홍길동   과정2   23/2/1  현금  이수
                   :
                   :
                   :
                   :

--------------------------------------------------------------------------------

   실체(E)
   속성(A)
   관계(R) - 관계표현
   
   1조) 
   실체(entity) : 관리자, 학생, 과정, 교육센터, 강사
속성(Atrribute) : 과정(코드, 학생이름, 수강료, 기간, 강사이름)
                 강사(강사이름, 전화번호, 수업과목(코드))
                 학생(학생이름, 전화번호, 수강과목(코드))
                 관리자(담당과정, 담당학생, 담당강사)
                 
                 
                [학생(E)]——<수강관계>——[과정(E)]———<강의 관계> ——<[강사(E)]
                                            |
                                            |
                                            |
                                        <관리 관계>
                                            |
                                            |
                                            |
                                        [관리자(E)]
   2조)
   
   3조)
   실체(Entity): 
    교육센터
    과정
    강사정보
    학생
    
    속성(Attribute):
    교육센터: 이름
    과정: 코드, 이름, 수강료, 기간
    강사: 이름, 전화번호
    학생: 이름, 전화번호
    
    관계(Relationship):
    교육센터는 여러 개의 과정을 가르친다. (One-to-Many)
    각 과정은 하나의 코드, 하나의 이름, 하나의 수강료, 하나의 기간을 갖는다. (One-to-One)
    각 과정은 여러 명의 학생들이 수강할 수 있다. (One-to-Many)
    우리는 박찬호와 박신양을 가장 훌륭한 강사로 인정한다. (Many-to-Many)
    각 학생은 하나의 이름과 하나의 전화번호를 갖는다. (One-to-One)
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
--------------------------------------------------------------------------------




















