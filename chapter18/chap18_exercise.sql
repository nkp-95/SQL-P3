--18 커서와 예외처리
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

--18-2 명시적 커서 선언[단일행]( STREM 처럼 생성 하지만 일회성이 아님)
DECLARE
    --ROW 변수 <- 커서데이터 로우 입력받을 변수
    V_DEPT_ROW DEPT%ROWTYPE;
    --1.명시적 커서 선언
    CURSOR C1 IS 
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = 40;
BEGIN
    --커서열기
    OPEN C1;
    LOOP
        --3. FETCH
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);

    END LOOP;
    --4. 커서 닫기
    CLOSE C1;
END;
/

--18-3 다중행 커서
DECLARE
    --ROW 변수 <- 커서데이터 로우 입력받을 변수
    V_DEPT_ROW DEPT%ROWTYPE;
    --1.명시적 커서 선언
    CURSOR C1 IS 
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT;
BEGIN
    --커서열기
    OPEN C1;
    LOOP
        --3. FETCH
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
        || ', DNAME : ' || V_DEPT_ROW.DNAME
        || ', LOC : ' || V_DEPT_ROW.LOC);

    END LOOP;
    --4. 커서 닫기
    CLOSE C1;
END;
/

--18-4  OPEN, CLOSE 없이 FOR IN문으로 닫을수도 있음
DECLARE
    --명시적 커서 선언
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
    --커서 데이터를 입력할 변수 선언
    V_DEPT_ROW DEPT%ROWTYPE;
    --명시적 커서 선언
    CURSOR C1 (P_DEPTNO DEPT.DEPTNO%TYPE) IS 
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT
       WHERE DEPTNO = P_DEPTNO;
BEGIN
--10번 부서 처리를 위해 커서 사용
    OPEN C1(10);
    LOOP
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
        || ', DNAME : ' || V_DEPT_ROW.DNAME
        || ', LOC : ' || V_DEPT_ROW.LOC);
    
    END LOOP;
    CLOSE C1;
--20번 부서 처리를 위해 커서 사용
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

--FOR IN 문 사용 파라미터 있는 커서 사용
DECLARE
    v_deptno DEPT.DEPTNO%TYPE;
    CURSOR C1 (P_DEPTNO DEPT.DEPTNO%TYPE) IS 
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = P_DEPTNO;
BEGIN
    --INPUT_DEPTNO 에 부서번호 입력 받고 V_DEPTNO 에 대입
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
     
    DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT);
    
    IF(SQL%FOUND) THEN 
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재여부: TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재여부: FALSE');
    END IF;
    
    IF(SQL%ISOPEN) THEN
         DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부: TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부: FALSE');
    END IF;
END;
/

--예외처리:
-- 오류가 발생해도 프로그램이 비정상 종료되지 않도록 하는 처리

DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG  --VALUE 에러
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
            DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');
END;
/
--18-10 예외 발생 후에 코드 실행 여부
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG 
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 이문장은 실행되지 않습니다.');
     
    EXCEPTION
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');
END;
/

--예외 이름
/*
DUP_VAL_ON_INDEX : UNIQE 인덱스가 있는 열에 중복 값을 저장 시
NO_DATA_FOUND : DELECT INTO 문에서 결과 행이 하나도 없을 경우
VALUE_ERROR : 산술, 변환 잘림, 제약 조건 오류가 발생 시
TOO_MANY_ROWS : SELECT INTO 문의 결과 행이 다중행 출력 시

*/
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG 
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 이문장은 실행되지 않습니다.');
     
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 요구보다 많은 행 추출 오류 발생');
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류 발생');
END;
/
--18-11
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG 
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 이문장은 실행되지 않습니다.');
     
    EXCEPTION        
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류 발생');
            DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/
---중간문제----------------------------------------------------------------------
--문제 5 ) 1부터 숫자중 홀수 10개만 출력하기
--(IF  조건문 없이 
--반복문  BASIC LOOP 와 WHILE LOOP 각각의 방법으로 출력해보세요)
--0
--기본 LOOP
DECLARE
    V_NUM NUMBER := 1;      --초기식
    V_CNT NUMBER := 1;
BEGIN
    LOOP
        EXIT WHEN V_CNT > 10; --조건식       
        DBMS_OUTPUT.PUT_LINE(V_NUM);
        V_NUM := V_NUM + 2;
        V_CNT := V_CNT + 1;
    END LOOP;
END;
/
--WHILE
DECLARE
    V_NUM NUMBER := 1;      --초기식   
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


--문제6) 사원테이블에서 30 번 부서인 사원의 사원번호, 이름, 직책 출력하기  (cursor 사용)
-- (v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job)
--1. 선언 OPEN   FETCH CLOSE      2. FOR   IN 
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
    FROM EMP;       --1 명시적 커서 선언
    
    
BEGIN
    OPEN C1;    --2커서 열기
    LOOP
    FETCH C1 INTO LOOP_EMP;     --3커서 패치사용
        EXIT WHEN C1%NOTFOUND;
    
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' || LOOP_EMP.EMPNO
        || ', ENAME : ' || LOOP_EMP.ENAME
        || ', JOB : ' || LOOP_EMP.JOB
        || ', SAL : ' || LOOP_EMP.SAL
        || ', DEPTNO : ' || LOOP_EMP.DEPTNO
        );        
    END LOOP;
    CLOSE C1;       --커서 닫기
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
    SELECT ENAME INTO V_WRONG   --INTO 단일행 결과만 대입 받을수 있음
      FROM EMP
     WHERE EMPNO = 7369;  
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
    
    EXCEPTION 
        WHEN OTHERS THEN  -- EXCEPTION WHEN NO_DATA_FOUND THEN
        
            DBMS_OUTPUT.PUT_LINE('오류가 발생 하였습니다.'|| 
                    TO_CHAR(SYSDATE, '[YYYY"년"MM"월"DD"일"HH24"시"MI"분"SS"초"]'));
            DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

