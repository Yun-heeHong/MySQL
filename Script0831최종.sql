-- select : 조회할 때 사용
-- select :<컬럼이름> from <테이블 이름>
select ename from emp
-- 사원이름, 번호조회
-- 1개 이상 컬럼을 조회할 때는 ,(콤마) 사용
select ename, empno from emp
-- 사원번호, 사원이름, 직책 조회
select empno ,ename, job from emp
-- as (별칭)
select ENAME as '사원이름', EMPNO as '사원번호' from emp
-- 모든 컬럼조회 *(아스테리스크)
select * from emp
-- where (필터링)
-- 20번 부서 사원 모두 조회
-- 쿼리순서 : 1.from 2.where 3.select

select * from emp 
where sal <= '3000'

select * from emp where DEPTNO = 20
-- 문1. Job이 manager인 사원이름, 번호, 직책, 입사날짜 조회하시오.
select ename, empno, job, hiredate from emp where job = 'manager';
-- 문2. job이 manager, salesman인 사원번호, 사원이름 조회하시오.
-- or(||), and(&&)
select empno, ename from emp 
where job = 'manager' or job = 'salesman';
-- 문3. 사원이름이 ALLEN인 사원의 이름, 직책, 입사날짜 조회
select ename, job, hiredate from emp where ename = 'ALLEN';
-- 사원이름이 A로 시작하는 사원의 이름, 사원번호 조회
-- like : 특정 단어를 검색할 수 있다.
select ename, empno from emp where ename like 'A%';
-- 사원이름에 L이 두번 들어간 사원이름, 번호 조회

select e.ENAME, e.JOB, d.DNAME, d.LOC 
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
where e.ename like 'A%';

select ENAME, MGR, EMPNO 
from emp 

select ename, empno from emp  where ename like '%L%L%';
-- 보너스를 받지 못한 사원의 급여와 번호를 조회
-- null사원
select sal, empno from emp where comm is null;
-- null 아닌사원
select sal, empno from emp where comm is not null;
-- 입사날짜가 1987-06-28 이상인 사원이름, 번호, 직책 조회
-- >=, <=, <, >
select ENAME, EMPNO, JOB from emp where HIREDATE >= '1987-06-28';
-- 입사일이 1980-12-17 ~ 1982-01-23 사이에 입사한
-- 문4. 사원이름, 번호, 입사날짜, 직책을 조회하시오.
select ENAME, EMPNO,HIREDATE, JOB from EMP 
where HIREDATE > '1980-12-17' and HIREDATE < '1982-01-23';
-- 문5. 직업이 MANAGER고, 급여가 1300이상 받는 사원번호, 이름, 급여, 직업 조회
select EMPNO as '사원번호', ENAME, SAL, JOB from EMP 
where JOB = 'MANAGER' and SAL >= 1300;

-- AVG, COUNT, MAX, MIN 함수(단일행 함수)
-- 직업이 manager인 사원들의 급여 평균 조회
select avg(sal) as '급여평균', job from emp where job = 'manager'
-- 직업이 CLERK인 사원수 조회
select count(EMPNO) from emp where job = 'clerk'
select max(sal) from emp where job = 'clerk'
select min(sal) from emp where job = 'clerk'
-- 문6. 입사날짜가 '1987-06-28'이상인 사원들의 수와 급여평균 조회
select count(EMPNO), avg(sal) from emp where HIREDATE >= '1987-06-28'
-- 문7. 직책이 'manager'가 아닌 사원이름, 직책 조회 
select ENAME, JOB from EMP where JOB != 'manager'
-- 문8. 사원이름이 'SCOTT', 'JONES'인 사원이름, 번호, 급여, 입사날짜 조회
select ENAME ,EMPNO ,SAL ,HIREDATE from emp 
where ENAME = 'SCOTT' or ENAME ='JONES'--방법1
select ENAME ,EMPNO ,SAL ,HIREDATE from emp 
where ENAME in('SCOTT','JONES') --방법2

select e.ENAME, e.JOB, e.SAL , d.DNAME 
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
where d.COMM != null

-- 08.30(화)
-- group by : 특정 컬럼을 그룹핑 하는 SQL 문법
-- job 별로 group by하기
-- group by할 컬럼을 select에도 써주자!
select job as '직책 그룹핑' from emp group by job
-- 입사날짜로 group by 
select HIREDATE as '입사날짜' from emp group by HIREDATE 
-- 입사날짜를 년도별로 group by 
-- date_format() SQL 내장함수, 날짜를 원하는대로 포맷팅 해줌.
-- %Y : year(년도), %M : month(월), %d : day(일)
select date_format(HIREDATE,'%Y') as '입사년도', count(EMPNO) as '사원수' from emp group by date_format(HIREDATE,'%Y')
-- 문제. 부서별로 그룹핑하고 부서인원수도 출력하시오.
select DEPTNO as '부서별', count(EMPNO) as '부서인원수' from emp group by DEPTNO 
-- 20번 부서를 제외한 나머지 부서 그룹핑!
select DEPTNO from emp where DEPTNO != 20 group by DEPTNO 
-- having : group by된 결과를 필터링할 때 사용
-- where : 필터링
-- where조건 안쓰고 having으로 사용하기
-- having과 where 차이점
-- 1. SQL 실행숭서가 다르다.
-- 2. where 조건에 집계함수(count, max, min, avg, sum ..)으로 비교 불가능
-- 3. having은 집계함수 비교 가능
select sal from emp having sal > 2000
select DEPTNO as '부서번호', count(EMPNO) as '사원 수' 
from emp group by DEPTNO having count(EMPNO)>=4
-- group by된 결과를 필터링하고 싶을 때 사용
-- 문1. 부서별로 급여합계를 그룹핑하시오.
select DEPTNO ,sum(SAL) as '부서별급여합계' from emp group by DEPTNO 
select DEPTNO ,sum(SAL) as '부서별급여합계'
from emp 
group by DEPTNO 
-- 문2. 문제 1번에서 급여합계가 5000 이상인 부서만 조회
select DEPTNO, sum(SAL) as '부서별급여합계' from emp group by DEPTNO having sum(sal)>=5000
-- 문3. 문제 2번에서 10번 30번 부서 제외
select DEPTNO, sum(SAL) as '부서별급여합계' from emp 
where DEPTNO=20 group by DEPTNO having sum(sal)>=5000
-- 문4. 입사날짜를 월별로 그룹핑하고 월별 입사자 수를 출력하시오.
select count(ENAME) as '입사 사원수', date_format(HIREDATE,'%M') as '입사 월' 
from emp group by date_format(HIREDATE, '%M')  

-- 문5. 직책별로 그룹핑하고 평균급여를 조회하고, 평균급여가 1000 이 넘는
-- 직책만 출력하시오. 단) 직책이 manager는 제외
select job, avg(sal) from emp where job !='manager' group by job having avg(sal)>1000
-- 문6. 1982년도에 입사한 모든 사원의 정보 조회
select * from emp where date_format(HIREDATE, '%Y')=1982
-- 문7. 급여가 1500 ~ 2850 사이의 범위에 속하는 사원이름, 급여, 직책 조회
select ENAME, sal, job from emp where sal>=1500 and sal<=2850
-- order by : 특정 컬럼을 정렬할 때 사용 (항상 마지막에 실행)
-- 아래 쿼리는 오름차순 (디폴트값)
select ename, sal from emp order by sal
select DEPTNO ,sum(SAL) as '부서별급여합계' 
from emp 
group by DEPTNO 
order by sal desc
-- 아래 쿼리는 내림차순
select ename, sal from emp order by sal desc
-- 컬럼위치로 정렬하기
-- order by는 항상 마지막에 실행되기 때문에 select 컬럼 순서를 알고 있다.
select ename, sal from emp order by 2 desc
-- 총정리
select deptno, count(empno), sum(sal), avg(sal)  
from emp
where deptno != 10
group by DEPTNO 
having count(empno) >= 3
order by count(EMPNO) desc

select e.EMPNO, e.ENAME, e.SAL, e.JOB, d.DNAME
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
where e.JOB = 'MANAGER' or e.JOB = 'CLERK' and
date_format(HIREDATE, '%Y')=1982;
## delete, update, insert
-- delete (데이터 삭제)
-- 삭제할 때는 where조건으로 삭제하자
delete from emp;
-- truncate 테이블안에 있는 데이터를 초기화
truncate table emp;
-- commit(완전저장), rollback(이전상태로 돌아가기)
select * from emp
-- auto commit을 해제하면 rollback(뒤 돌아가기)으로 돌아갈 수 있음
-- auto commit이 설정되어 있으면 rollback 명령이 불가능!
rollback
-- join****
-- 관계형 데이터베이스(MySQL, Oracle, Tibero)
-- 를 사용하면 join은 무조건 사용한다.
-- depno : 부서번호,dname : 부서이름,loc : 부서위치
-- 조인은 컬럼 이름이 같다고 해서 되는게 아니라, 데이터타입이 서로 같아야 한다.
-- 컬럼이름이 같은 이유는 사용자(개발자) 편의성을 위해서 같게 해준다.
-- join 문법
-- 테이블 이름에도 as를 사용할 수 있다.
-- 방법1.
select e.ENAME, e.DEPTNO , d.DNAME from emp as e
inner join dept as d 
on e.DEPTNO = d.DEPTNO 
-- 방법2.(추천x)
-- where 조건으로도 사용할 수 있지만
-- where가 나온 목적은 연산자(비교)를 이용해서 필터링을 하는게 목적이다.
-- 때문에 아래 방법보다는 방법 1로 join을 사용하자.
select e.ENAME, e.DEPTNO , d.DNAME from emp as e,
dept as d
where e.DEPTNO = d.DEPTNO  

-- 사원번호가 7788인 사원의 이름,직책,부서번호,부서이름,근무지역을 조회하시오.
-- 조인 팁 : 두 테이블 교집합 컬럼을 찾자!
select e.ENAME, e.JOB , e.EMPNO , d.DEPTNO , d.LOC 
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
where e.EMPNO = 7788
-- 부서 근무지가 NEW YORK이고, 직책이 MANAGER인 사원의 이름, 급여를 조회. 
select e.ENAME, e.SAL
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
where e.JOB = 'MANAGER' and d.LOC = 'NEW YORK';

select e.ENAME, e.SAL , d.LOC 
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
where d.DNAME = 'RESEARCH'

-- 부서별로 그룹핑을 하고 부서번호와 부서이름을 조회하시오.
-- join문법은 from과 where 사이에 온다.
select e.DEPTNO , d.DNAME 
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
group by e.DEPTNO 

-- 직책이 manager인 사원들의 이름, 부서이름, 부서위치를 조회하시오.
select e.ENAME as '사원이름', d.DNAME as '부서이름' , d.loc as '부서위치'
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
where e.job = 'manager'
-- inner join(교집합)에서 순서는 상관없지만
-- right join(차집합)과 left join은 상관있다.
select d.DNAME ,sum(e.SAL) as '부서별급여합계' 
from emp as e right join dept as d
on d.DEPTNO = e.DEPTNO
group by e.DEPTNO 
order by e.sal desc

select 
underling.ENAME as '사원이름',
underling.hiredate as '사원입사일',
boss.ENAME as '상사이름',
boss.hiredate as '상사입사일'
from emp as boss
inner join emp as underling
on boss.EMPNO = underling.MGR 
where boss.hiredate>underling.hiredate;

select * from dept as d
inner join emp as e 
-- left join(차집합), right join(차집합) : 아우터(outer) 조인
-- 40번 부서만 조회
select * from dept where DEPTNO = 40;
-- emp테이블에 없는 부서번호 조회
select * from emp as e right join dept as d 
on d.DEPTNO = e.DEPTNO 
where e.EMPNO is null        
-- self join (inner join하고 같음)
-- 그러나 자기 자신을 조인함 즉, 1개 테이블을 사용
-- boss: 상사, underling: 부하
select 
	boss.empno as '상사번호',
	boss.ENAME as '상사이름',
	underling.EMPNO as '부하직원번호',
	underling.ENAME as '부하직원이름'
from emp as boss
inner join emp as underling 
on boss.EMPNO = underling.MGR

select 
underling.ENAME as '사원명',
boss.empno as '사수번호',
boss.ENAME as '사수이름'
from emp as boss
inner join emp as underling 
on boss.EMPNO = underling.MGR 
where underling.MGR is null;

select 
underling.ENAME as '사원명',
boss.empno as '사수번호',
boss.ENAME as '사수이름'
from emp as boss
inner join emp as underling
on boss.EMPNO = underling.MGR 
where underling.MGR != NULL;

select 
underling.ENAME as '사원명',
boss.empno as '사수번호',
boss.ENAME as '사수이름'
from emp as boss
right join emp as underling 
on boss.EMPNO = underling.MGR 

select 
underling.ENAME as '사원이름',
underling.empno as '사원번호',
boss.empno as '상사번호',
boss.ENAME as '상사이름'
from emp as boss
inner join emp as underling
on boss.EMPNO = underling.MGR 
where boss.empno = '7698';

delete from emp

--emp에 insert 하기
insert into emp (empno, ENAME, JOB, sal, HIREDATE)
values (8000, '손흥민','SALESMAN', 6000, now());
-- 문제. 아우터 조인(left or right) 이용하기
-- 부서에 소속되어 있지 않는 사원번호, 이름, 입사날짜 조회 
-- 결과 흥민 손! 쏘니!
select * from emp as e left join dept as d 
on d.DEPTNO = e.DEPTNO 
where d.Dname is null
-- 사원번호가 8000인 사원의 급여를 8000으로 업데이트 하시오.
-- update 는 from을 명시하지 않는다.
-- delete from을 써준다.
update emp
set sal = 8000
where empno = 8000

insert into emp (empno, ENAME, JOB, sal, HIREDATE)
values (8200, 'SAM','MANAGER', 7500, now());

update emp
set sal = 8500
where empno = 8200

select * from dept
-- outer join
select * from emp as e right join dept as d
on e.deptno=d.deptno
where e.empno is null
-- self join-- junior : 사원, senior : 사수
select 
     junior.empno as "부하번호",
     junior.ename as "부하이름",
     senior.empno as "사수번호",
     senior.ename as "사수이름",
from emp as junior
inner join emp as senior
on junior.mrg = senior.empno
-- SQL 순서
-- 1. from (join) 2. where 3. group by 4. having 5. select 6. order by
-- delete from emp  -- update
null   'null' 다름 is null ,is not null
--pk는 중복불허용
--fk는 중복 가능함
insert into dept (deptno, dname, loc)
value (60, 'DW아카데미', '대전 선화동')
-- 위 SQL은 dept 테이블에 20번 부서가 이미 있으므로 에러 발생!
select 
underling.ENAME as '사원명',
boss.empno as '사수번호',
boss.ENAME as '사수이름'
from emp as boss
right join emp as underling
on boss.EMPNO = underling.MGR
where underling.MGR is NULL

select 
underling.ENAME as '사원이름',
boss.ENAME as '상사이름',
underling.deptno as '사원부서번호',
underling.dname as '사원부서명',
underling.loc as '사원근무지역'
from emp as boss
inner join emp as underling

select ifnull(e.comm,100),e.EMPNO, d.DNAME, e.JOB
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 
where date_format(HIREDATE, '%Y')>=1983;

select date_format(HIREDATE,'%M') as '입사날짜', 
count(EMPNO) as '사원수' 
from emp 
group by date_format(HIREDATE,'%M')








