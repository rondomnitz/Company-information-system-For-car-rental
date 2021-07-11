create table branch (
	bno int,
	baddress varchar(50),
	mid int,
	primary key (bno)
);

create table worker (
	wid int,
	wname varchar (20),
	waddress varchar (50),
	bno int references  branch,	
	primary key (wid)
);
create table car (
	lno numeric (8, 0),
	myear numeric (4,0),
	comp varchar(20),
	doors int check (doors > 0),
	shift int check (shift <=1 and shift >=0),
	boot int,
	seats int,	
	primary key (lno)
);

create table client (
	cid int,
	cname varchar(20),
	address varchar(50),
	credit numeric (4,0),
	byear numeric (4,0),
	primary key (cid)
);

create table request (
	cid int,
	rno int,
	days int check (days > 0),
	doors int check (doors > 0),
	shift int check (shift <=1 and shift >=0),
	boot int not null,
	seats int check (seats > 0),
	wid int references worker,	
	primary key (cid, rno)
);

create table rent (
	cid int,
	rno int,
	lno int,
	fdate date,
	tdate date,
	wid int references worker,
	amount float,	
	
	primary key (cid, rno, lno),
	foreign key (cid, rno) references request,
	foreign key (lno) references car
)