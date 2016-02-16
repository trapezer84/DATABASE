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
WHERE     HIRE_DATE >= '1998/02/20'
AND       HIRE_DATE <= '1998/05/01'
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

-- [6] 20 �� �� 50 �� �μ��� �ٹ��ϸ�, ������ 5000 ~ 12,000 ������ ������� LAST_NAME �� ������ ��ȸ�Ѵ�.
SELECT    LAST_NAME
          , SALARY
FROM      EMPLOYEES
WHERE     SALARY > 5000
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
;

-- [9] Ŀ�̼��� ���� ��� ������� LAST_ANME, ���� �� Ŀ�̼��� ��ȸ�Ѵ�.
-- ���� ����, Ŀ�̼� �������� �����Ѵ�.
SELECT    LAST_NAME
          , SALARY  
          , COMMISSION_PCT
FROM      EMPLOYEES
WHERE     COMMISSION_PCT IS NOT NULL
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


-- [14] ��� ������� LAST_NAME, �μ� ��ȣ �� �μ� �̸��� ��ȸ�Ѵ�.
SELECT LAST_NAME
, DEPARTMENT_ID
, DEPARTMENT_NAME
FROM EMPLOYEES
    , DEPARTMENTS
;
-- [15] �μ���ȣ 30 ���� ��� �������� ������ �������� ��ȸ�Ѵ�. 
--     90 �μ� ���� �����Ѵ�.

-- [16]  Ŀ�̼��� ���� ��� ������� 
-- LAST_NAME, �μ� ��, ���� ID �� ���� ���� ��ȸ�Ѵ�.
