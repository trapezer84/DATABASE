-- ��ü ������� ��� ��ȣ, LAST_NAME, �μ���, �μ� ��ȣ�� ��ȸ�Ѵ�. 
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
WHERE     E.DEPARTMENT_ID = D.DEPARTMENT_ID -- ���� �� 
AND       D.LOCATION_ID = L.LOCATION_ID -- ���� �� 
AND       L.LOCATION_ID = (
                              SELECT LOCATION_ID 
                              FROM   LOCATIONS
                              WHERE  CITY = 'Seattle'
                          )
--AND       L.CITY = 'Seattle'
;
       
-- 25
--�μ���, ��ġ ID, �� �μ� �� ��� �� ��, �� �μ� �� ��� ������ ��ȸ �Ѵ� 
-- ��� ������ 2�ڸ� �� ���� 
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

-- 27�� ������ ���� �������� �� �μ� �� �� ���� �� ���� �� �� �� �� �μ��� ���� �� ���� ��ȸ�Ѵ�.
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







