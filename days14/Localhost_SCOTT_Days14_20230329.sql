-- SCOTT -- 
1) 요구분석        -> 요구분석서(요구명세서) 작성
2) 개념적 DB 모델링 (  ERD  )
3) 논리적 DB 모델링 
    (1) 부모 테이블과 자식 테이블 : 생성 순서, 관계의 주체 
        관계형 데이터베이스 (RDBMS)        
        예) dept 테이블  <소속관계>  emp 테이블   - 생성 순서
              부모                    자식                        
        예) 고객 테이블   <주문관계>  상품 테이블  - 생성 순서 X, 관계 주체
              부모                     자식
        
    (2) 기본키( Priamry key )와 외래키( Foreign key )
        부(dept)    관계      자(emp) 
        PK                           deptno(FK) 외래키
        deptno(참조키)
       기본적으로 부모테이블의 PK 는 자식 테이블의 FK로 전이되어진다.
    
    10:02 수업 시작~ 
    (3) 식별관계와 비식별 관계
        ㄱ. 비식별관계(점선) : 부모테이블의 PK가 자식테이블의 일반 컬럼으로 전이되는 것.
        ㄴ. 식별 관계(실선)  : 부모테이블의 PK가 자식테이블의 PK로 전이 되는 것.
--------------------------------------------------------------------------------    
    *** 3) 논리적 DB 모델링 ***
             (1) 관계 스키마 생성 ( 매핑룰)
             (2) 정규화(NF) 작업
             
           ㄱ. Mapping Rule 이란 ? 
              - 개념적 DB 모델링에서 도출된 [개체 타입]과 [관계 타입]의 [테이블 정의] 의미
                                                                   "관계 스키마"
                즉, ERD을 이용해 관계 스키마를 생성하기 위해서 지키는 규칙을 "매핑룰"이라고 한다. 
              - [ 매핑룰 5가지  규칙 ]  
                1단계) 단순 엔티티 -> 테이블 
                2단계) 속성       -> 컬럼
                3단계) 식별자     -> 기본키
                4단계) 관계       -> 테이블 O X
                
                ERD ->   매핑룰-> 관계스키마           
--------------------------------------------------------------------------------                
           - 개념적 스키마      -> 논리적 스키마 
           -  ERD             -> 테이블 스키마
           -  ERD ->   매핑룰  -> 관계 스키마           
                                 관계형 모델
                                 
    4.1 매핑룰( 릴레이션 스키마 변환 규칙 )
        4.1.1 규칙1: 모든 개체는 릴레이션(테이블)으로 변환한다
            [E] -> table
             AAA      column 변환
        4.1.2 규칙2: 다대다(n:m) 관계는 릴레이션(테이블)으로 변환한다
            고객  n     <주문>        m  상품
                        주문테이블 변환                        
        4.1.3 규칙3: 일대다(1:n) 관계는 외래키로 표현한다
            부서(DEPT) 1             n  사원(EMP)
            deptno(PK)                   deptno(FK)
        
        4.1.4 규칙4: 일대일(1:1) 관계를 외래키로 표현한다
            남자  <혼인>  여자            
              혼인테이블 생성 : 남자FK, 여자FK
        
        4.1.5 규칙5: 다중 값 속성은 릴레이션으로 변환한다
           사원T
           A  부장     ((부하직원))
           
           [사원-부하직원 테이블] 생성
        
        4.1.6 기타 고려 사항 
           
11:03 수업시작~                            
--------------------------------------------------------------------------------           
    EXERD 모델링 툴(도구)를 사용해서   ERD -> 매핑룰 ->   [논리적 DB 모델링]  
    관계 스키마 생성하고 나면
    --  이상( Anomaly )  이해 필요.
    많은 문제 발생. == 이상( Anomaly ) == INSERT(삽입이상), DELETE(삭제이상),  UPDATE(수정 이상)
    --  이상 제거  => 정규화 작업
    
    -- "함수적 종속성" 이란?  속성들 간에 관련성.    
    예)
        X            Y
       사원번호(PK)  사원명  주소   직급   부서명
    
       부서번호(PK)  부서명   지역명
    
        X       Y
      고객ID   고객명   등급      
      PK         
      
     -- Y는 X에 종속성이 있다.
     -- X      ->  Y
     -- 결정자      종속자
     -- PK
    
      신청이벤트번호 이벤트당첨여부
      PK

  12:03 수업 시작
--------------------------------------------------------------------------------  
           
      (1) 완전 함수적 종속
          여러 개의 속성이 모여서 하나의 기본키를 이룰 때( 복합키 )
          복합키 전체에 어떤 속성이 종속적일 때 " 완전 함수적 종속"이라고 한다. 
          
              복합키        완전함수적 종속           부분함수적 종속   부분 함수적 종속
          [고객ID][이벤트ID]   당첨여부              등급              고객명
           kenik   E001         Y                  vip             홍길동
           
      (2) 부분 함수적 종속
         == 완전 함수적 종속이 아니면 부분 함수적 종속이다.
         성별: 남/여
         
         여러 개의 속성이 모여서 하나의 기본키를 이룰 때( 복합키 )
         복합키 전체에 어떤 속성이 종속적이지 않을 때 " 부분 함수적 종속"이라고 한다. 
      
      (3) 이행 함수적 종속
        X   -> Y         Y ->  Z        일때    X -> Z 관계
        ID   고객명   
        PK
--------------------------------------------------------------------------------
 -- 정규화 --
3.1 정규화의 개념과 종류
    3.2 제1정규형
      릴레이션(테이블)에 속한 모든 속성(컬럼)의 도메인이 원자 값(atomic value)으로만 구성되어 있으면
      제1정규형에 속한다.
      
      예) 
      [고객+이벤트 당첨 테이블 ]
      고객ID / 이벤트ID / 당첨여부 / 등급
      apple     E001      Y        gold
      apple     E002      N        gold
      apple     E003      N        gold
      apple     E004      Y        gold
      
      고객ID, 등급   속성에서 반복되는 속성값을 제거 하는 작업 -> 제1정규화한다. 
      
      [고객테이블]
      apple  홍길동   gold
      
      
      
      [등급]
      1   gold
      2    vip
      3   vvip
      
      
      [비디오]
        1     홍길동전  홍길동   액션 ..
        2     홍길동전  홍길동   액션 ..
        3     홍길동전  홍길동   액션 ..
        4     홍길동전  홍길동   액션 ..
        
      
      
    3.3 제2정규형
     - 릴레이션이 제1정규형에 속하고,
       기본키가 아닌 모든 속성이 기본키에 "완전 함수 종속"되면
       제2정규형에 속한다.
     - 부분 함수적 종속을 제거하는 작업 
     - 복합키 일때...
     
     2:00 수업 시작~ 
    3.4 제3정규형
    릴레이션이 제2정규형에 속하고,
    기본키가 아닌 모든 속성이 기본키에 이행적 함수 종속이 되지 않으면 제3정규형에 속한다.
    - 이행 함수 종속성 제거
    결정자 종속자
    PK
    X - >  Y
    Y속성은 X속성에 종속적이다.
    
    예)
    [ 사원테이블  ]
    empno(PK)  ename, deptno(FK), hiredate  , dname
    X->   Y        Y->      Z
    empno deptno   deptno   dname
    
    [ 사원테이블  ]
    empno(PK)  ename, deptno(XXX), hiredate
    
    [ 부서테이블]
    deptno(PK)  dname
    
    예) 
    회원테이블 에서                         [우편번호 테이블]주소<-우편번호(PK)
    
    3.5 보이스/코드 정규형
      [ Boyce/Codd Normal Form ]  == BCNF
      릴레이션의 함수 종속 관계에서 모든 결정자가 후보키이면 보이스/코드 정규형에 속한다.
      
      [강좌신청테이블]
            복합키
      [고객ID] + [인터넷강좌] 담당강사번호
       apple      영어회화     P001
       banana     기초토익     P002
       apple      기초토익     PXXX
 
      (1)
         복합키( 고객ID+인터넷강좌) -> 담당강사번호
              [ A      B  ] ->           C
          담당강사번호            ->   인터넷강좌
               C  -> B
               
          [ A , C ]             고객ID , 담당강사번호          
          [ C -> B ]            담당강사번호(PK) 인터넷강좌
          
          
    
    3.6 제4정규형과 제5정규형  X
     

--------------------------------------------------------------------------------
 4) 물리적 DB 모델링
   - 컬럼 타입, 크기, 제약조건, 인덱스, 트리거, 관계차수 등등
   - 논리적 DB 모델링 단계에서 얻어진 데이터베이스스키마(관계스키마,테이블스키마)를
     더 효율적으로 구현하기 위한 작업.
     예) 우편번호/주소 테이블 -> 효율성 -> 회원테이블 ..
   - DBMS(오라클)의 특성에 맞게 실제 데이터베이스 내의 개체들을 정의하는 단계.
   - (중요한점)  : 데이터 사용량 분석, 업무 프로세스를 분석해서 더
       ㄴ 성능 체크
       ㄴ 효율 체크
       
   - 역정규화.  인덱스   
   
   3:01 수업 시작~~~ 

--------------------------------------------------------------------------------
 [특수한 경우의 엔티티 모델링 ]
 1) 슈퍼타입 엔티티/ 서브타입 엔티티
   예)  정규직사원
        비정규직사원
        
       (1)  슈퍼 타입 : 전체를 하나의 테이블로 관리하는 것.
       사원 테이블 1개
       정/비 공통적인 컬럼(속성)
       [][][][][][][][][][][][정][정][정][정][정][정][비][비][비][비][비][비][비]
       ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ nullnullnullnullnullnull
       ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ nullnullnullnullnullnull
       ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌnullnullnullnullnullnullㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ 
       ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ nullnullnullnullnullnull
       ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌnullnullnullnullnullnullㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ 
       ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ nullnullnullnullnullnull
       ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌnullnullnullnullnullnullㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ 
       ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌnullnullnullnullnullnullㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ 
       
       - 정규직,비정규직사원의 고유 컬럼이 많지 않고, 전체에 대한 업무가 많은 경우에는 
         하나의 테이블로 설계하는 것이 유리하다. 
         
       2) 서브 타입 : 정규직 사원, 비정규직 사원 , (서브 타입의 갯수 만큼) 테이블을 설계하는 방법.
        - 정규직사원테이블
        [][][][][][][][][][][][정][정][정][정][정][정]
        
        - 비정규직사원테이블 
        [][][][][][][][][][][][비][비][비][비][비][비][비]
       
       3) 사원테이블   1개        정FK 비정FK
          [1001][][][][][][][][]  [O]  [null]
          [1001][][][][][][][][]  [null]  [O]
          
          정규직테이블 1개
          PK[정][정][정][정][정][정]
          
          비정규직테이블 1개
          PK[비][비][비][비][비][비][비]
       
 2) 재귀적 관계
     empno      mgr
     1232      2323
-------------------------------------------------------------------------------- 
VIEW
PL/SQL
-------------------------------------------------------------------------------- 









    
    
    
    
    
    
    