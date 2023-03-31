-- HR --
            
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
 
 