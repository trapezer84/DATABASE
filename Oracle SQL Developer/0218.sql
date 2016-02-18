SELECT  * 
FROM    EMP_DETAILS_VIEW
;

SELECT    *
FROM      (
              SELECT
              e.employee_id,
              e.job_id,
              e.manager_id,
              e.department_id,
              d.location_id,
              l.country_id,
              e.first_name,
              e.last_name,
              e.salary,
              e.commission_pct,
              d.department_name,
              j.job_title,
              l.city,
              l.state_province,
              c.country_name,
              r.region_name
            FROM
              employees e,
              departments d,
              jobs j,
              locations l,
              countries c,
              regions r
            WHERE e.department_id = d.department_id
              AND d.location_id = l.location_id
              AND l.country_id = c.country_id
              AND c.region_id = r.region_id
              AND j.job_id = e.job_id
          )
;        

--  30. LAST_NAME 에 u 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 LAST_NAME 을 조회한다.
-- LAST_NAME에 u가 포함되는 사원들만 구성으로 해서 테이블(뷰)을 만든다. 
SELECT    DISTINCT EMPLOYEE_ID
          , LAST_NAME
FROM      (
            SELECT  DEPARTMENT_ID 
            FROM    EMPLOYEES
            WHERE   LAST_NAME LIKE '%u%'
          ) U_NAME
          , EMPLOYEES E
WHERE     U_NAME.DEPARTMENT_ID = E.DEPARTMENT_ID
;
-------------------------------------------------
SELECT    E.EMPLOYEE_ID
          , LAST_NAME
FROM      (
            SELECT  EMPLOYEE_ID 
            FROM    EMPLOYEES
            WHERE   LAST_NAME LIKE '%u%'
          ) U_NAME
          , EMPLOYEES E
WHERE     U_NAME.EMPLOYEE_ID = E.EMPLOYEE_ID
;
---------------------------------------------------
SELECT    EMPLOYEE_ID
          , LAST_NAME
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID IN (
                              SELECT    DEPARTMENT_ID
                              FROM      EMPLOYEES
                              WHERE     LAST_NAME LIKE '%u%'
                           )
;                           

-- 31. 위치 ID 가 1700 인 부서에서 근무하는 사원들의 LAST_NAME, 부서 번호 및 JOB_ID 를 조회한다.
SELECT      LAST_NAME
            , DEPARTMENT_ID
            , JOB_ID
FROM        (
              SELECT  EMPLOYEE_ID
              FROM    EMPLOYEES E
                      , DEPARTMENTS D
              WHERE   E.DEPARTMENT_ID = D.DEPARTMENT_ID
              AND     D.LOCATION_ID = '1700'
            ) EMP1700
            , EMPLOYEES E
WHERE       EMP1700.EMPLOYEE_ID = E.EMPLOYEE_ID
;            
            
-- 34. 회사 전체 평균 연봉 보다 더 버는 사원들 중 LAST_NAME 에 u 가 있는 사원들이
-- 근무하는 부서에서 근무하는 사원들의 사번, LAST_NAME 및 연봉을 조회한다.
SELECT        E.EMPLOYEE_ID
              , LAST_NAME
              , SALARY
FROM          (
                 SELECT     EMPLOYEE_ID
                 FROM       EMPLOYEES
                 WHERE      SALARY > (
                                        SELECT  AVG(SALARY)
                                        FROM    EMPLOYEES
                                     )                    
              ) EMP2
              , EMPLOYEES E
WHERE         EMP2.EMPLOYEE_ID =  E.EMPLOYEE_ID
AND           E.LAST_NAME LIKE '%u%'
;
------------------------------------------------------
SELECT        DISTINCT EMPLOYEE_ID
              , LAST_NAME
              , SALARY
FROM          (
                  /* LAST_NAME에 u가 들어가는 사원 VIEW */
                  SELECT        DEPARTMENT_ID
                  FROM          (
                                   /* 회사 전체 평균 연봉보다 더 많이 버는 사원 VIEW */
                                   SELECT     EMPLOYEE_ID
                                   FROM       EMPLOYEES
                                   WHERE      SALARY > (
                                                          SELECT  AVG(SALARY)
                                                          FROM    EMPLOYEES
                                                       )                    
                                ) EMP2
                                , EMPLOYEES E
                  WHERE         EMP2.EMPLOYEE_ID =  E.EMPLOYEE_ID
                  AND           E.LAST_NAME LIKE '%u%'
              ) DEPT
              , EMPLOYEES E
WHERE         DEPT.DEPARTMENT_ID = E.DEPARTMENT_ID       
ORDER         BY LAST_NAME
;
 
-- 42. 위치 ID 가 1700 인 사원들의 연봉과 커미션이 동일한 사원들의 
-- LAST_NAME, 부서 번호 및 연봉을 조회한다.
 SELECT     DISTINCT LAST_NAME
            , E.DEPARTMENT_ID
            , E.SALARY
FROM        (
                SELECT    SALARY
                          , NVL (COMMISSION_PCT, 0) COMMISSION_PCT
                FROM      EMPLOYEES EMP 
                          , DEPARTMENTS D
                WHERE     LOCATION_ID = '1700'
                AND       D.DEPARTMENT_ID = EMP.DEPARTMENT_ID
            ) EMP2
            , EMPLOYEES E
WHERE       E.SALARY = EMP2.SALARY
AND         EMP2.COMMISSION_PCT = NVL( E.COMMISSION_PCT, 0)
;
---- 35.ST_CLERK 인 직업 ID 를 가진 사원이 없는 부서 ID 를 조회한다.
-- NULL 값은 제외한다. (NOT EXISTS 사용)
SELECT      DISTINCT DEPARTMENT_ID
FROM        EMPLOYEES E
/*  밑의 자료가 없다면 출력해라. 라는 의미 */
WHERE       NOT EXISTS (
                        /* ST_CLERK 인 직업을 가진 사람들을 1로 출력한다. 그리고 이 사람들을 DEPARTMENT_ID 만 또 따로 빼줌 */
                        SELECT      '1' /* 있으면 1을 RETURN 하라는 의미 */
                        FROM        EMPLOYEES E1
                        WHERE       JOB_ID = 'ST_CLERK'                        
                        AND         E1.DEPARTMENT_ID = E.DEPARTMENT_ID
                   )
AND         DEPARTMENT_ID IS NOT NULL                   
ORDER       BY DEPARTMENT_ID                   
;

SELECT      '1'
FROM        EMPLOYEES
WHERE       JOB_ID = 'ST_CLERK'
AND         DEPARTMENT_ID = 60
;

---- 36. 위치한 부서가 없는 국가 ID 및 국가 이름을 조회힌다.(NOT EXISTS 사용)
SELECT      DISTINCT COUNTRY_ID
            , COUNTRY_NAME
FROM        COUNTRIES C
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        LOCATIONS L
                            WHERE       L.COUNTRY_ID = C.COUNTRY_ID    
                       )                   
;            

----------------------------------------
SELECT      DISTINCT COUNTRY_ID
            , COUNTRY_NAME
FROM        COUNTRIES C
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        LOCATIONS L
                                        , DEPARTMENTS D
                            WHERE       L.COUNTRY_ID = C.COUNTRY_ID    
                            AND         D.LOCATION_ID = L.LOCATION_ID 
                       )                   
;  
-----------------------------------------
---- 35.ST_CLERK 인 직업 ID 를 가진 사원이 없는 부서 ID 를 조회한다.
-- NULL 값은 제외한다. (NOT EXISTS 사용)
SELECT      DISTINCT DEPARTMENT_ID 
FROM        EMPLOYEES E
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        EMPLOYEES E1
                            WHERE       JOB_ID = 'ST_CLERK'                            
                            AND         E1.DEPARTMENT_ID = E.DEPARTMENT_ID
                       )
AND         DEPARTMENT_ID IS NOT NULL                       
ORDER       BY DEPARTMENT_ID 
;

SELECT      '1'
FROM        EMPLOYEES E1
WHERE       JOB_ID = 'ST_CLERK'
;


---- 36. 위치한 부서가 없는 국가 ID 및 국가 이름을 조회힌다.(NOT EXISTS 사용)
SELECT      COUNTRY_ID
            , COUNTRY_NAME
FROM        COUNTRIES C 
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        DEPARTMENTS D
                                        , LOCATIONS L
                            WHERE       D.LOCATION_ID = L.LOCATION_ID     
                            AND         L.COUNTRY_ID = C.COUNTRY_ID
                       )
;

SELECT      '1'
FROM        DEPARTMENTS D
            , LOCATIONS L
WHERE       D.LOCATION_ID = L.LOCATION_ID            
;
 
-- 47. NOT EXISTS 연산자를 사용하여 매니저가 아닌 사원 이름을 조회한다. 
SELECT      FIRST_NAME
FROM        EMPLOYEES E
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        EMPLOYEES EMP
                            WHERE       EMP.MANAGER_ID = E.EMPLOYEE_ID                            
                       )
;


 
-- 46. 각 부서별 평균 연봉보다 더 받는 동일부서 근무사원들의 
-- LAST_NAME, 연봉, 부서번호 및 해당 부서의 평균 연봉을 조회한다.
-- 결과는 부서별 연봉을 기준으로 정렬한다.


 
--  13. 직업이 AD_PRESS 인 사람은 A 등급을, 
-- ST_MAN 인 사람은 B 등급을,
-- IT_PROG 인 사람은 C 등급을,
-- SA_REP 인 사람은 D 등급을,
-- ST_CLEAK 인 사람은 E 등급을 
-- 기타는 0 을 부여하여 조회한다.
SELECT      *
FROM        (
                SELECT          EMPLOYEE_ID
                                , LAST_NAME
                                , FIRST_NAME
                                , DECODE (JOB_ID
                                    , 'AD_PRESS'        , 'A' 
                                    , 'ST_MAN'          , 'B'
                                    , 'IT_PROG'         , 'C'
                                    , 'SA_REP'          , 'D'
                                    , 'ST_CLERK'        , 'E'
                                    , '0') JOB_GRADE
                FROM        EMPLOYEES
            )
WHERE       JOB_GRADE = 'B'            
;

 
SELECT      EMPLOYEE_ID
            , FIRST_NAME
            , LAST_NAME
            , CASE
                WHEN    JOB_ID = (SELECT 'AD_PRESS' FROM DUAL)  THEN
                        'A'
                WHEN    JOB_ID = 'ST_NAME'   THEN
                        'B'
                WHEN    JOB_ID = 'IT_PROG'   THEN
                        'C'
                WHEN    JOB_ID = 'SA_REP'    THEN
                        'D'
                WHEN    JOB_ID = 'ST_CLERK'  THEN
                        'E'
                ELSE    '0'
            END
FROM        EMPLOYEES
;
 
----------------------------------------------
-- DUAL을 사용한 것 
SELECT      COUNT ( (
                    SELECT  EMPLOYEE_ID
                    FROM    EMPLOYEES
                    WHERE   HIRE_DATE LIKE '06%'
                  ) )
FROM        DUAL
;
-------------------------------
SELECT      LPAD('111', 6, '0')
            || LPAD('1', 6, '0')
            || RPAD('111', 6, '0')
            || RPAD('1', 6, '0')
FROM        DUAL
;

SELECT      LPAD('111', 6, '0')
            , LPAD('1', 6, '0')
            , RPAD('111', 6, '0')
            , RPAD('1', 6, '0')
FROM        DUAL
;

SELECT      






 
 