--15�� ����� ����

--��Ű�� : ������ ���̽����� ������ �� ����, ���� �������� ��
--        �����͸� ����, �����ϱ� ���� ������ �����ͺ��̽� ������ ����
--        - �����ͺ��̽��� ������ ����ڿ� ����� ��ü�� �ǹ�

--CONNECT SYS/ORACLE AS SYSDBA;
--ALTER USER HR IDENTIFIED BY 1234 ACCOUNT UNLOCK;

CREATE USER ORCLSTUDY
IDENTIFIED BY ORACLE;  --insufficient privileges

CREATE TABLE TEMP(
    COL1 VARCHAR2(20),
    COL2 VARCHAR2(20)
);

GRANT SELECT ON TEMP TO ORCLSTUDY;  --SELECT�� TEMP�� ���Ѻο�

GRANT INSERT ON TEMP TO ORCLSTUDY;

--GRANT SELECT, INSERT ON TEMP TO ORCLSTUDY;  --�ѰŹ��� �ִ°͵� ����

REVOKE SELECT , INSERT ON TEMP FROM ORCLSTUDY;

--����� ���� : CREATE USER
--���Ѻο�    : GRANT
--���� ȸ��   : REVOKE


CREATE USER PREV_HW IDENTIFIED BY ORCL;
GRANT CREATE SESSION TO PREV_HW;



GRANT SELECT ON EMP TO PREV_HW;
GRANT SELECT ON DEPT TO PREV_HW;
GRANT SELECT ON SALGRADE TO PREV_HW;

SELECT * FROM HR.SALGRADE;

REVOKE SELECT ON SALGRADE FROM PREV_HW;




