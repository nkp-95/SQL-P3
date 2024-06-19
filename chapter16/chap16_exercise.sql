--16-1 PL/SQL ����
SET SERVEROUTPUT ON;  --ȭ�鿡 ��� Ȱ��ȭ   OFF�� ����

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, PL/SQL!');
END;

--�ּ� ����ϱ�
-- := �Ҵ� ������
DECLARE
--���� �̸� �ڷ��� := �� �Ǵ� ���� ����Ǵ� ���� ǥ����;
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME); 
END;
/

--����� ���� �������� ����ϱ�
DECLARE
    V_TAX CONSTANT NUMBER(1) := 3;
BEGIN
DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;
/

--������ �⺻�� �����ϱ�
DECLARE
    V_DEPTNO NUMBER(2) DEFAULT 10;   --�⺻�� 10 ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--16-7������ NOT NULL �����ϰ� ���� ������ �� ����ϱ� 
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL := 10;  --�⺻�� 10 ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--NOT NULL�� �⺻�� ���� ����
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL DEFAULT 10;   --�⺻�� 10 ���� NOT NULL
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_deptno);--V_ ��ҹ��� ���� X
END;
/

-- �ĺ��� �̸� ���̴� ��Ģ
-- ��ҹ��� �������� �ʽ��ϴ�.
-- ���� �� �ȿ��� �ĺ��ڴ� �����ؾ��ϸ� �ߺ��Ұ�
--      ���ڷ� ����, 30BYTE, ($, #, _)��밡��. SQL Ű���� �Ұ�(SELECT, FROM, WHERE)

--������ �ڷ���(�߿�)
--��Į�� : ����, ���ڿ�, ��¥ ��� ���� ����Ŭ���� �⺻���� �����س��� �ڷ���
--������ : Ư�� ���̺� ��(�÷�)�� �ڷ����̳� �ϳ��� �౸���� ����

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;  --DEPT.DEPTNO%TYPE => ������
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--16-10  �÷� 3��¥�� �ѹ��� ����
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC
      INTO V_DEPT_ROW
      FROM DEPT
     WHERE DEPTNO = 40;
     
     DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
     DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
     DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);

END;
/

SELECT * FROM DEPT WHERE DEPTNO = 40;

-- 16-3 ���� ���  --IF �� CASE�� ��� ����
--  IF ���ǽ� THEN 
--  ELSIF ���ǽ� THEN
--  ELSE(�׿ܿ�)
--  END IF;

--������ �Էµ� ���� Ȧ�� ���� �˾ƺ���
DECLARE
   V_NUMBER NUMBER := 13;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    END IF;
END;
/

--
DECLARE
   V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� ¦���Դϴ�!');
    END IF;
END;
/

--�Է��� ������ ��� �������� ����ϱ�
DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    IF V_SCORE >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A����');
    ELSIF V_SCORE >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B����');
    ELSIF V_SCORE >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C����');
    ELSIF V_SCORE >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D����');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('F����');
    END IF;
END;
/
/*
--��1) ������ȣ�� 7900  �� ���������� ����غ�����
  -- v_no||' '||v_name||' '||v_sal 
-- ��°��: ������ȣ�� 7900  �� �������� : 7900 JAMES 950
*/

DECLARE
    V_NO EMP.EMPNO%TYPE;
    V_NAME EMP.ENAME%TYPE;
    V_SAL EMP.SAL%TYPE;
BEGIN
    SELECT EMPNO, ENAME, SAL
      INTO V_NO, V_NAME, V_SAL
      FROM EMP
     WHERE EMPNO = 7900;
    
     DBMS_OUTPUT.PUT_LINE('������ȣ�� 7900  �� �������� : ' || V_NO || ' ' || V_NAME || ' ' || V_SAL);
END;
/

--��2) ������ȣ�� 7900  �� ����������  ROWTYPE ������ Ȱ���Ͽ� ������ ����غ�����.
DECLARE
    V_NO_ROW EMP%ROWTYPE;   
BEGIN
    SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
      INTO V_NO_ROW
      FROM EMP
     WHERE EMPNO = 7900;
     
     DBMS_OUTPUT.PUT_LINE('EMPNO : ' || V_NO_ROW.EMPNO); 
     DBMS_OUTPUT.PUT_LINE('ENAME : ' || V_NO_ROW.ENAME); 
     DBMS_OUTPUT.PUT_LINE('JOB : ' || V_NO_ROW.JOB); 
     DBMS_OUTPUT.PUT_LINE('MGR : ' || V_NO_ROW.MGR); 
     DBMS_OUTPUT.PUT_LINE('HIREDATE : ' || V_NO_ROW.HIREDATE); 
     DBMS_OUTPUT.PUT_LINE('SAL : ' || V_NO_ROW.SAL); 
     DBMS_OUTPUT.PUT_LINE('COMM : ' || V_NO_ROW.COMM); 
     DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_NO_ROW.DEPTNO); 
END;
/


DECLARE
    V_NO_ROW EMP%ROWTYPE;   
BEGIN
    SELECT *
      INTO V_NO_ROW
      FROM EMP
     WHERE EMPNO = 7900;
     
     DBMS_OUTPUT.PUT_LINE('EMPNO : ' || V_NO_ROW.EMPNO); 
     DBMS_OUTPUT.PUT_LINE('ENAME : ' || V_NO_ROW.ENAME); 
     DBMS_OUTPUT.PUT_LINE('JOB : ' || V_NO_ROW.JOB); 
     DBMS_OUTPUT.PUT_LINE('MGR : ' || V_NO_ROW.MGR); 
     DBMS_OUTPUT.PUT_LINE('HIREDATE : ' || V_NO_ROW.HIREDATE); 
     DBMS_OUTPUT.PUT_LINE('SAL : ' || V_NO_ROW.SAL); 
     DBMS_OUTPUT.PUT_LINE('COMM : ' || V_NO_ROW.COMM); 
     DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_NO_ROW.DEPTNO); 
END;
/

DECLARE
    V_NO_ROW EMP%ROWTYPE;   
BEGIN
    SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
      INTO V_NO_ROW
      FROM EMP
     WHERE EMPNO = 7900;
     
     DBMS_OUTPUT.PUT_LINE('EMPNO : ' || V_NO_ROW.EMPNO); 
     DBMS_OUTPUT.PUT_LINE('ENAME : ' || V_NO_ROW.ENAME); 
     DBMS_OUTPUT.PUT_LINE('JOB : ' || V_NO_ROW.JOB); 
     /*
     DBMS_OUTPUT.PUT_LINE('MGR : ' || V_NO_ROW.MGR); 
     DBMS_OUTPUT.PUT_LINE('HIREDATE : ' || V_NO_ROW.HIREDATE); 
     DBMS_OUTPUT.PUT_LINE('SAL : ' || V_NO_ROW.SAL); 
     DBMS_OUTPUT.PUT_LINE('COMM : ' || V_NO_ROW.COMM); 
     DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_NO_ROW.DEPTNO); 
     */
END;
/

--��3 EMP ���̺�� DEPT ���̺��� �����ؼ� EMPNO 7900�� ����� ������ �ٷ��غ�����
     (V_EMPNO || ' '  || V_ENAME || ' ' || V_DEPTNO || ' ' || V_DNAME)

DECLARE
    V_EMPNO     EMP.EMPNO%TYPE;
    V_ENAME     EMP.ENAME%TYPE;
    V_DEPTNO    DEPT.DEPTNO%TYPE;
    V_DNAME     DEPT.DNAME%TYPE;
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
      INTO V_EMPNO, V_ENAME, V_DEPTNO, V_DNAME
      FROM EMP E, DEPT D
     WHERE E.DEPTNO = D.DEPTNO 
       AND E.EMPNO = 7900;
       
    DBMS_OUTPUT.PUT_LINE(V_EMPNO || ' '  || V_ENAME || ' ' || V_DEPTNO || ' ' || V_DNAME);
END;
/

DECLARE
    v_empno  EMP.EMPNO%TYPE;
    v_ename  EMP.ENAME%TYPE;
    v_deptno DEPT.DEPTNO%TYPE;
    v_dname  DEPT.DNAME%TYPE;
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
      INTO v_empno, v_ename, v_deptno, v_dname 
      FROM EMP E, DEPT D
     WHERE E.DEPTNO = D.DEPTNO
       AND E.EMPNO = 7900;

    DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_ename ||  ' ' || v_deptno ||  ' ' || v_dname  );   
END;
/

SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.EMPNO = 7900;  --��Ƽ�� ������ 4���� ���͹���

SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO 
   AND E.EMPNO = 7900

/*
����4) 7369����� �޿��� 10000�̻��̸� '��'�� 
5000 �̻��̸� '��'�� �� ���ϸ� '��' ��� 
(ex.   DBMS_OUTPUT.PUT_LINE( v_empno || '�� ����� �޿�' || v_sal || '�� '|| v_level);   )
*/

DECLARE
    V_EMPNO  EMP.EMPNO%TYPE;
    V_SAL    EMP.SAL%TYPE;
    V_LEVEL  VARCHAR2(30);
BEGIN
    IF V_SAL >= 10000 THEN
        V_LEVEL := '��';
    ELSIF V_SAL >= 5000 THEN
        V_LEVEL := '��';
    ELSE
        V_LEVEL := '��';
    END IF;
    
    SELECT EMPNO, SAL 
      INTO V_EMPNO, V_SAL
      FROM EMP
     WHERE EMPNO = 7369;
    
     DBMS_OUTPUT.PUT_LINE( V_EMPNO || '�� ����� �޿�' || V_SAL || '�� '|| V_LEVEL);
    
END;
/

--CASE--------------------------------------------------

DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC(V_SCORE/10)
        WHEN 10 THEN
            DBMS_OUTPUT.PUT_LINE('A����');
        WHEN 9 THEN
            DBMS_OUTPUT.PUT_LINE('A����');
        WHEN 8 THEN
            DBMS_OUTPUT.PUT_LINE('B����');
        WHEN 7 THEN
            DBMS_OUTPUT.PUT_LINE('C����');
        WHEN 6 THEN
            DBMS_OUTPUT.PUT_LINE('D����');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('F����');
        END CASE;
END;
/

SELECT 87/10 FROM DUAL;

DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE
        WHEN V_SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('A����');
        WHEN V_SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('B����');
        WHEN V_SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('C����');
        WHEN V_SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('D����');
        ELSE DBMS_OUTPUT.PUT_LINE('F����');
    END CASE;
END;
/


--1. �̸��� TURNER�� ����� ���� ������ �ϴ� ����� �����ȣ, �̸�, ����, �޿� ����
SELECT * FROM EMP WHERE ENAME = 'TURNER';

SELECT EMPNO, ENAME, JOB, SAL
  FROM EMP
 WHERE JOB = (SELECT JOB FROM EMP
                WHERE ENAME = 'TURNER');


--2. EMP ���̺��� �����ȣ�� 7521�� ����� ������ ���� 
--�޿��� 7934�� ����� �޿����� ���� ����� 
--�����ȣ, �̸�, ������, �Ի���, �޿� ����
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL
  FROM EMP
 WHERE JOB = (SELECT JOB
                FROM EMP
               WHERE EMPNO = 7521)
   AND SAL > (SELECT SAL 
                FROM EMP
               WHERE EMPNO = 7934);

--3. EMP ���̺��� �޿��� ��պ��� ���� ����� �����ȣ, �̸�, ����, �޿�, �μ���ȣ ����
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
HAVING SAL < (SELECT AVG(SAL) FROM EMP)
 GROUP BY EMPNO, ENAME, JOB, SAL, DEPTNO;

SELECT AVG(SAL)
FROM EMP;
SELECT * FROM EMP;


--4. �μ��� �ּұ޿��� 20�� �μ��� �ּұ޿����� ū �μ��� �μ���ȣ, �ּ� �޿� ����--
/*
SELECT DEPTNO, MIN(SAL)
  FROM EMP
 WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO = 20)
 GROUP BY DEPTNO, SAL;  ---X  WHERE �� ��� X
*/

SELECT DEPTNO, MIN(SAL)
  FROM EMP
 GROUP BY DEPTNO
HAVING  MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20); 

--5. ������ �޿� ��� �� ���� ���� �޿������ ������ �޿���� ����
SELECT JOB, AVG(SAL)
  FROM EMP
GROUP BY JOB  
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL)) 
                     FROM EMP
                    GROUP BY JOB);

--6. ������ �ִ� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ ����
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
  FROM EMP E
 WHERE SAL = (SELECT MAX(SAL)
               FROM EMP
              WHERE JOB = E.JOB)
 ORDER BY JOB;

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
  FROM EMP
 WHERE(JOB, SAL) IN (SELECT JOB, MAX(SAL)
                     FROM EMP
                    GROUP BY JOB);

--7. 30�� �μ��� �ּұ޿��� �޴� ������� ���� �޿��� �޴� ����� 
--�����ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ, �� 30�� �μ��� �����ϰ� ����
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
  FROM EMP
 WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30)
   AND DEPTNO != 30;

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
  FROM EMP
 WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30)
   AND DEPTNO != 30;
   
--8. BLAKE�� ���� ��縦 ���� ����� �̸�,����, ����ȣ ����
SELECT ENAME, JOB, MGR
  FROM EMP
 WHERE MGR = (SELECT MGR FROM EMP WHERE ENAME = 'BLAKE');



--16-17
SET SERVEROUTPUT ON;

DECLARE
    V_NUM NUMBER := 0;  --�ʱ��
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;  --������
        --EXIT WHEN V_NUM >4;  --Ż�� ���ǽ�
        IF V_NUM > 4 THEN    --IF Ż�� ���ǽ�
            EXIT;
        END IF;
    END LOOP;
END;
/

--WHILE LOOP

DECLARE
    V_NUM NUMBER := 0;    --�ʱ��
BEGIN
    WHILE V_NUM < 4 LOOP  --���ǽ�
        DBMS_OUTPUT.PUT_LINE('���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM+1;  --������
    END LOOP;
END;
/

--16-19 FOR LOOP

--FOR��  ������ ��� ����(�˾Ƽ� ���������)
BEGIN
    FOR I IN 0..4 LOOP  --..�� ~�� ���� �� (0���� 4���� ����)  JAVA => FOR(INT I = 0; I<=4; I++) 
        DBMS_OUTPUT.PUT_LINE('���� I �� : ' || I);
    END LOOP;
END;
/

BEGIN
    FOR I IN REVERSE 0..4 LOOP  --�ݴ�� ȸ�� (ū������ ����)
        DBMS_OUTPUT.PUT_LINE('���� I �� : ' || I);
    END LOOP;
END;
/

--16-20
--CONTINUE ��

BEGIN
    FOR I IN 0..4 LOOP 
        CONTINUE WHEN MOD(I,2) = 1;  --Ȧ���̸� �ش�ȸ�� �ݺ��� ��ŵ
        DBMS_OUTPUT.PUT_LINE('���� I �� : ' || I);
    END LOOP;
END;
/

--Q1 ���� 1���� 10���� ������ Ȧ���� ���
BEGIN
    FOR I IN 1..10 LOOP
        CONTINUE WHEN MOD(I,2) = 0;
        DBMS_OUTPUT.PUT_LINE('���� I �� : ' || I);
    END LOOP;
END;
/
/*
DECLARE
    I NUMBER := 1;
BEGIN
    LOOP
        CONTINUE WHEN MOD(I, 2) = 0;
        DBMS_OUTPUT.PUT_LINE('���� I �� : ' || I);
        I := I+1;
        END WHEN I > 10;
    END LOOP;
END;
/
*/
--WHILE��
DECLARE
    I NUMBER := 0;
BEGIN
    WHILE I < 10 LOOP
        I := I+1;
        IF MOD(I, 2) = 0 THEN
            CONTINUE;
        END IF;
        -- CONTINUE WHEN MOD(I, 2) = 0;
        DBMS_OUTPUT.PUT_LINE('���� I �� : ' || I);
    END LOOP;
END;
/

--2Q  IF CASE 
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 10;
BEGIN
        IF V_DEPTNO = 10 THEN
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'ACCOUNTING');
        ELSIF V_DEPTNO = 20 THEN
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'RESEARCH');
        ELSIF V_DEPTNO = 30 THEN
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'SALES');
        ELSIF V_DEPTNO = 40 THEN
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'OPERATIONS');
        ELSE 
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'N/A');  
        END IF;    
END;
/

SELECT * FROM DEPT;
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
--CASE
    CASE V_DEPTNO
        WHEN  10 THEN 
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'ACCOUNTING');
        WHEN 20 THEN 
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'RESEARCH');
        WHEN 30 THEN 
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'SALES');
        WHEN 40 THEN 
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'OPERATIONS');
        ELSE 
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'N/A');
        END CASE;
END;
/





DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
    V_DEPT_NAME DEPT.DNAME%TYPE;
BEGIN
    SELECT DNAME
      INTO V_DEPT_NAME
      FROM DEPT
     WHERE DEPTNO = V_DEPTNO;
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_NAME);  
     
     EXCEPTION WHEN NO_DATA_FOUND THEN
        V_DEPT_NAME := 'N/A';
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_NAME);     
END;
/
     /*    --DBMS �ȿ��� SELECT �Ұ�
        IF V_DEPTNO = 10 THEN
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || SELECT DNAME FROM DEPT WHERE DEPTNO = 10);
        ELSIF V_DEPTNO = 20 THEN
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || SELECT DNAME FROM DEPT WHERE DEPTNO = 20);
        ELSIF V_DEPTNO = 30 THEN
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || SELECT DNAME FROM DEPT WHERE DEPTNO = 30);
        ELSIF V_DEPTNO = 40 THEN
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || SELECT DNAME FROM DEPT WHERE DEPTNO = 40);
        ELSE 
             DBMS_OUTPUT.PUT_LINE('DNAME : ' || 'N/A');  
        END IF;    
        */

