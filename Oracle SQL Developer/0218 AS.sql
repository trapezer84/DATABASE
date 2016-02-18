--1
SELECT LAST_NAME
       , SALARY
FROM   EMPLOYEES
WHERE  SALARY >= 12000
;

--2
SELECT LAST_NAME
       , DEPARTMENT_ID
FROM   EMPLOYEES
WHERE  EMPLOYEE_ID = 176
;

--3
SELECT LAST_NAME
       , SALARY
FROM   EMPLOYEES
WHERE  NOT(SALARY >= 5000
AND    SALARY <= 12000)
;

--4
SELECT LAST_NAME
       , JOB_ID
       , HIRE_DATE
FROM   EMPLOYEES
WHERE  HIRE_DATE >= '1998/02/20'
AND    HIRE_DATE <= '2003/05/01'
;

--5
SELECT LAST_NAME
       , DEPARTMENT_ID
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID IN ( 20, 50 )
ORDER  BY LAST_NAME ASC 
;

--6
SELECT LAST_NAME
       , SALARY
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID IN ( 20, 50 )
AND    SALARY >= 5000
AND    SALARY <= 12000
;

--7
SELECT LAST_NAME
       , HIRE_DATE
FROM   EMPLOYEES
WHERE  HIRE_DATE LIKE '1994%'
;

--8
SELECT LAST_NAME
       , JOB_ID
FROM   EMPLOYEES
WHERE  MANAGER_ID is null
OR MANAGER_ID = ''
;

--9
SELECT LAST_NAME
       , SALARY
       , COMMISSION_PCT
FROM   EMPLOYEES
WHERE  NOT(COMMISSION_PCT is null)
ORDER  BY SALARY DESC
       , COMMISSION_PCT DESC
;    

--10
SELECT LAST_NAME
FROM   EMPLOYEES
WHERE  LAST_NAME LIKE '___a%'
;

--11
SELECT LAST_NAME
FROM   EMPLOYEES
WHERE  LAST_NAME LIKE '%a%'
AND    LAST_NAME LIKE '%e%'
;

--12
SELECT LAST_NAME
       , JOB_ID
       , SALARY
FROM   EMPLOYEES
WHERE  JOB_ID IN ( 'SA_REP' , 'ST_CLERK')
AND    SALARY NOT IN ( 2500, 3500, 7000 )
;

--13
SELECT *
FROM (
        SELECT  EMPLOYEE_ID
                , FIRST_NAME
                , LAST_NAME
                , DECODE(JOB_ID
                            , 'AD_PRESS', 'A' 
                            , 'ST_MAN', 'B'
                            , 'IT_PROG', 'C' 
                            , 'SA_REP', 'D'
                            , 'ST_CLERK', 'E'
                            , '0') JOB_GRADE
        FROM    EMPLOYEES
        )
;

--14 모든 사원들의 LAST_NAME, 부서 번호 및 부서 이름을 조회한다.
SELECT LAST_NAME
       , DEPARTMENT_ID
       , DEPARTMENT_NAME
FROM   EMPLOYEES
;

--15 부서번호 30 내의 모든 직업들을 유일한 포맷으로 조회한다. 
--   90 부서 또한 포함한다.
SELECT  DISTINCT JOB_ID
        , LOCATION_ID
        , D.DEPARTMENT_ID
FROM    EMPLOYEES E
        , DEPARTMENTS D
WHERE   E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND     (
        E.DEPARTMENT_ID <= 30
        OR E.DEPARTMENT_ID = 90
        )
;

--16. 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
SELECT  LAST_NAME
        , DEPARTMENT_NAME
        , L.LOCATION_ID
        , CITY
FROM    EMPLOYEES E
        , DEPARTMENTS D
        , LOCATIONS L
WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID -- 빨간줄
AND    D.LOCATION_ID = L.LOCATION_ID -- 보라줄
AND    E.COMMISSION_PCT IS NOT NULL
AND    E.COMMISSION_PCT != 0
;

--17. LAST_NAME 이 DAVIES 인 사람보다 후에 고용된 사원들의 LAST_NAME 및 HIRE_DATE 을 조회한다.
SELECT LAST_NAME
       , HIRE_DATE
FROM   EMPLOYEES
WHERE  HIRE_DATE > (
                    SELECT HIRE_DATE
                    FROM   EMPLOYEES
                    WHERE  LAST_NAME = 'Davies'
                    )
ORDER  BY HIRE_DATE ASC
;

--* 18. 자신의 매니저보다 먼저 고용된 사원들의 LAST_NAME 및 고용일을 조회한다.
-- 자기자신 조인은 WHERE 순서가 중요함.
SELECT  EMP.EMPLOYEE_ID
        ,EMP.LAST_NAME
        , EMP.HIRE_DATE
        , MGR.EMPLOYEE_ID
        , MGR.HIRE_DATE
FROM    EMPLOYEES EMP
        , EMPLOYEES MGR
        --사원들의 매니저 아이디가 매니저의 EMPLOYEE_ID와 같은거
WHERE   EMP.MANAGER_ID = MGR.EMPLOYEE_ID
AND     EMP.HIRE_DATE < MGR.HIRE_DATE
;

-- 19. 회사 전체의 최대 연봉, 최소 연봉, 연봉 총 합 및 평균 연봉을 자연수로 포맷하여 조회한다.
SELECT  MAX(SALARY)
       , MIN(SALARY)
       , SUM(SALARY)
       , ROUND(AVG(SALARY))
FROM   EMPLOYEES
;

-- 20. 각 JOB_ID 별, 최대 연봉, 최소 연봉, 연봉 총 합 및 평균 연봉을 자연수로 포맷하여 조회한다.
SELECT JOB_ID
        , ROUND(MAX(SALARY))
        , ROUND(MIN(SALARY))
        , ROUND(SUM(SALARY))
        , ROUND(AVG(SALARY))
FROM   EMPLOYEES
GROUP  BY JOB_ID
;

-- 21. 동일한 직업을 가진 사원들의 총 수를 조회한다.
SELECT JOB_ID, COUNT(EMPLOYEE_ID)
FROM   EMPLOYEES
WHERE  EMPLOYEE_ID IS NOT NULL
GROUP  BY JOB_ID
;

-- 22. 매니저로 근무하는 사원들의 총 수를 조회한다.
SELECT COUNT(EMPLOYEE_ID)
FROM   EMPLOYEES
WHERE  EMPLOYEE_ID IN ( 
                      SELECT MANAGER_ID
                      FROM EMPLOYEES
                      WHERE MANAGER_ID IS NOT NULL
                      GROUP BY MANAGER_ID
                      )
;

-- 23. 사내의 최대 연봉 및 최소 연봉의 차이를 조회한다.
SELECT (MAX(SALARY)-MIN(SALARY))DIFF
FROM   EMPLOYEES
;

--24.  매니저의 사번 및 그 매니저 밑 사원들 중 최소 연봉을 받는 사원의 연봉을 조회한다.
-- 매니저가 없는 사람들은 제외한다.
-- 최소 연봉이 6000 미만인 경우는 제외한다.
-- 연봉 기준 역순으로 조회한다.
SELECT      MANAGER_ID
            , MIN(SALARY)
FROM        EMPLOYEES
WHERE       MANAGER_ID IS NOT NULL
GROUP       BY MANAGER_ID
HAVING      MIN(SALARY) >= 6000
ORDER       BY MIN(SALARY) DESC
;


--25. 부서 명, 위치 ID, 각 부서 별 사원 총 수, 각 부서 별 평균 연봉을 조회한다. - 평균 연봉은 소수점 2 자리까지만 표현한다.
-- COUNT, AVG 집계함수를 제외한 SELECT COLUMN은 GROUP BY 를 써줘야함.
SELECT  DEPARTMENT_NAME
        , LOCATION_ID
        , COUNT(EMPLOYEE_ID)
        , ROUND(AVG(SALARY),2)
FROM    DEPARTMENTS D
        , EMPLOYEES E
WHERE   D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP   BY DEPARTMENT_NAME
        , LOCATION_ID
;

-- 26. 총 사원 수 및 1995, 1996, 1997, 1998 년도 별 고용된 사원들의 총 수를 다음과 같이 조회한다.
-- 날짜를 적을때는 2005% 이런식으로 적어야됨. 05% 이렇게하면 안될수도 있음. 데이터베이스에는 날짜가 2005이렇게 들어가기때문
SELECT DISTINCT (
                SELECT COUNT(*)
                FROM   EMPLOYEES
                ) AS COUNTALL
                ,
                (
                SELECT COUNT(*)
                FROM   EMPLOYEES
                WHERE  HIRE_DATE LIKE '2001%'
                ) AS COUNT2001
                ,
                (
                SELECT COUNT(*)
                FROM   EMPLOYEES
                WHERE  HIRE_DATE LIKE '2003%'
                ) AS COUNT2003
                ,
                (
                SELECT COUNT(*)
                FROM   EMPLOYEES
                WHERE  HIRE_DATE LIKE '2005%'
                ) AS COUNT2005
FROM   EMPLOYEES
;

-- 27. 다음과 같은 포맷으로 각 부서 별 각 직업 별 연봉 총 합 및 각 부서별 연봉 총 합을 조회한다.
SELECT JOB_ID
        , (
          SELECT SUM(SALARY)
          FROM   EMPLOYEES
          WHERE  DEPARTMENT_ID = 20
          AND    JOB_ID = E.JOB_ID
          ) DEPT20
          , (
          SELECT SUM(SALARY)
          FROM   EMPLOYEES
          WHERE  DEPARTMENT_ID = 50
          AND    JOB_ID = E.JOB_ID
          ) DEPT50
        ,
        (
          SELECT SUM(SALARY)
          FROM   EMPLOYEES
          WHERE  DEPARTMENT_ID = 80
          AND    JOB_ID = E.JOB_ID
          ) DEPT80
        ,
        (
          SELECT SUM(SALARY)
          FROM   EMPLOYEES
          WHERE  DEPARTMENT_ID = 90
          AND    JOB_ID = E.JOB_ID
          ) DEPT90
        ,
        SUM(SALARY)
FROM   EMPLOYEES E
GROUP  BY JOB_ID
;

-- 28. LAST_NAME 이 Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 조회한다.
SELECT EMPLOYEE_ID
       , HIRE_DATE
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID = (
                        SELECT DEPARTMENT_ID
                        FROM   EMPLOYEES
                        WHERE  LAST_NAME = 'Zlotkey'
                        )   
AND    LAST_NAME != 'Zlotkey'
;

-- 29. 회사 전체 평균 연봉보다 더 받는 사원들의 사번 및 LAST_NAME 을 조회한다.
SELECT EMPLOYEE_ID
       , LAST_NAME
FROM   EMPLOYEES
WHERE  SALARY > (
                 SELECT AVG(SALARY)
                 FROM   EMPLOYEES
                 )
;

-- 30. LAST_NAME 에 u 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 LAST_NAME 을 조회한다.
SELECT EMPLOYEE_ID
       , LAST_NAME
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID IN (
                        SELECT DEPARTMENT_ID
                        FROM   EMPLOYEES
                        WHERE  LAST_NAME LIKE '%u%'
                        )
;                      

--31. 위치 ID 가 1700 인 부서에서 근무하는 사원들의 LAST_NAME, 부서 번호 및 JOB_ID 를 조회한다.
SELECT  LAST_NAME
        , D.DEPARTMENT_ID
        , JOB_ID
FROM    EMPLOYEES E
        , DEPARTMENTS D
        , LOCATIONS L
WHERE   L.LOCATION_ID = 1700
AND     D.LOCATION_ID = L.LOCATION_ID
AND     D.DEPARTMENT_ID = E.DEPARTMENT_ID
;

-- 32. King 을 매니저로 두고 있는 모든 사원들의 LAST_NAME 및 연봉을 조회한다.
SELECT LAST_NAME
       , SALARY
FROM   EMPLOYEES
WHERE  MANAGER_ID IN (
                      SELECT EMPLOYEE_ID
                      FROM   EMPLOYEES
                      WHERE  LAST_NAME = 'King'
                     )
;

--33. EXECUTIVE 부서에 근무하는 모든 사원들의 부서 번호, LAST_NAME, JOB_ID 를 조회한다.
SELECT  D.DEPARTMENT_ID
        , LAST_NAME
        , JOB_ID
FROM    DEPARTMENTS D
        , EMPLOYEES E
WHERE   D.DEPARTMENT_NAME = 'Executive'
AND     D.DEPARTMENT_ID = E.DEPARTMENT_ID
;

-- 34. 회사 전체 평균 연봉 보다 더 버는 사원들 중 LAST_NAME 에 u 가 있는 사원들이 근무하는 부서에서 근무하는 사원들의 사번, LAST_NAME 및 연봉을 조회한다.
SELECT EMPLOYEE_ID
       , LAST_NAME
       , SALARY
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID IN (
                        SELECT DEPARTMENT_ID
                        FROM   EMPLOYEES
                        WHERE  LAST_NAME LIKE '%u%'
                        AND    SALARY > (
                                          SELECT AVG(SALARY)
                                          FROM   EMPLOYEES
                                        )
                       )
;

--35.  ST_CLERK 인 직업 ID 를 가진 사원이 없는 부서 ID 를 조회한다.
-- NULL 값은 제외한다. (NOT EXISTS 사용. 왠만하면 사용하지말고. 이거말고 답이안나올때..)
-- EXISTS 는 컬럼이 필요없음..... (서브쿼리의 ROW가 있는지 없는지만)
SELECT  DISTINCT DEPARTMENT_ID
FROM    EMPLOYEES E
WHERE   NOT EXISTS (
                    /*조건이 있으면 1을 리턴해주는거임*/
                    SELECT  '1'
                    FROM    EMPLOYEES E1
                    WHERE   JOB_ID = 'ST_CLERK'
                    AND     E1.DEPARTMENT_ID = E.DEPARTMENT_ID
                   )
AND      DEPARTMENT_ID IS NOT NULL                
;


--36. 위치한 부서가 없는 국가 ID 및 국가 이름을 조회힌다.(NOT EXISTS 사용)
/*부서가 없음*/
SELECT  DISTINCT C.COUNTRY_ID
        , COUNTRY_NAME
FROM    COUNTRIES C
WHERE   NOT EXISTS ( 
/* 일치하는 ROW가 없다면 */
                      SELECT  '1'
                      FROM    DEPARTMENTS D
                              , LOCATIONS L
                      WHERE   L.LOCATION_ID = D.LOCATION_ID
                      AND     L.COUNTRY_ID = C.COUNTRY_ID
                   )
ORDER   BY COUNTRY_ID                   
;
                  
       
/* LOCATION 자체가 없음*/    
SELECT  DISTINCT C.COUNTRY_ID
        , COUNTRY_NAME
FROM    COUNTRIES C
WHERE   NOT EXISTS ( 
                      SELECT  '1'
                      FROM    DEPARTMENTS D
                              , LOCATIONS L
                      WHERE     L.COUNTRY_ID = C.COUNTRY_ID
                   )
                   
;


--37. 기존의 직업을 여전히 가지고 있는 사원들의 사번 및 JOB_ID 를 조회한다.
SELECT      E.EMPLOYEE_ID
            , J.JOB_ID
FROM        EMPLOYEES E 
            , JOB_HISTORY J
WHERE       E.JOB_ID = J.JOB_ID
AND         E.EMPLOYEE_ID NOT IN J.EMPLOYEE_ID
ORDER       BY EMPLOYEE_ID
;
------------------------------2
SELECT      DISTINCT E.EMPLOYEE_ID
            , JOB_ID
FROM        EMPLOYEES E
            , (
                SELECT DISTINCT EMPLOYEE_ID
                FROM   JOB_HISTORY
            ) JH
WHERE       E.EMPLOYEE_ID NOT IN JH.EMPLOYEE_ID
ORDER       BY EMPLOYEE_ID
;
-------------------3
SELECT      E.EMPLOYEE_ID
            , E.JOB_ID
FROM        EMPLOYEES E
WHERE       NOT EXISTS (
                          SELECT    EMPLOYEE_ID
                          FROM      JOB_HISTORY J
                          WHERE     J.EMPLOYEE_ID = E.EMPLOYEE_ID
                       )
ORDER       BY EMPLOYEE_ID
;
--41. 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의 LAST_NAME, 부서 번호 및 연봉을 조회한다.
SELECT  LAST_NAME
        , DEPARTMENT_ID
        , SALARY
FROM    EMPLOYEES
WHERE   (DEPARTMENT_ID, SALARY) IN (
                                        SELECT  DEPARTMENT_ID
                                                , SALARY
                                        FROM    EMPLOYEES
                                        WHERE   COMMISSION_PCT IS NOT NULL
                                   )
;                                   

--42. 위치 ID 가 1700 인 사원들의 연봉과 커미션이 동일한 사원들의 LAST_NAME, 부서 번호 및 연봉을 조회한다.
SELECT  LAST_NAME
        , D.DEPARTMENT_ID
        , SALARY
FROM    EMPLOYEES E
        , DEPARTMENTS D
WHERE   D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND    (
        E.SALARY 
        , NVL(E.COMMISSION_PCT, 0)
        , D.LOCATION_ID
        ) IN (
                SELECT SALARY
                      , NVL(COMMISSION_PCT, 0)
                      , D2.LOCATION_ID
                FROM   EMPLOYEES E2
                       , DEPARTMENTS D2
                WHERE  D2.LOCATION_ID = 1700
                AND    D2.DEPARTMENT_ID = E2.DEPARTMENT_ID
                AND    E.EMPLOYEE_ID != E2.EMPLOYEE_ID
             )                             
;

SELECT  LAST_NAME
        , D.DEPARTMENT_ID
        , SALARY
        , LOCATION_ID
FROM    EMPLOYEES E
        , DEPARTMENTS D
WHERE   D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND    (
        E.SALARY 
        , NVL(E.COMMISSION_PCT, 0)
        ) IN (
               SELECT SALARY
                      , NVL(COMMISSION_PCT, 0)
              FROM   EMPLOYEES E2
                     , DEPARTMENTS D2
              WHERE  D2.LOCATION_ID = 1700
              AND    D2.DEPARTMENT_ID = E2.DEPARTMENT_ID
              AND    E.EMPLOYEE_ID != E2.EMPLOYEE_ID
             )
        
;

--43. LAST_NAME 이 'Kochhar' 인 사원과 동일한 연봉 및 커미션을 버는 사원들의 LAST_NAME, 부서 번호 및 연봉을 조회한다.
SELECT  LAST_NAME
        , DEPARTMENT_ID
        , SALARY
FROM    EMPLOYEES E
WHERE  (SALARY , NVL(COMMISSION_PCT, 0)) IN (
                                    SELECT SALARY
                                           , NVL(COMMISSION_PCT, 0)
                                    FROM   EMPLOYEES
                                    WHERE  LAST_NAME = 'Kochhar'
                                    AND    E.EMPLOYEE_ID != EMPLOYEE_ID
                                   )                              
;

--44. 직업 ID 가 SA_MAN 인 사원들의 최대 연봉 보다 높게 받는 사원들의 LAST_NAME, JOB_ID 및 연봉을 조회한다.
SELECT  LAST_NAME
        , JOB.JOB_ID
        , SALARY
FROM    EMPLOYEES E
        , JOBS    JOB
WHERE   E.JOB_ID = JOB.JOB_ID
AND     E.SALARY > (
                    SELECT  MAX(E2.SALARY)
                    FROM    EMPLOYEES E2
                            , JOBS JOB2
                    WHERE   JOB2.JOB_ID = 'SA_MAN'       
                    AND     E2.JOB_ID = JOB2.JOB_ID
                    )
;

--45. 도시 이름이 T 로 시작하는 지역에 사는 사원들의 사번, LAST_NAME 및 부서 번호를 조회한다.
SELECT  EMPLOYEE_ID
        , LAST_NAME
        , D2.DEPARTMENT_ID
FROM    EMPLOYEES E
        , DEPARTMENTS D2
WHERE   D2.DEPARTMENT_ID IN (
                            SELECT  D.DEPARTMENT_ID
                            FROM    DEPARTMENTS D
                                    , EMPLOYEES   E2
                            WHERE   D.LOCATION_ID IN (
                                                      SELECT  D3.LOCATION_ID
                                                      FROM    LOCATIONS L
                                                              , DEPARTMENTS D3
                                                      WHERE   L.CITY LIKE 'T%'
                                                      AND     D3.LOCATION_ID = L.LOCATION_ID
                                                     )
                            AND     D.DEPARTMENT_ID = E2.DEPARTMENT_ID
                            )
AND     D2.DEPARTMENT_ID = E.DEPARTMENT_ID                            
;

SELECT  EMPLOYEE_ID
        , LAST_NAME
        , D.DEPARTMENT_ID
        , CITY
FROM    EMPLOYEES E
        , DEPARTMENTS D
        , LOCATIONS L
WHERE   CITY LIKE 'T%'
AND     D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND     L.LOCATION_ID = D.LOCATION_ID
;


--46. 각 부서별 평균 연봉보다 더 받는 동일부서 근무사원들의 
-- LAST_NAME, 연봉, 부서번호 및 해당 부서의 평균 연봉을 조회한다.
-- 결과는 부서별 연봉을 기준으로 정렬한다.
SELECT      LAST_NAME
            , E.SALARY
            , E.DEPARTMENT_ID
            , AVG_SALARY.DPT_AVG
FROM        EMPLOYEES E
            , (
                SELECT  DEPARTMENT_ID
                        , ROUND(AVG(SALARY)) DPT_AVG
                FROM    EMPLOYEES
                GROUP   BY DEPARTMENT_ID
              ) AVG_SALARY
WHERE       E.DEPARTMENT_ID = AVG_SALARY.DEPARTMENT_ID
AND         E.SALARY > AVG_SALARY.DPT_AVG
ORDER       BY AVG_SALARY.DPT_AVG DESC
;

--47. NOT EXISTS 연산자를 사용하여 매니저가 아닌 사원 이름을 조회한다.
SELECT  DISTINCT FIRST_NAME
        ,LAST_NAME
FROM    EMPLOYEES E
WHERE   NOT EXISTS (
                    SELECT 'X'
                    FROM    EMPLOYEES M
                    WHERE   E.EMPLOYEE_ID = M.MANAGER_ID
                   -- AND     E.FIRST_NAME = E1.FIRST_NAME
                    )
;


--48. 소속부서의 평균 연봉보다 적게 버는 사원들의 last_name 을 조회한다.
SELECT      LAST_NAME
FROM        EMPLOYEES E
WHERE       AVG(SALARY)
GROUP       BY 
---------------------
SELECT      LAST_NAME 
FROM        EMPLOYEES E
            , (
                SELECT  DEPARTMENT_ID
                        , ROUND(AVG(SALARY)) DPT_AVG
                FROM    EMPLOYEES
                GROUP   BY DEPARTMENT_ID
              ) AVG_SALARY  
WHERE       SALARY < AVG_SALARY.DPT_AVG              
AND         E.DEPARTMENT_ID = AVG_SALARY.DEPARTMENT_ID
;




--49.  각 사원 별 소속부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 
--     사원/ 
-- 이 존재하는 모든 사원들의 last_name 을 조회한다.
SELECT      DISTINCT E1.LAST_NAME
FROM        EMPLOYEES E1
            , EMPLOYEES E2
WHERE       E1.HIRE_DATE < E2.HIRE_DATE
AND         E1.DEPARTMENT_ID IN E2.DEPARTMENT_ID
AND         E1.SALARY < E2.SALARY
;

-------------
SELECT      DISTINCT LAST_NAME
FROM        EMPLOYEES EMP1
WHERE       DEPARTMENT_ID IN (
                                    SELECT      DISTINCT EMP1.DEPARTMENT_ID
                                    FROM        EMPLOYEES EMP1
                                                , (
                                                    SELECT  EMPLOYEE_ID
                                                            , DEPARTMENT_ID
                                                            , HIRE_DATE
                                                            , SALARY
                                                    FROM    EMPLOYEES
                                                ) EMP2
                                    WHERE       EMP1.HIRE_DATE < EMP2.HIRE_DATE
                                    AND         EMP1.DEPARTMENT_ID IN EMP2.DEPARTMENT_ID
                                    AND         EMP1.EMPLOYEE_ID NOT IN EMP2.EMPLOYEE_ID
                                    AND         EMP1.SALARY < EMP2.SALARY
                             )
;                   
------------------------------------------------------------------
-----들어가는 DPT_ID---------------
SELECT      DISTINCT EMP1.DEPARTMENT_ID
FROM        EMPLOYEES EMP1
            , (
                SELECT  EMPLOYEE_ID
                        , DEPARTMENT_ID
                        , HIRE_DATE
                        , SALARY
                FROM    EMPLOYEES
            ) EMP2
WHERE       EMP1.HIRE_DATE < EMP2.HIRE_DATE
AND         EMP1.DEPARTMENT_ID IN EMP2.DEPARTMENT_ID
AND         EMP1.EMPLOYEE_ID NOT IN EMP2.EMPLOYEE_ID
AND         EMP1.SALARY < EMP2.SALARY
;






