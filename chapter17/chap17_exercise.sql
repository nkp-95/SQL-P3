-- 17장 레코드와 컬렉션

--레코드 : 자료형이 다른 여러 데이터를 저장할수 있는 타입

--17-1
--RECODE  == ROW
SET SERVEROUTPUT ON;
DECLARE
    TYPE REC_DEPT IS RECORD(--클래스 타입 선언
        DEPT_NO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC  REC_DEPT;
BEGIN
    DEPT_REC.DEPT_NO := 99;
    DEPT_REC.DNAME := 'DATABASE';
    DEPT_REC.LOC := 'SEOUJL';
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_REC.DEPT_NO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_REC.LOC);
END;
/

--레코드를 사용한 INSERT
CREATE TABLE DEPT_RECORD
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_RECORD;

--17-3
DECLARE
    TYPE REC_DEPT IS RECORD(--클래스 타입 선언
        DEPT_NO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC  REC_DEPT;
BEGIN
    DEPT_REC.DEPT_NO := 99;
    DEPT_REC.DNAME := 'DATABASE';
    DEPT_REC.LOC := 'SEOUJL';
    
    INSERT INTO DEPT_RECORD
    VALUES DEPT_REC;
    
    
    
--    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_REC.DEPT_NO);
--    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_REC.DNAME);
--    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_REC.LOC);
END;
/

SELECT * FROM DEPT_RECORD;

--17-4
DECLARE
    TYPE REC_DEPT IS RECORD(--클래스 타입 선언
        DEPT_NO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC  REC_DEPT;
BEGIN
    DEPT_REC.DEPT_NO := 50;
    DEPT_REC.DNAME := 'DB';
    DEPT_REC.LOC := 'SEOUJL';
    
    UPDATE DEPT_RECORD
       SET ROW = DEPT_REC
     WHERE DEPTNO = 99;
    
    
--    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_REC.DEPT_NO);
--    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_REC.DNAME);
--    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_REC.LOC);
END;
/
SELECT * FROM DEPT_RECORD;

--17-5
DECLARE
    TYPE REC_DEPT IS RECORD(--클래스 타입 선언
        DEPT_NO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    
    TYPE REC_EMP IS RECORD(
        EMPNO EMP.EMPNO%TYPE,
        ENAME EMP.ENAME%TYPE,
        DINFO REC_DEPT
    
    );
    
    EMP_REC REC_EMP;
BEGIN
   SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
     INTO EMP_REC.EMPNO, EMP_REC.ENAME
        , EMP_REC.DINFO.DEPT_NO
        , EMP_REC.DINFO.DNAME  --2중으로 들어가야 사용가능
        , EMP_REC.DINFO.LOC
     FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
      AND E.EMPNO = 7788;
      
      DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || EMP_REC.DINFO.DEPT_NO);
END;
/

--17-2  컬렉션 
--자료형이 같은 여러 데이터를 저장하는 컬렉션

--17-6 연관배열
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER;  --예약어
    
    TEXT_ARR ITAB_EX;
BEGIN--SQL배열은 []=>X, ()=>O 
    TEXT_ARR(1) := '1ST DATA';
    TEXT_ARR(2) := '2ND DATA';
    TEXT_ARR(3) := '3RD DATA';
    TEXT_ARR(4) := '4TH DATA';  
    
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(1) : ' || TEXT_ARR(1));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(2) : ' || TEXT_ARR(2));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(3) : ' || TEXT_ARR(3));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(4) : ' || TEXT_ARR(4));
END;
/

--자바의 객체 배열처럼
--레코드 타입의 연관 배열 생성

--17-7
DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE,
        DNAME DEPT.DNAME%TYPE
    );
    
    TYPE ITAB_DEPT IS TABLE OF REC_DEPT
        INDEX BY PLS_INTEGER;
    
    DEPT_ARR ITAB_DEPT;
    IDX PLS_INTEGER := 0;
BEGIN

    FOR I IN (SELECT DEPTNO, DNAME FROM DEPT) LOOP
        IDX := IDX + 1;
        DEPT_ARR(IDX).DEPTNO := I.DEPTNO;
        DEPT_ARR(IDX).DNAME := I.DNAME;
        
        DBMS_OUTPUT.PUT_LINE(
            DEPT_ARR(IDX).DEPTNO || ' : ' || DEPT_ARR(IDX).DNAME);
    END LOOP;
END;
/

DECLARE
    TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
        INDEX BY PLS_INTEGER;
        
    DEPT_ARR ITAB_DEPT;
    IDX PLS_INTEGER := 0;
    
BEGIN
    FOR I IN (SELECT * FROM DEPT) LOOP
        IDX := IDX + 1;
        DEPT_ARR(IDX).DEPTNO := I.DEPTNO;
        DEPT_ARR(IDX).DNAME := I.DNAME;
        DEPT_ARR(IDX).LOC := I.LOC;
        
        DBMS_OUTPUT.PUT_LINE(DEPT_ARR(IDX).DEPTNO || ' : ' ||
                             DEPT_ARR(IDX).DNAME || ' : ' ||
                             DEPT_ARR(IDX).LOC);
    END LOOP;
END;
/

--17--9 컬렉션 메서드 사용하기
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER;
    
    TEXT_ARR ITAB_EX;
BEGIN
    TEXT_ARR(1) := '1ST DATA';
    TEXT_ARR(2) := '2ND DATA';
    TEXT_ARR(3) := '3RD DATA';
    TEXT_ARR(50) := '50TH DATA';
    
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.COUNT : ' || TEXT_ARR.COUNT);
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.FIRST : ' || TEXT_ARR.FIRST);
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.LAST : ' || TEXT_ARR.LAST);
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.PRIOR(50) : ' || TEXT_ARR.PRIOR(50));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR.NEXT(50) : ' || TEXT_ARR.NEXT(50));
END;
/

DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER;

    text_arr ITAB_EX;
BEGIN
    text_arr(1) := '1st data';
    text_arr(2) := '2nd data';
    text_arr(3) := '3nd data';
    text_arr(50) := '50th data';
    
    DBMS_OUTPUT.PUT_LINE('text_arr.COUNT : ' || text_arr.COUNT);
    DBMS_OUTPUT.PUT_LINE('text_arr.FIRST : ' || text_arr.FIRST);
    DBMS_OUTPUT.PUT_LINE('text_arr.LAST : ' || text_arr.LAST);
    DBMS_OUTPUT.PUT_LINE('text_arr.PRIOR(50) : ' || text_arr.PRIOR(50));
    DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(50) : ' || text_arr.NEXT(50));
END;
/

--복합자료형 : 여러 데이터를 하나의 자료형으로 지정 사용 위해 직접 정의하는 자료형
--   레코드 : 여러종류의 자료형을 하나의 변수에 저장시 사용
--   컬렉션 : 특정자료형의 데이터를 하나의 변수에 저장시 사용

--잊기전에 한번더 
--Q1

CREATE TABLE EMP_RECORD
    AS SELECT * FROM EMP
        WHERE 1<>1;

SELECT * FROM EMP_RECORD;

-----------------------------------------------
DECLARE
    TYPE REC_EMP IS RECORD(
        EMPNO   EMP.EMPNO%TYPE NOT NULL := 9999,
        ENAME   EMP.ENAME%TYPE,
        JOB     EMP.JOB%TYPE,
        MGR     EMP.MGR%TYPE,
        HREDATE EMP.HIREDATE%TYPE,
        SAL     EMP.SAL%TYPE,
        COMM    EMP.COMM%TYPE,
        DEPTNO  EMP.DEPTNO%TYPE
        );
    
    
   EMP_REC REC_EMP;
BEGIN
   EMP_REC.EMPNO := 1111;
   EMP_REC.ENAME := 'TEST_USER';
   EMP_REC.JOB := 'TEST_JOB';
   EMP_REC.HREDATE := '20180301';
   EMP_REC.SAL := 3000;
   EMP_REC.DEPTNO := 40;
   
   INSERT INTO EMP_RECORD
   VALUES EMP_REC;
END;
/


------------------Q2----------------------------
DECLARE
    TYPE ITAB_EMP IS TABLE OF EMP%ROWTYPE
        INDEX BY PLS_INTEGER;
    
    EMP_ARR ITAB_EMP;
    IDX PLS_INTEGER := 0;
BEGIN
    FOR I IN (SELECT * FROM EMP) LOOP
        IDX := IDX + 1;
        EMP_ARR(IDX).EMPNO := I.EMPNO;
        EMP_ARR(IDX).ENAME := I.ENAME;
        EMP_ARR(IDX).JOB := I.JOB;
        EMP_ARR(IDX).MGR := I.MGR;
        EMP_ARR(IDX).HIREDATE := I.HIREDATE;
        EMP_ARR(IDX).SAL := I.SAL;
        EMP_ARR(IDX).COMM := I.COMM;
        EMP_ARR(IDX).DEPTNO := I.DEPTNO;
        
        DBMS_OUTPUT.PUT_LINE(
                 EMP_ARR(IDX).EMPNO || ' : ' ||
                 EMP_ARR(IDX).ENAME || ' : ' ||
                 EMP_ARR(IDX).JOB || ' : ' ||
                 EMP_ARR(IDX).MGR || ' : ' ||
                 TO_CHAR(EMP_ARR(IDX).HIREDATE, 'YYYY/MM/DD') || ' : ' ||
                 EMP_ARR(IDX).SAL || ' : ' ||
                 EMP_ARR(IDX).COMM || ' : ' ||
                 EMP_ARR(IDX).DEPTNO
        );
    END LOOP;
END;
/



/*
DECLARE
    TYPE REC_EMP IS RECORD(
        EMPNO EMP.EMPNO&TYPE,
        ENAME EMP.ENAME&TYPE,
        JOB EMP.JOB.&TYPE,
        MGR EMP.HIREDATE&TYPE,
        SAL EMP.SAL&TYPE,
        COMM EMP.COMM&TYPE
    );
    
    
    TYPE ITAB_EX IS TABLE OF REC_EMP
    INDEX BY PLS_INTEGER;
    
    EMP_ARR ITAB_EX;
        IDX PLS_INTEGER := 0;
BEGIN
     
     FOR I IN (SELECT * FROM EMP) LOOP
        IDX := IDX + 1;
        EMP_ARR(IDX).EMPNO := I.EMPNO;
        EMP_ARR(IDX).ENAME := I.ENAME;
        EMP_ARR(IDX).JOB := I.JOB;
        EMP_ARR(IDX).MGR := I.MGR;
        EMP_ARR(IDX).HIREDATE := I.HIREDATE;
        EMP_ARR(IDX).SAL := I.SAL;
        EMP_ARR(IDX).COMM := I.COMM;
        EMP_ARR(IDX).DEPTNO := I.DEPTNO;
        
     
    DBMS_OUTPUT.PUT_LINE(EMP_ARR.EMPNO || ' : ' ||
                         EMP_ARR.ENAME || ' : ' || 
                         EMP_ARR.JOB || ' : ' ||
                         EMP_ARR.MGR || ' : ' ||
                         EMP_ARR.SAL || ' : ' ||
                         EMP_ARR.COMM);
    END LOOP;
END;
/
*/

DECLARE
    TYPE ITAB_EMP IS TABLE OF EMP%ROWTYPE
        INDEX BY PLS_INTEGER;
    emp_arr ITAB_EMP;
    idx PLS_INTEGER := 0;
BEGIN
    FOR i IN (SELECT * FROM EMP) LOOP
        idx := idx + 1;
        emp_arr(idx).EMPNO := i.EMPNO;
        emp_arr(idx).ENAME := i.ENAME;
        emp_arr(idx).JOB := i.JOB;        
        emp_arr(idx).MGR := i.MGR;
        emp_arr(idx).HIREDATE := i.HIREDATE;
        emp_arr(idx).SAL := i.SAL;
        emp_arr(idx).COMM := i.COMM;
        emp_arr(idx).DEPTNO := i.DEPTNO;
        
        DBMS_OUTPUT.PUT_LINE ( 
            emp_arr(idx).EMPNO || ' : ' ||
            emp_arr(idx).ENAME || ' : ' ||
            emp_arr(idx).JOB || ' : ' ||
            emp_arr(idx).MGR || ' : ' ||
            TO_CHAR(emp_arr(idx).HIREDATE, 'YY/MM/DD') || ' : ' ||
            emp_arr(idx).SAL || ' : ' ||
            emp_arr(idx).COMM || ' : ' ||
            emp_arr(idx).DEPTNO
        );
    END LOOP;
END;
/
