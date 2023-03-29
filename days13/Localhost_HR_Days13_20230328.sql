-- HR --


= 비디오 가게(ShOP)  DB모델링 = [요구분석서]
 
	□ 실무자와 같이 업무적인 설명을 듣고 모델링을 시작해 보자.

		1. 회원제를 실시하는 비디오 상점.
		2. 회원 관리
			ㄱ) 회원이름, 주민번호, 전화번호, 휴대폰번호, 우편번호, 주소, 등록일 등 .
		3. 비디오 테이프 관리
			ㄱ) 장르별, 등급별로 나누어 관리.
			ㄴ) 고유한 일련번호를 부여해서 비디오 테이프를 관리. 
			ㄷ) 영화제목, 제작자, 제작 국가, 주연배우, 감독, 개봉일자, 비디오 출시일 등 상세 정보 관리.
			ㄹ) 파손 여부와 대여 여부 관리.		
		4. 비디오 테이프 대여
			ㄱ) 회수일이 기본 이틀
			ㄴ) 미납 회원들의 목록을 자동으로 관리.
			ㄷ) 연체되었을 경우에는 연체료를 받는다.
			ㄹ) 대여료 신/구 차등 관리.
		5. 포인터 관리 서비스
			ㄱ) 회원에게 대여 1회당 1점씩 포인트 점수를 부여하여 10점이 되면 무료로 TAPE 하나 대여 서비스
		6. 관리자 관리
			ㄱ) 일별 , 월별, 년별 매출액 손쉽게 파악.
			ㄴ) 비디오 테이프의 대여 회수 파악.
			ㄷ) 연체료 관리
			ㄹ) 미납 회원 관리.
			ㅂ) 직원 관리( 근무 시간, 임금 자동 계산 ) / 임금 + 근태관리
			ㅅ) 체인점을 확장해 운영하고 자 함.  
            
            
CREATE TABLE TBL_CSTVSBOARD (
      seq NUMBER NOT NULL PRIMARY KEY, -- 글번호(PK)
      writer VARCHAR2(20) NOT NULL ,  -- 작성자
      pwd  VARCHAR2(20) NOT NULL ,  -- 비밀번호
      email  VARCHAR2(100)  ,  -- 이메일
      title  VARCHAR2(200) NOT NULL ,  -- 제목
      writedate DATE DEFAULT SYSDATE, -- 작성일
      readed NUMBER DEFAULT 0, -- 조회수
      tag NUMBER(1) DEFAULT 0 ,   -- 0 텍스트모드  1 HTML 모드
      content CLOB   -- 글내용
); 
 
-- scott / tiger 비밀번호 수정
----------------------------------------------------------------------------------------------------------------------------------
-- 피봇 마지막 문제 --
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

               
                
 
 
 
 
 
 
 