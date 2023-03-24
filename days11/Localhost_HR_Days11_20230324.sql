-- HR --

--------------------------------------------------------------------------------------------------------------------------------    
SELECT TO_CHAR( TO_DATE('2022.01.03'), 'IW' ) -- ISO 표준 주   월~일까지 1주.
, TO_CHAR( TO_DATE('2022.01.09'), 'IW' )
 , TO_CHAR( TO_DATE('2022.02.04'), 'WW' )  -- 년의 주          1~7  끝어짐
 , TO_CHAR( TO_DATE('2022.02.05'), 'WW' )
FROM dual;


----------------------------------------------------------------------------------------------------------------------------------
-- 피봇 마지막 문제 ( 프로젝트 진행 중 ... )--
1. 테이블 생성 : TBL_PIVOT
2.       컬럼  : no, name , jumsu     국어, 영어, 수학
                            kor , eng, mat
-- 테이블 설계가 잘못되었다.

-- 정규화 잘됨. ( 제 1 정규화 위배 ) DB 모델링
--1    홍길동  90
--2    홍길동  89
--3    홍길동  99
--
--4    홍길동  90  89   99

CREATE TABLE TBL_PIVOT
(
    no NUMBER NOT NULL  PRIMARY KEY -- 고유한키 PK
    , name VARCHAR2(20) NOT NULL
    , jumsu NUMBER(3)  -- NULL 허용
)
-- Table TBL_PIVOT이(가) 생성되었습니다.

INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 1, '박예린', 90 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 2, '박예린', 89 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 3, '박예린', 99 );  -- mat
 
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 4, '안시은', 56 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 5, '안시은', 45 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 6, '안시은', 12 );  -- mat 
 
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 7, '김민', 99 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 8, '김민', 85 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 9, '김민', 100 );  -- mat 

COMMIT; 

SELECT * 
FROM tbl_pivot;
 
1	박예린	90  k   1
2	박예린	89  e   2
3	박예린	99  m   0
4	안시은	56     1
5	안시은	45    2
6	안시은	12
7	김민	99
8	김민	85
9	김민	100
 
 -- 질문) 피봇
번호 이름 국,영,수
1 박예린  90 89 99
2 안시은  56 45 12
3 김민    99 85 100
-- 풀이.
  1) 피봇대상 *** 
-- 12:01 수업 시작~   
  IN ( 국어, 영어, 수학  )
  
  SELECT *
  FROM (
          SELECT   TRUNC( (no-1)/3 )  + 1  no
                , name
                , jumsu
                , DECODE( MOD( no, 3), 1, '국어', 2, '영어', 0, '수학' ) subject -- 과목
          FROM tbl_pivot
  )
  PIVOT(  MAX(jumsu)  FOR subject   IN ('국어',  '영어',  '수학'))
  ORDER BY no ASC;  
1월     12월 

-- 조민경
SELECT *
FROM (
    SELECT name, jumsu
    , ROW_NUMBER() OVER(PARTITION BY name ORDER BY no) r -- subejct
    FROM tbl_pivot
    )
PIVOT( SUM(jumsu)   FOR  r  IN ( 1 AS "국", 2"영", 3"수"));

-- 자바 - 임의의 수(난수)     0.0 <=   Math.radnom()   < 1.0
-- Oracle :  dbms_random 패키지 == 관련 함수, 프로시저 등등
--           PL/SQL  6가지 종류 : 패키지(package)

--------------------------------------------------------------------------------------------------------------------------------

               
                
 
 
 
 
 
 
 