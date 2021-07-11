--1
select distinct cid, request.rno
from request, worker, branch
where wname = 'dan cohen' and worker.bno = branch.bno and
	  waddress like '%ramat gan%' and
	  request.wid=worker.wid;

--2
select cid,rno
from rent
where amount =(
		select max(rent.amount)
		from rent
		);
--3
select rent_2020.cname
from rent natural join client as rent_2020
where DATE_PART('year', tdate)=2020
group by rent_2020.cid
having SUM (amount) >= ALL(select SUM(rent.amount)
						   from rent
        				   where DATE_PART('year', rent.tdate)=2020
						   group by cid);

--4
select bno
from worker,request
where worker.wid=request.wid AND seats>5
group by bno
having count (distinct worker.wid) >= 3;
--5
select distinct client.cname
from client 
join request
    on client.cid = request.cid
join rent
    on request.cid = rent.cid
join car
    on rent.lno = car.lno
where request.shift <> car.shift;
--6
select wid, count (wid)
from worker natural join rent
where wid not in (
					select wid
					from request)
group by wid
having count (wid) >= all (
							select count (wid)
							from worker natural join rent
							where wid not in (
											 select wid
											 from request)
							group by wid);
							
--7
select request.rno, request.cid
from request 
	join rent on request.cid = rent.cid and request.rno = rent.rno 
	join car on rent.lno = car.lno
group by request.cid, request.rno
having count (distinct comp) = (select count (distinct comp)
			   					from car);