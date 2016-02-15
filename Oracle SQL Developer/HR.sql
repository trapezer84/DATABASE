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