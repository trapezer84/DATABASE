-- Employees 테이블에서 LAST_NAME과 SALARY를 받아온다 -- 
SELECT  LAST_NAME
        , SALARY
  FROM EMPLOYEES
;

-- Employees 테이블에서 LAST_NAME과 EMPLOYEE_ID 그리고 SALARY를 받아온다 -- 
SELECT LAST_NAME
      , EMPLOYEE_ID
      , HIRE_DATE
FROM EMPLOYEES
;

-- 사원들의 LAST_NAME, 연봉 및 커미션을 조화 --
SELECT LAST_NAME
      , SALARY
      , COMMISSION_PCT
FROM EMPLOYEES
;

-- 사원들의 EMPLOYESS_ID, FIRST_NAME, LAST_NAME, 연봉 및 커미션을 조회 --
SELECT EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , SALARY
      , COMMISSION_PCT
FROM EMPLOYEES
;

-- DEPARTMENT 알아보기 --
SELECT *
FROM DEPARTMENTS
;

-- DEPARTMENT의 TABLE에서 DEPARTMENT_ID 와 DEPARTMENT_NAME 출력 --
SELECT DEPARTMENT_ID
      , DEPARTMENT_NAME
FROM DEPARTMENTS
;

SELECT EMPLOYEE_ID 
      , DEPARTMENT_ID
      , DEPARTMENT_NAME
FROM EMPLOYEES
    , DEPARTMENTS
;

SELECT LAST_NAME
      , SALARY 
FROM EMPLOYEES
WHERE SALARY >= 12000
;

-- 다 똑같지만 NOT 과 ! 다르다 --
SELECT LAST_NAME
      , SALARY 
FROM EMPLOYEES
WHERE NOT(SALARY >= 12000)
;

-- 사원 번호가 176번인 사람을 출력하라 -- 
SELECT LAST_NAME
      , DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176
;

-- 부서 번호가 30보다 작은 부서에서 일하는 
-- 사원들의 사번과 성과 이름을 조회
SELECT EMPLOYEE_ID 
      , LAST_NAME 
FROM EMPLOYEES
WHERE DEPARTMENT_ID < 30
;

-- 부서 번호가 30보다 작은 부서에서 일하는 
-- 사원들의 사번과 성과 이름을 조회 중에서 사번이 200번인 사람만 조회
SELECT EMPLOYEE_ID 
      , LAST_NAME 
FROM EMPLOYEES
WHERE DEPARTMENT_ID < 30
      AND EMPLOYEE_ID = 200
;

-- 부서 번호가 30보다 작은 부서에서 일하는 
-- 사원들의 사번과 성과 이름을 조회 중에서 연봉이 5000 이상인 사원만 조회
SELECT EMPLOYEE_ID 
      , LAST_NAME 
      , FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID < 30
      AND SALARY > 5000
;

-- 연봉이 5000~12000 이외의 사원들의 LAST_NAME 을 조회
SELECT LAST_NAME
      , SALARY
FROM EMPLOYEES
WHERE SALARY < 5000
OR    12000 < SALARY 
;

-- 20번 및 50번 부서에서 근무하는 모든 사원들의 LAST_NAME 및 부서번호를 조회 
SELECT LAST_NAME
      , DEPARTMENT_ID
FROM  EMPLOYEES
WHERE DEPARTMENT_ID = 20
OR    DEPARTMENT_ID = 50
;

-- 20번 및 50번 부서에서 근무하는 모든 사원들의 LAST_NAME 및 부서번호를 조회 
SELECT LAST_NAME
      , DEPARTMENT_ID
FROM  EMPLOYEES
WHERE DEPARTMENT_ID IN ( 20, 50)
;

-- 샐러리 기준으로 오름차순 시키기 
SELECT  LAST_NAME
        , SALARY 
FROM    EMPLOYEES
WHERE   SALARY >= 12000
ORDER   BY SALARY ASC 
;

-- 샐러리 기준으로 내림차순 시키기 
SELECT  LAST_NAME
        , SALARY 
FROM    EMPLOYEES
WHERE   SALARY >= 12000
ORDER   BY SALARY DESC 
;

-- 2차 정렬 하기 
SELECT  LAST_NAME
        , SALARY 
FROM    EMPLOYEES
WHERE   SALARY >= 12000
ORDER   BY SALARY ASC
        , LAST_NAME DESC
;

-- 20번 및 50번 부서에서 근무하는 모든 사원들의 
-- LAST_NAME 및 부서 번호를 알파벳 순으로 조회한다 
SELECT  LAST_NAME
        , DEPARTMENT_ID 
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = 20
OR      DEPARTMENT_ID = 50
ORDER   BY LAST_NAME ASC
;

-- 과제 시작 -- 

-- [1] 연봉이 12000 이상되는 직원들의 LAST_NAME 및 연봉을 조회한다.
SELECT  LAST_NAME
        , SALARY
FROM EMPLOYEES
WHERE SALARY > 12000
;

-- [2] 사원번호가 176 인 사람의 LAST_NAME 과 부서 번호를 조회한다.
SELECT    LAST_NAME
          , DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176
;

-- [3] 연봉이 5000 에서 12000의 범위 이외인 사람들의 
--    LAST_NAME 및 연봉을 조회힌다.
SELECT    LAST_NAME
          , SALARY
FROM      EMPLOYEES
WHERE     SALARY < 5000
OR        SALARY > 12000
;

-- [4] 1998/02/20 일부터 1998/05/01 사이에 고용된 사원들의 LAST_NAME 사번, 고용일자를 조회한다.
-- 고용일자 순으로 정렬한다.
SELECT    LAST_NAME
          , EMPLOYEE_ID
          , HIRE_DATE
FROM      EMPLOYEES
WHERE     HIRE_DATE >= '2002/02/20'
AND       HIRE_DATE <= '2005/05/01'
ORDER     BY HIRE_DATE
;

-- [5]  20 번 및 50 번 부서에서 근무하는 모든 사원들의 
--    LAST_NAME 및 부서 번호를 알파벳순으로 조회한다.
SELECT    LAST_NAME
          , DEPARTMENT_ID
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID = 20
OR        DEPARTMENT_ID = 50
ORDER     BY LAST_NAME ASC
;

-- [5]  20 번 및 50 번 부서에서 근무하는 모든 사원들의 
--    LAST_NAME 및 부서 번호를 알파벳순으로 조회한다.
SELECT    LAST_NAME
          , DEPARTMENT_ID
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID IN ( 20, 50 )
ORDER     BY LAST_NAME ASC
;

-- [6] 20 번 및 50 번 부서에 근무하며, 연봉이 5000 ~ 12,000 사이인 사원들의 LAST_NAME 및 연봉을 조회한다.
SELECT    LAST_NAME
          , SALARY
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID IN ( 20, 50 )
AND       SALARY > 5000
AND       SALARY < 12000
;

-- [7] 1994년도에 고용된 모든 사람들의 LAST_NAME 및 고용일을 조회한다.
SELECT      LAST_NAME
            , HIRE_DATE
FROM        EMPLOYEES
WHERE       HIRE_DATE LIKE '94/%M/%D'
;

-- [8] 매니저가 없는 사람들의 LAST_NAME 및 JOB_ID 를 조회한다.
SELECT      LAST_NAME
            , JOB_ID
FROM        EMPLOYEES
WHERE       MANAGER_ID IS NULL
OR          MANAGER_ID = ''
;

-- [9] 커미션을 버는 모든 사원들의 LAST_ANME, 연봉 및 커미션을 조회한다.
-- 연봉 역순, 커미션 역순차로 정렬한다.
SELECT    LAST_NAME
          , SALARY  
          , COMMISSION_PCT
FROM      EMPLOYEES
WHERE     COMMISSION_PCT IS NOT NULL
OR        COMMISSION_PCT != ''
;

-- [10] LAST_NAME 의 네번째 글자가 a 인 사원들의 LAST_NAME 을 조회한다.
SELECT    LAST_NAME
FROM      EMPLOYEES
WHERE     LAST_NAME LIKE '___a%'
;

-- [11] LAST_NAME 에 a 및 e 글자가 있는 사원들의 LAST_NAME 을 조회힌다.
SELECT     LAST_NAME
FROM       EMPLOYEES
WHERE      LAST_NAME LIKE '%a%'
OR         LAST_NAME LIKE '%E%'
;


-- [12] 연봉이 2,500, 3,500, 7000 이 아니며 직업이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
SELECT      LAST_NAME
            , JOB_ID
            , SALARY
FROM        EMPLOYEES
WHERE       NOT (SALARY = 2500)
AND         NOT (SALARY = 3500)
AND         NOT (SALARY = 7000)
AND         ( JOB_ID = 'SA_REP' OR JOB_ID = 'ST_CLERK' )
;

-- [13] 직업이 AD_PRESS 인 사람은 A 등급을, 
--  ST_MAN 인 사람은 B 등급을,
--  IT_PROG 인 사람은 C 등급을,
--  SA_REP 인 사람은 D 등급을,
--  ST_CLEAK 인 사람은 E 등급을 
--  기타는 0 을 부여하여 조회한다.
SELECT      LAST_NAME
            , JOB_ID
FROM        EMPLOYEES

;

CREATE TABLE RATE (
      JOB_ID      CHAR(7)     NOT NULL 
      JOB_RATE    CHAR(3)     NOT NULL
);

CREATE TABLE TEST1 
    AS SELECT DISTINCT JOB_ID  
    FROM EMPLOYEES
;

SELECT *
FROM TEST
;


-- [14] 모든 사원들의 LAST_NAME, 부서 번호 및 부서 이름을 조회한다.
SELECT      EMPLOYEES.LAST_NAME
            , EMPLOYEES.DEPARTMENT_ID
            , DEPARTMENTS.DEPARTMENT_NAME
FROM        EMPLOYEES
INNER JOIN  DEPARTMENTS 
ON          EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
;

-- [15] 부서번호 30 내의 모든 직업들을 유일한 포맷으로 조회한다. 
--     90 부서 또한 포함한다. 

-- [16]  커미션을 버는 모든 사람들의 
-- LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.


----- 수업 -------------

--- 1. 
SELECT    DISTINCT MANAGER_ID
          , DEPARTMENT_ID
FROM      EMPLOYEES
WHERE     MANAGER_ID IS NOT NULL
ORDER     BY MANAGER_ID
          , DEPARTMENT_ID
;


---- 2. 
SELECT    MANAGER_ID 
          , DEPARTMENT_ID
FROM      EMPLOYEES
GROUP     BY DEPARTMENT_ID
          , MANAGER_ID
ORDER     BY MANAGER_ID
          , DEPARTMENT_ID
;

-- 3.
-- 부서별 사원수를 구한다 
SELECT    DEPARTMENT_ID 
          , COUNT(EMPLOYEE_ID)
FROM      EMPLOYEES
GROUP     BY DEPARTMENT_ID
ORDER     BY DEPARTMENT_ID
;

-- 4. GROUP BY 를 SELECT 컬럼과 맞춰주지 않으면 오류가 생긴다. 
SELECT    DEPARTMENT_ID 
          , COUNT(EMPLOYEE_ID)
FROM      EMPLOYEES
GROUP     BY MANAGER_ID
ORDER     BY DEPARTMENT_ID
;

--- 5.
-- 부서장 (MANAGER_ID) 별 부하 직원의 수를 구하시오 
SELECT    MANAGER_ID 
          , COUNT (EMPLOYEE_ID)
FROM      EMPLOYEES
GROUP     BY MANAGER_ID
;

 -- 6. 
 -- 전체 사원 중 가장 높은 연봉와 가장 낮은 연봉 
 -- 그리고 전체 연봉의 합, 전체 연봉의 평균을 구하시오 
 SELECT     MAX(SALARY)   AS HIGH_SALARY
            , MIN(SALARY) AS LOW_SALARY
            , SUM(SALARY) AS SUM_SALARY
            , ROUND(AVG(SALARY)) AS AVG_SALARY
 FROM       EMPLOYEES
 ;

-- 7.
-- 부서별 가장 높은 연봉, 가장 낮은 연봉
-- 전체 연봉의 합, 전체 연봉의 평균을 구하시오 
SELECT      DEPARTMENT_ID
            , MAX(SALARY)   AS HIGH_SALARY
            , MIN(SALARY) AS LOW_SALARY
            , SUM(SALARY) AS SUM_SALARY
            , ROUND(AVG(SALARY)) AS AVG_SALARY
 FROM       EMPLOYEES
 GROUP      BY DEPARTMENT_ID
 ;
            

-- 8.
-- 아래의 함수는 NULL 이라면 0으로 표시해라는 의미 
SELECT      NVL ( DEPARTMENT_ID, 0) 
            , MAX(SALARY)   AS HIGH_SALARY
            , MIN(SALARY)   AS LOW_SALARY
            , SUM(SALARY)   AS SUM_SALARY
            , ROUND(AVG(SALARY)) AS AVG_SALARY
 FROM       EMPLOYEES
 GROUP      BY DEPARTMENT_ID
;

-- 9.
-- ~ 이상, ~ 이하 출력하기 GROUP BY 의 조건들은 HAVING으로 사용한다. 
SELECT      NVL ( DEPARTMENT_ID, 0) 
            , MAX(SALARY)   AS HIGH_SALARY
            , MIN(SALARY)   AS LOW_SALARY
            , SUM(SALARY)   AS SUM_SALARY
            , ROUND(AVG(SALARY)) AS AVG_SALARY
 FROM       EMPLOYEES
 GROUP      BY DEPARTMENT_ID
 HAVING     AVG(SALARY) >= 5000
;

-- INSERT INTO TEST
SELECT *
FROM TEST
;

INSERT INTO TEST (JOB_ID)
VALUES ('LEINA')
;

-- 10.
-- 전체 사원 중에서 연봉을 가장 적게 받는 사람 
-- 서브 쿼리 
SELECT      MIN(SALARY) 
FROM        EMPLOYEES
;

SELECT      *
FROM        EMPLOYEES
WHERE       SALARY = (
                        SELECT    MIN (SALARY)
                        FROM      EMPLOYEES
                     )
;

SELECT      *
FROM        EMPLOYEES
WHERE       SALARY = (
                        SELECT    MAX (SALARY)
                        FROM      EMPLOYEES
                     )
;
            
            
SELECT      *
FROM        EMPLOYEES
WHERE       SALARY > (
                        SELECT    AVG(SALARY)
                        FROM      EMPLOYEES
                     )
;         
-- 위의 2개의 쿼리가 하나의 쿼리에 들어간다. 
-- 괄호로 감싸서 들어간다. 

SELECT      *
FROM        EMPLOYEES
WHERE       SALARY > (
                        SELECT    AVG(SALARY) - 500
                        FROM      EMPLOYEES
                     )
AND         SALARY < (
                        SELECT    AVG(SALARY) + 500
                        FROM      EMPLOYEES
                     )
;    



-- 11. 부서별 최고 연봉 
SELECT      DEPARTMENT_ID
            , MAX(SALARY)
FROM        EMPLOYEES 
GROUP       BY DEPARTMENT_ID
;


SELECT      *
FROM        EMPLOYEES
WHERE       (DEPARTMENT_ID, SALARY) IN (
                                        SELECT      DEPARTMENT_ID
                                        , MAX(SALARY)
                                        FROM        EMPLOYEES 
                                        GROUP       BY DEPARTMENT_ID
                                       )

;

-- 12.
-- NVL  ( NULL 비교하기 )
SELECT      *
FROM        EMPLOYEES
WHERE       ( NVL (DEPARTMENT_ID, 0), SALARY) IN (
                                        SELECT      DEPARTMENT_ID
                                        , MAX(SALARY)
                                        FROM        EMPLOYEES 
                                        GROUP       BY DEPARTMENT_ID
                                       )
;


-- 13.
-- 

SELECT      EMPLOYEE_ID
            , HIRE_DATE
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID IN (
                                SELECT    DEPARTMENT_ID
                                FROM      EMPLOYEES
                                WHERE     LAST_NAME = 'Zlotkey'   
                             ) 
AND         LAST_NAME != 'Zlotkey'
;



-- 14. 
-- 이중 서브쿼리 시도해보기 
-- 회사 전체 평균 연봉 보다 더 버는 사원들 중 LAST_NAME 에 U가 있는 사원들이 
-- 근무하는 부서에서 근무하는 사원들의 사번, LAST_NAME 및 연봉을 조회한다. 
SELECT      EMPLOYEE_ID
            , LAST_NAME
            , SALARY
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID IN (
                                SELECT      DEPARTMENT_ID
                                FROM        EMPLOYEES
                                WHERE       LAST_NAME LIKE '%u%'
                                AND         SALARY > (
                                                         SELECT   AVG(SALARY)
                                                         FROM     EMPLOYEES   
                                                      ) 
  
                             )
ORDER       BY SALARY
;

SELECT      DEPARTMENT_ID
FROM        EMPLOYEES
WHERE       LAST_NAME LIKE '%u%'
AND         SALARY > (
                        SELECT      AVG(SALARY)
                        FROM        EMPLOYEES   
                     ) 
;

