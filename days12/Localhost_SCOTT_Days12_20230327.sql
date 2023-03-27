-- SCOTT -- 

-- 9:45 제출
--------------------------------------------------------------------------------------------------------------------------------
-- 복습 문제 --
--1.  truncate / delete / drop 대해서 설명하세요
--     DDL : CREATE, ALTER , [ DROP ] 
--     DML : INSERT, UPDATE, [DELETE], [TRUNCATE], RENAME + 커밋, 롤백
                              삭제         삭제 + 자동 커밋.
INSERT ~

--2.  insert 문 수행 중 다음과 같은 오류가 발생했다면 이유에 대해 설명하세요
--  ㄱ. 00947. 00000 -  "not enough values"
     INSERT INTO emp ( empno, ename, hiredate ) VALUES ( 2222, 'aaa');
--  ㄴ. ORA-00001: unique constraint (SCOTT.SYS_C007770) violated  
      SYS_?????  제약조건 이름 자동 부여
      PK_테이블명_컬럼명
      PK_EMP_EMPNO
      UK 유일성 제약조건, 중복 X
      
    empno 7369 SMITH
    INSERT    empno    VALUES ( 7369 )  PK 제약조건 위배 = UK + NN
    
     개체 무결성..
      
--  ㄷ. ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
--    무결성 제약조건 위배 :  FK_DEPTNO 포린키==참조키== 외래키
    dept 테이블에 : deptno 10,20,30,40     부모테이블( parent )
    
    관계: RDBMS      소속관계  dept.deptno(PK) -> emp.deptno(FK) 
    
    INSERT emp 테이블에서 : deptno(FK) 50  자식테이블( child )
    
    개체, [참조], 도메인 무결성
    
    kor NUMBER(3)  -999~999                  0~100 CHECK 제약조건 설정


-- 10:07 수업 시작~~

--3. 서브쿼리를 사용해서 테이블 생성
--  ㄱ. deptno, dname, empno, ename, sal+nvl(comm,0) pay, grade 컬럼을 가진 새로운 테이블 생성
--  ㄴ. 테이블명 : tbl_empdeptgrade   

dept : deptno, dname
emp  : empno, ename, sal, comm
salgrade : grade 

3개 테이블 조인
-- ORA-00918: column ambiguously defined

CREATE TABLE tbl_empdeptgrade
AS ( 
     SELECT d.deptno, dname, empno, ename, sal+nvl(comm,0) pay, grade
     FROM emp e JOIN dept d ON d.deptno = e.deptno
                JOIN salgrade s ON e.sal BETWEEN losal AND hisal
);

--4-1. insa 테이블에서 num, name 가져와서 tbl_score 테이블 생성
--     (tbl_score 테이블이 있으면 삭제 후 시작하세요 )
CREATE TABLE tbl_score
AS ( 
     SELECT num, name
     FROM insa
);

--4-2. kor, eng, mat, tot          , avg , grade, rank 컬럼 추가

ALTER TABLE tbl_score
ADD (
        kor NUMBER(3)
        , 
        
        , grade NVARCHAR2(3)      --  CHAR(1 CHAR) 'A'~'F'
        , rank NUMBER(3)
);


--4-3. 각 학생들의 kor,eng,mat 점수 0~100 랜덤하게 채워넣기.
UPDATE tbl_score
SET   kor = TRUNC( dbms_random.value(0, 101) )
, eng = TRUNC( dbms_random.value(0, 101) )
, mat = TRUNC( dbms_random.value(0, 101) );

--4-4. 총점, 평균, 등급, 등수 수정     *****
--    조건)
--     등급은 모든 과목이 40점이상이고, 평균 60 이상이면 "합격"
--           평균 60 이상이라도 한 과목이라 40점 미만이라면  "과락"
--           그외는 "불합격" 이라고 저장.


정보처리기능사/기사 실기          과락  40 미만,  평균 60 

UPDATE tbl_score  a
SET  tot =  kor+eng+mat
, avg = (kor+eng+mat)/3   -- NUMBER(5,2)
, grade = CASE
                    WHEN  kor>=40 AND eng>=40 AND mat>=40 AND 평 >=60 THEN '합격'
                    WHEN (kor<40 OR eng<40 OR mat<40) AND 평 >=60  THEN '과락'
                    ELSE '불합격'
          END
, rank = (  SELECT COUNT(*)+1  FROM tbl_score b WHERE b.총 > a.총)

--             
--5.  emp 테이블의 구조를 확인하고, 제약조건을 확인하고, 임의의 사원 정보를 추가하는 INSERT 문을 작성하세요.
--   ㄱ. 구조확인 쿼리 
DESC emp;

--   ㄴ. 제약조건 확인 쿼리
SELECT *
FROM user_constraints
WHERE table_name = 'EMP'; -- 뷰(VIEW)
FROM user_users;
FROM user_tables;
--   ㄷ. INSERT 쿼리 
--
--6-1. emp 테이블의 구조만 복사해서 새로운 tbl_emp10, tbl_emp20, tbl_emp30, tbl_emp40 테이블을 생성하세요. 
CREATE TABLE tbl_emp10
AS
  (     SELECT * FROM emp WHErE 1=0    )
  
  CREATE TABLE tbl_emp20
AS
  (     SELECT * FROM emp WHErE 1=0    )
  
  CREATE TABLE tbl_emp30
AS
  (     SELECT * FROM emp WHErE 1=0    )
  
  CREATE TABLE tbl_emp40
AS
  (     SELECT * FROM emp WHErE 1=0    )

--6-2. emp 테이블의 각 부서에 해당하는 사원정보를  위에서 생성한 테이블에 INSERT 하는 쿼리를 작성하세요.   

다중 INSERT문  4가지
1. UC I A           X
2. C I A
3. P I              X
4. C I F

INSERT ALL
   WHEN deptno = 10 THEN
      INTO tbl_emp10 VALUES ( 컬럼명.... )
   WHEN  deptno = 10 THEN
      INTO tbl_emp20 VALUES ( 컬럼명.... )
     :
  SELECT * FROM emp;   

--7. 조건이 있는 다중 INSERT 문에서  INSERT ALL 과 INSERT FIRST 문에 대한 차이점을 설명하세요.
        MILLER  20 , CLEAK
           WHEN deptno= 20 THEN  
              INTO 테이블명
           WHEN  job = 점원 THEN
             INTO 테이블명
--
--8. 제약조건( Contratrint ) 
--  ㄱ. 제약조건이란 ?  테이블에 DML 작업 시 데이타 무결성 위한 규칙 
--       데이타 무결성 ? 데이터가 허가 되지 않는 값으로 추가,수정,삭제 제한하는 특성.

--  ㄴ. 제약조건을 설정하는 2가지 방법에 대해 설명하세요.
--        컬럼레벨 - IN-LINE
          테이블레벨 - OUT-LINE
          
--  ㄷ. 제약조건의 5가지 종류 
--      PK, FK, NN, CK, UK

--  ㄹ. emp 테이블의 제약조건 확인 쿼리 작성 
--     
--  ㅁ. 데이터 무결성 종류 및 설명
       개체,
       참조,
       도메인 무결성
--------------------------------------------------------------------------------------------------------------------------------
-- [ 병합(MERGE) ]
 ㄴ  사전적 의미 : 합치다, 병합하다.
 ㄴ  '구조가 같은' 두 개의 테이블을 비교하여 하나의 테이블로 합치기 위한 데이터 조작이다
 ㄴ  왜 ?  하루(수십만건), 지점별로 테이블을 따로 관리 -> 년말 ( 병합 )
 ㄴ  A                         B
   a1   100(INSERT)           a2 100
   a2   200(UPDATE)           a3 200
   
   A->B 병합
 ㄴ  여러 데이터 소스로부터 다양한 데이터를 수집해서 작업을 수행하는 dataware housing등에 적용하면 유용하다. 
 ㄴ 【형식】
    MERGE [hint] INTO [schema.] {table ¦ view} [t_alias]
      USING {{[schema.] {table ¦ view}} ¦
            subquery} [t_alias]
      ON (condition) [merge_update_clause] [merge_insert_clause] [error_logging_clause];

    【merge_update_clause 형식】
       WHEN MATCHED THEN UPDATE SET {column = {expr ¦ DEFAULT},...}
         [where_clause] [DELETE where_clause]
    
    【merge_insert_clause 형식】
       WHEN MATCHED THEN INSERT [(column,...)]
        VALUES ({expr,... ¦ DEFAULT}) [where_clause]
       
    【where_clause 형식】
       WHERE condition
    
    【error_logging_clause 형식】
       LOG ERROR [INTO [schema.] table] [(simple_expression)]
         [REJECT LIMIT {integer ¦ UNLIMITED}]
 
   (실습)
   CREATE TABLE tbl_emp(
        id     number primary key, 
        name   varchar2(10) not null,
        salary  number,
        bonus number default 100
   );
   -- Table TBL_EMP이(가) 생성되었습니다.
   
    insert into tbl_emp(id,name,salary) values(1001,'jijoe',150);
    insert into tbl_emp(id,name,salary) values(1002,'cho',130);
    insert into tbl_emp(id,name,salary) values(1003,'kim',140);
   COMMIT;
   
   SELECT *
   FROM tbl_emp;
   
   create table tbl_bonus(
    id number
    , bonus number default 100
  );
  -- Table TBL_BONUS이(가) 생성되었습니다.
  insert into tbl_bonus(id)
     (select e.id from tbl_emp e);
     COMMIT;
  SELECT *
  FROM tbl_bonus;   
  
  -- tbl_bonus 테이블
  id    bonus
  1001	100
  1002	100
  1003	100
  1004	 50
  
  -- tbl_emp 테이블
   id   name   sal  bonus
  1001	jijoe	150	100
  1002	cho	    130	100
  1003	kim	    140	100
  
  INSERT INTO tbl_bonus VALUES( 1004, 50 );
  -- 1 행 이(가) 삽입되었습니다
  COMMIT;
  
  -- 병합(MERGE)  tbl_emp + tbl_bonus 두 테이블 병합
  MERGE INTO tbl_bonus  b
  USING ( SELECT id, salary FROM tbl_emp  )  e
  ON ( b.id = e.id )
  WHEN MATCHED THEN 
     UPDATE SET  b.bonus = b.bonus + e.salary * 0.01 
  WHEN NOT MATCHED THEN 
     INSERT (b.id, b.bonus) VALUES ( e.id, e.salary*0.01) ;
  -- WHERE 조건절     
   
  DROP TABLE tbl_emp PURGE; 
  DROP TABLE tbl_bonus PURGE; 
  
  -- 병합 문제)
  CREATE TABLE tbl_merge1
    (
         id number primary key
       , name varchar2(20)
       , pay number
       , sudang number             
    );
    
    CREATE TABLE tbl_merge2
    (
       id number primary key 
       , sudang number             
    );
   
  -- Table TBL_MERGE1이(가) 생성되었습니다. 
  -- Table TBL_MERGE2이(가) 생성되었습니다.
  
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (1, 'a', 100, 10);
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (2, 'b', 150, 20);
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (3, 'c', 130, 0);
    
INSERT INTO tbl_merge2 (id, sudang) VALUES (2,5);
INSERT INTO tbl_merge2 (id, sudang) VALUES (3,10);
INSERT INTO tbl_merge2 (id, sudang) VALUES (4,20);

COMMIT;
   
   tbl_merge1
   1     INSERT
   2     UPDATE
   3     UPDATE
   
   tbl_merge2
   아이디   수당
   2      5
   3      10
   4      20
   
   문제) tbl_merge1을 tbl_merge2에 병합 ( id, sudang )
   MERGE INTO tbl_merge2 t2
   USING ( SELECT id, sudang FROM tbl_merge1 ) t1
   -- USING (  tbl_merge1 ) t1
   ON ( t1.id = t2.id )
   WHEN  MATCHED  THEN  -- UPDATE
     UPDATE SET t2.sudang = t2.sudang + t1.sudang
   WHEN NOT MATCHED THEN -- INSERT
     INSERT ( t2.id, t2.sudang )  VALUES ( t1.id, t1.sudang);
   
   SELECT * 
   FROM tbl_merge2;
   
   id= 1    새로 INSERT, 
   id=2,3    UPDATE
   
   
  DROP TABLE tbl_merge1 PURGE; 
  DROP TABLE tbl_merge2 PURGE; 
--------------------------------------------------------------------------------------------------------------------------------
  11:00 수업 시작
  -- 제약조건( cosntraint ) --
  1. 테이블에 부여된 제약조건 확인
  SELECT *
  FROM user_constraints
  WHERE table_name = 'EMP';
        제약조건명   제약조건_타입
  SCOTT	PK_EMP	    P    ==  PRIMARY KEY(고유키)
  SCOTT	FK_DEPTNO	R    ==  FOREIGN KEY(외래키, 참조키)
  
  2. 제약조건( constraint )
    1) 테이블에 레코드(행)을 추가,수정,삭제할 때의 적용되는  규칙
    2) DATA INTERGRITY ( 데이타 무결성 ) == 결함이 없는 데이타  
    3) 테이블에 의해 참조되고 있는 경우 테이블의 삭제 방지를 위해서도 사용된다
   
   DELETE FROM dept
   WHERE deptno = 10;
   --ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found  
   emp 자식테이블에서 사원 2명 존재( 참조 )
 
 3. 제약조건의 종류 5가지 
   1) PRIMARY KEY( PK ) == 고유한키 예)empno(PK)   = NN + UK 
   2) FOREIGN KEY( FK )
   3) UNIQUE KEY( UK )
   4) NOT NULL ( NN )
   5) CHECK ( CK )

 4. 제약조건을 사용하는 이유 ? 
    1) 제약조건 없이 테이블 생성할 수 있다.
       하지만 제약조건이 없으면 DML 데이터 조작할 때 원할하지 않다. 
    2) 각 컬럼에 제약조건을 만들어 줄 수 있다. 
    3) 

 5. DATA INTERGIRTY 의 3가지 종류( 데이타 무결성 == 결함이 없는 데이타, 즉, 완전한 데이타) 
    1) 개체 무결성( ENTITY I~ )
       - 릴레이션(테이블)에 저장되는 튜플(tuple, 행,레코드)의 유일성을 보장하기 위한 제약조건이다
       - PK == NN + UK(유일성)
         레코드를 구별하기 위한 고유한 키
         예) emp 테이블의 각 사원(레코드)를 구별할 수 있는 고유한 키 즉, PK는  사원번호(empno)
         7369 SMITH 사원존재
         7369 ADMIN 사원 추가 X   
         
    2) 참조 무결성( RELATIONAL I~ )
      - 릴레이션(테이블)  간의 데이터의 일관성을 보장하기 위한 제약조건이다       
      예) dept 부서테이블
         deptno(PK)   [참조키]  참조되는 키
          10
          20
          30
          40
          
        emp 
                                     deptno [외래키 FK ] 참조하는키
        7369 SMITH                    50 X 
      
    3) 도메인 무결성( DOMAIN I~ )
       - 속성(컬럼)에서 허용 가능한 값의 범위를 지정하기 위한 제약조건이다
       예) kor NUMBER(3)         허용 가능한 값의  범위 ( 0<=   <=100)  CK
          -999~999 정수 
       - 도메인 무결성 규칙에서는 속성의 데이터 타입, 길이, 기본 키, 유일성, null 허용, 허용 값의 범위와 같은 다양한 제약조건을 지정할 수 있다.

 6. 제약조건의 특징
    • DML 작업에서 잘못되는 것을 제약조건에 의해 방지한다.
      INSERT INTO emp (empno, ename) VALUES( 7369, 'ADMIN');
      1) 개체무결성 규칙에 위배.
      ORA-00001: unique constraint (SCOTT.PK_EMP) violated  
      7369  PK 사원번호를 가진 사원이 존재하기 때문에..
      
      2) 참조무결성 규칙에 위배
      INSERT INTO emp (empno, ename, deptno ) VALUES( 1111, 'ADMIN', 90);
      ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
      
      3) 도메인무결성 규칙에 위배 X
    
    • 모든 정보가 데이터 사전에 저장된다.
       제약 조건을 생성(추가)하면 [데이터 사전]에 저장.
       인명 사전 : 유명한 사람들...위인
       
    • 언제든지 disable, enable시킬 수 있다.
              비활성화, 활성화.
              
    • 처리결과가 즉시 사용자에게 넘겨진다.
    • 한 컬럼에 여러 개의 제약조건을 지정할 수 있다.
    • 하나의 컬럼뿐만 아니라 여러 컬럼을 조합하여 하나의 key를 구성하는 composit key(복합키)를 만들 수 있다. 예: PRIMARY KEY(pno, ename)
    • 제약조건의 관리는 DB server가 담당한다.

  7.무결성제약조건(Constraint) 생성 생성
     1) 제약조건 생성하는 2가지 방법
       ㄱ. IN-LINE constraint 방법(column level에서의 제약조건) 
       ㄴ. OUT-OF-LINE constraint 방법(Table level에서의 제약조건 )
           ㄴ NOT NULL 제약조건은 OUT-OF-LINE 제약조건 방법으로는 생성될 수 없다.

     2) 제약조건 생성 시점. 
       ㄱ. 테이블 [생성]할 때 제약조건 설정
       ㄴ. 테이블 [수정]할 때 제약조건 설정.
   
  8. 제약조건 실습  
    1) tbl_constraint 테이블 확인
    SELECT *
    FROM tabs
    WHERE table_name LIKE  '%CONSTRAINT%';
    2) tbl_constraint 테이블 생성 시점에 제약조건 추가 + 컬럼 레벨 또는 테이블 레벨 방식으로 
    CREATE TABLE tbl_constraint
    (
         empno NUMBER(4)
       , ename VARCHAR2(20)
       , deptno NUMBER(2)
       , kor   NUMBER(3)
       , email VARCHAR2(250)
       , city VARCHAR2(20)
    );    
   -- Table TBL_CONSTRAINT이(가) 생성되었습니다.
   
    3) 제약 조건이 없을 때 문제점 파악.   
     (1) DML 
     INSERT INTO tbl_constraint ( empno, ename, deptno, kor, email, city )
     VALUES                     ( null,null,null,null,null,null ) ;
     -- 1 행 이(가) 삽입되었습니다. X
     COMMIT;
     
     INSERT INTO tbl_constraint ( empno, ename, deptno, kor, email, city )
     VALUES                     ( 1111,'홍길동',10,100,'hong@naver.com',null ) ;   
    --1 행 이(가) 삽입되었습니다.
    INSERT INTO tbl_constraint ( empno, ename, deptno, kor, email, city )
     VALUES                     ( 1111,'박철수',20,90,'park@naver.com',null ) ;
    --1 행 이(가) 삽입되었습니다.
   
   SELECT *
   FROM tbl_constraint;
   --   
   UPDATE tbl_constraint
   SET ename = '김수정'
   WHERE empno = 1111;
   --
   DELETE tbl_constraint
    WHERE empno = 1111;
   
   -- 제약조건이 없다보니깐  사원번호 1111 동일한  여러명 추가 .. 문제점
   -- 수정, 삭제할 때 사원을 찾을 수가 없어서 모두 수정/삭제... 문제점
   
   
      [PK] [UK]  [NN]  [CK]  [FK]
   4) 제약조건 추가 :  테이블 생성할 때(시점)  + 컬럼 레벨 방식(방법)
   DROP TABLE tbl_constraint PURGE;
   
   12:12 수업 시작~~~ 
   CREATE TABLE tbl_constraint
    (
       -- PK 형식) 컬럼명 데이터타입 [CONSTRAINT PK_테이블명_컬럼명] PRIMARY KEY(컬럼명,...)
       -- [CONSTRAINT PK_테이블명_컬럼명] 제약조건명을 생략하면 자동으로  SYS_XXX 이름으로 부여된다.
       -- 나중에 제약조건 삭제, 비활성화, 활성화 할 때 제약조건명을 알면 편리하다. 
         empno NUMBER(4)       NOT NULL CONSTRAINT pk_tblconstraint_empno PRIMARY KEY
       , ename VARCHAR2(20)    NOT NULL  
       -- dept 테이블의 deptno 컬럼을 참조하는 외래키(FK)로 선언
       -- FK형식) 컬럼명 데이터타입 CONSTRAINT constraint명 
       --    REFERENCES 참조테이블명 (참조컬럼명) 
       --      [ON DELETE CASCADE | ON DELETE SET NULL]
       , deptno NUMBER(2)      NOT NULL  CONSTRAINT fk_tblconstraint_deptno 
                                          REFERENCES dept( deptno )
                                          --ON DELETE CASCAE
                                          --ON DELETE SET NULL
              -- -999~999
              -- 0~100 국어점수  범위제한
       -- CK 형식)  컬럼명 데이터타입 CONSTRAINT constraint명 CHECK(컬럼명 조건)
       , kor   NUMBER(3) CONSTRAINT CK_tblconstraint_kor CHECK( kor BETWEEN 0 AND 100 )
       -- 유일성
       , email VARCHAR2(250) CONSTRAINT UK_tblconstraint_email UNIQUE       
       -- CK 형식)  컬럼명 데이터타입 CONSTRAINT constraint명 CHECK(컬럼명 조건)
       -- 도시 : 서울, 부산, 인천
       , city VARCHAR2(20) CONSTRAINT CK_tblconstraint_city 
                                CHECK( city IN ('서울', '부산', '인천') )
    );
   -- NN 제약조건 때문에 INSERT X
   -- ORA-01400: cannot insert NULL into ("SCOTT"."TBL_CONSTRAINT"."EMPNO")
   INSERT INTO tbl_constraint (empno, ename, deptno, kor, email, city)
    VALUES (  null, 'KIM', 10, 90, 'kim@naver.com', '서울' );
    
   -- FK 제약조건 때문에  
   --ORA-02291: integrity constraint (SCOTT.FK_TBLCONSTRAINT_DEPTNO) violated -
   -- parent key not found   
   INSERT INTO tbl_constraint (empno, ename, deptno, kor, email, city)
   VALUES (  1001, 'KIM', [90], 90, 'kim@naver.com', '서울' );
   
   -- ORA-02290: check constraint (SCOTT.CK_TBLCONSTRAINT_KOR) violated
   INSERT INTO tbl_constraint (empno, ename, deptno, kor, email, city)
   VALUES (  1001, 'KIM', 10, [101], 'kim@naver.com', '서울' );
   
   -- ORA-02290: check constraint (SCOTT.CK_TBLCONSTRAINT_CITY) violated
   INSERT INTO tbl_constraint (empno, ename, deptno, kor, email, city)
   VALUES (  1001, 'KIM', 10, 80, 'kim@naver.com', '[대전]' );
   
   (1) PRIMARY KEY (PK)
        • 테이블에 대한 기본 키를 생성한다.
        • 기본키는 테이블당 하나만 존재한다. 
           그러나, 반드시 하나의 컬럼으로만 구성되는 것은 아니다.( 복합키 )
        • 테이블에서 각 행을 유일하게 식별하는 컬럼 또는 컬럼의 집합이다.
          NULL 값이 입력될 수 없고
          , 이미 테이블에 존재하고 있는 데이터를 다시 입력할 수 없다.
          즉, UNIQUE와 NOT NULL 제약조건을 결합한 개념이다.
        • *** 인덱스[UNIQUE INDEX]가 자동으로 만들어 진다. ***
          데이터를 select할 때 where절에 대한 조건으로 
          INDEX가 생성되어 있는 컬럼이 사용되면
          오라클은 자동으로 그 INDEX를 사용하여 데이터를 빠르게 찾아낸다.
          그러므로 한 개의 테이블에는 primary key가 하나밖에 존재할 수 없다. 
          user_indexes 뷰를 이용하여 인덱스를 확인할 수 있다.
        
        
        【컬럼레벨의 형식】
            컬럼명 데이터타입 [CONSTRAINT constraint명] PRIMARY KEY(컬럼명,...)
        【테이블레벨의 형식】
            컬럼명 데이터타입,
            컬럼명 데이터타입,
             ...
             [CONSTRAINT constraint명] PRIMARY KEY(컬럼1명, 컬럼2명,...)
        • constraint를 추가시에 constraint명을 생략하면 오라클 서버가 자동적으로 constraint명을 부여한다.
        • 일반적으로 constraint명은 '테이블명_컬럼명_constraint약자'처럼 기술한다.
        
   (2) FOREIGN KEY (FK)
두 테이블 A,B에서 테이블 B의 기본키가 테이블A의 외래키(Foreign key)이다.
  dept(deptno)    emp(deptno)
  부모 PK          자식(FK)

• 부모, 자식 테이블간의 행 사이에 일관성을 유지하기 위한 제약조건이다.
• 부모 테이블은 참조를 당하는 쪽이고, 자식 테이블은 참조하는 쪽이다.
          참조키                          외래키(FK)
          
• FOREIGN KEY 제약조건은 참조하는 자식 테이블에서 하나 이상의 컬럼에 대해 선언한다. 이때 참조되는 테이블의 컬럼의 수와 데이터타입이 같아야 한다.(부모 테이블과 자식 테이블의 참조하는 컬럼과 참조 당하는 컬럼의 데이터 타입은 일치해야 한다.)
• 부모 테이블이 먼저 생성된 후 자식 테이블(foreign key를 포함하는 테이블)이 생성되어야 한다.
• FOREIGN KEY는 부모 테이블의 PRIMARY KEY, UNIQUE만 참조할 수 있고, 컬럼의 값과 일치하거나 NULL 값이어야 한다.
• ON DELETE CASCADE 옵션을 이용하면 부모 테이블의 행이 삭제될 때 이를 참조한 자식 테이블의 행을 동시에 삭제할 수 있다.
• ON DELETE SET NULL은 자식 테이블이 참조하는 부모 테이블의 값이 삭제되면 자식 테이블의 값을 NULL 값으로 변경시킨다.
• 참조 무결성 제약조건에서 부모 테이블의 참조 키 컬럼에 존재하지 않는 값을 자식 테이블에 입력하면 오류가 발생한다.


【컬럼레벨의 형식】
        컬럼명 데이터타입 CONSTRAINT constraint명
	REFERENCES 참조테이블명 (참조컬럼명) 
             [ON DELETE CASCADE | ON DELETE SET NULL]
【테이블레벨의 형식】
        컬럼명 데이터타입,
        컬럼명 데이터타입,
         ...
        CONSTRAINT constraint명 FOREIGN KEY(컬럼)
	REFERENCES 참조테이블명 (참조컬럼명)
             [ON DELETE CASCADE | ON DELETE SET NULL]
             
 (4) CHECK (CK)
컬럼에서 허용 가능한 데이터의 범위나 조건을 지정하기 위한 제약조건이다.

• 하나의 컬럼에 대하여 여러 개의 CHECK 무결성 제약조건을 지정할 수 있다.
• CURRVAL, NEXTVAL과 같은 가상 컬럼이나 SYSDATE, USER와 같은 함수는 사용할 수 없다.
• 동일 테이블의 컬럼에서 다른 행을 참조할 수 있다.
• 컬럼에 입력되는 데이터를 검사해서 조건에 맞는 데이터만 입력되도록 한다.
• 조건은 where절과 유사하게 해당 컬럼에 저장되는 데이터 값의 범위, 특정 패턴의 숫자 또는 문자열뿐만 아니라 같은 테이블 내의 다른 컬럼도 참조할 수 있다.
• row(행)이 만족해야 하는 조건을 정의한다.
• user_constraints 뷰의 constraint_type에서 CHECK 제약조건이나, NOT NULL 제약조건이 모두 C로 표시되지만, 구체적으로 확인하기 위해서 search_condition 컬럼의 값으로 확인할 수 있다.


【컬럼레벨의 형식】
        컬럼명 데이터타입 CONSTRAINT constraint명 CHECK(컬럼명 조건)
【테이블레벨의 형식】
        컬럼명 데이터타입,
        컬럼명 데이터타입,
         ...
        CONSTRAINT constraint명  CHECK(컬럼명 조건)



   5) 제약조건 추가 :  테이블 생성할 때(시점)  + 테이블 레벨 방식(방법)
   DROP TABLE tbl_constraint PURGE;
     - NOT NULL 제약조건은 테이블 레벨 방식으로 설정할 수 없다. 
     
    CREATE TABLE tbl_constraint
    (
         empno NUMBER(4)       NOT NULL    
       , ename VARCHAR2(20)    NOT NULL    
       , deptno NUMBER(2)      NOT NULL        
       , kor   NUMBER(3)      
       , email VARCHAR2(250) 
       , city VARCHAR2(20) 
       -- 해당 테이블에 제약조건 추가..  어떤 컬럼에게 PK, UK, FK 설정 추가
       , CONSTRAINT pk_tblconstraint_empno PRIMARY KEY( empno )     
       , CONSTRAINT fk_tblconstraint_deptno FOREIGN KEY(deptno) REFERENCES dept( deptno ) 
       , CONSTRAINT CK_tblconstraint_kor CHECK( kor BETWEEN 0 AND 100 )
       , CONSTRAINT UK_tblconstraint_email UNIQUE ( email )      
       , CONSTRAINT CK_tblconstraint_city   CHECK( city IN ('서울', '부산', '인천') )
    );
  -- Table TBL_CONSTRAINT이(가) 생성되었습니다.
  
  (복합키) = PK = 컬럼1 + 컬럼2+..
  , CONSTRAINT pk_tblconstraint_empno PRIMARY KEY( empno, ename )  
  (복합키 필요한 이유 ? )
  
  [ 급여 지급 테이블 ]
  PK 어떤 컬럼 설정 ? 레코드(행)을 구별할 수 있는 고유한키, 레코드 구별
  사원번호(PK X), 지급날짜 X, 급여액 X, 보너스 X ...
  1001         23/1  300   null
  1001         23/2  300   null
  1001         23/3  300   null
  
  
  복합키( 사원번호 + 지급날짜  )
  , CONSTRAINT pk_급여 지급 테이블_empno PRIMARY KEY( 사원번호, 지급일자 )     -> 역정규화? ( 성능 때문에 )
  
 오후 2:00 수업시작~~~   
 
 -- 컬럼레벨방식, 테이블 레벨방식으로 제약조건 + 테이블 생성
 
 Table TBL_CONSTRAINT이(가) 생성되었습니다.
 -- 제약조건 확인
 SELECT *
 FROM user_constraints
 WHERE table_name = 'TBL_CONSTRAINT';
 
    --  제약조건이름  타입
    --   SYS_XXXXX
SCOTT	SYS_C009682	[C]	TBL_CONSTRAINT	"EMPNO" IS NOT NULL
SCOTT	SYS_C009683	C	TBL_CONSTRAINT	"ENAME" IS NOT NULL
SCOTT	SYS_C009684	C	TBL_CONSTRAINT	"DEPTNO" IS NOT NULL

C - NN, CK

SCOTT	CK_TBLCONSTRAINT_KOR	[C]	TBL_CONSTRAINT	 kor BETWEEN 0 AND 100 
SCOTT	CK_TBLCONSTRAINT_CITY	C	TBL_CONSTRAINT	 city IN ('서울', '부산', '인천') 

P - PK
SCOTT	PK_TBLCONSTRAINT_EMPNO	P	TBL_CONSTRAINT	

U - UK
SCOTT	UK_TBLCONSTRAINT_EMAIL	U	TBL_CONSTRAINT	

R - FK
SCOTT	FK_TBLCONSTRAINT_DEPTNO	R	TBL_CONSTRAINT	

 -- PK 제약조건을 삭제(제거)
 -- 1. 제약조건은 수정할 수 없다. (삭제 후 다시 추가 ) 
 -- 2. 테이블을 삭제하면  그 안의 제약조건도 삭제
       제약조건명 - 삭제.
 -- 3. PK 제약 조건을 삭제할 때는 제약조건명을 몰라도 된다. ( 왜? 1개 )      
 방법1)
ALTER TABLE 테이블명 
DROP [CONSTRAINT constraint명 | PRIMARY KEY | UNIQUE(컬럼명)]
[CASCADE];

CASCADE옵션은 참조하는 FOREIGN KEY가 있을 때 사용한다.
  ㄱ. 
  ALTER TABLE tbl_constraint
  DROP CONSTRAINT pk_tblconstraint_empno;
  -- Table TBL_CONSTRAINT이(가) 변경되었습니다.
  ㄴ. 
  ALTER TABLE tbl_constraint
  DROP primary key;
  
  -- UNIQUE 제약조건 :  email
  ALTER TABLE tbl_constraint
   DROP  UNIQUE(email);
  -- Table TBL_CONSTRAINT이(가) 변경되었습니다.

방법2) X
DROP TABLE 테이블명 CASCADE CONSTRAINTS;

테이블과 그 테이블을 참조하는 foreign key를 동시에 삭제할 수 있다.

방법3) X
DROP TABLESPACE 테이블스페이스명 
INCLUDING CONTENTS
CASCADE CONSTRAINTS;


 -- 테이블 생성 후 + 제약조건을 추가..
   1) PK 제약 조건 추가.
   테이블 생성 후에 constraint의 추가는 [테이블 레벨 방식]으로 해야 한다.
   ALTER TABLE tbl_constraint
     ADD (  -- 컬럼 추가, 제약조건 추가
          CONSTRAINT pk_tblconstraint_empno PRIMARY KEY(empno)
        , CONSTRAINT UK_tblconstraint_email UNIQUE ( email )    
        );
  -- Table TBL_CONSTRAINT이(가) 변경되었습니다.
  
  
  -- 제약조건 비활성화/활성화
  ALTER TABLE 테이블명
  ENABLE | DISABLE CONSTRAINT 제약조건명
  
  ALTER TABLE 테이블명   DISABLE CONSTRAINT 제약조건명
  ALTER TABLE 테이블명   ENABLE   CONSTRAINT 제약조건명
  
  
  --
  컬럼명 데이터타입 CONSTRAINT constraint명
	REFERENCES 참조테이블명 (참조컬럼명) 
             [ON DELETE CASCADE | ON DELETE SET NULL]
  
  ㄱ. ON DELETE CASCADE 옵션 ? 부모 테이블의 행이 삭제될 때 
               이를 참조한 자식 테이블의 행을 동시에 삭제할 수 있다.

  ㄴ. ON DELETE SET NULL 옵션 ? 자식 테이블이 참조하는 부모 테이블의 값이 삭제되면
                  자식 테이블의 값을 NULL 값으로 변경시킨다.
  -- 실습 --
  emp -> tbl_emp 생성
  dept -> tbl_dept 생성
  --
  SELECT *
  FROM tabs
  WHERE table_name LIKE 'TBL_%';
  --
  DROP TABLE TBL_CONSTRAINT PURGE;
  --
  CREATE TABLE tbl_emp 
  AS
    (    
        SELECT * 
        FROM emp
    );
    
  CREATE TABLE tbl_dept 
  AS
    (    
        SELECT * 
        FROM dept
    )  
  -- Table TBL_EMP이(가) 생성되었습니다
  -- NN 제약조건은 복사가 되지만 그 외 제약 조건은 복사되지 않는다. 
  SELECT  *
  FROM user_constraints
  WHErE table_name = 'TBL_DEPT';
  WHErE table_name = 'TBL_EMP';
  -- empno  제약 조건 PK 추가
  ALTER TABLE tbl_emp
  ADD ( CONSTRAINT pk_tblemp_empno PRIMARY KEY( empno ) );
  -- deptno  제약 조건 PK 추가
  ALTER TABLE tbl_dept
  ADD ( CONSTRAINT pk_tbldept_deptnno PRIMARY KEY( deptno ) );
  
  
  -- tbl_emp테이블 
  컬럼명 데이터타입 CONSTRAINT constraint명
	REFERENCES 참조테이블명 (참조컬럼명) 
             [ON DELETE CASCADE | ON DELETE SET NULL]
  
  ㄱ. ON DELETE CASCADE 옵션 ? 부모 테이블의 행이 삭제될 때 
               이를 참조한 자식 테이블의 행을 동시에 삭제할 수 있다.

  ㄴ. ON DELETE SET NULL 옵션 ? 자식 테이블이 참조하는 부모 테이블의 값이 삭제되면
                  자식 테이블의 값을 NULL 값으로 변경시킨다.
                  
   1)  테스트   ㄱ,ㄴ 옵션 X  
   ALTER TABLE tbl_emp
   ADD CONSTRAINT fk_tblemp_deptno FOREIGN KEY( deptno ) REFERENCES tbl_dept(deptno);
   --
   SELECT * 
   FROM tbl_dept;
   --
   DELETE FROM tbl_dept
   WHERE deptno = 30;
   ORA-02292: integrity constraint (SCOTT.FK_TBLEMP_DEPTNO) violated - child record found
   -- 무결성  FK 제약조건 위배
   -- 30번 부서를 참조하고 있는 emp 테이블의 사원들이 존재하기 때문에 삭제 할 수 없다.
   
   -- 
   ALTER TABLE tbl_emp
   DROP CONSTRAINT fk_tblemp_deptno;
   -- Table TBL_EMP이(가) 변경되었습니다.
   
   2)  테스트   ㄱ  ON DELETE CASCADE   dept/30 삭제 -> emp의 모든 30부서원도 삭제.
   ALTER TABLE tbl_emp
   ADD CONSTRAINT fk_tblemp_deptno FOREIGN KEY( deptno ) 
         REFERENCES tbl_dept(deptno) ON DELETE CASCADE; -- 참조하는 자식테이블의 행도 모두 삭제
   --
   SELECT * 
   FROM tbl_emp;
   FROM tbl_dept;
   --
   DELETE FROM tbl_dept
   WHERE deptno = 30;
   
   ROLLBACK;
   
   3)  테스트   ㄴ  ON DELETE SET NULL : dept /30 삭제  emp / 30부서원들의 deptno = null
   ALTER TABLE tbl_emp
   ADD CONSTRAINT fk_tblemp_deptno FOREIGN KEY( deptno ) 
         REFERENCES tbl_dept(deptno) ON DELETE SET NULL;
--------------------------------------------------------------------------------------------------------------------------------
-- 조인(join)
   ㄴ 같거나 서로 다른 두 개 이상의 테이블에서 컬럼을 검색(조회)할 때 사용한다. 
예) deptno,  dname, ename, hirdate
 deptno, dname           : dept
 deptno, ename, hiredate : emp
 
 SELECT d.deptno,  dname, ename, hiredate
 FROM dept d, emp e
 WHERE d.deptno = e.deptno;

  -- join.sql
-- 1) 책 테이블
  CREATE TABLE book(
       b_id     VARCHAR2(10)    NOT NULL PRIMARY KEY   -- 책ID
      ,title      VARCHAR2(100) NOT NULL  -- 책 제목
      ,c_name  VARCHAR2(100)    NOT NULL     -- c 이름
     -- ,  price  NUMBER(7) NOT NULL
 );
-- Table BOOK이(가) 생성되었습니다.
INSERT INTO book (b_id, title, c_name) VALUES ('a-1', '데이터베이스', '서울');
INSERT INTO book (b_id, title, c_name) VALUES ('a-2', '데이터베이스', '경기');
INSERT INTO book (b_id, title, c_name) VALUES ('b-1', '운영체제', '부산');
INSERT INTO book (b_id, title, c_name) VALUES ('b-2', '운영체제', '인천');
INSERT INTO book (b_id, title, c_name) VALUES ('c-1', '워드', '경기');
INSERT INTO book (b_id, title, c_name) VALUES ('d-1', '엑셀', '대구');
INSERT INTO book (b_id, title, c_name) VALUES ('e-1', '파워포인트', '부산');
INSERT INTO book (b_id, title, c_name) VALUES ('f-1', '엑세스', '인천');
INSERT INTO book (b_id, title, c_name) VALUES ('f-2', '엑세스', '서울');

COMMIT;

SELECT *
FROM book;

  3:05 수업 시작~ 
  -- 2) 단가 테이블
  CREATE TABLE danga(
      b_id  VARCHAR2(10)  NOT NULL  -- PK , FK
      ,price  NUMBER(7) NOT NULL    -- 책 가격
      
      ,CONSTRAINT PK_dangga_id PRIMARY KEY(b_id)
      ,CONSTRAINT FK_dangga_id FOREIGN KEY (b_id)
              REFERENCES book(b_id)
              ON DELETE CASCADE
);
-- Table DANGA이(가) 생성되었습니다.

INSERT INTO danga (b_id, price) VALUES ('a-1', 300);
INSERT INTO danga (b_id, price) VALUES ('a-2', 500);
INSERT INTO danga (b_id, price) VALUES ('b-1', 450);
INSERT INTO danga (b_id, price) VALUES ('b-2', 440);
INSERT INTO danga (b_id, price) VALUES ('c-1', 320);
INSERT INTO danga (b_id, price) VALUES ('d-1', 321);
INSERT INTO danga (b_id, price) VALUES ('e-1', 250);
INSERT INTO danga (b_id, price) VALUES ('f-1', 510);
INSERT INTO danga (b_id, price) VALUES ('f-2', 400);

COMMIT;

SELECT *
FROM danga;
 -- 5) 저자 테이블
 CREATE TABLE au_book(
       id   number(5)  NOT NULL PRIMARY KEY
      ,b_id VARCHAR2(10)  NOT NULL  CONSTRAINT FK_AUBOOK_BID
            REFERENCES book(b_id) ON DELETE CASCADE
      ,name VARCHAR2(20)  NOT NULL
);
INSERT INTO au_book (id, b_id, name) VALUES (1, 'a-1', '저팔개');
INSERT INTO au_book (id, b_id, name) VALUES (2, 'b-1', '손오공');
INSERT INTO au_book (id, b_id, name) VALUES (3, 'a-1', '사오정');
INSERT INTO au_book (id, b_id, name) VALUES (4, 'b-1', '김유신');
INSERT INTO au_book (id, b_id, name) VALUES (5, 'c-1', '유관순');
INSERT INTO au_book (id, b_id, name) VALUES (6, 'd-1', '김하늘');
INSERT INTO au_book (id, b_id, name) VALUES (7, 'a-1', '심심해');
INSERT INTO au_book (id, b_id, name) VALUES (8, 'd-1', '허첨');
INSERT INTO au_book (id, b_id, name) VALUES (9, 'e-1', '이한나');
INSERT INTO au_book (id, b_id, name) VALUES (10, 'f-1', '정말자');
INSERT INTO au_book (id, b_id, name) VALUES (11, 'f-2', '이영애');

COMMIT;

SELECT * 
FROM au_book;
          
  출판사 -> [ 서점(고객) ]         ->   고객(일반 사용자)
       판매                      판매
 -- 3) 고객 테이블  
 CREATE TABLE gogaek(
      g_id       NUMBER(5) NOT NULL PRIMARY KEY 
      ,g_name   VARCHAR2(20) NOT NULL
      ,g_tel      VARCHAR2(20)
);
 
 INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (1, '우리서점', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (2, '도시서점', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (3, '지구서점', '333-3333');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (4, '서울서점', '444-4444');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (5, '수도서점', '555-5555');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (6, '강남서점', '666-6666');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (7, '강북서점', '777-7777');

COMMIT;

SELECT *
FROM gogaek;
 
 -- 4) 판매 테이블 
 CREATE TABLE panmai(
       id         NUMBER(5) NOT NULL PRIMARY KEY
      ,g_id       NUMBER(5) NOT NULL CONSTRAINT FK_PANMAI_GID
                     REFERENCES gogaek(g_id) ON DELETE CASCADE
      ,b_id       VARCHAR2(10)  NOT NULL CONSTRAINT FK_PANMAI_BID
                     REFERENCES book(b_id) ON DELETE CASCADE
      ,p_date     DATE DEFAULT SYSDATE
      ,p_su       NUMBER(5)  NOT NULL
);

INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (1, 1, 'a-1', '2000-10-10', 10);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (2, 2, 'a-1', '2000-03-04', 20);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (3, 1, 'b-1', DEFAULT, 13);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (4, 4, 'c-1', '2000-07-07', 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (5, 4, 'd-1', DEFAULT, 31);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (6, 6, 'f-1', DEFAULT, 21);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (7, 7, 'a-1', DEFAULT, 26);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (8, 6, 'a-1', DEFAULT, 17);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (9, 6, 'b-1', DEFAULT, 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (10, 7, 'a-2', '2000-10-10', 15);

COMMIT;

SELECT *
FROM panmai;         

3. JOIN  종류
• EQUI JOIN :
    - 두 개 이상의 테이블에 관계되는 컬럼들의 값들이 일치하는 경우에 사용하는 가장 일반적인 join 형태임,
    - WHERE 절에 '='(등호)를 사용한다.
    - 흔히 primary key, foreign key 관계를 이용한다.
    - 오라클에서는 NATURAL JOIN이 EQUI JOIN과 동일하다.
    - 또는 USING 절을 사용하여 EQUI JOIN과 동일한 결과를 출력한다

  [문제]  책ID, 책제목, 출판사  (c_name), 단가 출력.
  BOOK   : b_id, title, c_name
  DANGA :  b_id, price
  
     1)  객체명.컬럼명
     SELECT book.b_id, book.title, book.c_name, danga.price
     FROM book, danga
     WHERE book.b_id = danga.b_id;
     
     2)  별칭(alias).컬럼명
     SELECT b.b_id, b.title, b.c_name, d.price
     FROM book  b, danga  d
     WHERE b.b_id = d.b_id;  -- 이콜조인(EQUI JOIN) 

     2-2)  별칭(alias).컬럼명
     SELECT b.b_id, title, c_name, price
     FROM book  b, danga  d
     WHERE b.b_id = d.b_id;  -- 이콜조인(EQUI JOIN) 
     
     3)  JOIN~ ON 구문
     SELECT b.b_id, title, c_name, price
     FROM book  b  JOIN danga  d   ON b.b_id = d.b_id; 
     
     4)  USING  절 
     SELECT       b_id, title, c_name, price
     FROM book    JOIN danga    USING( b_id  ); 
     -- USING() 절을 사용할 때는 객체명.컬럼명 또는 별칭명.컬럼명을 사용하지 않는다. 
     
     5) NATURAL JOIN 구문 -- 객체명을 붙이지 않는다. 
     SELECT     b_id, title, c_name, price
     FROM book NATURAL JOIN danga ; 

    [문제] 책코드(b_id), 책명(title), 수량(p_su), 단가(price)
         , 서점명(g_name), 판매금액(p_su*price) 출력

    1)
    SELECT b.b_id, title, p_su, price , g_name,  p_su * price 
    FROM book b, danga d , panmai p, gogaek g
    WHERE b.b_id = d.b_id AND b.b_id = p.b_id AND g.g_id = p.g_id;
    
    2) JOIN ~ ON 구문
    SELECT b.b_id, title, p_su, price , g_name,  p_su * price 
    FROM book b  JOIN danga d  ON b.b_id = d.b_id
                 JOIN panmai p ON b.b_id = p.b_id
                 JOIN gogaek g ON g.g_id = p.g_id;

   2) USING 구문
    SELECT b_id, title, p_su, price , g_name,  p_su * price 
    FROM book   JOIN danga   USING(b_id)
                 JOIN panmai  USING(b_id)
                 JOIN gogaek   USING(g_id);

• NON-EQUI JOIN :
관계되는 컬럼이 정확히 일치하지 않는 경우에 사용되는 JOIN의 형태이다.
WHERE 절에 BETWEEN ... AND ... 연산자를 사용한다.
오라클에서는 ON 절을 이용하여 NON-EQUI JOIN과 동일한 역할을 수행한다.
   1) 
   SELECT ename, sal , losal, hisal , grade
   FROM emp e , salgrade s
   WHERE  e.sal BETWEEN s.losal AND s.hisal;
   
   2) JOIN ON 구문
   SELECT ename, sal , losal, hisal , grade
   FROM emp e JOIN salgrade s  ON e.sal BETWEEN s.losal AND s.hisal;

• INNER JOIN :
  simple join이라고도 하며, 
  둘 이상의 테이블에서 join condition을 만족하는 행만 반환한다.
  SELECT *
  FROM emp;
  -- 사원들의 deptno  : 10(2), 20(3), 30(6) ,       null(1) X
  SELECT *
  FROM dept;  
  -- 부서의 deptno :  10,20,30,                     40 X  
  SELECT d.deptno, ename, hiredate
  FROM emp e INNER JOIN dept d ON e.deptno = d.deptno; -- EQUI JOIN , INNER JOIN

• OUTER JOIN :
JOIN 조건을 만족하지 않는 행을 보기 위한 추가적인 join의 형태이다.
일반적인 join으로 얻을 수 없는 데이터를 구하고 싶을 때 사용하며, '(+)' 연산자를 사용한다.
오라클에서는 LEFT(RIGHT) OUTER JOIN이 OUTER JOIN이다.
FULL OUTER JOIN은 이전 버전에서 UNION을 이용한 연산과 동일한 결과를 얻는다.


LEFT [OUTER] JOIN 
  SELECT d.deptno, ename, hiredate
  FROM emp e LEFT  JOIN dept d ON e.deptno = d.deptno;
   null	KING	81/11/17 ( 출력 )

RIGHT [OUTER] JOIN 
  SELECT d.deptno, ename, hiredate
  FROM emp e RIGHT  JOIN dept d ON e.deptno = d.deptno;

FULL [OUTER] JOIN  
  SELECT d.deptno, ename, hiredate
  FROM emp e FULL  JOIN dept d ON e.deptno = d.deptno;

• SELF JOIN :
자신의 테이블을 alias를 사용하여 마치 두 개의 테이블인처럼 JOIN하는 형태이다.
오라클에서는 JOIN ∼ ON 문을 이용하여 SELF JOIN과 동일한 역할을 수행한다.

  SELECT deptno, empno, ename, 직속상사의 사원번호, 사원명, 부서명
  FROM emp;
  
  SELECT *
  FROM emp;
   -- 
  SELECT a.deptno, a.empno, a.ename , b.empno, b.ename, b.deptno
  FROM emp a JOIN emp b ON a.mgr = b.empno;

-- 4:10 수업 시작
• CROSS JOIN :
Cartesian Product를 수행한 결과와 같다.
이 cartesian product는 매우 많은 행을 생성하므로 극히 드물게 사용된다.
두 테이블에 각각 100개의 행을 가지고 있다면, 10000개의 cartesian product 결과가 생성되기 때문이다.

   Cartesian Product == 데카르트 곱 == 집합A 와 집합B의 곱한 집합
   
   SELECT e.*, d.*
   FROM emp e, dept d;
  --   12  *  4  == 48

• SEMI JOIN :
  - 서브쿼리한 결과 속에 해당 컬럼이 존재하는 경우로 EXISTS을 사용함
     SELECT 
  -  WHERE  IN ()
     WHERE EXISTS( 서브쿼리 )
  -- SELECT    a,b,c,d                  EXISTS  a,c
  
  SELECT d.deptno, d.dname
  FROM dept d 
  WHERE EXISTS ( 
        SELeCT *
        FROM emp e
        WHERE d.deptno = e.deptno AND e.sal > 2800
  );
  
  SELECT d.deptno, d.dname
  FROM dept d 
  WHERE deptno IN ( 
        SELeCT deptno
        FROM emp e
        WHERE  e.sal > 2800
  );
  
• ANTI JOIN : 
서브쿼리한 결과 속에 해당 컬럼이 존재하지 않는 경우로 NOT IN을 사용함

SELECT d.deptno, d.dname
  FROM dept d 
  WHERE deptno NOT IN ( 
        SELeCT deptno
        FROM emp e
        WHERE  e.sal > 2800
  );

-- JOIN ON 구문  == 표준(ANSI) 문법 == ANSI JOIN

--------------------------------------------------------------------------------------------------------------------------------
(문제1) 책ID, 책제목, 판매수량, 단가, 서점명(고객), 판매금액(판매수량*단가) 출력   [4:29 풀이]

  book :  b_id, title
  panmai :  p_su
  danga  :  price
  gogaek : g_name

(문제2) 출판된 책들이 각각 총 몇권이 판매되었는지 조회    [4:36 풀이]                
    (    책ID, 책제목, 총판매권수, 단가 컬럼 출력   )
   -- ORA-00979: not a GROUP BY expression
   [판매테이블]
   SELECT b.b_id, title , SUM( p_su ), price 총판매권수
   FROM panmai p JOIN book b ON p.b_id = b.b_id
                 JOIN danga d ON b.b_id = d.b_id
   GROUP BY b.b_id, title
   ORDER BY b.b_id;
   
   고_id 책_id  판매날짜  판매수량
1	1	a-1	00/10/10	10
2	2	a-1	00/03/04	20
3	1	b-1	22/10/12	13
4	4	c-1	00/07/07	5
5	4	d-1	22/10/12	31
6	6	f-1	22/10/12	21
7	7	a-1	22/10/12	26
8	6	a-1	22/10/12	17
9	6	b-1	22/10/12	5
10	7	a-2	00/10/10	15

 (문제3) 가장 판매권수가 많은 것 조회  [4:47 풀이]
   - TOP -N 방식
      정렬 총판매권수  정렬*(  DESC )
      ROWNUM 순위 = 1
   
   
    SELECT rowNUM, t.*
    FROM (
       SELECT b.b_id, title , SUM( p_su ) 총판매권수 , price 
       FROM panmai p JOIN book b ON p.b_id = b.b_id
                     JOIN danga d ON b.b_id = d.b_id
       GROUP BY b.b_id, title, price
       ORDER BY 총판매권수 desc
       
       ) t 
    WHERE ROWNUM = 1   ;
   
   - RANK 함수
SELECT t.*
FROM (
      SELECT b.b_id, title , SUM( p_su ) 총판매권수 , price 
        , RANK() OVER( ORDER BY SUM( p_su ) DESC) 판매순위

       FROM panmai p JOIN book b ON p.b_id = b.b_id
                     JOIN danga d ON b.b_id = d.b_id
       GROUP BY b.b_id, title, price
       ORDER BY 총판매권수 desc
       ) t
       WHERE t.판매순위 <= 1;

  문제4) book 테이블에서 판매가 된 적이 없는 책의 정보 조회  [4:57 풀이]
  
  -- 판매테이블 조회
  SELECT b.b_id, title , price
  FROM book  b JOIN danga d ON b.b_id = d.b_id
  WHERE b.b_id NOT IN (  SELECT DISTINCT b_id  FROM panmai );  -- 안티조인
  
  문제5) book 테이블에서 판매가 된 적이 있는 책의 정보 조회
      ( b_id, title, price  컬럼 출력 )

  -- 판매테이블 조회                                               세미조인
  SELECT b.b_id, title , price
  FROM book  b JOIN danga d ON b.b_id = d.b_id
  WHERE b.b_id IN (  SELECT DISTINCT b_id  FROM panmai );


  --  판매된 적이 있는 책 ID
        SELECT a.b_id, a.title , price
        FROM book a  JOIN    ( SELECT DISTINCT b_id  FROM panmai ) b  -- INNER, EQUI
                  ON a.b_id = b.b_id
                  JOIN danga d ON a.b_id = d.b_id;
                  
                  
--------------------------------------------------------------------------------------------------------------------------------
   *** 팀 : 오라클 팀 프로젝트 DB 모델링 ***

-- (월 3/27) [병합(MERGE)],[제약조건], [조인], 
-- (화 3/28) 계층적 쿼리(hierarchical query), 복습문제 ,DB 모델링
-- (수 3/29) DB 모델링, VIEW, PL/SQL
-- (목 3/30)  PL/SQL 
-- (금 3/31) PL/SQL,   오라클 팀 프로젝트 
-- (토 4/1 ~ 일 4/9)   오라클 팀 프로젝트 
-- (월 4/10) 발표..  JDBC(1주)


















