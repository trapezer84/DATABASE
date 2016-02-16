-- Employees ���̺��� LAST_NAME�� SALARY�� �޾ƿ´� -- 
SELECT  LAST_NAME
        , SALARY
  FROM EMPLOYEES
;

-- Employees ���̺��� LAST_NAME�� EMPLOYEE_ID �׸��� SALARY�� �޾ƿ´� -- 
SELECT LAST_NAME
      , EMPLOYEE_ID
      , HIRE_DATE
FROM EMPLOYEES
;

-- ������� LAST_NAME, ���� �� Ŀ�̼��� ��ȭ --
SELECT LAST_NAME
      , SALARY
      , COMMISSION_PCT
FROM EMPLOYEES
;

-- ������� EMPLOYESS_ID, FIRST_NAME, LAST_NAME, ���� �� Ŀ�̼��� ��ȸ --
SELECT EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , SALARY
      , COMMISSION_PCT
FROM EMPLOYEES
;

-- DEPARTMENT �˾ƺ��� --
SELECT *
FROM DEPARTMENTS
;

-- DEPARTMENT�� TABLE���� DEPARTMENT_ID �� DEPARTMENT_NAME ��� --
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

-- �� �Ȱ����� NOT �� ! �ٸ��� --
SELECT LAST_NAME
      , SALARY 
FROM EMPLOYEES
WHERE NOT(SALARY >= 12000)
;

-- ��� ��ȣ�� 176���� ����� ����϶� -- 
SELECT LAST_NAME
      , DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176
;

-- �μ� ��ȣ�� 30���� ���� �μ����� ���ϴ� 
-- ������� ����� ���� �̸��� ��ȸ
SELECT EMPLOYEE_ID 
      , LAST_NAME 
FROM EMPLOYEES
WHERE DEPARTMENT_ID < 30
;

-- �μ� ��ȣ�� 30���� ���� �μ����� ���ϴ� 
-- ������� ����� ���� �̸��� ��ȸ �߿��� ����� 200���� ����� ��ȸ
SELECT EMPLOYEE_ID 
      , LAST_NAME 
FROM EMPLOYEES
WHERE DEPARTMENT_ID < 30
      AND EMPLOYEE_ID = 200
;

-- �μ� ��ȣ�� 30���� ���� �μ����� ���ϴ� 
-- ������� ����� ���� �̸��� ��ȸ �߿��� ������ 5000 �̻��� ����� ��ȸ
SELECT EMPLOYEE_ID 
      , LAST_NAME 
      , FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID < 30
      AND SALARY > 5000
;

-- ������ 5000~12000 �̿��� ������� LAST_NAME �� ��ȸ
SELECT LAST_NAME
      , SALARY
FROM EMPLOYEES
WHERE SALARY < 5000
OR    12000 < SALARY 
;

-- 20�� �� 50�� �μ����� �ٹ��ϴ� ��� ������� LAST_NAME �� �μ���ȣ�� ��ȸ 
SELECT LAST_NAME
      , DEPARTMENT_ID
FROM  EMPLOYEES
WHERE DEPARTMENT_ID = 20
OR    DEPARTMENT_ID = 50
;

-- 20�� �� 50�� �μ����� �ٹ��ϴ� ��� ������� LAST_NAME �� �μ���ȣ�� ��ȸ 
SELECT LAST_NAME
      , DEPARTMENT_ID
FROM  EMPLOYEES
WHERE DEPARTMENT_ID IN ( 20, 50)
;

-- ������ �������� �������� ��Ű�� 
SELECT  LAST_NAME
        , SALARY 
FROM    EMPLOYEES
WHERE   SALARY >= 12000
ORDER   BY SALARY ASC 
;

-- ������ �������� �������� ��Ű�� 
SELECT  LAST_NAME
        , SALARY 
FROM    EMPLOYEES
WHERE   SALARY >= 12000
ORDER   BY SALARY DESC 
;

-- 2�� ���� �ϱ� 
SELECT  LAST_NAME
        , SALARY 
FROM    EMPLOYEES
WHERE   SALARY >= 12000
ORDER   BY SALARY ASC
        , LAST_NAME DESC
;

-- 20�� �� 50�� �μ����� �ٹ��ϴ� ��� ������� 
-- LAST_NAME �� �μ� ��ȣ�� ���ĺ� ������ ��ȸ�Ѵ� 
SELECT  LAST_NAME
        , DEPARTMENT_ID 
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = 20
OR      DEPARTMENT_ID = 50
ORDER   BY LAST_NAME ASC
;

-- ���� ���� -- 

-- [1] ������ 12000 �̻�Ǵ� �������� LAST_NAME �� ������ ��ȸ�Ѵ�.
SELECT  LAST_NAME
        , SALARY
FROM EMPLOYEES
WHERE SALARY > 12000
;

-- [2] �����ȣ�� 176 �� ����� LAST_NAME �� �μ� ��ȣ�� ��ȸ�Ѵ�.
SELECT    LAST_NAME
          , DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176
;

-- [3] ������ 5000 ���� 12000�� ���� �̿��� ������� 
--    LAST_NAME �� ������ ��ȸ����.
SELECT    LAST_NAME
          , SALARY
FROM      EMPLOYEES
WHERE     SALARY < 5000
OR        SALARY > 12000
;

-- [4] 1998/02/20 �Ϻ��� 1998/05/01 ���̿� ���� ������� LAST_NAME ���, ������ڸ� ��ȸ�Ѵ�.
-- ������� ������ �����Ѵ�.
SELECT    LAST_NAME
          , EMPLOYEE_ID
          , HIRE_DATE
FROM      EMPLOYEES
WHERE     HIRE_DATE >= '2002/02/20'
AND       HIRE_DATE <= '2005/05/01'
ORDER     BY HIRE_DATE
;

-- [5]  20 �� �� 50 �� �μ����� �ٹ��ϴ� ��� ������� 
--    LAST_NAME �� �μ� ��ȣ�� ���ĺ������� ��ȸ�Ѵ�.
SELECT    LAST_NAME
          , DEPARTMENT_ID
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID = 20
OR        DEPARTMENT_ID = 50
ORDER     BY LAST_NAME ASC
;

-- [5]  20 �� �� 50 �� �μ����� �ٹ��ϴ� ��� ������� 
--    LAST_NAME �� �μ� ��ȣ�� ���ĺ������� ��ȸ�Ѵ�.
SELECT    LAST_NAME
          , DEPARTMENT_ID
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID IN ( 20, 50 )
ORDER     BY LAST_NAME ASC
;

-- [6] 20 �� �� 50 �� �μ��� �ٹ��ϸ�, ������ 5000 ~ 12,000 ������ ������� LAST_NAME �� ������ ��ȸ�Ѵ�.
SELECT    LAST_NAME
          , SALARY
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID IN ( 20, 50 )
AND       SALARY > 5000
AND       SALARY < 12000
;

-- [7] 1994�⵵�� ���� ��� ������� LAST_NAME �� ������� ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , HIRE_DATE
FROM        EMPLOYEES
WHERE       HIRE_DATE LIKE '94/%M/%D'
;

-- [8] �Ŵ����� ���� ������� LAST_NAME �� JOB_ID �� ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , JOB_ID
FROM        EMPLOYEES
WHERE       MANAGER_ID IS NULL
OR          MANAGER_ID = ''
;

-- [9] Ŀ�̼��� ���� ��� ������� LAST_ANME, ���� �� Ŀ�̼��� ��ȸ�Ѵ�.
-- ���� ����, Ŀ�̼� �������� �����Ѵ�.
SELECT    LAST_NAME
          , SALARY  
          , COMMISSION_PCT
FROM      EMPLOYEES
WHERE     COMMISSION_PCT IS NOT NULL
OR        COMMISSION_PCT != ''
;

-- [10] LAST_NAME �� �׹�° ���ڰ� a �� ������� LAST_NAME �� ��ȸ�Ѵ�.
SELECT    LAST_NAME
FROM      EMPLOYEES
WHERE     LAST_NAME LIKE '___a%'
;

-- [11] LAST_NAME �� a �� e ���ڰ� �ִ� ������� LAST_NAME �� ��ȸ����.
SELECT     LAST_NAME
FROM       EMPLOYEES
WHERE      LAST_NAME LIKE '%a%'
OR         LAST_NAME LIKE '%E%'
;


-- [12] ������ 2,500, 3,500, 7000 �� �ƴϸ� ������ SA_REP �̳� ST_CLERK �� ������� ��ȸ�Ѵ�.
SELECT      LAST_NAME
            , JOB_ID
            , SALARY
FROM        EMPLOYEES
WHERE       NOT (SALARY = 2500)
AND         NOT (SALARY = 3500)
AND         NOT (SALARY = 7000)
AND         ( JOB_ID = 'SA_REP' OR JOB_ID = 'ST_CLERK' )
;

-- [13] ������ AD_PRESS �� ����� A �����, 
--  ST_MAN �� ����� B �����,
--  IT_PROG �� ����� C �����,
--  SA_REP �� ����� D �����,
--  ST_CLEAK �� ����� E ����� 
--  ��Ÿ�� 0 �� �ο��Ͽ� ��ȸ�Ѵ�.
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


-- [14] ��� ������� LAST_NAME, �μ� ��ȣ �� �μ� �̸��� ��ȸ�Ѵ�.
SELECT      EMPLOYEES.LAST_NAME
            , EMPLOYEES.DEPARTMENT_ID
            , DEPARTMENTS.DEPARTMENT_NAME
FROM        EMPLOYEES
INNER JOIN  DEPARTMENTS 
ON          EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
;

-- [15] �μ���ȣ 30 ���� ��� �������� ������ �������� ��ȸ�Ѵ�. 
--     90 �μ� ���� �����Ѵ�. 

-- [16]  Ŀ�̼��� ���� ��� ������� 
-- LAST_NAME, �μ� ��, ���� ID �� ���� ���� ��ȸ�Ѵ�.


----- ���� -------------

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
-- �μ��� ������� ���Ѵ� 
SELECT    DEPARTMENT_ID 
          , COUNT(EMPLOYEE_ID)
FROM      EMPLOYEES
GROUP     BY DEPARTMENT_ID
ORDER     BY DEPARTMENT_ID
;

-- 4. GROUP BY �� SELECT �÷��� �������� ������ ������ �����. 
SELECT    DEPARTMENT_ID 
          , COUNT(EMPLOYEE_ID)
FROM      EMPLOYEES
GROUP     BY MANAGER_ID
ORDER     BY DEPARTMENT_ID
;

--- 5.
-- �μ��� (MANAGER_ID) �� ���� ������ ���� ���Ͻÿ� 
SELECT    MANAGER_ID 
          , COUNT (EMPLOYEE_ID)
FROM      EMPLOYEES
GROUP     BY MANAGER_ID
;

 -- 6. 
 -- ��ü ��� �� ���� ���� ������ ���� ���� ���� 
 -- �׸��� ��ü ������ ��, ��ü ������ ����� ���Ͻÿ� 
 SELECT     MAX(SALARY)   AS HIGH_SALARY
            , MIN(SALARY) AS LOW_SALARY
            , SUM(SALARY) AS SUM_SALARY
            , ROUND(AVG(SALARY)) AS AVG_SALARY
 FROM       EMPLOYEES
 ;

-- 7.
-- �μ��� ���� ���� ����, ���� ���� ����
-- ��ü ������ ��, ��ü ������ ����� ���Ͻÿ� 
SELECT      DEPARTMENT_ID
            , MAX(SALARY)   AS HIGH_SALARY
            , MIN(SALARY) AS LOW_SALARY
            , SUM(SALARY) AS SUM_SALARY
            , ROUND(AVG(SALARY)) AS AVG_SALARY
 FROM       EMPLOYEES
 GROUP      BY DEPARTMENT_ID
 ;
            

-- 8.
-- �Ʒ��� �Լ��� NULL �̶�� 0���� ǥ���ض�� �ǹ� 
SELECT      NVL ( DEPARTMENT_ID, 0) 
            , MAX(SALARY)   AS HIGH_SALARY
            , MIN(SALARY)   AS LOW_SALARY
            , SUM(SALARY)   AS SUM_SALARY
            , ROUND(AVG(SALARY)) AS AVG_SALARY
 FROM       EMPLOYEES
 GROUP      BY DEPARTMENT_ID
;

-- 9.
-- ~ �̻�, ~ ���� ����ϱ� GROUP BY �� ���ǵ��� HAVING���� ����Ѵ�. 
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
-- ��ü ��� �߿��� ������ ���� ���� �޴� ��� 
-- ���� ���� 
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
-- ���� 2���� ������ �ϳ��� ������ ����. 
-- ��ȣ�� ���μ� ����. 

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



-- 11. �μ��� �ְ� ���� 
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
-- NVL  ( NULL ���ϱ� )
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
-- ���� �������� �õ��غ��� 
-- ȸ�� ��ü ��� ���� ���� �� ���� ����� �� LAST_NAME �� U�� �ִ� ������� 
-- �ٹ��ϴ� �μ����� �ٹ��ϴ� ������� ���, LAST_NAME �� ������ ��ȸ�Ѵ�. 
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

