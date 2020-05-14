go
create proc getDonInfo
@cnic bigint,
@output int output
as
begin
	begin try
		select * from Donor where cnic=@cnic
		set @output=0 ;   --found req Donor
	end try
	begin catch
		set @output=1; --something went wrong
	end catch
end


go
create proc checkDonLoginAttempts
@cnic bigint,
@password varchar(16),
@result int output
as
begin
	if(exists(select * 
		 from Donor 
		 where cnic=@cnic and @password=[password] ))	
		 begin
				if(not exists(select *  from Donor  where cnic=@cnic and @password=[password] and [status]=3))
				begin
					set @result=0
				end

				else
				begin
					if(exists(select *from bannedLoginDonor BLR where BLR.cnic=@cnic and DATEDIFF(minute, bantime,GETDATE())<2))
						begin
								set @result=1 --user is banned
							
						end
						else
						begin
						set @result=3    --pass incorrect
							update Donor set [status]=0 where cnic=@cnic 
							delete from bannedLoginDonor where cnic=@cnic
							insert into DonorLoginAttempts values(@cnic,GETDATE());
							return
						end
				end
		 end
	else
		begin
			if(exists(select *  from Donor  where cnic=@cnic  ))   --cnic exists 
			begin 
				if(not exists(select *  from Donor  where cnic=@cnic and [status]=3))
				begin
					delete from DonorLoginAttempts where @cnic=cnic and DATEDIFF(minute, attemptTime,GETDATE())>=1
					if(exists(select cnic,count(*) from DonorLoginAttempts where cnic=@cnic group by cnic having count(*)>=5)) --its time to ban user
					begin
							update Donor set [status]=3 where cnic=@cnic 
							insert into bannedLoginDonor values(@cnic,getdate());
							set @result=4; --user has been banned
							return
				
					end

					else   --insert user into wrong attempts table
					begin
						insert into DonorLoginAttempts values(@cnic,GETDATE());
						set @result=3 --pass incorrect
						return 

					end
				end
				else
				begin
					if(exists(select *from bannedLoginDonor BLR where BLR.cnic=@cnic and DATEDIFF(minute, bantime,GETDATE())<2))
						begin
								set @result=1 --user is banned
							
						end
						else
						begin
						set @result=3    --pass incorrect
							update Donor set [status]=0 where cnic=@cnic 
							delete from bannedLoginDonor where cnic=@cnic
							insert into DonorLoginAttempts values(@cnic,GETDATE());
							return
						end
				end
			end
			else
			begin
				set @result=5  --cnic invalid/does not exist
			end
		end	
end



-------------Login Checks-------------------


create procedure updateCnic
@oldcnic bigint,
@newcnic bigint,
@output int output
as 
begin
	if(exists(select *from [Donor] where cnic=@oldcnic))
	begin
		update [Donor]
		set cnic=@newcnic
		where cnic=@oldcnic
		set @output=0
	end
	else
	begin
		
		set @output=1
	end
end


create procedure updateDonPhone
@oldcnic bigint,
@phoneno int,
@output int output
as 
begin 
	
		if(not exists(select *from [Donor] where phoneno=@phoneno and [cnic]!=@oldcnic))
		begin
			update	[Donor]
			set phoneno=@phoneno
			where cnic=@oldcnic
			set @output=0
		end
		else
		begin

			set @output=1
		end

end

go
create procedure updateDonCity
@oldcnic bigint,
@City varchar(20),
@output int output

as 
begin 
		if(exists(select * from [Donor] where [cnic]=@oldcnic))
			begin
		
				update	[Donor]
				set city=@City
				where cnic=@oldcnic
				set @output=0
			end
		else
		begin
			set @output=1;
		end

end
go
create procedure updateDonAge
@oldcnic bigint,
@age int,
@output int output
as 
begin 
	if(exists(select * from [Donor] where [cnic]=@oldcnic))
		begin
			update	[Donor]
			set age=@age
			where cnic=@oldcnic
		end
end



go
create procedure updateDonBlock
@oldcnic bigint,
@Block varchar(20),
@output int output
as 
begin 
	if(exists(select * from [Donor] where [cnic]=@oldcnic))
		begin
		update	[Donor]
		set block=@Block
		where cnic=@oldcnic
		set @output=0
		end
		else
		begin
			set @output=1
		end

end


go
create procedure updateDonAdd
@oldcnic bigint,
@add varchar(50),
@output int output
as 
begin 
	if(exists(select * from [Donor] where [cnic]=@oldcnic))
	begin
		update	[Donor]
		set [address]=@add
		where cnic=@oldcnic
		set @output=0
	end
	else
	
	begin
			set @output=1
	end
end

go
create procedure updateDonName
@oldcnic bigint,
@name varchar(20),
@output int output
as 
begin 
	
		if(exists(select * from [Donor] where cnic=@oldcnic))
		begin
		update	[Donor]
		set name=@name
		where cnic=@oldcnic
		set @output=0

		end

		else
		begin
		set @output=1
		end
end
go
create procedure signup
@cnic bigint,
@password varchar(16),
@name varchar(50),
@age bigint,
@phoneno bigint,
@block varchar(20),
@city varchar(20),
@add varchar(50),
@bloodtype varchar(5),
@status int output
as
begin
	if(@cnic<=9999999999999 and not exists(select * from [Donor] where cnic=@cnic or phoneno=@phoneno))
	begin
		if(@age>=18)
		begin
				if(@bloodtype='A+' or @bloodtype='A-' or @bloodtype='B+' or @bloodtype='B-' or @bloodtype='O+' or @bloodtype='O-' or @bloodtype='AB+' or @bloodtype='AB-')
				begin	
					insert into [Donor] values(@cnic,@password,@name,@age,@phoneno,@block,@city,@add,@bloodtype,0,0,0,0,1,getdate())
					set @status=0
				end
				else
				begin
					set @status=3
				end
		end
		else
		begin
			set @status=2
		end
	end
	else
		set @status=1
end
drop proc signup
declare @myoutput int
select *from Donor
select *from RECIEVER

insert into [Donor] values(3520211477175,'faizan11','Faizan Saleem',18,03214949166,'Samanabad','Lahore','19-Gulfishan Colony','O+',0,0,0,0,1,getdate())
insert into [Donor] values(3520211477176,'faizan11F','Faizan Saleem',18,03214969166,'Samanabad','Lahore','19-Gulfishan Colony','O+',0,0,0,0,1,getdate())
execute signup @cnic=3520211477172,
@name='Faizan',
@age=18,
@phoneno ='03214949154',
@block ='Samanabad',
@city ='lahore',
@add ='19 Gulfishan Colony',
@bloodtype ='O+',
@status=@myoutput output

select @myoutput
select *from Donor

go

create proc authLogin 
@cnic bigint,
@password varchar(16),
@output int output
as
begin
	if(exists(select * from Donor where cnic=@cnic and [password]=@password))
	begin
		set @output=0
	end	

	else
	begin
		set @output=1
	end

end
delete RECIEVER
select * from RECIEVER

go