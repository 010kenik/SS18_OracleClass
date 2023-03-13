-- HR --
--[문제] ht 이  소유하고 있는 테이블 목록 정보를 조회.
SELECT *
FROM user_tables;

[테이블명]  table == 데이터 저장소
테이블의 구조 확인해보면 -> 어떤 데이터가 저장되어지는 지 파악해야 겠다.

4:10 쉬는 시간 + 5분
4:16 수업 시작
1조 분석)
어떤 대륙에 어떤 나라 있는 지 정보 나타내는 테이블들이네요.

1. REGIONS :  "대륙 정보"를 갖고 있는 테이블
   1) 
   DESC REGIONS;
   이름          널?       유형           
----------- -------- ------------ 
REGION_ID   NOT NULL NUMBER         지역아이디
REGION_NAME          VARCHAR2(25)   지역명
  2) 데이터 확인
  SELECT *
  FROM regions;
1	Europe
2	Americas
3	Asia
4	Middle East and Africa

2. COUNTRIES : 국가 테이블
  1) 
  DESC COUNTRIES;
  이름           널?       유형           
------------ -------- ------------ 
COUNTRY_ID   NOT NULL CHAR(2)      
COUNTRY_NAME          VARCHAR2(40) 
REGION_ID             NUMBER    지역아이디
  2) 
  SELECT *
  FROM COUNTRIES;

2조 분석)
3. LOCATIONS : 위치 테이블
   DESC LOCATIONS;
이름             널?       유형           
-------------- -------- ------------ 
LOCATION_ID    NOT NULL NUMBER(4)    위치 아이디
STREET_ADDRESS          VARCHAR2(40)  주소
POSTAL_CODE             VARCHAR2(12)  우편번호
CITY           NOT NULL VARCHAR2(30)   시티
STATE_PROVINCE          VARCHAR2(25) 
COUNTRY_ID              CHAR(2)        

4. DEPARTMENTS : 부서 테이블
DESC DEPARTMENTS;
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)     부서아이디
DEPARTMENT_NAME NOT NULL VARCHAR2(30)   부서명
MANAGER_ID               NUMBER(6)     부서장아이디
LOCATION_ID              NUMBER(4)      위치아이디

3조 분석)
5. JOBS : 잡 테이블
  DESC JOBS;
이름         널?       유형           
---------- -------- ------------ 
JOB_ID     NOT NULL VARCHAR2(10)   잡아이디.
JOB_TITLE  NOT NULL VARCHAR2(35)   잡 제목
MIN_SALARY          NUMBER(6)      최소 기본급
MAX_SALARY          NUMBER(6)      최대 기본급

6. EMPLOYEES :
DESC EMPLOYEES;
이름(컬럼명)     널?(널허용X)  유형     
               NOT NULL 널허용 X == 필수입력항목
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)     사원번호(ID)
   사원아이디는 필수입력항목이고, 숫자 6자리이다.

FIRST_NAME              VARCHAR2(20) f 이름
LAST_NAME      NOT NULL VARCHAR2(25) l 이름

EMAIL          NOT NULL VARCHAR2(25) 이메일
PHONE_NUMBER            VARCHAR2(20) 폰번호
HIRE_DATE      NOT NULL DATE         입사일자
JOB_ID         NOT NULL VARCHAR2(10) 잡ID
SALARY                  NUMBER(8,2)  기본급
COMMISSION_PCT          NUMBER(2,2)  커미션
MANAGER_ID              NUMBER(6)    직속상사아이디
DEPARTMENT_ID           NUMBER(4)    부서아이디

오라클 자료형 : NUMBER( 숫자 ), VARCHAR2 (문자,문자열), DATE (날짜)

7. JOB_HISTORY : 잡 히스토리 테이블
  DESC JOB_HISTORY;
이름            널?       유형           
------------- -------- ------------ 
EMPLOYEE_ID   NOT NULL NUMBER(6)      사원아이디
START_DATE    NOT NULL DATE           시작날짜
END_DATE      NOT NULL DATE           종료날짜
JOB_ID        NOT NULL VARCHAR2(10)   잡 아이디
DEPARTMENT_ID          NUMBER(4)      부서아이디

SELECT *
FROM JOB_HISTORY;


