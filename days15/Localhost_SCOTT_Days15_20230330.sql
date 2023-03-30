-- SCOTT -- 
-- 1.  요구분석서(명세서) 작성
 1) 설문 작성(등록)하는 사람은 관리자만이 할 수 있다.
 2) 로그인 한 고객(회원)만이  설문 참여할 수 있다.
 3) 관리자 - 설문 등록, 수정, 삭제
 4) 회원 - 설문 목록, 설문 참여(투표), 투표 수정, 취소
          설문 보기
 5) 설문을 작성할 때는 
    ㄱ. 질문
    ㄴ. 설문 시작일 :년, 월, 일
    ㄷ. 설문 종요일 
    ㄹ. 항목의 갯수를 선택하면
    ㅁ. 항목 _
    설문 등록...
 6) 설문 목록 페이지   
     1) 설문 번호
     2) 질문
     3) 작성자
     4) 시작일, 종료일
     5) 항목수 
     6) 참여자수
     7) 상태 ( 진행 중, 종료 )
     --        진행 전 설문 X
 
   7) A. 설문보기 페이지 +  B.설문참여(투표하기) 
   
      총참여자수 8명
        항목 : 내용 [            ] 2 (%)
        항목
        항목
                  
-- 2. 개념적 DB 모델링            
   1) E  : 관리자, 고객(회원)), 설문, 설문항목, 투표
             사용자 ( 속성 )  
   2) A
   3) I
   4) R
   5) 관계표현 관계 차수, 선택성(옵션)
   
   ERD
   10:01 수업시작
-- 3. 논리적 DB 모델링 
      1)   ERD        -> 매핑룰(5가지) ->  논리적 스키마
       개념적 스키마        변환            테이블스키마, 관계스키마
      2) 이상 현상 ( 삽입, 삭제, 수정 )  제거        정규화
         함수 종속성( 속성 연관성 ) 파악               1NF
           ㄴ 완전 함수적 종속성                   -> 2NF  복합키 
           ㄴ 부분    " 
           ㄴ 이행    "                           -> 3NF
                                                    BCNF
                                                    
                                                    4NF, 5NF X
    -- 식별  관계     P(PK) - C(PK) 전이
    -- 비식별관계     P(PK) - C(FK) 일반컬럼 전이
    
    BOOK(T)     DANGA(T)
    b_id(PK)    b_id(PK, FK)    식별관계  ---------
    price       price
                X seq(PK)
                  
   -- (설문) 
   질문, 작성자,시작일,종료일, 항목1,항목2,항목3,항목4, ... 항목10
   질문, 작성자,시작일,종료일, 항목1,항목2 
   질문, 작성자,시작일,종료일, 항목1,항목2,항목3 
   질문, 작성자,시작일,종료일, 항목1,항목2,항목3,항목4, 
   질문, 작성자,시작일,종료일, 항목1,항목2,항목3,항목4, ... 항목10
   질문, 작성자,시작일,종료일, 항목1,항목2,항목3,항목4, ... 항목10
   질문, 작성자,시작일,종료일, 항목1,항목2,항목3,항목4, ... 항목10
   질문, 작성자,시작일,종료일, 항목1,항목2 
   질문, 작성자,시작일,종료일, 항목1,항목2,항목3,항목4, ... 항목10
   질문, 작성자,시작일,종료일, 항목1,항목2,항목3,항목4, 
    
--------------------------------------------------------------------------------
1) 회원 가입/수정/탈퇴 쿼리..
DESC T_MEMBER;
이름            널?       유형            
------------- -------- ------------- 
MEMBERSEQ     NOT NULL NUMBER(4)       PK
MEMBERID      NOT NULL VARCHAR2(20)  
MEMBERPASSWD           VARCHAR2(20)  
MEMBERNAME             VARCHAR2(20)  
MEMBERPHONE            VARCHAR2(20)  
MEMBERADDRESS          VARCHAR2(100) 

  ㄱ. T_MEMBER  -> PK 확인.
SELECT *  
FROM user_constraints  
WHERE table_name LIKE 'T_M%'  AND constraint_type = 'P';
    
  ㄴ.  회원가입
  시퀀스(sequence)  자동으로 번호 발생시키는 객체 == 은행 (번호)
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  1,         'admin', '1234',  '관리자', '010-1111-1111', '서울 강남구' );
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  2,         'hong', '1234',  '홍길동', '010-1111-1112', '서울 동작구' );
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  3,         'kim', '1234',  '김기수', '010-1111-1341', '경기 남양주시' );
    COMMIT;
  ㄷ. 회원 정보 조회
  SELECT * 
  FROM t_member;
  
  ㄹ. 회원 정보 수정
  로그인 -> (홍길동) -> [내 정보] -> 내 정보 보기 -> [수정] -> [이름][][][][][][] -> [저장]
  PL/SQL
  UPDATE T_MEMBER
  SET    MEMBERNAME = , MEMBERPHONE = 
  WHERE MEMBERSEQ = 2;
  ㅁ. 회원 탈퇴
  DELETE FROM T_MEMBER 
  WHERE MEMBERSEQ = 2;
  
--------------------------------------------------------------------------------
1) 회원 가입/수정/탈퇴 쿼리..    
   ㄱ. 관리자로 로그인         
   ㄴ. [설문작성] 메뉴 선택
   ㄷ. 설문 작성 페이지로 이동...
   INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
   VALUES             ( 1  ,'좋아하는 여배우?'
                          , TO_DATE( '2023-03-01 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , TO_DATE( '2023-03-15 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                          , 5
                          , 0
                          , TO_DATE( '2023-02-15 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , 1
                    );
    ㄹ. 설문 항목                  
 
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (1 ,'배슬기', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (2 ,'김옥빈', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (3 ,'아이유', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (4 ,'김선아', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (5 ,'홍길동', 0, 1 );      
   COMMIT;
--
   ㄷ. 설문 작성 페이지로 이동...
   INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
   VALUES             ( 2  ,'좋아하는 과목?'
                          , TO_DATE( '2023-03-20 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , TO_DATE( '2023-04-01 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                          , 4
                          , 0
                          , TO_DATE( '2023-03-15 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , 1
                    );
    ㄹ. 설문 항목                  
 
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (6 ,'자바', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (7 ,'오라클', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (8 ,'HTML5', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (9 ,'JSP', 0, 2 );
   
   COMMIT;
--
SELECT *
FROM t_poll;
SELECT *
FROM t_pollsub; 
 
   설문 수정, 설문 삭제 query
 
 11:03 수업...
--------------------------------------------------------------------------------
3) 회원이 로그인했습니다.     [ 설문목록페이지  ]
   2 설문 : 좋아하는 과목 "제목" 클릭
SELECT *
FROM t_member;   
  --> 3	kim	1234	김기수 (인증)
SELECT *
FROM (
    SELECT  pollseq 번호, question 질문, membername 작성자
         , sdate 시작일, edate 종료일, itemcount 항목수, polltotal 참여자수
         , CASE 
              WHEN  SYSDATE > edate THEN  '종료'
              WHEN  SYSDATE BETWEEN  sdate AND edate THEN '진행 중'
              ELSE '시작 전'
           END 상태 -- 추출속성   종료, 진행 중, 시작 전
    FROM t_poll p JOIN  t_member m ON m.memberseq = p.memberseq
    ORDER BY 번호 DESC
) t 
WHERE 상태 != '시작 전';  

--------------------------------------------------------------------------------  
3)  3(김기수) 로그인 상태 +  2번 설문 참여..( 좋아하는 과목 ) [ 투표 페이지 ]
   업무 프로세스 
   설문 목로페이지에서 설문참여하기 위해서 2번 질문을 클릭
   [설문 보기 페이지]
   1) 2번 설문의 내용이 SELECT-> 출력
       ㄱ. 설문내용 
           질문, 작성자, 작성일, 시작일, 종료일, 상태, 항목수 조회
           SELECT question, membername
               , TO_CHAR(regdate, 'YYYY-MM-DD AM hh:mi:ss')
               , TO_CHAR(sdate, 'YYYY-MM-DD')
               , TO_CHAR(edate, 'YYYY-MM-DD')
               , CASE 
                  WHEN  SYSDATE > edate THEN  '종료'
                  WHEN  SYSDATE BETWEEN  sdate AND edate THEN '진행 중'
                  ELSE '시작 전'
               END 상태
               , itemcount
           FROM t_poll p JOIN t_member m ON p.memberseq = m.memberseq
           WHERE pollseq = 2;
       ㄴ. 설문항목
           SELECT answer
           FROM t_pollsub
           WHERE pollseq = 2;
   2) 총참여자수 7명
      배 []
      .  []
      .  []
    -- 2번 설문의 총참여자수   
    SELECT  polltotal  
    FROM t_poll
    WHERE pollseq = 2;
    -- 
    SELECT answer, acount
        , ( SELECT  polltotal      FROM t_poll    WHERE pollseq = 2 ) totalCount
        -- ,  막대그래프
        , ROUND (acount /  ( SELECT  polltotal      FROM t_poll    WHERE pollseq = 2 ) * 100) || '%'
     FROM t_pollsub
    WHERE pollseq = 2;
  
  3) [ 투표하기 ] 버튼 클릭
     - 2질문의 항목을 선택을 해야된다. 
    자바
    오라클 (체크)  PK 7  ( 질문항목  PK 값인 7을 선택)
    HTML5
    JSP
    
    SELECT *
    FROM t_voter;
    -- (1) t_voter
    INSERT INTO t_voter 
    ( vectorseq, username, regdate, pollseq, pollsubseq, memberseq )
    VALUES
    (      1   ,  '김기수'      , SYSDATE,   2  ,     7 ,        3 );
    COMMIT;
    
    -- 1)         2/3 자동 UPDATE  [트리거]
    -- (2) t_poll   totalCount = 1증가
    UPDATE   t_poll
    SET polltotal = polltotal + 1
    WHERE pollseq = 2;
    
    -- (3)t_pollsub   account = 1증가
    UPDATE   t_pollsub
    SET acount = acount + 1
    WHERE  pollsubseq = 7;
    
    commit;
    
    SELECT *
    FROM t_poll;

12:02 수업 시작  PL/SQL
--------------------------------------------------------------------------------
-- PL/SQL
[DECLARE] 선언부
   1 블럭 : 변수 , 매개변수 선언
   [v]empno NUMBER(4) := 7369;
   vename VARCHAR2(20);
   vsal   NUMBER(7,2);   
   in_stock  BOOLEAN;
   -- RECORD, TABLE 데이터타입 
BEGIN
   2 블럭 : SQL 작성
   PL/SQL 화면 출력  : DBMS_OUTPUT 패키지 사용.
   SELECT ename, sal   INTO vename, vsal
   FROM emp
   WHERE empno = vempno; 
   
   INSERT INTO    VALUES ( vename, vsal );
   
   DB~
[EXCEPTION]
   3 블럭 : 예외 처리
END;
--------------------------------------------------------------------------------
-- PL/SQL 문법 정리 : [ PL/SQL 변수의 종류 ]

  - 상수와 변수는 사용되기 전에 먼저 선언되어야 한다.
  - 선언된 상수와 변수는 SQL 문에서 사용된다. 
  - 변수값을 지정하는 방법( 대입, 할당 )
      1) 대입연산자   :=
      2)  select나 fetch에 의해서 변수값 지정 
  - 상수의 선언은 변수선언 방법에 CONSTANT라는 예약어를 사용하면 된다
    예)    vpi CONSTANT NUMBER := 3.14;
    JAVA)   final double PI = 3.14;

  - 변수의 4가지  종류 
     1) SCLAR 변수
     2) REFERENCES 변수
     3) COMPOSITE 변수
     4) BIND 변수
  
  - [ %TYPE 변수 ]   
     형식) 변수명   테이블명.컬럼명%TYPE;
      - 만약 어떤 테이블의 특정 컬럼의 값을 변수에 지정해야 한다면, 
  변수를 선언할 때 해당 테이블과 해당 컬럼의 데이터 타입과 크기를 
  그대로 참조하여 정의하여 사용할 수 있는데 이 타입을 TYPE 변수라 한다.

     - 이 타입에서는 테이블의 구조가 자주 변경되는 데이터베이스 환경에서 변경될
때마다 PL/SQL 블럭을 변경하지 않아도 되는 장점이 있다. 
--예)사원 번호 7369 의  사원명, sal 출력하는 익명 프로시저 선언 + 실생
DECLARE
  vempno emp.empno%TYPE := 7369;
  vename emp.ename%TYPE  ;
  vsal   emp.sal%TYPE   ;
BEGIN
--EXCEPTION
END;

DESC emp;
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10)  
SAL               NUMBER(7,2)   
   
-- 예)
DECLARE
  vname emp.ename%TYPE;
  vage  NUMBER(3);
BEGIN
   -- INTO : SELECT , FETCH 절에서 사용
   vname := '홍길동';
   vage := 20;
   
   DBMS_OUTPUT.PUT_LINE( vname || ' ' || vage );

-- EXCEPTION
END;

-- 문제) 30번 부서의 지역명을 얻어와서 10번 부서의 지역명으로 수정...
-- 하는 익명 프로시저를 선언 + 실행....
SELECT *
FROM dept;
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
-- 
DECLARE
  vloc dept.loc%TYPE;
BEGIN
  SELECT loc INTO vloc -- CHICAGO
  FROM dept
  WHERE deptno = 30;
  
  UPDATE dept
  SET loc= vloc
  WHERE deptno = 10;
  
  COMMIT;
--EXCEPTION
  -- ROLLBACK;
END;

-- 문제) 10번 부서원 중에 최고sal를 받는 사원의 정보를 출력하세요.
 -- TOP-N
 SELECT *
 FROM ( 
            SELECT *
            FROM emp
            WHERE deptno = 10
            ORDER BY sal DESC
)
WHERE ROWNUM = 1;
-- RANK 함수 사용 변경.
SELECT t.*
FROM ( 
    SELECT emp.*
      , RANK() OVER(PARTITION BY deptno ORDER BY sal DESC  ) 순위
    FROM emp
    WHERE deptno = 10
) t
WHERE t.순위 = 1;

3:05 수업시작~
-- 상관서브쿼리

SELECT *
FROM emp 
WHERE sal = (SELECT MAX( sal ) max_sal FROM emp WHERE deptno = 10)
     AND deptno = 10;
     
-- 익명프로시저
DECLARE
  vmax_sal_10 emp.sal%TYPE; -- 2450
  
  vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
  vjob emp.job%TYPE;
  vsal emp.sal%TYPE;
  vhiredate emp.hiredate%TYPE;
  vdeptno emp.deptno%TYPE;
BEGIN
  SELECT MAX( sal ) INTO vmax_sal_10
  FROM emp 
  WHERE deptno = 10;
  
 SELECT empno, ename, job, sal, hiredate, deptno 
      INTO vempno, vename, vjob, vsal, vhiredate, vdeptno 
 FROM emp 
 WHERE sal =  vmax_sal_10    AND deptno = 10;
 
 DBMS_OUTPUT.PUT_LINE( vempno   );
 DBMS_OUTPUT.PUT_LINE( vename   );
 DBMS_OUTPUT.PUT_LINE( vjob   );
 DBMS_OUTPUT.PUT_LINE( vsal   );
 DBMS_OUTPUT.PUT_LINE( vhiredate   );
 DBMS_OUTPUT.PUT_LINE( vdeptno   ); 
END;

-- 익명프로시저
DECLARE
  vmax_sal_10 emp.sal%TYPE; -- 2450
  
  vrow  emp%ROWTYPE;
BEGIN
  SELECT MAX( sal ) INTO vmax_sal_10
  FROM emp 
  WHERE deptno = 10;
  
 SELECT empno, ename, job, sal, hiredate, deptno 
      INTO vrow.empno, vrow.ename, vrow.job
         , vrow.sal, vrow.hiredate, vrow.deptno
 FROM emp 
 WHERE sal =  vmax_sal_10    AND deptno = 10;
 
 DBMS_OUTPUT.PUT_LINE( vrow.empno   );
 DBMS_OUTPUT.PUT_LINE( vrow.ename   );
 DBMS_OUTPUT.PUT_LINE( vrow.job   ); 
END;

-- 모든 사원의 empno, ename 정보를 조회.
 
-- PL/SQL 에서 여러 개의 레코드를 가져와서 처리하기 위해서는 반드시 커서(cursor)를 사용해야 된다. 
--ORA-01422: exact fetch returns more than requested number of rows
--            정확한 페치(가져오다)가           요청된 수보다 많은 행을 반환하다.
--ORA-06512: at line 5
--01422. 00000 -  "exact fetch returns more than requested number of rows"

DECLARE
  vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
BEGIN
   SELECT empno, ename INTO vempno, vename
   FROM emp;
   -- WHERE empno = 7369;

   DBMS_OUTPUT.PUT_LINE(  vempno || ', ' || vename  ) ;
--EXCEPTION
END;
-- PL/SQL 흐름제어(제어문)
1) IF...THEN...ELSE 문
   자바)
   if(조건){
   }
   
   if( 조건식){
   }else{
   }
   
   if( 조건식){
   }else if(조건식){
   }else if(조건식){
   }else if(조건식){
   }else{
   }
   
   PL/SQL)
   IF (조건식) THEN
   END IF;
      
   IF (조건식) THEN
   ELSE
   END IF;
   
   IF (조건식) THEN
   ELSIF(조건식) THEN
   ELSIF(조건식) THEN
   ELSIF(조건식) THEN
   ELSE
   END IF;

-- [문제] 변수를 하나 선언해서 정수를 입력받아서 짝수, 홀수 출력.
DECLARE
  vnum NUMBER(3) := 0;
  vresult VARCHAR2(6) := '짝수';
BEGIN
  -- java   vnum = scanner.nextInt();
  vnum := :bindNumber;  
  IF ( MOD(vnum,2)= 1 ) THEN
    vresult := '홀수';
  END IF;  
  DBMS_OUTPUT.PUT_LINE( vresult ); 
--EXCEPTION
END;
-- 문자열 버퍼가 너무 작은가요?.
--ORA-06502: PL/SQL: numeric or value error: character string buffer too small

4:00 수업 시작~ 
-- [문제] 국어점수를 입력받아서  수/우/미/양/가 출력... 
-- ( 익명 프로시저를 사용해서 실행 )
DECLARE
   vkor   NUMBER(3) := 0 ;
   vgrade VARCHAR2(1 CHAR) := '수';
BEGIN
   vkor :=  :bindKor;
   IF  vkor BETWEEN 0 AND 100  THEN
      IF vkor >= 90 THEN
        vgrade := '수';
      ELSIF vkor >= 80 THEN
        vgrade := '우';
      ELSIF vkor >= 70 THEN
        vgrade := '미';
      ELSIF vkor >= 60 THEN
        vgrade := '양';
      ELSE
        vgrade := '가';
      END IF;
      DBMS_OUTPUT.PUT_LINE( vgrade );
   ELSE
     DBMS_OUTPUT.PUT_LINE('국어점수 0~100점');
   END IF;
--EXCEPTION
END;

-- 
DECLARE
   vkor   NUMBER(3) := 0 ;
   vgrade VARCHAR2(1 CHAR) := '수';
BEGIN
   vkor :=  :bindKor;   
   CASE  TRUNC( vkor/10 )
      WHEN 10 THEN vgrade := '수';
      WHEN 9 THEN vgrade := '수';
      WHEN 8 THEN vgrade := '우';
      WHEN 7 THEN vgrade := '미';
      WHEN 6 THEN vgrade := '양';
      ELSE         vgrade :='가';
   END CASE;    
    DBMS_OUTPUT.PUT_LINE( vgrade );
--EXCEPTION
END;


2) LOOP...END LOOP;(단순 반복) 문

    자바) WHILE( 참 ){
       if( 조건 ) break;
     }
     
     LOOP
       -- 반복 코딩.
       EXIT WHEN 조건
     END LOOP;
    -- 1+2+3+4+5+6+7+8+9+10=55

DECLARE
  vi NUMBER := 1;
  vsum NUMBER := 0;
BEGIN
  LOOP
     DBMS_OUTPUT.PUT( vi  ); -- 1+ 10
     IF vi != 10 THEN 
       DBMS_OUTPUT.PUT( '+' );
     END IF; 
     vsum := vsum + vi ; 
     EXIT WHEN vi = 10;
     vi := vi + 1; -- i++
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(   '='  || vsum );
--EXCEPTION
END;

    

3) WHILE...LOOP(제한적 반복) 문
  자바) while( 조건식 ){
      --
  }

   WHILE  조건식
   LOOP
     -- 반복코딩
   END LOOP;

4) FOR...LOOP(제한적 반복) 문
   자바) for
   for( 초기식; 조건식; 증감식 ){
   }
   for( int i=1; i<=10; i++)
   {  LOOP
     -- 반복적으로 처리할 코딩.
   } END LOOP;
   
   [PL/SQL for문 형식]
   FOR   카운트변수(i)  IN  [REVERSE]  시작값.. 끝값 
   LOOP
      -- 반복적으로 처리할 코딩.
   END LOOP;
   
[문제]  1~10 합출력            1+2+3..+9+10=55
  1) FOR 문   4:26 풀이
DECLARE
  vi NUMBER ;
  vsum NUMBER := 0;
BEGIN
  FOR vi IN 1.. 10
  LOOP
     DBMS_OUTPUT.PUT( vi  );
     IF vi != 10 THEN 
       DBMS_OUTPUT.PUT( '+' );
     END IF; 
     -- sum += i  += 복합대입연산자 X
     vsum := vsum + vi ;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(   '='  || vsum );
--EXCEPTION
END;

  2) WHILE문
DECLARE
  vi NUMBER ;
  vsum NUMBER := 0;
BEGIN
  vi := 1 ;
  WHILE (  vi <= 10 )
  LOOP
     DBMS_OUTPUT.PUT( vi  );
     IF vi != 10 THEN 
       DBMS_OUTPUT.PUT( '+' );
     END IF; 
     -- sum += i  += 복합대입연산자 X
     vsum := vsum + vi ;
     
     -- vi++; 증감연산자 X
    vi := vi + 1;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(   '='  || vsum );
--EXCEPTION
END;

   
5) GOTO문(순차적 흐름제어)  X
----------------------


1조 :  LOOP ~ END LOOP;         구구단 출력
2조 :  FOR LOOP ~ END LOOP;     구구단 출력
3조 :  WHILE LOOP ~ END LOOP;   구구단 출력























 
 
 
 
 
