-- 14. 모든 사원들의 LAST_NAME, 부서 번호 및 부서 이름을 조회한다.
SELECT      LAST_NAME
            , D.DEPARTMENT_ID
            , DEPARTMENT_NAME
FROM        EMPLOYEES E 
            , DEPARTMENTS D
WHERE       D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER       BY D.DEPARTMENT_ID
;

-- 15. 부서번호 30 내의 모든 직업들을 유일한 포맷으로 조회한다. 90 부서 또한 포함한다.
SELECT      JOB_TITLE
FROM        JOBS J
            , JOB_HISTORY JH
WHERE       DEPARTMENT_ID IN (30, 90)
-- WHERE    DEPARTMENT_ID = 30 
-- OR       DEPARTMENT_ID = 90
AND         JH.JOB_ID = J.JOB_ID
;
----------------------------------------------------
SELECT      JOB_ID
            , LOCATION_ID
FROM        EMPLOYEES E
            , DEPARTMENTS D     
WHERE       DEPARTMENT_ID IN (30, 90)
AND         D.DEPARTMENT_ID = E.DEPARTMENT_ID
;
-- 16. 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
SELECT      LAST_NAME
            , DEPARTMENT_NAME
            , L.LOCATION_ID
            , CITY
FROM        EMPLOYEES E
            , LOCATIONS L
            , DEPARTMENTS D
WHERE       D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND         L.LOCATION_ID = D.LOCATION_ID
AND         COMMISSION_PCT IS NOT NULL
AND         COMMISSION_PCT != 0
ORDER       BY CITY
;

-- * 18. 자신의 매니저보다 먼저 고용된 사원들의 LAST_NAME 및 고용일을 조회한다.
SELECT      LAST_NAME
            , HIRE_DATE
FROM        EMPLOYEES E
WHERE       HIRE_DATE < (
                            SELECT    HIRE_DATE
                            FROM      EMPLOYEES
                            WHERE     E.MANAGER_ID = EMPLOYEE_ID
                            AND       ROWNUM = 1
                        )
ORDER       BY HIRE_DATE
;
----------------------------------------
SELECT    EMP.LAST_NAME
          , EMP.HIRE_DATE 
FROM      EMPLOYEES EMP 
          , EMPLOYEES MGR
WHERE     EMP.MANAGER_ID = MGR.EMPLOYEE_ID
AND       EMP.HIRE_DATE < MGR.HIRE_DATE
;

-- 25. 부서 명, 위치 ID, 각 부서 별 사원 총 수, 각 부서 별 평균 연봉을 조회한다. - 평균 연봉은 소수점 2 자리까지만 표현한다.
SELECT      DEPARTMENT_NAME
            , D.LOCATION_ID
            , COUNT(EMPLOYEE_ID)
            , ROUND ( AVG(SALARY), 2)
FROM        DEPARTMENTS D
            , LOCATIONS L
            , EMPLOYEES E
WHERE       D.LOCATION_ID = L.LOCATION_ID
AND         E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP       BY DEPARTMENT_NAME
            , D.LOCATION_ID
ORDER       BY  LOCATION_ID
            , COUNT(EMPLOYEE_ID)
;
-- 31. 위치 ID 가 1700 인 부서에서 근무하는 사원들의 LAST_NAME, 부서 번호 및 JOB_ID 를 조회한다.
-- 18개 
SELECT    LAST_NAME
          , D.DEPARTMENT_ID
          , JOB_ID
FROM      EMPLOYEES E
          , DEPARTMENTS D
WHERE     D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND       LOCATION_ID = 1700 
;

-- 33. Executive 부서에 근무하는 모든 사원들의 부서 번호, LAST_NAME, JOB_ID 를 조회한다.
SELECT      D.DEPARTMENT_ID
            , LAST_NAME
            , JOB_ID
FROM        EMPLOYEES E
            , DEPARTMENTS D
WHERE       DEPARTMENT_NAME = 'Executive'
AND         D.DEPARTMENT_ID = E.DEPARTMENT_ID          
;
-- 42. 위치 ID 가 1700 인 사원들의 연봉과 커미션이 동일한 사원들의 LAST_NAME, 부서 번호 및 연봉을 조회한다.
SELECT      LAST_NAME
            , D.DEPARTMENT_ID
            , SALARY
FROM        EMPLOYEES E
            , DEPARTMENTS D
WHERE       SALARY IN (
                        SELECT      SALARY
                        FROM        EMPLOYEES E
                                    , DEPARTMENTS D
                        WHERE       D.DEPARTMENT_ID = E.DEPARTMENT_ID
                        AND         D.LOCATION_ID = 1700 
                     )
AND         NVL (COMMISSION_PCT, 0) IN (
                                          SELECT      NVL (COMMISSION_PCT, 0)
                                          FROM        EMPLOYEES E
                                                      , DEPARTMENTS D
                                          WHERE       D.DEPARTMENT_ID = E.DEPARTMENT_ID
                                          AND         D.LOCATION_ID = 1700                                     
                                       )    
AND         D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND         LOCATION_ID != 1700                                       
ORDER       BY SALARY
            , DEPARTMENT_ID
;
-----------------------------------------------------------------------------------
SELECT      LAST_NAME
            , D.DEPARTMENT_ID
            , SALARY
FROM        EMPLOYEES E 
            , DEPARTMENTS D
WHERE       E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND         ( SALARY, COMMISSION_PCT )
AND         LOCATION_ID = 1700
ORDER       BY SALARY
            , DEPARTMENT_ID

;
-------------------------------------
SELECT  EMP1.LAST_NAME
        , EMP1.DEPARTMENT_ID
        , EMP1.SALARY
FROM    EMPLOYEES EMP1
        , (
              SELECT  DISTINCT EMP.SALARY
                      , EMP.COMMISSION_PCT
              FROM    EMPLOYEES EMP
                      , DEPARTMENTS DEPT
              WHERE   EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
              AND     DEPT.LOCATION_ID = 1700
           ) EMP_1700
WHERE   EMP1.SALARY = EMP_1700.SALARY
AND     NVL(EMP1.COMMISSION_PCT,0) = NVL(EMP_1700.COMMISSION_PCT, 0)
;
            
-- 43. LAST_NAME 이 'Kochhar' 인 사원과 동일한 연봉 및 커미션을 버는 사원들의 LAST_NAME, 부서 번호 및 연봉을 조회한다.
SELECT      LAST_NAME
            , DEPARTMENT_ID 
            , SALARY
FROM        EMPLOYEES
WHERE       SALARY = (
                        SELECT      SALARY
                        FROM        EMPLOYEES
                        WHERE       LAST_NAME = 'Kochhar'                        
                     )
OR          NVL (COMMISSION_PCT, 0) = (
                                        SELECT      COMMISSION_PCT
                                        FROM        EMPLOYEES
                                        WHERE       LAST_NAME = 'Kochhar'                                            
                                      )                                      
;
--------------------------------------------------------
SELECT      LAST_NAME
            , DEPARTMENT_ID 
            , SALARY
FROM        EMPLOYEES
WHERE       (SALARY , NVL (COMMISSION_PCT, 0) ) IN (
                                        SELECT      SALARY 
                                                    , NVL (COMMISSION_PCT, 0)
                                        FROM        EMPLOYEES
                                        WHERE       LAST_NAME = 'Kochhar'                                            
                                      )                                      
;
                 
                                      
-- 44. 직업 ID 가 SA_MAN 인 사원들의 최대 연봉 보다 높게 받는 사원들의 LAST_NAME, JOB_ID 및 연봉을 조회한다.
SELECT      LAST_NAME
            , JOB_ID
            , SALARY
FROM        EMPLOYEES
WHERE       SALARY > (
                          SELECT      MAX(SALARY)
                          FROM        EMPLOYEES
                          WHERE       JOB_ID = 'SA_MAN'                        
                     )
ORDER       BY SALARY
            , LAST_NAME
;


-- 45. 도시 이름이 T 로 시작하는 지역에 사는 사원들의 사번, LAST_NAME 및 부서 번호를 조회한다.
SELECT      EMPLOYEE_ID
            , LAST_NAME
            , D.DEPARTMENT_ID
FROM        EMPLOYEES E 
            , LOCATIONS L
            , DEPARTMENTS D
WHERE       L.LOCATION_ID IN (
                              SELECT      LOCATION_ID
                              FROM        LOCATIONS
                              WHERE       CITY LIKE 'T%'
                           )
AND         D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND         D.LOCATION_ID = L.LOCATION_ID
;

-- 11개 (18번 문제는 옵션)