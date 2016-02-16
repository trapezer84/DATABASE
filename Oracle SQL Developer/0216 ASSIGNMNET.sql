-- 10. LAST_NAME 의 네번째 글자가 a 인 사원들의 LAST_NAME 을 조회한다.
SELECT      LAST_NAME
FROM        EMPLOYEES
WHERE       LAST_NAME LIKE '___a%'
;

-- 11. LAST_NAME 에 a 및 e 글자가 있는 사원들의 LAST_NAME 을 조회한다.
SELECT      LAST_NAME
FROM        EMPLOYEES
WHERE       LAST_NAME LIKE '%a%'
OR          LAST_NAME LIKE '%e%'
;

-- 17. LAST_NAME 이 Davies 인 사람보다 후에 고용된 사원들의 LAST_NAME 및 HIRE_DATE 을 조회한다.
SELECT      LAST_NAME
            , HIRE_DATE
FROM        EMPLOYEES
WHERE       HIRE_DATE > (
                            SELECT      HIRE_DATE
                            FROM        EMPLOYEES
                            WHERE       LAST_NAME = 'Davies'
                        )
;


-- 19. 회사 전체의 최대 연봉, 최소 연봉, 연봉 총 합 및 평균 연봉을 자연수로 포맷하여 조회한다.
SELECT      MAX(SALARY)
            , MIN(SALARY)
            , SUM(SALARY)
            , ROUND (AVG(SALARY))
FROM        EMPLOYEES
;

-- 20. 각 JOB_ID 별, 최대 연봉, 최소 연봉, 연봉 총 합 및 평균 연봉을 자연수로 포맷하여 조회한다.
SELECT      JOB_ID
            , MAX(SALARY)
            , MIN(SALARY)
            , SUM(SALARY)
            , ROUND (AVG(SALARY))
FROM        EMPLOYEES
GROUP       BY JOB_ID
;

-- 21. 동일한 직업을 가진 사원들의 총 수를 조회한다.
SELECT      DEPARTMENT_ID
            , COUNT(EMPLOYEE_ID)
FROM        EMPLOYEES
GROUP       BY DEPARTMENT_ID
ORDER       BY DEPARTMENT_ID
;

-- 22. 매니저로 근무하는 사원들의 총 수를 조회한다.
SELECT      COUNT(MANAGER_ID)
FROM        EMPLOYEES
WHERE       MANAGER_ID IS NOT NULL
;

-- 23. 사내의 최대 연봉 및 최소 연봉의 차이를 조회한다.
SELECT      MAX(SALARY) - MIN(SALARY)
FROM        EMPLOYEES
;

-- 26. 총 사원 수 및 2005, 2006, 2007, 2008 년도 별 고용된 사원들의 총 수를 다음과 같이 조회한다.
SELECT      COUNT(EMPLOYEE_ID)
FROM        EMPLOYEES
;

SELECT      COUNT(EMPLOYEE_ID)     
FROM        EMPLOYEES
WHERE       HIRE_DATE IN (
                            SELECT      HIRE_DATE
                            FROM        EMPLOYEES
                            WHERE       HIRE_DATE LIKE '05%'
                            OR          HIRE_DATE LIKE '06%'
                            OR          HIRE_DATE LIKE '07%'
                            OR          HIRE_DATE LIKE '08%'
                          )
;
------------------------------------------------------------------------------------------
SELECT      DISTINCT
            ( SELECT  COUNT(EMPLOYEE_ID) 
                FROM    EMPLOYEES
            ) AS ALL_COUNT
            , ( SELECT  COUNT(HIRE_DATE)
                FROM    EMPLOYEES
                WHERE   HIRE_DATE LIKE '05%'
              ) AS COUNT05
            , ( SELECT  COUNT(HIRE_DATE)
                FROM    EMPLOYEES
                WHERE   HIRE_DATE LIKE '06%'
              ) AS COUNT06
            , ( SELECT  COUNT(HIRE_DATE)
                FROM    EMPLOYEES
                WHERE   HIRE_DATE LIKE '07%'
              ) AS COUNT07
            , ( SELECT  COUNT(HIRE_DATE)
                FROM    EMPLOYEES
                WHERE   HIRE_DATE LIKE '08%'
              ) AS COUNT08
FROM        EMPLOYEES
;
-----------------------------------------------------------------------------------------




-- 27. 다음과 같은 포맷으로 각 부서 별 각 직업 별 연봉 총 합 및 각 부서별 연봉 총 합을 조회한다.
SELECT      SUM(SALARY)
            , DEPARTMENT_ID
FROM        EMPLOYEES
GROUP       BY DEPARTMENT_ID
ORDER       BY DEPARTMENT_ID
;

SELECT      SUM(SALARY)
            , JOB_ID
FROM        EMPLOYEES
GROUP       BY JOB_ID
ORDER       BY SUM(SALARY)
;
---------------------------------------------------------------------------------
SELECT     JOB_ID 
            , (
                SELECT  SUM(SALARY)
                FROM    EMPLOYEES
                WHERE   DEPARTMENT_ID = 20
             ) DEPARTMENTID20
            , (
                SELECT  SUM(SALARY)
                FROM    EMPLOYEES
                WHERE   DEPARTMENT_ID = 50
             ) DEPARTMENTID50
            , (
                SELECT  SUM(SALARY)
                FROM    EMPLOYEES
                WHERE   DEPARTMENT_ID = 80
             ) DEPARTMENTID80
            , (
                SELECT  SUM(SALARY)
                FROM    EMPLOYEES
                WHERE   DEPARTMENT_ID = 90
             ) DEPARTMENTID90
            , (
                SELECT  SUM(SALARY)
                FROM    EMPLOYEES
             ) DEPARTMENTIDTOTAL
FROM        EMPLOYEES
GROUP   BY JOB_ID
ORDER   BY JOB_ID
;

-- 28. LAST_NAME 이 Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 조회한다.
SELECT      EMPLOYEE_ID
            , HIRE_DATE
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID IN (
                              SELECT      DEPARTMENT_ID
                              FROM        EMPLOYEES
                              WHERE       LAST_NAME = 'Zlotkey'
                              )
;

-- 29. 회사 전체 평균 연봉보다 더 받는 사원들의 사번 및 LAST_NAME 을 조회한다.
SELECT    EMPLOYEE_ID
          , LAST_NAME
FROM      EMPLOYEES
WHERE     SALARY > (
                    SELECT    AVG(SALARY)
                    FROM      EMPLOYEES
                    )
;

-- 30. LAST_NAME 에 u 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 LAST_NAME 을 조회한다.
SELECT      EMPLOYEE_ID
            , LAST_NAME
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID IN (
                              SELECT      DEPARTMENT_ID
                              FROM        EMPLOYEES
                              WHERE       LAST_NAME LIKE '%u%'
                              )
ORDER       BY EMPLOYEE_ID
;


-- 32. King 을 매니저로 두고 있는 모든 사원들의 LAST_NAME 및 연봉을 조회한다.
SELECT      LAST_NAME
            , SALARY
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID IN (
                              SELECT  DEPARTMENT_ID
                              FROM    EMPLOYEES
                              WHERE   LAST_NAME = 'King'
                              )
;

-- 34. 회사 전체 평균 연봉 보다 더 버는 사원들 중 LAST_NAME 에 u 가 있는 사원들이 근무하는 부서에서 근무하는 사원들의 사번, LAST_NAME 및 연봉을 조회한다.
SELECT      EMPLOYEE_ID
            , LAST_NAME
FROM        EMPLOYEES
WHERE       SALARY > (
                      SELECT  AVG(SALARY)
                      FROM    EMPLOYEES
                      )
AND         LAST_NAME LIKE '%u%'
;

