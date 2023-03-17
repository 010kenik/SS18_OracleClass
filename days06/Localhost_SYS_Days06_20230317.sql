-- SYS --
-----------------------------------------------------------------


[수치함수]

함수명
 

설명
 


ABS
 

절대값을 반환한다.
 


ACOS 
 

n의 역코사인(arc cosine)값을 반환한다.
 


ASIN
 

n의 역사인(arc sine)값을 반환한다.
 


ATAN
 

n의 역탄젠트(arc tangent)값을 반환한다.
 


ATAN2
 

ATAN2(n,m)은 atan2(n/m)과 같으며, n/m의 역탄젠트(arc tangent)값을 반환한다.
 


BITAND
 

인수1과 인수2의 비트에 대한 AND연산을 수행하여 정수를 반환한다.
 


CEIL
 

인수에서 지정한 수치를 올림하여 정수를 구하는 함수이다.
 


COS
 

n(라디안으로 표현되는 각도)의 코사인값을 반환한다.
 


COSH
 

n(라디안으로 표현되는 각도)의 쌍곡 코사인값(hyperbolic cosine)을 반환한다.
 


EXP
 

e의 n 제곱 값을 반환한다.
 


FLOOR
 

지정한 숫자보다 작거나 같은 정수 중에서 최대값을 반환한다.
 


LN
 

입력값의 자연 로그 값을 반환한다.
 


LOG
 

LOG(m,n)에서 밑을 m으로 한 n의 로그 값을 반환
 


MOD
 

n2을 n1으로 나눈 나머지값을 반환
 


NANVL
 

입력 값 n2가 Nan(숫치가 아닌)라면, 대체 값 n1을 반환. n2가 NaN이 아니라면, n2를 반환
 


POWER
 

n2의 n1승 값을 반환
 


REMAINDER
 

n2를 n1으로 나눈 나머지를 반환
 


ROUND (number)
 

n값을 소수점 이하를 integer를 기준으로 반올림하여 반환한다.
 


SIGN
 

n의 부호를 반환
 


SIN
 

n의 사인(sine)값을 반환
 


SINH
 

n의 쌍곡선 사인(hyperbolic sine)을 반환
 


SQRT
 

n의 제곱근을 반환
 


TAN
 

n의 사인(tangent)값을 반환
 


TANH
 

n의 쌍곡선 탄젠트(hyperbolic tangent)을 반환
 


TRUNC (number)
 

인수 n1을 소수점 자리 파라미터 n2 이하를 절삭
 


WIDTH_BUCKET
 

동일한 넓이를 갖는 히스토그램을 생성
 
 




문자값을 반환하는 문자 함수
 






함수명
 

설명
 


CHR
 

10진수 n 에 대응하는 아스키코드를 반환
 


CONCAT
 

char1과 char2를 연결하여 반환한다.
 


INITCAP
 

입력 문자열 중에서 각 단어의 첫 글자를 대문자로 나머지는 소문자로 변환하여 반환한다.
 


LOWER
 

입력된 문자열을 소문자로 변환한다.
 


LPAD
 

지정된 자리수 n으로부터 expr1을 채우고,왼편의 남은 공간에 expr1을 채운다.
 


LTRIM
 

문자열 char 좌측으로부터 set으로 지정된 모든 문자를 제거한다.
 


NCHR
 

유니코드 문자를 반환
 


NLS_INITCAP
 

각 단어의 처음 문자를 대문자로, 나머지 문자를 소문자로 변환하여 char를 반환한다.
 


NLS_LOWER
 

모든 문자를 소문자로 변환하여 반환한다.
 


NLSSORT
 

입력 문자열을 소팅하여 스트링을 반환한다.
 


NLS_UPPER
 

입력 문자열을 모두 대문자로 변환한 문자열을 반환한다.
 


REGEXP_REPLACE
 

지정한 정규 표현을 만족하는 부분을, 지정한 다른 문자열로 치환합니다.
 


REGEXP_SUBSTR
 

지정한 정규 표현을 만족하는 부분 문자열을 반환
 


REPLACE
 

파라미터로 주어지는 첫번째 문자열에서, 두번째 문자열을 모두 세번째 문자열로 바꾼 후 결과를 반환한다.
 


RPAD
 

인수 expr1 오른편으로 인수 expr2로 지정한 문자를 길이 필요에 따라 반복하여 n만큼 붙여준다.
 


RTRIM
 

인수 char의 오른쪽 끝에서 부터 set으로 지정된 모든 문자를 제거한다.
 


SOUNDEX
 

char의 음성 표현을 가지는 문자열을 반환
 


SUBSTR
 

문자열 Char에서 position 문자 위치로부터 substring_length 문자 길이만큼 문자열을 추출하여 반환
 
 




NLS 문자 함수
 






함수명
 

설명
 


NLS_CHARSET_DECL_LEN
 

NCHAR열의 선언된 폭을 반환
 


NLS_CHARSET_ID
 

문제셋 이름에 상응하는 ID번호를 반환
 


NLS_CHARSET_NAME
 

ID번호 number에 상응하는 문자 세트의 이름을 반환
 
 




수치값을 반환하는 문자 함수
 






함수명
 

설명
 


ASCII
 

주어진 char의 첫 문자의 아스키 값에 상응하는 10진수값을 반환한다.
 


INSTR
 

문자열중에서 지정한 문자가 처음 나타나는 위치를 숫자로 반환.
 


LENGTH
 

인수 char의 길이를 반환한다.
 


REGEXP_INSTR
 

지정한 조건(정규 표현)을 만족하는 부분의 최초의 위치(무슨 문자인지)를 반환.
 
 




일시 함수
 






함수명
 

설명
 


ADD_MONTHS
 

일자 date에 특정 개월수 integer를 더한 값을 반환한다.
 


CURRENT_DATE
 

현재 세션의 날짜 정보를 Date 데이터 형으로 반환한다.
 


CURRENT_TIMESTAMP
 

현재 session의 날짜와 시간 정보를 반환한다.
 


DBTIMEZONE
 

데이터 베이스 time zone의 값을 반환한다.
 


EXTRACT (datetime)
 

특정 날짜,시간 값이나 날짜 값 표현식으로부터 지정된 날짜 영역의 값을 추출하여 반환한다.
 


FROM_TZ
 

timestamp 데이터형과 time zone데이터 형을 TIMESTAMP WITH TIME ZONE 데이터형으로 변환
 


LAST_DAY
 

해당 날짜가 속한 달의 마지막 날짜를 반환한다.
 


LOCALTIMESTAMP
 

timestamp의 현재 날짜와 시각을 출력한다.
 


MONTHS_BETWEEN
 

일자 date1과 date2 사이의 월을 계산한다.
 


NEW_TIME
 

date,zone1시간대를 zone2 시간대로 출력
 


NEXT_DAY
 

해당일을 기준으로 명시된 요일의 다음 날짜를 변환
 


NUMTODSINTERVAL
 

n을 INTERVAL DAY TO SECOND 문자로 변경한다.
 


NUMTOYMINTERVAL
 

n을 INTERVAL YEAR TO MONTH문자로 변경한다.
 


ROUND (date)
 

포맷 모델 fmt에 의해 지정한 단위로 반올림된 날짜를 반환한다.
 


SESSIONTIMEZONE
 

현재 세션의 시간대역(time zone)을 반영한다.
 


SYS_EXTRACT_UTC
 

협정 세계시간 UTC (Coordinated Universal Time?formerly Greenwich Mean Time)을 반환.
 


SYSDATE
 

데이터 베이스가 있는 OS의 일자와 시간을 반환한다.
 


SYSTIMESTAMP
 

시스템의 날짜를 반환한다.
 


TO_CHAR (datetime)
 

사용자가 지정한 폼을 갖는 varchar2 형식의 데이터로 변환한다.
 


TO_DSINTERVAL
 

INTERVAR DAY TO SECOND값으로 변환한다.
 


TO_TIMESTAMP
 

TIMESTAMP 데이터형의 값으로 변환한다.
 


TO_TIMESTAMP_TZ
 

TIMESTAMP WITH TIME ZONE 데이터형으로 변환한다.
 


TO_YMINTERVAL
 

INTERVAL YEAR TO MONTH 형태로 변경한다.
 


TRUNC (date)
 

날짜를 년,월,일을 기준으로 반올림하거나 절삭한다.
 


TZ_OFFSET
 

문장이 실행된 일자에 근거한 인수에 상응하는 time zone offset을 반환한다.
 
 




일반적인 비교 함수
 






함수명
 

설명
 


GREATEST
 

하나 이상의 인수중에서 가장 큰 값을 반환
 


LEAST
 

인수 EXPR의 리스트 중에서 가장 작은 값을 반환
 
 




변환 함수
 






함수명
 

설명
 


ASCIISTR
 

주어진 문자열의 아스키 문자열을 반환
 


BIN_TO_NUM
 

비트(2진수) 벡터를 동등한 수치(10진수)로 변환
 


CAST
 

데이터 형식이나 collection 형식을 다른 데이터 형식이나 collection 형식으로변환
 


CHARTOROWID
 

CHAR, VARCHAR2, NCHAR, or NVARCHAR2 데이터형태의 값으로부터 ROWID형으로 변환
 


COMPOSE
 

완전한 정규화된 형태의 유니코드를 반환
 


CONVERT
 

문자세트를 다른 문자세트로 문자열을 변환
 


DECOMPOSE
 

입력과 같은 문자 세트로 분해후의 UNICODE 문자열을 반환
 


HEXTORAW
 

16진수를 raw값으로 변환
 


NUMTODSINTERVAL
 

n을 INTERVAL DAY TO SECOND 문자로 변경
 


NUMTOYMINTERVAL
 

n을 INTERVAL YEAR TO MONTH문자로 변경한다.
 


RAWTOHEX
 

RAW을 16진수의 문자로 변환
 


RAWTONHEX
 

RAW을 NVARCHAR2 형태의 16진수로 변환
 


ROWIDTOCHAR
 

rowid 값을 VARCHAR2형식으로 변환
 


ROWIDTONCHAR
 

rowid값을 NVARCHAR2형식으로 변환
 


SCN_TO_TIMESTAMP
 

시스템 변경 번호(SCN)로 평가되는 수치를 인수로 취하여, SCN과 관련된 가까운 timestamp를 반환
 


TIMESTAMP_TO_SCN
 

timestamp와 관련된 시스템 변경 번호(system change number,SCN)을 반환
 


TO_BINARY_DOUBLE
 

배정밀도 부동소수점을 반환
 


TO_BINARY_FLOAT
 

단순정밀도(single-precision) 부동 소수점수(floating-point number)를 반환
 


TO_CHAR (character)
 

데이터 베이스 문자 세트로 변환
 


TO_CHAR (datetime)
 

지정된 포맷의 VARCHAR2 데이터 타입의 값으로 변환
 


TO_CHAR (number)
 

VARCHAR2 데이터형의 값으로 변환
 


TO_CLOB
 

NCLOB값을 CLOB값으로 변환
 


TO_DATE
 

char을 날짜형 데이터 타입값으로 변환
 


TO_DSINTERVAL
 

INTERVAR DAY TO SECOND값으로 변환
 


TO_LOB
 

LONG또는 LONG ROW값을 LOB값으로 변환
 


TO_MULTI_BYTE
 

multibyte 문자를 상응하는 single-byte 문자로 변환한 문자를 반환
 


TO_NCHAR (character)
 

문자열,CLOB,NCLOB 값을 각국 문자 세트로 변환
 


TO_NCHAR (datetime)
 

national character set으로 변환
 


TO_NCHAR (number)
 

n을 national character set으로 변환
 


TO_NCLOB
 

CLOB값을 NCLOB값으로 변환
 


TO_NUMBER
 

expr을 NUMBER 데이터형의 값으로 변환
 


TO_SINGLE_BYTE
 

multibyte문자를 그에 상응하는 single-byte문자로 변환하여 char을 반환
 


TO_TIMESTAMP
 

CHAR,VARCHAR2,NCHAR,NVARCHAR2 데이터형의 char을 TIMESTAMP 데이터형의 값으로 변환
 


TO_TIMESTAMP_TZ
 

CHAR,VARCHAR2,NCHAR,NVARCHAR2데이터형의 char을 TIMESTAMP WITH TIME ZONE 데이터형으로 변환
 


TO_YMINTERVAL
 

CHAR,VARCHAR2,NCHAR,NVARCHAR2 데이터형의 문자열을 INTERVAL YEAR TO MONTH 형태로 변경
 


TRANSLATE ... USING
 

char을 데이터 베이스 문자세트와 각국어 문자 센트사이의 변환에 대한 지정된 문자 세트로 변경
 


UNISTR
 

텍스트 문자열을 인수로 취하고, 각국어 문자 세트로 반환
 
 




Large Object(LOB) 함수
 






함수명
 

설명
 


BFILENAME
 

서버 파일 시스템의 물리 LOB 바이너리 파일과 연관된 BFILE locator를 반환
 


EMPTY_BLOB


EMPTY_CLOB
 

LOB 변수를 초기화하기 위하여 쓰이거나, 또는 INSERT 문이나 UPDATE 문에서 empty LOB 위치를 반환
 
 




수집 함수
 






함수명
 

설명
 


CARDINALITY
 

nested table에서 원소의 수를 반환
 


COLLECT
 

선택된 행으로부터 입력된 형태의 중첩 테이블을 생성
 


POWERMULTISET
 

입력된 중첩(nested)테이블의 공백이 아닌 모든 부분집합(submultisets)을 소유한 중첩 테이블의 중첩된 테이블을 반환
 


POWERMULTISET_BY_CARDINALITY
 

중첩 테이블과 cardinality(주어진 수학적 집합에서 요소들의 개수)를 취해서, 지정한 카디나리트의 중첩 테이블의 모든 비공백 부분집합(submultisets이라고 불리는)을 소유하는 중첩 테이블의 중첩테이블을 반환
 


SET
 

중첩 테이블에서 중복을 배제하여 반환
 
 




계층 함수
 






함수명
 

설명
 


SYS_CONNECT_BY_PATH
 

루트로 부터 node로 열의 값 Path를 반환
 
 




XML 함수
 






함수명
 

설명
 


DEPTH
 

상관 변수를 가지는 UNDER_PATH조건에 의해 지정된 PATH에서 레벨의 수를 반환
 


EXISTSNODE
 

node의 존재여부를 확인하여 그 결과를 반환
 


EXTRACT (XML) 
 

XML 플래그먼트(fragment)를 포함한 XMLType 인스턴스를 반환
 


EXTRACTVALUE
 

node의 스칼라 값을 반환
 


PATH
 

지정된 자원에서 상대적인 경로를 반환
 


SYS_DBURIGEN
 

특정 열 또는 행 오브젝트에 대한 DBURIType 데이터 타입의 URL을 생성
 


SYS_XMLAGG
 

입력 받은 모든 문서를 하나의 XML문서를 통합
 


SYS_XMLGEN
 

스칼라값,object type,xml type 인스턴스를 XML문서로 변형
 


XMLAGG
 

XML fragment(조각)의 집합체를 취해서, 집계된 XML 문서를 반환. GROUP BY 질의에서 XML 데이타를 그룹으로 분류 또는 집계하는 함수
 


XMLCOLATTVAL
 

XML 단편(fragment)을 생성하고, 각각의 XML 단편(fragment)이 속성 name을 포함한 name열을 가지는 결과 XML으로 확장
 


XMLCONCAT
 

둘 이상의 XML 값을 연결하는 함수
 


XMLELEMENT
 

XMLType 타입의 instance를 반환. 관계형 값을 XML 요소로 변형시키는 함수
 


XMLFOREST
 

각 인수의 파라미터를 XML로 변환하고, 변환된 인수를 연결한 XML 단편(fragment)을 반환. 관계형 값 목록으로부터 XML 요소의 목록(일명: '포리스트(forest)')을 생성하는 함수
 


XMLSEQUENCE
 

XMLType에 있는 top-level 노드의 varray를 반환. 커서의 각 행에 대하여 XMLSequence 형태로써 XML문서를 반환
 


XMLTRANSFORM
 

스타일 쉬트를 인스턴스로 적용하고, XMLType를 반환
 
 




인코딩 함수와 디코딩 함수
 






함수명
 

설명
 


DECODE
 

일반적인 프로그래밍 언어의 IF문을 SQL 문자 또는 PL/SQL안으로 끌여들여 사용하기 위하여 만들어진 오라클함수
 


DUMP
 

지정한 데이터의 위치와 길이 등을 지정한 형식으로 반환
 


ORA_HASH
 

주어진 표현에 대한 해쉬 값을 계산하는 함수
 


VSIZE
 

expr의 내부 표현에서 바이트의 수를 반환
 
 




NULL 함수
 






함수명
 

설명
 


COALESCE
 

나열된 값을 순차적으로 체크하여 NULL이 아닌 첫번째 인수를 반환
 


LNNVL
 

조건의 한쪽 또는 양쪽 연산자가 NULL이 존재할 경우에, 조건문을 평가하기 위한 방법을 제공
 


NULLIF
 

expr1과 expr2가 같으면, NULL값을 반환
 


NVL
 

쿼리의 결과에서 NULL(공백으로 반환)값을 치환
 


NVL2
 

지정한 표현이 NULL인지 여부에 근거하여 쿼리의 반환될 값을 판단할수 있다. expr1이 NULL이 아니라면, NVL2는 expr2를 반환한다. 만약 expr1인 NULL이라면, NVL2는 expr3을 반환
 
 




환경 함수와 식별자 함수
 






함수명
 

설명
 


SYS_CONTEXT
 

문맥 namespace와 관련된 parameter의 값을 반환
 


SYS_GUID
 

16바이트로 구성된 고유전역식별자(globally unique identifier,RAW 값)을 생성하여 반환
 


SYS_TYPEID
 

피연산자(operand)의 대부분 지정한 형태의 typeid를 반환
 


UID
 

세션 사용자의 유일한 식별하는 정수를 반환(로그인 유저)
 


USER
 

VARCHAR2 형태를 가지는 세션 사용자(로그인 유저)의 이름을 반환
 


USERENV
 

현재 세션에 대한 정보를 반환
 
 




집계 함수
 






함수명
 

설명
 


AVG
 

지정된 컬럼에 대한 조건을 만족하는 행중에서 Null을 제외한 평균을 반환
 


COLLECT
 

선택된 행으로부터 입력된 형태의 중첩 테이블을 생성
 


CORR
 

수치 쌍에 대한 상관 계수를 반환
 


CORR_*
 

(CORR 참조)는 Pearson's 상관계수를 계산
 


COUNT
 

쿼리에 의해 반환된 행의 수를 반환
 


COVAR_POP
 

 number조합의 세트의 모집단 공분산을 반환
 


COVAR_SAMP
 

 number쌍의 세트의 표본 공분산을 반환
 


CUME_DIST
 

값의 그룹에 있는 값의 누적 분포치를 계산
 


DENSE_RANK
 

 ORDER BY절에 사용된 컬럼이나 표현식에 대하여 순위를 부여하는데 RANK()와 달리 동일 순위 다음의 순위는 동일 순위의 수와 상관없이 1 증가된 값을 돌려준다.
 


FIRST
 

주어진 소트 지정에 대해서 FIRST 또는 LAST로서 순위를 주어서 행의 세트로부터 값의 세트에 운영하는 집계와 분석 함수
 


GROUP_ID
 

지정된 GROUP BY 결과로부터 중복된 그룹을 구별
 


GROUPING
 

 ROLLUP이나 CUBE 연산자와 함께 사용하여 GROUPING 함수에 기술된 컬럼이 그룹핑 시 즉, ROLLUP이나 CUBE 연산시 사용이 되었는지를 보여 주는 함수
 


GROUPING_ID
 

행과 관련되는 GROUPING 비트 벡터에 대응되는 수치를 반환
 


LAST
 

행을 서열화 시켜서 마지막 행을 추출
 


MAX
 

인수중에서 최대값을 반환
 


MEDIAN
 

중앙값 또는 값의 정렬후에 중앙값이 보간된 값을 반환
 


MIN
 

인수중에서 최소값을 반환
 


PERCENT_RANK
 

그룹 수에 대한 값의 순위 퍼센트를 반환
 


PERCENTILE_CONT
 

연속된 분포 모델을 가정한 역 분포 함수(inverse distribution function).
 


PERCENTILE_DISC
 

이산 분포 모형을 가정하는 역 분포 함수
 


RANK
 

값의 그룹에서 값의 순위를 계산
 


REGR_ (Linear Regression)


Functions
 

선형회귀함수는 정규 최소 제곱 회귀 선상을 수치 쌍의 세트에 적합
 


STATS_BINOMIAL_TEST
 

단지 두개의 유효한 값이 존재하는 이분 변수(두개의 배타적인 값을 가지는 변수)에 대해서 이용되는 정확 확률 테스트
 


STATS_CROSSTAB
 

교차분석(crosstab)은 두개의 명목 변수를 분석하는 방법
 


STATS_F_TEST
 

STATS_F_TEST함수는 두개의 분산이 유의한 차가 있는지 테스트
 


STATS_KS_TEST
 

두개의 표본이 같은 모집단에 속하고 있는지 또는 같은 분포를 가지는 모집단에 속하고 있는지 테스트 하는 Kolmogorov-Smirnov함수
 


STATS_MODE
 

가장 큰 빈도를 가지는 값을 반환
 


STATS_MW_TEST
 

A Mann Whitney test는 2개의 독립 표본을 비교
 


STATS_ONE_WAY_ANOVA
 

일원분산분석 함수(STATS_ONE_WAY_ANOVA)는 분산의 다른 2개 추정치 비교에 의해 통계적 유의성에 대한 평균(그룹 또는 변수에 대한)의 유의한 차를 검증
 


STATS_T_TEST_*
 

 t검정에서는, 평균치의 차이의 유의성을 측정
 


STATS_WSR_TEST
 

대응쌍표본의 윌콕스 부호 순위 검증을 수행하며,표본간의 차이가 zero로부터 유의한 차이가 있는지 검정
 


STDDEV
 

Number의 조합인 expr의 표본표준편차를 반환
 


STDDEV_POP
 

모집단 표준 편차를 계산하고, 모집단 분산의 제곱근값을 반환
 


STDDEV_SAMP
 

누적 표본 표준편차를 계산하고, 표본 분산의 제곱근값을 반환
 


SUM
 

expr의 값의 합을 반환
 


VAR_POP
 

Null값들을 제거한후에 Number 세트의 모집단 분산을 반환
 


VAR_SAMP
 

null들을 제거한후에 number의 세트의 표본분산을 반환
 


VARIANCE
 

expr의 분산을 반환
 
 




분석 함수
 






함수명
 

설명
 


AVG *
 

지정된 컬럼에 대한 조건을 만족하는 행중에서 Null을 제외한 평균을 반환
 


CORR *
 

수치 쌍에 대한 상관 계수를 반환
 


COUNT *
 

쿼리에 의해 반환된 행의 수를 반환
 


COVAR_POP *
 

number조합의 세트의 모집단 공분산을 반환
 


COVAR_SAMP *
 

number쌍의 세트의 표본 공분산을 반환
 


CUME_DIST
 

값의 그룹에 있는 값의 누적 분포치를 계산
 


DENSE_RANK
 

ORDER BY절에 사용된 컬럼이나 표현식에 대하여 순위를 부여하는데 RANK()와 달리 동일 순위 다음의 순위는 동일 순위의 수와 상관없이 1 증가된 값을 돌려준다.
 


FIRST
 

주어진 소트 지정에 대해서 FIRST 또는 LAST로서 순위를 주어서 행의 세트로부터 값의 세트에 운영하는 집계와 분석 함수
 


FIRST_VALUE *
 

값의 정렬된 세트에서 첫번째 값을 반환
 


LAG
 

현재 행을 기준으로 이전 값을 참조하는 함수
 


LAST
 

행을 서열화 시켜서 마지막 행을 추출
 


LAST_VALUE *
 

윈도우에서 정렬된 값중에서 마지막 값을 반환
 


LEAD
 

현재 행을 기준으로 이후의 값을 참조하는 함수
 


MAX *
 

인수중에서 최대값을 반환
 


MIN *
 

인수중에서 최소값을 반환
 


NTILE
 

순서화된 데이터를 expr에 의해 지정된 bucket의 수로 분한하여, 각 행을 적절한 bucket 번호를 할당 / 출력 결과를 사용자가 지정한 그룹 수로 나누어 출력하는 함수
 


PERCENT_RANK
 

그룹 수에 대한 값의 순위 퍼센트를 반환
 


PERCENTILE_CONT
 

연속된 분포 모델을 가정한 역 분포 함수(inverse distribution function)
 


PERCENTILE_DISC
 

이산 분포 모형을 가정하는 역 분포 함수
 


RANK
 

값의 그룹에서 값의 순위를 계산
 


RATIO_TO_REPORT
 

값의 세트의 합에 대한 값의 비율을 계산
 


REGR_ (Linear Regression) Functions *
 

선형회귀함수는 정규 최소 제곱 회귀 선상을 수치 쌍의 세트에 적합
 


ROW_NUMBER
 

분할별로 정렬된 결과에 대해 순위를 부여하는 기능 / 1로 시작하는 order_by_clause에서 지정된 행의 순위 순서로, 적용되는 각 행에 unique 순서를 할당
 


STDDEV *
 

Number의 조합인 expr의 표본표준편차를 반환
 


STDDEV_POP *
 

모집단 표준 편차를 계산하고, 모집단 분산의 제곱근값을 반환
 


STDDEV_SAMP *
 

누적 표본 표준편차를 계산하고, 표본 분산의 제곱근값을 반환
 


SUM *
 

expr의 값의 합을 반환
 


VAR_POP *
 

Null값들을 제거한후에 Number 세트의 모집단 분산을 반환
 


VAR_SAMP *
 

null들을 제거한후에 number의 세트의 표본분산을 반환
 


VARIANCE *
 

expr의 분산을 반환
 
 




Object 참조 함수
 






함수명
 

설명
 


DEREF
 

인수 expr의 오브젝트 참조를 반환
 


MAKE_REF
 

object 인식자가 주 키로 근거하고 있는 object 테이블에서 object view의 행 또는 object 표의 행에 대한 REF를 생성
 


REF
 

인수로써 오브젝트 테이블 또는 오브젝트 뷰의 행과 연관된 상관 변수(테이블 별명)를 취한다.
 


REFTOHEX
 

인수 expr을 16진수로 변환.
 


VALUE
 

object 테이블에 저장된 object instance를 반환
 
 




모델 함수
 






함수명
 

설명
 


CV
 

포뮬러의 좌측 항에 정의된 multi-cell reference를 우측 항으로 복사하는 기능을 제공


우측 항 계산을 위해 좌측 항의 값 이용하기
 


ITERATION_NUMBER
 

델 규칙에 따라 완료된 반복을 나타내는 정수를 반환
 


PRESENTNNV
 

cell_reference가 존재하고 NULL이 아닌 경우, model_clause이 실행되기 전에 expr1을 반환
 


PRESENTV
 

cell_reference가 존재할때 expr1을 반환한다. 그 이외에는 expr2를 반환
 


PREVIOUS
 

각 iteration의 초기에 cell_reference의 값을 반환
 
 




기타 단일행 함수
 






함수명
 

설명
 


SYS_EXTRACT_UTC
 

협정 세계시간 UTC (Coordinated Universal Time?formerly Greenwich Mean Time)을 추출
 


UPDATEXML
 

XMLType인스턴스와 XPath값 쌍을 취하고, 업데이트된 값을 가지는 XMLType 인스턴스를 반환
 
--------------------------------------------------------------















    