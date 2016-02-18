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

--14 ��� ������� LAST_NAME, �μ� ��ȣ �� �μ� �̸��� ��ȸ�Ѵ�.
SELECT LAST_NAME
       , DEPARTMENT_ID
       , DEPARTMENT_NAME
FROM   EMPLOYEES
;

--15 �μ���ȣ 30 ���� ��� �������� ������ �������� ��ȸ�Ѵ�. 
--   90 �μ� ���� �����Ѵ�.
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

--16. Ŀ�̼��� ���� ��� ������� LAST_NAME, �μ� ��, ���� ID �� ���� ���� ��ȸ�Ѵ�.
SELECT  LAST_NAME
        , DEPARTMENT_NAME
        , L.LOCATION_ID
        , CITY
FROM    EMPLOYEES E
        , DEPARTMENTS D
        , LOCATIONS L
WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID -- ������
AND    D.LOCATION_ID = L.LOCATION_ID -- ������
AND    E.COMMISSION_PCT IS NOT NULL
AND    E.COMMISSION_PCT != 0
;

--17. LAST_NAME �� DAVIES �� ������� �Ŀ� ���� ������� LAST_NAME �� HIRE_DATE �� ��ȸ�Ѵ�.
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

--* 18. �ڽ��� �Ŵ������� ���� ���� ������� LAST_NAME �� ������� ��ȸ�Ѵ�.
-- �ڱ��ڽ� ������ WHERE ������ �߿���.
SELECT  EMP.EMPLOYEE_ID
        ,EMP.LAST_NAME
        , EMP.HIRE_DATE
        , MGR.EMPLOYEE_ID
        , MGR.HIRE_DATE
FROM    EMPLOYEES EMP
        , EMPLOYEES MGR
        --������� �Ŵ��� ���̵� �Ŵ����� EMPLOYEE_ID�� ������
WHERE   EMP.MANAGER_ID = MGR.EMPLOYEE_ID
AND     EMP.HIRE_DATE < MGR.HIRE_DATE
;

-- 19. ȸ�� ��ü�� �ִ� ����, �ּ� ����, ���� �� �� �� ��� ������ �ڿ����� �����Ͽ� ��ȸ�Ѵ�.
SELECT  MAX(SALARY)
       , MIN(SALARY)
       , SUM(SALARY)
       , ROUND(AVG(SALARY))
FROM   EMPLOYEES
;

-- 20. �� JOB_ID ��, �ִ� ����, �ּ� ����, ���� �� �� �� ��� ������ �ڿ����� �����Ͽ� ��ȸ�Ѵ�.
SELECT JOB_ID
        , ROUND(MAX(SALARY))
        , ROUND(MIN(SALARY))
        , ROUND(SUM(SALARY))
        , ROUND(AVG(SALARY))
FROM   EMPLOYEES
GROUP  BY JOB_ID
;

-- 21. ������ ������ ���� ������� �� ���� ��ȸ�Ѵ�.
SELECT JOB_ID, COUNT(EMPLOYEE_ID)
FROM   EMPLOYEES
WHERE  EMPLOYEE_ID IS NOT NULL
GROUP  BY JOB_ID
;

-- 22. �Ŵ����� �ٹ��ϴ� ������� �� ���� ��ȸ�Ѵ�.
SELECT COUNT(EMPLOYEE_ID)
FROM   EMPLOYEES
WHERE  EMPLOYEE_ID IN ( 
                      SELECT MANAGER_ID
                      FROM EMPLOYEES
                      WHERE MANAGER_ID IS NOT NULL
                      GROUP BY MANAGER_ID
                      )
;

-- 23. �系�� �ִ� ���� �� �ּ� ������ ���̸� ��ȸ�Ѵ�.
SELECT (MAX(SALARY)-MIN(SALARY))DIFF
FROM   EMPLOYEES
;

--24.  �Ŵ����� ��� �� �� �Ŵ��� �� ����� �� �ּ� ������ �޴� ����� ������ ��ȸ�Ѵ�.
-- �Ŵ����� ���� ������� �����Ѵ�.
-- �ּ� ������ 6000 �̸��� ���� �����Ѵ�.
-- ���� ���� �������� ��ȸ�Ѵ�.
SELECT      MANAGER_ID
            , MIN(SALARY)
FROM        EMPLOYEES
WHERE       MANAGER_ID IS NOT NULL
GROUP       BY MANAGER_ID
HAVING      MIN(SALARY) >= 6000
ORDER       BY MIN(SALARY) DESC
;


--25. �μ� ��, ��ġ ID, �� �μ� �� ��� �� ��, �� �μ� �� ��� ������ ��ȸ�Ѵ�. - ��� ������ �Ҽ��� 2 �ڸ������� ǥ���Ѵ�.
-- COUNT, AVG �����Լ��� ������ SELECT COLUMN�� GROUP BY �� �������.
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

-- 26. �� ��� �� �� 1995, 1996, 1997, 1998 �⵵ �� ���� ������� �� ���� ������ ���� ��ȸ�Ѵ�.
-- ��¥�� �������� 2005% �̷������� ����ߵ�. 05% �̷����ϸ� �ȵɼ��� ����. �����ͺ��̽����� ��¥�� 2005�̷��� ���⶧��
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

-- 27. ������ ���� �������� �� �μ� �� �� ���� �� ���� �� �� �� �� �μ��� ���� �� ���� ��ȸ�Ѵ�.
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

-- 28. LAST_NAME �� Zlotkey �� ������ �μ��� �ٹ��ϴ� ��� ������� ��� �� ��볯¥�� ��ȸ�Ѵ�.
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

-- 29. ȸ�� ��ü ��� �������� �� �޴� ������� ��� �� LAST_NAME �� ��ȸ�Ѵ�.
SELECT EMPLOYEE_ID
       , LAST_NAME
FROM   EMPLOYEES
WHERE  SALARY > (
                 SELECT AVG(SALARY)
                 FROM   EMPLOYEES
                 )
;

-- 30. LAST_NAME �� u �� ���ԵǴ� ������ ���� �μ��� �ٹ��ϴ� ������� ��� �� LAST_NAME �� ��ȸ�Ѵ�.
SELECT EMPLOYEE_ID
       , LAST_NAME
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID IN (
                        SELECT DEPARTMENT_ID
                        FROM   EMPLOYEES
                        WHERE  LAST_NAME LIKE '%u%'
                        )
;                      

--31. ��ġ ID �� 1700 �� �μ����� �ٹ��ϴ� ������� LAST_NAME, �μ� ��ȣ �� JOB_ID �� ��ȸ�Ѵ�.
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

-- 32. King �� �Ŵ����� �ΰ� �ִ� ��� ������� LAST_NAME �� ������ ��ȸ�Ѵ�.
SELECT LAST_NAME
       , SALARY
FROM   EMPLOYEES
WHERE  MANAGER_ID IN (
                      SELECT EMPLOYEE_ID
                      FROM   EMPLOYEES
                      WHERE  LAST_NAME = 'King'
                     )
;

--33. EXECUTIVE �μ��� �ٹ��ϴ� ��� ������� �μ� ��ȣ, LAST_NAME, JOB_ID �� ��ȸ�Ѵ�.
SELECT  D.DEPARTMENT_ID
        , LAST_NAME
        , JOB_ID
FROM    DEPARTMENTS D
        , EMPLOYEES E
WHERE   D.DEPARTMENT_NAME = 'Executive'
AND     D.DEPARTMENT_ID = E.DEPARTMENT_ID
;

-- 34. ȸ�� ��ü ��� ���� ���� �� ���� ����� �� LAST_NAME �� u �� �ִ� ������� �ٹ��ϴ� �μ����� �ٹ��ϴ� ������� ���, LAST_NAME �� ������ ��ȸ�Ѵ�.
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

--35.  ST_CLERK �� ���� ID �� ���� ����� ���� �μ� ID �� ��ȸ�Ѵ�.
-- NULL ���� �����Ѵ�. (NOT EXISTS ���. �ظ��ϸ� �����������. �̰Ÿ��� ���̾ȳ��ö�..)
-- EXISTS �� �÷��� �ʿ����..... (���������� ROW�� �ִ��� ��������)
SELECT  DISTINCT DEPARTMENT_ID
FROM    EMPLOYEES E
WHERE   NOT EXISTS (
                    /*������ ������ 1�� �������ִ°���*/
                    SELECT  '1'
                    FROM    EMPLOYEES E1
                    WHERE   JOB_ID = 'ST_CLERK'
                    AND     E1.DEPARTMENT_ID = E.DEPARTMENT_ID
                   )
AND      DEPARTMENT_ID IS NOT NULL                
;


--36. ��ġ�� �μ��� ���� ���� ID �� ���� �̸��� ��ȸ����.(NOT EXISTS ���)
/*�μ��� ����*/
SELECT  DISTINCT C.COUNTRY_ID
        , COUNTRY_NAME
FROM    COUNTRIES C
WHERE   NOT EXISTS ( 
/* ��ġ�ϴ� ROW�� ���ٸ� */
                      SELECT  '1'
                      FROM    DEPARTMENTS D
                              , LOCATIONS L
                      WHERE   L.LOCATION_ID = D.LOCATION_ID
                      AND     L.COUNTRY_ID = C.COUNTRY_ID
                   )
ORDER   BY COUNTRY_ID                   
;
                  
       
/* LOCATION ��ü�� ����*/    
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


--37. ������ ������ ������ ������ �ִ� ������� ��� �� JOB_ID �� ��ȸ�Ѵ�.
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
--41. Ŀ�̼��� ���� ������� �μ��� ������ ������ ������� LAST_NAME, �μ� ��ȣ �� ������ ��ȸ�Ѵ�.
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

--42. ��ġ ID �� 1700 �� ������� ������ Ŀ�̼��� ������ ������� LAST_NAME, �μ� ��ȣ �� ������ ��ȸ�Ѵ�.
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

--43. LAST_NAME �� 'Kochhar' �� ����� ������ ���� �� Ŀ�̼��� ���� ������� LAST_NAME, �μ� ��ȣ �� ������ ��ȸ�Ѵ�.
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

--44. ���� ID �� SA_MAN �� ������� �ִ� ���� ���� ���� �޴� ������� LAST_NAME, JOB_ID �� ������ ��ȸ�Ѵ�.
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

--45. ���� �̸��� T �� �����ϴ� ������ ��� ������� ���, LAST_NAME �� �μ� ��ȣ�� ��ȸ�Ѵ�.
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


--46. �� �μ��� ��� �������� �� �޴� ���Ϻμ� �ٹ�������� 
-- LAST_NAME, ����, �μ���ȣ �� �ش� �μ��� ��� ������ ��ȸ�Ѵ�.
-- ����� �μ��� ������ �������� �����Ѵ�.
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

--47. NOT EXISTS �����ڸ� ����Ͽ� �Ŵ����� �ƴ� ��� �̸��� ��ȸ�Ѵ�.
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


--48. �ҼӺμ��� ��� �������� ���� ���� ������� last_name �� ��ȸ�Ѵ�.
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




--49.  �� ��� �� �ҼӺμ����� �ڽź��� �ʰ� ���Ǿ����� ���� ���� ������ �޴� 
--     ���/ 
-- �� �����ϴ� ��� ������� last_name �� ��ȸ�Ѵ�.
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
-----���� DPT_ID---------------
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






