-- SYS --
SELECT *
FROM scott.emp;
FROM emp;
-- ORA-00942: table or view does not exist
1) SYSTEM 권한으로 접속한다.
2) PUBLIC 옵션을 사용하여 시노님을 생성한다
【형식】
  CREATE PUBLIC SYNONYM arirang
  	FOR scott.emp;
 -- SYNONYM ARIRANG이(가) 생성되었습니다.   
 SELECT *
 FROM arirang;

4) 시노님 삭제
【형식】
	DROP [PUBLIC] SYNONYM synonym명;
  
  DROP PUBLIC SYNONYM arirang;    
 -- SYNONYM ARIRANG이(가) 삭제되었습니다.  

5) 시노님 조회
   SELECT *  
   --FROM user_synonyms;
   FROM all_synonyms;  
   
   
    
    
    
    
