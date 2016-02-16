-- 10. LAST_NAME �� �׹�° ���ڰ� a �� ������� LAST_NAME �� ��ȸ�Ѵ�.
SELECT      LAST_NAME
FROM        EMPLOYEES
WHERE       LAST_NAME LIKE '___a%'
;

-- 11. LAST_NAME �� a �� e ���ڰ� �ִ� ������� LAST_NAME �� ��ȸ�Ѵ�.
SELECT      LAST_NAME
FROM        EMPLOYEES
WHERE       LAST_NAME LIKE '%a%'
OR          LAST_NAME LIKE '%e%'
;

-- 17. LAST_NAME �� Davies �� ������� �Ŀ� ���� ������� LAST_NAME �� HIRE_DATE �� ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , HIRE_DATE
FROM        EMPLOYEES
WHERE       HIRE_DATE > (
                            SELECT      HIRE_DATE
                            FROM        EMPLOYEES
                            WHERE       LAST_NAME = 'Davies'
                        )
;


-- 19. ȸ�� ��ü�� �ִ� ����, �ּ� ����, ���� �� �� �� ��� ������ �ڿ����� �����Ͽ� ��ȸ�Ѵ�.
SELECT      MAX(SALARY)
            , MIN(SALARY)
            , SUM(SALARY)
            , ROUND (AVG(SALARY))
FROM        EMPLOYEES
;

-- 20. �� JOB_ID ��, �ִ� ����, �ּ� ����, ���� �� �� �� ��� ������ �ڿ����� �����Ͽ� ��ȸ�Ѵ�.
SELECT      JOB_ID
            , MAX(SALARY)
            , MIN(SALARY)
            , SUM(SALARY)
            , ROUND (AVG(SALARY))
FROM        EMPLOYEES
GROUP       BY JOB_ID
;

-- 21. ������ ������ ���� ������� �� ���� ��ȸ�Ѵ�.
SELECT      DEPARTMENT_ID
            , COUNT(EMPLOYEE_ID)
FROM        EMPLOYEES
GROUP       BY DEPARTMENT_ID
ORDER       BY DEPARTMENT_ID
;

-- 22. �Ŵ����� �ٹ��ϴ� ������� �� ���� ��ȸ�Ѵ�.
SELECT      COUNT(MANAGER_ID)
FROM        EMPLOYEES
WHERE       MANAGER_ID IS NOT NULL
;

-- 23. �系�� �ִ� ���� �� �ּ� ������ ���̸� ��ȸ�Ѵ�.
SELECT      MAX(SALARY) - MIN(SALARY)
FROM        EMPLOYEES
;

-- 26. �� ��� �� �� 2005, 2006, 2007, 2008 �⵵ �� ���� ������� �� ���� ������ ���� ��ȸ�Ѵ�.
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




-- 27. ������ ���� �������� �� �μ� �� �� ���� �� ���� �� �� �� �� �μ��� ���� �� ���� ��ȸ�Ѵ�.
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

-- 28. LAST_NAME �� Zlotkey �� ������ �μ��� �ٹ��ϴ� ��� ������� ��� �� ��볯¥�� ��ȸ�Ѵ�.
SELECT      EMPLOYEE_ID
            , HIRE_DATE
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID IN (
                              SELECT      DEPARTMENT_ID
                              FROM        EMPLOYEES
                              WHERE       LAST_NAME = 'Zlotkey'
                              )
;

-- 29. ȸ�� ��ü ��� �������� �� �޴� ������� ��� �� LAST_NAME �� ��ȸ�Ѵ�.
SELECT    EMPLOYEE_ID
          , LAST_NAME
FROM      EMPLOYEES
WHERE     SALARY > (
                    SELECT    AVG(SALARY)
                    FROM      EMPLOYEES
                    )
;

-- 30. LAST_NAME �� u �� ���ԵǴ� ������ ���� �μ��� �ٹ��ϴ� ������� ��� �� LAST_NAME �� ��ȸ�Ѵ�.
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


-- 32. King �� �Ŵ����� �ΰ� �ִ� ��� ������� LAST_NAME �� ������ ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , SALARY
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID IN (
                              SELECT  DEPARTMENT_ID
                              FROM    EMPLOYEES
                              WHERE   LAST_NAME = 'King'
                              )
;

-- 34. ȸ�� ��ü ��� ���� ���� �� ���� ����� �� LAST_NAME �� u �� �ִ� ������� �ٹ��ϴ� �μ����� �ٹ��ϴ� ������� ���, LAST_NAME �� ������ ��ȸ�Ѵ�.
SELECT      EMPLOYEE_ID
            , LAST_NAME
FROM        EMPLOYEES
WHERE       SALARY > (
                      SELECT  AVG(SALARY)
                      FROM    EMPLOYEES
                      )
AND         LAST_NAME LIKE '%u%'
;

