--UNION
--두 쿼리문을 합칠 때 사용
--중복을 배제하고 나옴
--각각의 결과 컬럼 갯수가 동일해야 한다.

--PLAYER 테이블에서 포지션이 GK이면서 K02인 선수
--TEAM_ID로 정렬
SELECT * FROM PLAYER
	WHERE "POSITION" = 'GK'
UNION
SELECT * FROM PLAYER
	WHERE TEAM_ID = 'K02'
ORDER BY 3;

SELECT * FROM PLAYER
	WHERE "POSITION" = 'GK' OR TEAM_ID = 'K02';


--UNION ALL
--중복이 배제되지 않고 모두 나온다.
SELECT * FROM PLAYER
	WHERE "POSITION" = 'GK'
UNION ALL
SELECT * FROM PLAYER
	WHERE TEAM_ID = 'K02';
--------------------------------------------------------
--실습
--정남일 선수가 소속된 팀의 선수들 검색
SELECT * FROM PLAYER
	WHERE TEAM_ID = 
	(SELECT TEAM_ID FROM PLAYER
		WHERE PLAYER_NAME = '정남일');
	
--축구선수들 중 전체 평균키보다 작은 선수들 검색
--키 내림차순 정렬
SELECT * FROM PLAYER
	WHERE HEIGHT <
	(SELECT AVG(HEIGHT) FROM PLAYER)
ORDER BY HEIGHT DESC;

SELECT AVG(HEIGHT) FROM PLAYER;

--EMP테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC(DEPT테이블) 검색
SELECT * FROM DEPT D JOIN EMP E
ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME LIKE '%L%';

SELECT ENAME FROM EMP;

--JOB TITLE중 'Manager'라는 문자열이 포함된 직원들의 평균 연봉을
--JOB TITLE별로 검색
SELECT J.JOB_TITLE, AVG(E.SALARY) FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
WHERE J.JOB_TITLE LIKE '%Manager%'
GROUP BY JOB_TITLE;
--축구선수들 중 정현수가 소속된 팀의 선수들 검색(IN 사용)
--TEAM_ID값이 2개이므로 OR연산자 가능
SELECT * FROM PLAYER
	WHERE TEAM_ID IN
		(SELECT TEAM_ID 
			FROM PLAYER 
			WHERE PLAYER_NAME = '정현수');

--축구선수들 중에서 각 팀별 키가 가장 큰 선수들 검색(TEAM_ID로 정렬)
--(IN LINE VIEW) FROM절
SELECT * FROM PLAYER P1, 
(SELECT TEAM_ID, MAX(HEIGHT) MHEIGHT FROM PLAYER GROUP BY TEAM_ID) P2
WHERE P1.TEAM_ID = P2.TEAM_ID
AND P1.HEIGHT = P2.MHEIGHT
ORDER BY P1.TEAM_ID;

--위의 쿼리문을 (SUB-QUERY) WHERE절로 변경해서 같은 결과 나오게 하기
--WHERE절에서의 IN
--(A, B) IN (C, D) : A=C AND B=D
SELECT * FROM PLAYER
WHERE (TEAM_ID, HEIGHT) IN 
(SELECT TEAM_ID, MAX(HEIGHT) MHEIGHT FROM PLAYER GROUP BY TEAM_ID)
ORDER BY TEAM_ID;

--경기장 중 경기 일정이 20120501 ~ 20120502 사이에 있는 경기장 검색(IN, BETWEEN사용)
--A IN (B,C,D,E,F)
--A = B OR A = C OR.....
SELECT * FROM STADIUM
WHERE STADIUM_ID IN
(SELECT STADIUM_ID FROM SCHEDULE S
WHERE S.SCHE_DATE BETWEEN '20120501' AND '20120502');

--PLAYER테이블에서 생일이 NULL인 선수들을 정준 선수의 생일로 UPDATE하기
--(절대 COMMIT하지 않는다. 바로 결과 확인 후 ROLLBACK하기)
SELECT PLAYER_NAME, BIRTH_DATE 
FROM PLAYER 
WHERE BIRTH_DATE IS NULL;

UPDATE PLAYER
SET BIRTH_DATE = (SELECT BIRTH_DATE FROM PLAYER WHERE PLAYER_NAME = '정준')
WHERE BIRTH_DATE IS NULL;

--PLAYER 테이블에서 왕선재와 생일이 같은 선수들 TEAM_ID별로 검색하기
--TEAM_ID, PLAYER_NAME, BIRTHDAY 검색
SELECT TEAM_ID, PLAYER_NAME, BIRTH_DATE 
FROM PLAYER
WHERE BIRTH_DATE = 
(SELECT BIRTH_DATE FROM PLAYER
WHERE PLAYER_NAME = '왕선재')
GROUP BY TEAM_ID, PLAYER_NAME, BIRTH_DATE
ORDER BY TEAM_ID;

SELECT * FROM PLAYER;

--EMPLOYEES 테이블에서 Den의 전화번호 앞3자리와 같은 사원들
--JOB_ID별로 검색
--JOB_ID, PHONE_NUMBER, FIRST_NAME
SELECT JOB_ID, PHONE_NUMBER, FIRST_NAME FROM EMPLOYEES
WHERE PHONE_NUMBER 
LIKE ((SELECT SUBSTR(PHONE_NUMBER, 1, 3) FROM EMPLOYEES
WHERE FIRST_NAME = 'Den') || '%')
GROUP BY JOB_ID, PHONE_NUMBER, FIRST_NAME;

--EMP 테이블에서 JOB별 평균 급여를 반올림해서 정수로 검색하기
--JOB으로 정렬 
SELECT JOB 직종, ROUND(AVG(SAL)) 평균급여 FROM EMP
GROUP BY JOB
ORDER BY JOB;

--STADIUM 테이블에서 경기장 이름과 홈팀명 검색
--TEAM_ID, TEAM_NAME, STADIUM_NAME
SELECT NVL(T.TEAM_ID, '없음') "팀 번호", NVL(T.TEAM_NAME, '없음') "팀 이름"
, S.STADIUM_NAME "경기장 이름"
FROM STADIUM S LEFT OUTER JOIN TEAM T
ON S.HOMETEAM_ID = T.TEAM_ID
ORDER BY 1;














