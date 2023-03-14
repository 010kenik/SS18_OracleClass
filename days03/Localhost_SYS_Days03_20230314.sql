-- SYS --
-- 9:35 제출~
SELECT *
FROM dba_users;
--
SELECT *   -- username, user_id, created  3개 컬럼 정보만 조회.
FROM all_users;
--
SELECT *
FROM user_users;
--
SELECT *
FROM dba_tables;

--
SELECT *
FROM all_tables;

--
SELECT * 
FROM dba_sys_privs
WHERE grantee = 'DBA'; -- 시스템 권한
WHERE grantee = 'RESOURCE'; -- 시스템 권한







