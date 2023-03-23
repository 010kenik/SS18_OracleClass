-- HR --
    
SELECT TO_CHAR( TO_DATE('2022.01.03'), 'IW' ) -- ISO 표준 주   월~일까지 1주.
, TO_CHAR( TO_DATE('2022.01.09'), 'IW' )
 , TO_CHAR( TO_DATE('2022.02.04'), 'WW' )  -- 년의 주          1~7  끝어짐
 , TO_CHAR( TO_DATE('2022.02.05'), 'WW' )
FROM dual;

               
                
 
 
 
 
 
 
 