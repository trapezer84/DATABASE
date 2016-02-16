
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
