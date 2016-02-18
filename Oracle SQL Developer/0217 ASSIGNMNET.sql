-- 14. ��� ������� LAST_NAME, �μ� ��ȣ �� �μ� �̸��� ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , D.DEPARTMENT_ID
            , DEPARTMENT_NAME
FROM        EMPLOYEES E 
            , DEPARTMENTS D
WHERE       D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER       BY D.DEPARTMENT_ID
;

-- 15. �μ���ȣ 30 ���� ��� �������� ������ �������� ��ȸ�Ѵ�. 90 �μ� ���� �����Ѵ�.
SELECT      JOB_TITLE
FROM        JOBS J
            , JOB_HISTORY JH
WHERE       DEPARTMENT_ID IN (30, 90)
-- WHERE    DEPARTMENT_ID = 30 
-- OR       DEPARTMENT_ID = 90
AND         JH.JOB_ID = J.JOB_ID
;
----------------------------------------------------
SELECT      JOB_ID
            , LOCATION_ID
FROM        EMPLOYEES E
            , DEPARTMENTS D     
WHERE       DEPARTMENT_ID IN (30, 90)
AND         D.DEPARTMENT_ID = E.DEPARTMENT_ID
;
-- 16. Ŀ�̼��� ���� ��� ������� LAST_NAME, �μ� ��, ���� ID �� ���� ���� ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , DEPARTMENT_NAME
            , L.LOCATION_ID
            , CITY
FROM        EMPLOYEES E
            , LOCATIONS L
            , DEPARTMENTS D
WHERE       D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND         L.LOCATION_ID = D.LOCATION_ID
AND         COMMISSION_PCT IS NOT NULL
AND         COMMISSION_PCT != 0
ORDER       BY CITY
;

-- * 18. �ڽ��� �Ŵ������� ���� ���� ������� LAST_NAME �� ������� ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , HIRE_DATE
FROM        EMPLOYEES E
WHERE       HIRE_DATE < (
                            SELECT    HIRE_DATE
                            FROM      EMPLOYEES
                            WHERE     E.MANAGER_ID = EMPLOYEE_ID
                            AND       ROWNUM = 1
                        )
ORDER       BY HIRE_DATE
;
----------------------------------------
SELECT    EMP.LAST_NAME
          , EMP.HIRE_DATE 
FROM      EMPLOYEES EMP 
          , EMPLOYEES MGR
WHERE     EMP.MANAGER_ID = MGR.EMPLOYEE_ID
AND       EMP.HIRE_DATE < MGR.HIRE_DATE
;

-- 25. �μ� ��, ��ġ ID, �� �μ� �� ��� �� ��, �� �μ� �� ��� ������ ��ȸ�Ѵ�. - ��� ������ �Ҽ��� 2 �ڸ������� ǥ���Ѵ�.
SELECT      DEPARTMENT_NAME
            , D.LOCATION_ID
            , COUNT(EMPLOYEE_ID)
            , ROUND ( AVG(SALARY), 2)
FROM        DEPARTMENTS D
            , LOCATIONS L
            , EMPLOYEES E
WHERE       D.LOCATION_ID = L.LOCATION_ID
AND         E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP       BY DEPARTMENT_NAME
            , D.LOCATION_ID
ORDER       BY  LOCATION_ID
            , COUNT(EMPLOYEE_ID)
;
-- 31. ��ġ ID �� 1700 �� �μ����� �ٹ��ϴ� ������� LAST_NAME, �μ� ��ȣ �� JOB_ID �� ��ȸ�Ѵ�.
-- 18�� 
SELECT    LAST_NAME
          , D.DEPARTMENT_ID
          , JOB_ID
FROM      EMPLOYEES E
          , DEPARTMENTS D
WHERE     D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND       LOCATION_ID = 1700 
;

-- 33. Executive �μ��� �ٹ��ϴ� ��� ������� �μ� ��ȣ, LAST_NAME, JOB_ID �� ��ȸ�Ѵ�.
SELECT      D.DEPARTMENT_ID
            , LAST_NAME
            , JOB_ID
FROM        EMPLOYEES E
            , DEPARTMENTS D
WHERE       DEPARTMENT_NAME = 'Executive'
AND         D.DEPARTMENT_ID = E.DEPARTMENT_ID          
;
-- 42. ��ġ ID �� 1700 �� ������� ������ Ŀ�̼��� ������ ������� LAST_NAME, �μ� ��ȣ �� ������ ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , D.DEPARTMENT_ID
            , SALARY
FROM        EMPLOYEES E
            , DEPARTMENTS D
WHERE       SALARY IN (
                        SELECT      SALARY
                        FROM        EMPLOYEES E
                                    , DEPARTMENTS D
                        WHERE       D.DEPARTMENT_ID = E.DEPARTMENT_ID
                        AND         D.LOCATION_ID = 1700 
                     )
AND         NVL (COMMISSION_PCT, 0) IN (
                                          SELECT      NVL (COMMISSION_PCT, 0)
                                          FROM        EMPLOYEES E
                                                      , DEPARTMENTS D
                                          WHERE       D.DEPARTMENT_ID = E.DEPARTMENT_ID
                                          AND         D.LOCATION_ID = 1700                                     
                                       )    
AND         D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND         LOCATION_ID != 1700                                       
ORDER       BY SALARY
            , DEPARTMENT_ID
;
-----------------------------------------------------------------------------------
SELECT      LAST_NAME
            , D.DEPARTMENT_ID
            , SALARY
FROM        EMPLOYEES E 
            , DEPARTMENTS D
WHERE       E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND         ( SALARY, COMMISSION_PCT )
AND         LOCATION_ID = 1700
ORDER       BY SALARY
            , DEPARTMENT_ID

;
-------------------------------------
SELECT  EMP1.LAST_NAME
        , EMP1.DEPARTMENT_ID
        , EMP1.SALARY
FROM    EMPLOYEES EMP1
        , (
              SELECT  DISTINCT EMP.SALARY
                      , EMP.COMMISSION_PCT
              FROM    EMPLOYEES EMP
                      , DEPARTMENTS DEPT
              WHERE   EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
              AND     DEPT.LOCATION_ID = 1700
           ) EMP_1700
WHERE   EMP1.SALARY = EMP_1700.SALARY
AND     NVL(EMP1.COMMISSION_PCT,0) = NVL(EMP_1700.COMMISSION_PCT, 0)
;
            
-- 43. LAST_NAME �� 'Kochhar' �� ����� ������ ���� �� Ŀ�̼��� ���� ������� LAST_NAME, �μ� ��ȣ �� ������ ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , DEPARTMENT_ID 
            , SALARY
FROM        EMPLOYEES
WHERE       SALARY = (
                        SELECT      SALARY
                        FROM        EMPLOYEES
                        WHERE       LAST_NAME = 'Kochhar'                        
                     )
OR          NVL (COMMISSION_PCT, 0) = (
                                        SELECT      COMMISSION_PCT
                                        FROM        EMPLOYEES
                                        WHERE       LAST_NAME = 'Kochhar'                                            
                                      )                                      
;
--------------------------------------------------------
SELECT      LAST_NAME
            , DEPARTMENT_ID 
            , SALARY
FROM        EMPLOYEES
WHERE       (SALARY , NVL (COMMISSION_PCT, 0) ) IN (
                                        SELECT      SALARY 
                                                    , NVL (COMMISSION_PCT, 0)
                                        FROM        EMPLOYEES
                                        WHERE       LAST_NAME = 'Kochhar'                                            
                                      )                                      
;
                 
                                      
-- 44. ���� ID �� SA_MAN �� ������� �ִ� ���� ���� ���� �޴� ������� LAST_NAME, JOB_ID �� ������ ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , JOB_ID
            , SALARY
FROM        EMPLOYEES
WHERE       SALARY > (
                          SELECT      MAX(SALARY)
                          FROM        EMPLOYEES
                          WHERE       JOB_ID = 'SA_MAN'                        
                     )
ORDER       BY SALARY
            , LAST_NAME
;


-- 45. ���� �̸��� T �� �����ϴ� ������ ��� ������� ���, LAST_NAME �� �μ� ��ȣ�� ��ȸ�Ѵ�.
SELECT      EMPLOYEE_ID
            , LAST_NAME
            , D.DEPARTMENT_ID
FROM        EMPLOYEES E 
            , LOCATIONS L
            , DEPARTMENTS D
WHERE       L.LOCATION_ID IN (
                              SELECT      LOCATION_ID
                              FROM        LOCATIONS
                              WHERE       CITY LIKE 'T%'
                           )
AND         D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND         D.LOCATION_ID = L.LOCATION_ID
;

-- 11�� (18�� ������ �ɼ�)