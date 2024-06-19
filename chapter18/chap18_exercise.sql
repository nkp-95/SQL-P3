--18 Ŀ���� ����ó��
--18-1
SET SERVEROUTPUT ON;

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

--18-2 ����� Ŀ�� ����[������]( STREM ó�� ���� ������ ��ȸ���� �ƴ�)
DECLARE
    --ROW ���� <- Ŀ�������� �ο� �Է¹��� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    --1.����� Ŀ�� ����
    CURSOR C1 IS 
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = 40;
BEGIN
    --Ŀ������
    OPEN C1;
    LOOP
        --3. FETCH
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);

    END LOOP;
    --4. Ŀ�� �ݱ�
    CLOSE C1;
END;
/

--18-3 ������ Ŀ��
DECLARE
    --ROW ���� <- Ŀ�������� �ο� �Է¹��� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    --1.����� Ŀ�� ����
    CURSOR C1 IS 
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT;
BEGIN
    --Ŀ������
    OPEN C1;
    LOOP
        --3. FETCH
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
        || ', DNAME : ' || V_DEPT_ROW.DNAME
        || ', LOC : ' || V_DEPT_ROW.LOC);

    END LOOP;
    --4. Ŀ�� �ݱ�
    CLOSE C1;
END;
/

--18-4  OPEN, CLOSE ���� FOR IN������ �������� ����
DECLARE
    --����� Ŀ�� ����
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT;
BEGIN
    FOR C1_REC IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || C1_REC.DEPTNO
        || ', DNAME : ' || C1_REC.DNAME
        || ', LOC : ' || C1_REC.LOC);
    
    END LOOP;
END;
/

--18-5
DECLARE
    --Ŀ�� �����͸� �Է��� ���� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    --����� Ŀ�� ����
    CURSOR C1 (P_DEPTNO DEPT.DEPTNO%TYPE) IS 
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT
       WHERE DEPTNO = P_DEPTNO;
BEGIN
--10�� �μ� ó���� ���� Ŀ�� ���
    OPEN C1(10);
    LOOP
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
        || ', DNAME : ' || V_DEPT_ROW.DNAME
        || ', LOC : ' || V_DEPT_ROW.LOC);
    
    END LOOP;
    CLOSE C1;
--20�� �μ� ó���� ���� Ŀ�� ���
    OPEN C1(20);
        LOOP
            FETCH C1 INTO V_DEPT_ROW;
            EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
            || ', DNAME : ' || V_DEPT_ROW.DNAME
            || ', LOC : ' || V_DEPT_ROW.LOC);
        
    END LOOP;
    CLOSE C1;
END;
/

--FOR IN �� ��� �Ķ���� �ִ� Ŀ�� ���
DECLARE
    v_deptno DEPT.DEPTNO%TYPE;
    CURSOR C1 (P_DEPTNO DEPT.DEPTNO%TYPE) IS 
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = P_DEPTNO;
BEGIN
    --INPUT_DEPTNO �� �μ���ȣ �Է� �ް� V_DEPTNO �� ����
    v_deptno := &INPUT_DEPTNO;
    FOR C1_REC IN C1(v_deptno) LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || C1_REC.DEPTNO
            || ', DNAME : ' || C1_REC.DNAME
            || ', LOC : ' || C1_REC.LOC);
    END LOOP;
END;
/

--18-7
BEGIN
    UPDATE DEPT SET DNAME = ' DATABASE'
     WHERE DEPTNO = 50;
     
    DBMS_OUTPUT.PUT_LINE('���ŵ� ���� �� : ' || SQL%ROWCOUNT);
    
    IF(SQL%FOUND) THEN 
        DBMS_OUTPUT.PUT_LINE('���� ��� �� ���翩��: TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���� ��� �� ���翩��: FALSE');
    END IF;
    
    IF(SQL%ISOPEN) THEN
         DBMS_OUTPUT.PUT_LINE('Ŀ���� OPEN ����: TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ŀ���� OPEN ����: FALSE');
    END IF;
END;
/

--����ó��:
-- ������ �߻��ص� ���α׷��� ������ ������� �ʵ��� �ϴ� ó��

DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG  --VALUE ����
      FROM DEPT
     WHERE DEPTNO = 10;
END;
/

DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG 
      FROM DEPT
     WHERE DEPTNO = 10;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�');
END;
/
--18-10 ���� �߻� �Ŀ� �ڵ� ���� ����
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG 
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� �̹����� ������� �ʽ��ϴ�.');
     
    EXCEPTION
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�');
END;
/

--���� �̸�
/*
DUP_VAL_ON_INDEX : UNIQE �ε����� �ִ� ���� �ߺ� ���� ���� ��
NO_DATA_FOUND : DELECT INTO ������ ��� ���� �ϳ��� ���� ���
VALUE_ERROR : ���, ��ȯ �߸�, ���� ���� ������ �߻� ��
TOO_MANY_ROWS : SELECT INTO ���� ��� ���� ������ ��� ��

*/
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG 
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� �̹����� ������� �ʽ��ϴ�.');
     
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : �䱸���� ���� �� ���� ���� �߻�');
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ���� ���� �� ���� �߻�');
END;
/
--18-11
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG 
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� �̹����� ������� �ʽ��ϴ�.');
     
    EXCEPTION        
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ���� ���� �� ���� �߻�');
            DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/
---�߰�����----------------------------------------------------------------------
--���� 5 ) 1���� ������ Ȧ�� 10���� ����ϱ�
--(IF  ���ǹ� ���� 
--�ݺ���  BASIC LOOP �� WHILE LOOP ������ ������� ����غ�����)
--0
--�⺻ LOOP
DECLARE
    V_NUM NUMBER := 1;      --�ʱ��
    V_CNT NUMBER := 1;
BEGIN
    LOOP
        EXIT WHEN V_CNT > 10; --���ǽ�       
        DBMS_OUTPUT.PUT_LINE(V_NUM);
        V_NUM := V_NUM + 2;
        V_CNT := V_CNT + 1;
    END LOOP;
END;
/
--WHILE
DECLARE
    V_NUM NUMBER := 1;      --�ʱ��   
BEGIN
        WHILE V_NUM < 11 LOOP
        --CONTINUE WHEN MOD(V_NUM, 2) = 0;
        DBMS_OUTPUT.PUT_LINE(V_NUM);
        
        V_NUM := V_NUM + 1;                
    END LOOP;
END;
-- FOR IN .. LOOP
BEGIN
    FOR V_NUM IN 1..10 LOOP
    CONTINUE WHEN MOD(V_NUM, 2) = 0;
     DBMS_OUTPUT.PUT_LINE(V_NUM);
    END LOOP;
END;
/


--����6) ������̺��� 30 �� �μ��� ����� �����ȣ, �̸�, ��å ����ϱ�  (cursor ���)
-- (v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job)
--1. ���� OPEN   FETCH CLOSE      2. FOR   IN 
DECLARE
    V_EMP EMP%ROWTYPE;
    CURSOR C1 IS
    SELECT * 
      FROM EMP 
     WHERE DEPTNO = 30;    --1 
BEGIN
    OPEN C1;--2
    LOOP
        FETCH C1 INTO V_EMP;--3
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_EMP.EMPNO || '  ' || V_EMP.ENAME || '  ' || V_EMP.job);        
    END LOOP;
    CLOSE C1;--4
END;
/
--FOR IN
DECLARE
    CURSOR C1 IS
    SELECT * 
      FROM EMP 
     WHERE DEPTNO = 30;     
BEGIN
    FOR C1_REC IN C1 LOOP
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(C1_REC.EMPNO || '  ' || C1_REC.ENAME || '  ' || C1_REC.job);        
    END LOOP;
END;
/

--Q1------------------------------------------------------------------------------------

DECLARE
    LOOP_EMP EMP%ROWTYPE;
    
    CURSOR C1 IS
    SELECT * 
    FROM EMP;       --1 ����� Ŀ�� ����
    
    
BEGIN
    OPEN C1;    --2Ŀ�� ����
    LOOP
    FETCH C1 INTO LOOP_EMP;     --3Ŀ�� ��ġ���
        EXIT WHEN C1%NOTFOUND;
    
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' || LOOP_EMP.EMPNO
        || ', ENAME : ' || LOOP_EMP.ENAME
        || ', JOB : ' || LOOP_EMP.JOB
        || ', SAL : ' || LOOP_EMP.SAL
        || ', DEPTNO : ' || LOOP_EMP.DEPTNO
        );        
    END LOOP;
    CLOSE C1;       --Ŀ�� �ݱ�
END;
/

--FOR LOOP
DECLARE
    FOR_EMP EMP%ROWTYPE;
    
    CURSOR C1 IS
    SELECT * 
    FROM EMP; 
    
    
BEGIN
    FOR FOR_EMP IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' || FOR_EMP.EMPNO
                            || ', ENAME : ' || FOR_EMP.ENAME
                            || ', JOB : ' || FOR_EMP.JOB
                            || ', SAL : ' || FOR_EMP.SAL
                            || ', DEPTNO : ' || FOR_EMP.DEPTNO
                            );   
   END LOOP;
    
END;
/



--Q2-----------------------------------------------------------------------------

DECLARE
    V_WRONG DATE;
BEGIN
    SELECT ENAME INTO V_WRONG   --INTO ������ ����� ���� ������ ����
      FROM EMP
     WHERE EMPNO = 7369;  
    
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�.');
    
    EXCEPTION 
        WHEN OTHERS THEN  -- EXCEPTION WHEN NO_DATA_FOUND THEN
        
            DBMS_OUTPUT.PUT_LINE('������ �߻� �Ͽ����ϴ�.'|| 
                    TO_CHAR(SYSDATE, '[YYYY"��"MM"��"DD"��"HH24"��"MI"��"SS"��"]'));
            DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

