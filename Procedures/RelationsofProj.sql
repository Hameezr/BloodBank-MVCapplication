create table [Donor](

[cnic] BIGINT,
primary key(cnic),
check (cnic>1000000000000 AND cnic<=8000000000000),

[password] varchar(16),

[name] varchar(30) not null,

[age] int not null,
check (age >= 18),

[phoneno] BIGINT unique not null,
check (phoneno >=03000000000 AND phoneno <=03559999999),

[block] varchar(20) not null,

city varchar(20) not null,

[address] varchar(50) not null,

bloodtype varchar(4) not null,
check (bloodtype='A+' or bloodtype='A-' or bloodtype='B+' or bloodtype='B-' or bloodtype='O+' or bloodtype='O-' or bloodtype='AB+' or bloodtype='AB-'),

requestmade int default 0 not null,

requestaccpted int default 0 not null,

[status] int default 0 not null,	--0=active,1=Inactive,2=Banned,

cnicflag bit not null,

quantity int default 0 not null,

Lastdonateddate date,
)

go
create table bannedLoginDonor
(
	cnic bigint primary key,
	bantime datetime,
	foreign key (cnic) references Donor(cnic) on update cascade on delete cascade
);
create table DonorLoginAttempts(
	attemptId int not null identity(1,1) primary key,
	cnic bigint not null ,
	foreign key (cnic) references Donor(cnic) on update cascade on delete cascade,
	attemptTime datetime 

);

create table [RECIEVER](
[cnic] bigint,
primary key(cnic),
check (cnic>1000000000000 AND cnic<=8000000000000),

[password] varchar(16),
[name] varchar(30) not null,

[phoneno] BIGINT unique not null,
check (phoneno >=03000000000 AND phoneno <=03559999999),

[address] varchar(50) not null,

[status] int not null,--0-allowed to search,1-banned,2-Left

starttime datetime,

);

create table userLoginAttempts(
	attemptId int not null identity(1,1) primary key,
	cnic bigint not null,
	foreign key (cnic) references RECIEVER(cnic) on update cascade on delete cascade,
	attemptTime datetime 

);
create table bannedLoginReceiver
(
	cnic bigint primary key,
	bantime datetime,
	foreign key (cnic) references Reciever(cnic) on update cascade on delete cascade
);

create table [BLOODBANK](
	Id int primary key identity(1,1),

	[name] varchar(50) unique not null,
	[password] varchar(16) not null,
	hospitalname varchar(30) unique not null,
	
	[block] varchar(20) not null,
	
	city varchar(20) not null,
	
	[address] varchar(50) not null,

	inboxstatus bit not null,
)

create table [BLOODBANKDATA](
	[id] int primary key foreign key references BLOODBANK([id]),
	[A-] int not null,
	[A+] int not null,
	[B+] int not null,
	[B-] int not null,
	[O+] int not null,
	[O-] int not null,
	[AB+] int not null,
	[AB-] int not null,
)

create table [MESSAGES](
	msgid int primary key identity(1,1),

	sendername varchar(50) foreign key references BLOODBANK([name]) on update cascade on delete no action,--sender name

	msg varchar(200) not null,
)
create table [BLOODBANKCONTACTS](
Id int foreign key references BLOODBANK(Id),

[phoneno] BIGINT unique not null,
check (phoneno >=10000000 AND phoneno <=99999999999),

primary key (Id,phoneno)
);

create table [BLOODBANKMESSAGES](
	senderid int foreign key references BLOODBANK([id]) on update cascade on delete no action,
	
	msgid int primary key identity(1,1),
	
	msg varchar(200) not null
);

create table [MESSAGERECIEVERS](
	[recievername] varchar(50) foreign key references BLOODBANK([name]),

	msgid int foreign key references BLOODBANKMESSAGES(msgid) on update cascade on delete no action,

	primary key (recievername,msgid)
);

-----------------------------------------------------------------------------------------------------------------

create table[RECIEVERSEARCHRECORD](
	cnic bigint foreign key references RECIEVER([cnic]) on update cascade on delete cascade,

	bloodtype varchar(4) unique not null,
	check (bloodtype='A+' or bloodtype='A-' or bloodtype='B+' or bloodtype='B-' or bloodtype='O+' or bloodtype='O-' or bloodtype='AB+' or bloodtype='AB-'),

	primary key (cnic,bloodtype)
)
create Table [BANNEDRECIEVER](
cnic bigint primary key foreign key references RECIEVER([cnic]) on update cascade on delete cascade,

starttime datetime,

banduration datetime,
);

