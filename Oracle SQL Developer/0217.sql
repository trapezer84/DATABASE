-- 전체 사원들의 사원 번호, LAST_NAME, 부서명, 부서 번호를 조회한다. 
SELECT    EMPLOYEE_ID
          , LAST_NAME
          , DEPARTMENT_NAME
          , D.DEPARTMENT_ID
FROM      EMPLOYEES E 
          , DEPARTMENTS D 
WHERE     E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

SELECT      FIRST_NAME
            , JOB_ID
            , JOB_NAME
FROM        EMPLOYEES
            , 
;
            
SELECT    LAST_NAME
          , DEPARTMENT_NAME
          , L.LOCATION_ID
          , CITY 
FROM      EMPLOYEES E
          , DEPARTMENTS D 
          , LOCATIONS L 
WHERE     E.DEPARTMENT_ID = D.DEPARTMENT_ID -- 빨간 줄 
AND       D.LOCATION_ID = L.LOCATION_ID -- 보라 줄 
AND       L.LOCATION_ID = (
                              SELECT LOCATION_ID 
                              FROM   LOCATIONS
                              WHERE  CITY = 'Seattle'
                          )
--AND       L.CITY = 'Seattle'
;
       
-- 25
--부서명, 위치 ID, 각 부서 별 사원 총 수, 각 부서 별 평균 연봉을 조회 한다 
-- 평균 연봉은 2자리 수 까지 
SELECT    DEPARTMENT_NAME
          , LOCATION_ID
          , COUNT(EMPLOYEE_ID)
          , AVG(SALARY)
FROM      DEPARTMENTS D  
          , EMPLOYEES E 
WHERE     E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP     BY DEPARTMENT_NAME
          , LOCATION_ID
;

-- 27번 다음과 같은 포맷으로 각 부서 별 각 직업 별 연봉 총 합 및 각 부서별 연봉 총 합을 조회한다.
SELECT  JOB_ID
        , NVL((
            SELECT  SUM(SALARY)
            FROM    EMPLOYEES E1
            WHERE   E1.DEPARTMENT_ID = 20
            AND     E.JOB_ID = E1.JOB_ID
          ),0) DEPT20
         , NVL((
            SELECT  SUM(SALARY)
            FROM    EMPLOYEES E1
            WHERE   E1.DEPARTMENT_ID = 50
            AND     E.JOB_ID = E1.JOB_ID
          ),0) DEPT50
        , NVL((
            SELECT  SUM(SALARY)
            FROM    EMPLOYEES E1
            WHERE   E1.DEPARTMENT_ID = 80
            AND     E.JOB_ID = E1.JOB_ID
          ),0) DEPT80
        , NVL((
            SELECT  SUM(SALARY)
            FROM    EMPLOYEES E1
            WHERE   E1.DEPARTMENT_ID = 90
            AND     E.JOB_ID = E1.JOB_ID
          ),0) DEPT90
        , SUM(SALARY)
FROM    EMPLOYEES E
GROUP   BY JOB_ID
;







