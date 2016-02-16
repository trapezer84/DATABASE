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
WHERE     HIRE_DATE >= '1998/02/20'
AND       HIRE_DATE <= '1998/05/01'
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

-- [6] 20 번 및 50 번 부서에 근무하며, 연봉이 5000 ~ 12,000 사이인 사원들의 LAST_NAME 및 연봉을 조회한다.
SELECT    LAST_NAME
          , SALARY
FROM      EMPLOYEES
WHERE     SALARY > 5000
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
;

-- [9] 커미션을 버는 모든 사원들의 LAST_ANME, 연봉 및 커미션을 조회한다.
-- 연봉 역순, 커미션 역순차로 정렬한다.
SELECT    LAST_NAME
          , SALARY  
          , COMMISSION_PCT
FROM      EMPLOYEES
WHERE     COMMISSION_PCT IS NOT NULL
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


-- [14] 모든 사원들의 LAST_NAME, 부서 번호 및 부서 이름을 조회한다.
SELECT LAST_NAME
, DEPARTMENT_ID
, DEPARTMENT_NAME
FROM EMPLOYEES
    , DEPARTMENTS
;
-- [15] 부서번호 30 내의 모든 직업들을 유일한 포맷으로 조회한다. 
--     90 부서 또한 포함한다.

-- [16]  커미션을 버는 모든 사람들의 
-- LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
