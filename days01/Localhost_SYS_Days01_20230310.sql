1. 자바 프로젝트 발표 
  1) 각 팀장님 : 소스파일 + 발표자료 ( PPT ) 압축 -> 1조_이태규.zip  + 발표자( 줌 , 공통 호스트 )
  2) 발표 순서 : 1조(김지은), 2조(하동호), 3조(탁인혁)
                            9:56 발표시작   
  3) 발표 시간 : 20분 ~
  4) 발표 
      (1) 팀, 팀원 소개 
      (2) 발표자료 + 시현
      (3) 질문/답변
      (4) 각 팀원 후기(소감)

11:10 수업 시작~~~
-- 수/목 
-- 대답 X, 질문 X
-- 프로젝트 :  수업 내용 총 정리 + 취업

-- [오라클(Oracle)]--
1. Ora_Help.zip 파일 -> 압축 풀기
   C# -> Ora_Help 오라클 수업 교재 대신... 
2. OracleClass 폴더 생성
    C:\Class\WorkSpace
                ㄴ JavaClass 폴더 : 자바 수업                 
                ㄴ OracleClass 폴더 : 오라클 수업
                    ㄴ [.git 폴더 ]
                    ㄴ days01 폴더 
                    ㄴ days02 폴더 
                          :
3. 팀 GIT/GITHUB 스터디 - 형상관리(프로젝트 관리)
4. C:\Class\DownLoad 폴더 
   1) https://www.oracle.com/
   2)  OTN( Oracle Technology Network ) == 오라클 회원
       OTN(오라클 회원) 가입
       ㄱ. 로그인
      (1)오라클 다운로드 + 설치
          Oracle Database 21c   Enterprise Edition
          Oracle Database 19c   Enterprise Edition (also includes Standard Edition 2)
          Oracle Database 21c   Express Edition
          
         --> Oracle Database 11g  XE ( Express Edition )
          https://www.oracle.com/database/technologies/xe-prior-release-downloads.html          
         --> Oracle Database 11gR2 Express Edition for Windows x64 다운로드
                                        OracleXE112_Win64.zip
             
         -->  Oracle Database 11gR2 XE Documentation  링크 클릭
             https://docs.oracle.com/cd/E17781_01/index.htm    
             
      (2) 클라이언트 도구  다운로드 + 설치     
         ㄱ. 돋보기 :  sql developer 입력 후 검색         
         --> https://www.oracle.com/database/sqldeveloper/technologies/download/
         SQL Developer 22.2.1 Downloads
         Windows 64-bit with JDK 11 included
                                      sqldeveloper-22.2.1.234.1810-x64.zip
-- 12:13 수업 시작      --               
          Oracle Database 8i, 9i      i == internet
          Oracle Database 10g, 11g    g == grid( 그리드 )  
          Oracle Database 19c, 21c    c == cloud
          
         [오라클 에디션]
         1. Enterprise Edition( EE ) - CPU 4개 이상, 
         2. Standard Edition( SE )  - 모든 기본 기능 지원, CPU 4개 이하, 메모리 개수 X
         *** 3. Express Edition( XE )   - 무료  CPU 1개, 11GB, 1GB
         4. Standard Edition ONE( SEO )
         5. Personal Edition ( PE ) - 개인용 ( 1명 )
         6. Oracle Database Lite  - 모바일( mobile )용
--
5. 오라클 설치
   OracleXE112_Win64.zip -> 압축 풀기.
   1) SYS, SYSTEM 데이터베이스 계정( DBA ) + 비밀번호
     [ ss123$ ]
     [ ss123$ ]
   2) 오라클 설치화면 저장.

6. 클라이언트 도구  다운로드 + 설치 
   1) sqldeveloper-22.2.1.234.1810-x64 압축풀어서 C 드라이브에 복사 + 붙이기 
     바탕화면에 바로가기 - sqldeveloper-22.2.1.exe

7. 오라클 삭제
   1) 주요 오라클 서비스 중지.
     (1) 검색 : 서비스 .
     (2)  OracleService + [SID명] 서비스
          OracleService     XE
          오라클 XE를 1개만 설치된다.
          SID : XE  (기억)
          - 오라클 기본 서비스 ( 반드시 시작 )
     (3) Oracle[XE]TNSListener :   (반드시 시작 )  
          리스너 ? 네트워크를 통해서 오라클 서버와 클라이언트의 연결을 담당하는 프로그램.
   2) uninstall.exe 
      프로그램 추가/제거
      Oracle 11g XE - ... "제거" 
   3) C:\oraclexe 폴더도 삭제.
   4) 레지스트리 삭제
        "레지스트리 편집기"
        "regedit"   == reg + edit        
        HKEY_LOCAL_MACHINE 폴더의 하위 4개 곳 삭제...

--------------------------------------------------------------------------------
8. 개요
  1) Data (데이터)
    (1) 의미가 있는 정보를 가진 모든 값
        ( 사람, 자동기기가 생성 또는 처리하는 형태로 표시된 것. )
    (2) 정보( information ) - 의미를 부여한 값(결과)  
    (3) 재료, 자료, 논거 라는 뜻인 "datum"의 복수형이다.
    
  2) DB( DataBase == Data + Base )
    (1) Data(자료) + Base(저장소)
    (2) 공유되어 사용될 목적으로 통합 관리되는 "데이터의 집합"
    (3) 현실 세계에서 존재하는 유형, 무형 등 방대한 정보(==자료)의 집합.
    
  3) DBMS( DataBase Management System )
    (1) 데이터 집합 + 효율적으로 관리하는  시스템
    (2) 소프트웨어 ( 오피스 )
    (3) 오라클사( [ Oracle ], My SQL ), MS사( MS SQL ) 등등
    (4) 오라클 버젼별 특징 : 접미사  i, g, c
    (5) 오라클 종류( Edition) : SE, EE, PE, [XE], SEO 등등

9. 1521 포트 방화벽 해제.
     검색 : 방화벽 -> "방화벽 상태 확인" 클릭 -> "Windows Defender 방화벽" 창
     
10. 용어 정리 
  1) 오라클 서버( Oracle Server ) : 
    (1) 여러 개의 물리적인 파일들, 메모리, 프로세스들로 구성된다.
    (2) My Computer ( 노트북 ) - 오라클이 설치된 본인 컴퓨터
    (3) 오라클 데이터베이스 + 오라클 인스턴스로 구성된다. 
    
  2) 오라클 데이터베이스 ( Oracle Database )
    (1) 설치 초반에   "전역 데이터베이스 이름"을 입력하여 시작 데이터베이스 == 오라클 데이터베이스 
    (2) 오라클 데이터베이스 시스템 그 자체
    
    ㄴ 4) 전역 데이터베이스 이름                               [XE]
      (1) Global Database Name : 전세계에서 유일한 이름(값)
       - Global 전 세계
      (2) "데이터베이스명.도메인명"   
     (3) 오라클 데이터베이스를 식별하기 위한 유일한 이름(값)
  
  3) 오라클 인스턴스 ( Oracle Instance )
    (1) 자바 인스턴스 ...
    (2) 물리적인 파일에 접근하고 데이터베이스를 관리하기 위한 수단. 
        이런 역할하는              메모리 영역(SGA)+ 백그라운드 프로세스(background Process) 로 구성된다. 
    ㄴ 5) SID  ( System Identifier ) == 시스템 식별자.        [XE]
       오라클 데이터베이스 ( Oracle Database )이 아니라 오라클 인스턴스 ( Oracle Instance )를 식별하기 위한
       유일한 이름(값)
     
     
   (참고) 전역 데이터베이스 이름에서 도메인명을 생략하고 나면 SID 이름과 동일한다. 
   
 11. 오라클 서버와 연결해서 데이터 효율적으로 관리할 도구
   1) SQLPlus 툴 - 오라클 설치하면 자동으로 설치가 된다.
   *** 2) SQL Developer 도구 - 무료 ***
   3) 토드(Toad) - 가장 널리 사용되는 도구, 유료 X
      면접관 -> 왜 토드 사용 안했냐? X
   4) 오렌지, PL/SQL Developer 등등~   

3:06 수업 시작~   
12. 오라클 설치 폴더
    C:\oraclexe               [tnsname.ora] 검색하면 
    "파일 위치 열기"
    C:\oraclexe\app\oracle\product\11.2.0\server  \network\ADMIN
                                     Oracle HOme
                                     Ora Home
   ( 파일 내용 ) 
   XE =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = KeNiK-T495)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  )

    EXTPROC_CONNECTION_DATA =
      (DESCRIPTION =
        (ADDRESS_LIST =
          (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1))
        )
        (CONNECT_DATA =
          (SID = PLSExtProc)
          (PRESENTATION = RO)
        )
      )
    
    ORACLR_CONNECTION_DATA = 
      (DESCRIPTION = 
        (ADDRESS_LIST = 
          (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1)) 
        ) 
        (CONNECT_DATA = 
          (SID = CLRExtProc) 
          (PRESENTATION = RO) 
        ) 
      ) 
 
   (1) tnsname.ora 파일의 용도
       - 파일 확장자   .oar            : oracle 파일
       - 본인 컴퓨터 +   오라클 설치
            본인컴퓨터와  오라클 데이터베이스를 연결 설정 정보 : tnsname.ora 파일

13. 오라클 설치할 때 DBA(DB 관리자)
   [SYS]            최고 오라클 계정   ss123$  
   SYSTEM           오라클 계정   ss123$

14. 데이터(data)를 효율적으로 관리하는 시스템 : DBMS ( Oracle )
    데이터 저장 -> 물리적 파일로 저장 (  .dbf 또는 .ora )
    논리적 개념 :  데이터 블록(data block) < 익스텐드(extent)  < 세그먼드(segment) < 테이블스페이스( table space)
    으로 데이터 관리.
    
    1) 테이블스페이스
        - 최소한 물리적인 파일  1개 이상으로 구성된다. 
    2) 테이블스페이스 4가지 종류
      (1) SYSTEM  - SYS, SYSTEM DBA가 소유한 객체 저장소
                  - 데이터 사전(딕셔너리) 저장  
                  - SYSTEM.DBF
                  
      (2) TEMP    - 임시 저장소
                  - SQL 문장이 실행될 때 정렬 작업을 위해 마련된 공간. 
                  - TEMP.DBF
                  
      (3) UNDOTBS1 - UNDO 취소( 되돌리기 )
                   - ROLLBACK 을 위한 저장소
                   -UNDOTBS1.DBF
                   
      (4) EXAMPLE - 예제 테이블 스페이스.
                

     C:\oraclexe\app\oracle\[oradata]\XE
        CONTROL.DBF
        SYSAUX.DBF
        USERS.DBF
     
   3) 테이블스페이스 생성 + 팀 프로젝트할 때 데이터 저장
      GoGoOracle 테이블스페이스 생성 + GoGoOracle.DBF

   
15. 오라클 서버( Oracle DB ) <-------- 데이터 관리(CRUD)X  + 연결          ---  클라이언트 도구( SQL Developer )  
       PC
                                         SQL, PL/SQL(오라클)

  1) 클라이언트 도구 + (연결 connect) + 오라클 서버
     (1) 명령 프롬프트 실행
       C:\Windows\System32>_
       C:\Windows\System32>sqlplus
       C:\Windows\System32>sqlplus /?
     
     Usage 1: sqlplus -H | -V

            -H             Displays the SQL*Plus version and the
                   usage help.
            -V             Displays the SQL*Plus version.

    Usage 2: sqlplus [ [<option>] [{logon | /nolog}] [<start>] ]


     C:\Windows\System32>sqlplus sys/ss123$ as sysdba
     SQL*Plus: Release 11.2.0.2.0 Production on ?3?10 15:50:27 2023

    Copyright (c) 1982, 2014, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
    
    SQL>_
        sqlplus 명령어
        sql , pl/sql 
        
    SQL> show user 
    USER is "SYS"
    
    SQL>_         SQL
       모든 사용자 계정(SYS,SYSTEM 외에 ) 조회 - SQL 문 작성 
       
    SQL> SELECT *
      2  FROM all_users;
    
    USERNAME                          USER_ID CREATED
    ------------------------------ ---------- --------
    XS$NULL                        2147483638 14/05/29
    SCOTT                                  52 22/09/26
    APEX_040000                            47 14/05/29
    APEX_PUBLIC_USER                       45 14/05/29
    FLOWS_FILES                            44 14/05/29
    HR                                     43 14/05/29
    MDSYS                                  42 14/05/29
    ANONYMOUS                              35 14/05/29
    XDB                                    34 14/05/29
    CTXSYS                                 32 14/05/29
    APPQOSSYS                              30 14/05/29
    
    USERNAME                          USER_ID CREATED
    ------------------------------ ---------- --------
    DBSNMP                                 29 14/05/29
    ORACLE_OCM                             21 14/05/29
    DIP                                    14 14/05/29
    OUTLN                                   9 14/05/29
    SYSTEM                                  5 14/05/29
    SYS                                     0 14/05/29
    
    17 rows selected.
    
    SQL>   
     
  2) 클라이언트 도구       + (데이터 관리(CRUD)       + 오라클 서버
      sqlplus.exe             Connected        Oracle Database 
      sql developer           SQL , PL/SQL   
      [sql문작성]
      select * 
      from all_users;


    SQL> exit
    Disconnected from Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
    
    C:\Windows\System32>_
        
4:10 수업 시작~~        
16.  SQL Developer 도구...사용.

17. 데이터 모델 ? 컴퓨터에 데이터를 저장하는 방식을 정의해 놓은 개념 모델
    데이터 모델의 종류 - 계층형, 네트워크형,  [관계형], 객체 지향적 데이터 모델 등등
    현대에서 가장 많이 사용하는 데이터 모델  - 관계형 데이터 모델
    
    오라클       [R(관계형)]DBMS
    - 데이터 간의 관계에 초점을 둔 모델.
    - 데이터 저장소(테이블)과 테이블 간의 관계에 초점을 둔 모델..
   
18. 관계형 데이터 모델의 핵심 구성 요소
  1) 개체(Entity) - 데이터를 저장하는 가장 작은 단위 == RDMBS  테이블(table) == 릴레이션 ( relation )
  2) 속성(Attribute) - 개체의 특징, 종류, 상태      ==    컬럼(열) Column
  3) 관계(Relationship) - 개체와 개체 간의 연관성
  
  예)  사원 개체(Entity)             소속관계                   부서 개체(Entity) 
       
       속성(Attibute)                                            속성       
       사원명                                                    부서번호  
       연락처                                                    부서명
       직급                                                      부서위치
       등등                                                        등등
    
    클라이언트도구       데이터 관리                 오라클서버
                       언어 SQL, PL/SQL
    
19. SQL이란 ? 
  1) [S]tructured [Q]uery [L]anguage(SQL)
     구조화된      질의     언어
  2) 단순 질의  +  DB 생성, 삭제, Table 생성 ,갱신, 삭제 등등 운영 작업   
  3) SQL은 기본적으로 릴레이션(relation:관계) 즉, 테이블을 대상으로 수행되며
     테이블에는 기본 테이블(base table)과 뷰(view)가 있다.
  4) PL/SQL 이란 ? 절차적인 언어(Procedural Language )확장 + SQL   
  5) SQL문의  5가지 종류
    (1) DQL - 검색 :  SELECT문
    (2) DDL - 정의 :  CREATE, DROP, ALTER문
       (Data definition language )
    (3) DML - 조작 :  INSERT, DELETE, UPDATE, RENAME, TRUNCATE 문
       (Data manipulation languag) 
    (4) DCL - 권한 : GRANT, REVOKE문
       (Data control language) 
    (5) TCL - 트랜잭션 : COMMIT, ROLLBACK, SAVEPOINT문
      (Transaction Control Language )
  
  다음 주 월~   
  6) SQL 문장 작성법    
    
20. SQL*Plus이란? 
    SQL 및 PL/SQL 문장을 인식하고 실행시켜주는 Oracle Tool,
    사용자와 물리적 Database 간의 Interface를 담당하는 도구,
    즉, DBMS와 user간의 통신수단임

    
-------------------------------------------------------------------------------------------------------
-- 홍 1
-------------------------------------------------------------------------------------------------------
1) 테이블스페이스 생성
CREATE TABLESPACE myts DATAFILE 
'C:\oraclexe\app\oracle\oradata\XE\myts.dbf' SIZE 100M AUTOEXTEND ON NEXT 5M;
2) 사용자 생성
CREATE USER ora_user IDENTIFIED BY hong
DEFAULT TABLESPACE myts
TEMPORARY TABLESPACE temp;
3) 롤 부여
GRANT DBA TO ora_user;
4) 샘플 스키마.
  (1) https://github.com/gilbutitbook/006696
  (2) C:\Class\WorkSpace\OracleClass\days01>imp ora_user/hong file=expall.dmp log=empall.log ignore=y grants=y rows=y indexes=y full=y
  
CHANNELS : 판매 채널 테이블
COUNTRIES : 국가 
CUSTOMERS : 고객
DEPARTMENTS : 부서
EMPLOYEES : 사원
JOB_HISTORY : 잡 히스토리
JOBS : 잡
KOR_LOAN_STATUS :
PRODUCTS : 제품
    








