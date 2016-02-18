SELECT  * 
FROM    EMP_DETAILS_VIEW
;

SELECT    *
FROM      (
              SELECT
              e.employee_id,
              e.job_id,
              e.manager_id,
              e.department_id,
              d.location_id,
              l.country_id,
              e.first_name,
              e.last_name,
              e.salary,
              e.commission_pct,
              d.department_name,
              j.job_title,
              l.city,
              l.state_province,
              c.country_name,
              r.region_name
            FROM
              employees e,
              departments d,
              jobs j,
              locations l,
              countries c,
              regions r
            WHERE e.department_id = d.department_id
              AND d.location_id = l.location_id
              AND l.country_id = c.country_id
              AND c.region_id = r.region_id
              AND j.job_id = e.job_id
          )
;        

--  30. LAST_NAME �� u �� ���ԵǴ� ������ ���� �μ��� �ٹ��ϴ� ������� ��� �� LAST_NAME �� ��ȸ�Ѵ�.
-- LAST_NAME�� u�� ���ԵǴ� ����鸸 �������� �ؼ� ���̺�(��)�� �����. 
SELECT    DISTINCT EMPLOYEE_ID
          , LAST_NAME
FROM      (
            SELECT  DEPARTMENT_ID 
            FROM    EMPLOYEES
            WHERE   LAST_NAME LIKE '%u%'
          ) U_NAME
          , EMPLOYEES E
WHERE     U_NAME.DEPARTMENT_ID = E.DEPARTMENT_ID
;
-------------------------------------------------
SELECT    E.EMPLOYEE_ID
          , LAST_NAME
FROM      (
            SELECT  EMPLOYEE_ID 
            FROM    EMPLOYEES
            WHERE   LAST_NAME LIKE '%u%'
          ) U_NAME
          , EMPLOYEES E
WHERE     U_NAME.EMPLOYEE_ID = E.EMPLOYEE_ID
;
---------------------------------------------------
SELECT    EMPLOYEE_ID
          , LAST_NAME
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID IN (
                              SELECT    DEPARTMENT_ID
                              FROM      EMPLOYEES
                              WHERE     LAST_NAME LIKE '%u%'
                           )
;                           

-- 31. ��ġ ID �� 1700 �� �μ����� �ٹ��ϴ� ������� LAST_NAME, �μ� ��ȣ �� JOB_ID �� ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , DEPARTMENT_ID
            , JOB_ID
FROM        (
              SELECT  EMPLOYEE_ID
              FROM    EMPLOYEES E
                      , DEPARTMENTS D
              WHERE   E.DEPARTMENT_ID = D.DEPARTMENT_ID
              AND     D.LOCATION_ID = '1700'
            ) EMP1700
            , EMPLOYEES E
WHERE       EMP1700.EMPLOYEE_ID = E.EMPLOYEE_ID
;            
            
-- 34. ȸ�� ��ü ��� ���� ���� �� ���� ����� �� LAST_NAME �� u �� �ִ� �������
-- �ٹ��ϴ� �μ����� �ٹ��ϴ� ������� ���, LAST_NAME �� ������ ��ȸ�Ѵ�.
SELECT        E.EMPLOYEE_ID
              , LAST_NAME
              , SALARY
FROM          (
                 SELECT     EMPLOYEE_ID
                 FROM       EMPLOYEES
                 WHERE      SALARY > (
                                        SELECT  AVG(SALARY)
                                        FROM    EMPLOYEES
                                     )                    
              ) EMP2
              , EMPLOYEES E
WHERE         EMP2.EMPLOYEE_ID =  E.EMPLOYEE_ID
AND           E.LAST_NAME LIKE '%u%'
;
------------------------------------------------------
SELECT        DISTINCT EMPLOYEE_ID
              , LAST_NAME
              , SALARY
FROM          (
                  /* LAST_NAME�� u�� ���� ��� VIEW */
                  SELECT        DEPARTMENT_ID
                  FROM          (
                                   /* ȸ�� ��ü ��� �������� �� ���� ���� ��� VIEW */
                                   SELECT     EMPLOYEE_ID
                                   FROM       EMPLOYEES
                                   WHERE      SALARY > (
                                                          SELECT  AVG(SALARY)
                                                          FROM    EMPLOYEES
                                                       )                    
                                ) EMP2
                                , EMPLOYEES E
                  WHERE         EMP2.EMPLOYEE_ID =  E.EMPLOYEE_ID
                  AND           E.LAST_NAME LIKE '%u%'
              ) DEPT
              , EMPLOYEES E
WHERE         DEPT.DEPARTMENT_ID = E.DEPARTMENT_ID       
ORDER         BY LAST_NAME
;
 
-- 42. ��ġ ID �� 1700 �� ������� ������ Ŀ�̼��� ������ ������� 
-- LAST_NAME, �μ� ��ȣ �� ������ ��ȸ�Ѵ�.
 SELECT     DISTINCT LAST_NAME
            , E.DEPARTMENT_ID
            , E.SALARY
FROM        (
                SELECT    SALARY
                          , NVL (COMMISSION_PCT, 0) COMMISSION_PCT
                FROM      EMPLOYEES EMP 
                          , DEPARTMENTS D
                WHERE     LOCATION_ID = '1700'
                AND       D.DEPARTMENT_ID = EMP.DEPARTMENT_ID
            ) EMP2
            , EMPLOYEES E
WHERE       E.SALARY = EMP2.SALARY
AND         EMP2.COMMISSION_PCT = NVL( E.COMMISSION_PCT, 0)
;
---- 35.ST_CLERK �� ���� ID �� ���� ����� ���� �μ� ID �� ��ȸ�Ѵ�.
-- NULL ���� �����Ѵ�. (NOT EXISTS ���)
SELECT      DISTINCT DEPARTMENT_ID
FROM        EMPLOYEES E
/*  ���� �ڷᰡ ���ٸ� ����ض�. ��� �ǹ� */
WHERE       NOT EXISTS (
                        /* ST_CLERK �� ������ ���� ������� 1�� ����Ѵ�. �׸��� �� ������� DEPARTMENT_ID �� �� ���� ���� */
                        SELECT      '1' /* ������ 1�� RETURN �϶�� �ǹ� */
                        FROM        EMPLOYEES E1
                        WHERE       JOB_ID = 'ST_CLERK'                        
                        AND         E1.DEPARTMENT_ID = E.DEPARTMENT_ID
                   )
AND         DEPARTMENT_ID IS NOT NULL                   
ORDER       BY DEPARTMENT_ID                   
;

SELECT      '1'
FROM        EMPLOYEES
WHERE       JOB_ID = 'ST_CLERK'
AND         DEPARTMENT_ID = 60
;

---- 36. ��ġ�� �μ��� ���� ���� ID �� ���� �̸��� ��ȸ����.(NOT EXISTS ���)
SELECT      DISTINCT COUNTRY_ID
            , COUNTRY_NAME
FROM        COUNTRIES C
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        LOCATIONS L
                            WHERE       L.COUNTRY_ID = C.COUNTRY_ID    
                       )                   
;            

----------------------------------------
SELECT      DISTINCT COUNTRY_ID
            , COUNTRY_NAME
FROM        COUNTRIES C
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        LOCATIONS L
                                        , DEPARTMENTS D
                            WHERE       L.COUNTRY_ID = C.COUNTRY_ID    
                            AND         D.LOCATION_ID = L.LOCATION_ID 
                       )                   
;  
-----------------------------------------
---- 35.ST_CLERK �� ���� ID �� ���� ����� ���� �μ� ID �� ��ȸ�Ѵ�.
-- NULL ���� �����Ѵ�. (NOT EXISTS ���)
SELECT      DISTINCT DEPARTMENT_ID 
FROM        EMPLOYEES E
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        EMPLOYEES E1
                            WHERE       JOB_ID = 'ST_CLERK'                            
                            AND         E1.DEPARTMENT_ID = E.DEPARTMENT_ID
                       )
AND         DEPARTMENT_ID IS NOT NULL                       
ORDER       BY DEPARTMENT_ID 
;

SELECT      '1'
FROM        EMPLOYEES E1
WHERE       JOB_ID = 'ST_CLERK'
;


---- 36. ��ġ�� �μ��� ���� ���� ID �� ���� �̸��� ��ȸ����.(NOT EXISTS ���)
SELECT      COUNTRY_ID
            , COUNTRY_NAME
FROM        COUNTRIES C 
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        DEPARTMENTS D
                                        , LOCATIONS L
                            WHERE       D.LOCATION_ID = L.LOCATION_ID     
                            AND         L.COUNTRY_ID = C.COUNTRY_ID
                       )
;

SELECT      '1'
FROM        DEPARTMENTS D
            , LOCATIONS L
WHERE       D.LOCATION_ID = L.LOCATION_ID            
;
 
-- 47. NOT EXISTS �����ڸ� ����Ͽ� �Ŵ����� �ƴ� ��� �̸��� ��ȸ�Ѵ�. 
SELECT      FIRST_NAME
FROM        EMPLOYEES E
WHERE       NOT EXISTS (
                            SELECT      '1'
                            FROM        EMPLOYEES EMP
                            WHERE       EMP.MANAGER_ID = E.EMPLOYEE_ID                            
                       )
;


 
-- 46. �� �μ��� ��� �������� �� �޴� ���Ϻμ� �ٹ�������� 
-- LAST_NAME, ����, �μ���ȣ �� �ش� �μ��� ��� ������ ��ȸ�Ѵ�.
-- ����� �μ��� ������ �������� �����Ѵ�.


 
--  13. ������ AD_PRESS �� ����� A �����, 
-- ST_MAN �� ����� B �����,
-- IT_PROG �� ����� C �����,
-- SA_REP �� ����� D �����,
-- ST_CLEAK �� ����� E ����� 
-- ��Ÿ�� 0 �� �ο��Ͽ� ��ȸ�Ѵ�.
SELECT      *
FROM        (
                SELECT          EMPLOYEE_ID
                                , LAST_NAME
                                , FIRST_NAME
                                , DECODE (JOB_ID
                                    , 'AD_PRESS'        , 'A' 
                                    , 'ST_MAN'          , 'B'
                                    , 'IT_PROG'         , 'C'
                                    , 'SA_REP'          , 'D'
                                    , 'ST_CLERK'        , 'E'
                                    , '0') JOB_GRADE
                FROM        EMPLOYEES
            )
WHERE       JOB_GRADE = 'B'            
;

 
SELECT      EMPLOYEE_ID
            , FIRST_NAME
            , LAST_NAME
            , CASE
                WHEN    JOB_ID = (SELECT 'AD_PRESS' FROM DUAL)  THEN
                        'A'
                WHEN    JOB_ID = 'ST_NAME'   THEN
                        'B'
                WHEN    JOB_ID = 'IT_PROG'   THEN
                        'C'
                WHEN    JOB_ID = 'SA_REP'    THEN
                        'D'
                WHEN    JOB_ID = 'ST_CLERK'  THEN
                        'E'
                ELSE    '0'
            END
FROM        EMPLOYEES
;
 
----------------------------------------------
-- DUAL�� ����� �� 
SELECT      COUNT ( (
                    SELECT  EMPLOYEE_ID
                    FROM    EMPLOYEES
                    WHERE   HIRE_DATE LIKE '06%'
                  ) )
FROM        DUAL
;
-------------------------------
SELECT      LPAD('111', 6, '0')
            || LPAD('1', 6, '0')
            || RPAD('111', 6, '0')
            || RPAD('1', 6, '0')
FROM        DUAL
;

SELECT      LPAD('111', 6, '0')
            , LPAD('1', 6, '0')
            , RPAD('111', 6, '0')
            , RPAD('1', 6, '0')
FROM        DUAL
;

SELECT      






 
 