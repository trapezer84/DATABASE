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