create proc getRecInfo
@cnic bigint,
@output int output
as
begin
	begin try
		select * from RECIEVER where cnic=@cnic
		set @output=0 ;   --found req receiver
	end try
	begin catch
		set @output=1; --something went wrong
	end catch
end

create proc checkRecLoginAttempts
@cnic bigint,
@password varchar(16),
@result int output
as
begin
	if(exists(select * 
		 from RECIEVER 
		 where cnic=@cnic and @password=[password] ))	
		 begin
				if(not exists(select *  from RECIEVER  where cnic=@cnic and @password=[password] and [status]=3))
				begin
					set @result=0
				end

				else
				begin
					if(exists(select *from bannedLoginReceiver BLR where BLR.cnic=@cnic and DATEDIFF(minute, bantime,GETDATE())<2))
						begin
								set @result=1 --user is banned
							
						end
						else
						begin
						set @result=3    --pass incorrect
							update RECIEVER set [status]=0 where cnic=@cnic 
							delete from bannedLoginReceiver where cnic=@cnic
							insert into userLoginAttempts values(@cnic,GETDATE());
							return
						end
				end
		 end
	else
		begin
			if(exists(select *  from RECIEVER  where cnic=@cnic  ))   --cnic exists 
			begin 
				if(not exists(select *  from RECIEVER  where cnic=@cnic and [status]=3))
				begin
					delete from userLoginAttempts where @cnic=cnic and DATEDIFF(minute, attemptTime,GETDATE())>=1
					if(exists(select cnic,count(*) from userLoginAttempts where cnic=@cnic group by cnic having count(*)>=5)) --its time to ban user
					begin
							update RECIEVER set [status]=3 where cnic=@cnic 
							insert into bannedLoginReceiver values(@cnic,getdate());
							set @result=4; --user has been banned
							return
				
					end

					else   --insert user into wrong attempts table
					begin
						insert into userLoginAttempts values(@cnic,GETDATE());
						set @result=3 --pass incorrect
						return 

					end
				end
				else
				begin
					if(exists(select *from bannedLoginReceiver BLR where BLR.cnic=@cnic and DATEDIFF(minute, bantime,GETDATE())<2))
						begin
								set @result=1 --user is banned
							
						end
						else
						begin
						set @result=3    --pass incorrect
							update RECIEVER set [status]=0 where cnic=@cnic 
							delete from bannedLoginReceiver where cnic=@cnic
							insert into userLoginAttempts values(@cnic,GETDATE());
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

go
create procedure updateRecName
@cnic bigint,
@name varchar(50),
@output int output
as 
begin
	if(exists(select * from [RECIEVER] where cnic=@cnic))
	begin
		update [RECIEVER]
		set name=@name
		where cnic=@cnic
		set @output=0
	end
	else
	begin
		set @output=1;
	end
end

go
create procedure updateRecPhone
@cnic bigint,
@phoneNo bigint,
@output int output
as 
begin
	if(exists(select * from [RECIEVER] where cnic=@cnic))
	begin
		update [RECIEVER]
		set phoneno=@phoneNo
		where cnic=@cnic
		set @output=0
	end
	else
	begin
		set @output=1;
	end
end


go
create procedure updateRecadd
@cnic bigint,
@add varchar(50),
@output int output
as 
begin
	if(exists(select * from [RECIEVER] where cnic=@cnic))
	begin
		update [RECIEVER]
		set [address]=@add
			where cnic=@cnic
		set @output=0
	end
	else
	begin
		set @output=1;
	end
end

go
create procedure updateRecCnic
@oldcnic bigint,
@newcnic bigint,
@output int output
as 
begin
	if(exists(select *from [RECIEVER] where cnic=@oldcnic))
	begin
		update [RECIEVER]
		set cnic=@newcnic
		set @output=0;
	end
	else

	begin
		set @output=1
	end
end

go
create procedure RecSignup
@cnic bigint ,
@password varchar(16),
@name varchar(30),
@phoneno bigint,
@address varchar(50),
@output int output
as
begin
	if((not exists(select * from [RECIEVER] where cnic=@cnic or phoneno=@phoneno)) and @cnic<=9999999999999)
	begin
		insert into [RECIEVER] values(@cnic,@password,@name,@phoneno,@address,0,NULL)
		set @output=0
	end
	else

	begin
		set @output=1

	end
end
drop proc RecSignup
select * from RECIEVER
delete RECIEVER
create procedure authRecLogin
@cnic bigint,
@password varchar(16),
@output int output
as
begin
	if(exists(select * from [RECIEVER] where cnic=@cnic and [password]=@password))
	begin
		set @output=0
	end
	else
	begin
		set @output=1
	end
end

go
create Procedure RecDonSearch --output the table of donor
@bloodtype varchar(4),
@city varchar(50),
@block varchar(20),
@output int output
as
begin
	begin try
	
	select name,phoneno,bloodtype from [Donor] where bloodtype=@bloodtype and city=@city and block=@block
	set	@output=0
	end try

	begin catch
	set	@output=1;
	end catch;
end

create Procedure RecBBSearch
@bloodtype varchar(4),
@city varchar(50),
@block varchar(20),
@output int output
as
begin
	
	if(exists(select *
				from (select BB.Id,BB.name,BB.hospitalname,BB.[address],BB.block,BB.city from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city 
				
				 ))
	Begin
		if(@bloodtype='A+')
		begin
			if(exists(
			select *
				from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[A+] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city and hey.[A+]>0 ))

				begin
					
					select *
					from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[A+] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
					where hey.block=@block and hey.city=@city and hey.[A+]>0 
					set @output=0
				end
			else
				
			begin
				set @output=1
			end
							
		end
			else if(@bloodtype='AB+')

				
		begin
			if(exists(
			select *
				from (select BB.Id,BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[AB+] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city and hey.[AB+]>0 ))

				begin
					select *
					from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[AB+] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
					where hey.block=@block and hey.city=@city and hey.[AB+]>0 
					set @output=0
				end
			else
				
			begin
				set @output=1
			end


		end
			else if(@bloodtype='A-')
		begin
				if(exists(
			select *
				from (select BB.Id,BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[A-] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city and hey.[A-]>0 ))

				begin
					select *
					from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[A-] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
					where hey.block=@block and hey.city=@city and hey.[A-]>0 
					set @output=0
				end
			else
				
			begin
				set @output=1
			end
		end
			else if(@bloodtype='B+')
		begin

			if(exists(
			select *
				from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[B+] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city and hey.[B+]>0 ))

				begin
					select *
					from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[B+] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
					where hey.block=@block and hey.city=@city and hey.[B+]>0 
					set @output=0
				end
			else
				
			begin
				set @output=1
			end


		end
			else if(@bloodtype='AB-')
		begin
				if(exists(
			select *
				from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[AB-] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city and hey.[AB-]>0 ))

				begin
					select *
					from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[AB-] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
					where hey.block=@block and hey.city=@city and hey.[AB-]>0 
					set @output=0
				end
			else
				
			begin
				set @output=1
			end
		end
			else if(@bloodtype='B-')
		begin
				if(exists(
			select *
				from (select BB.Id,BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[B-] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city and hey.[B-]>0 ))

				begin
					select *
					from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[B-] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
					where hey.block=@block and hey.city=@city and hey.[B-]>0 
					set @output=0
				end
			else
				
			begin
				set @output=1
			end
		end
		
			else if(@bloodtype='O+')
		begin
				if(exists(
			select *
				from (select BB.Id,BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[O+] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city and hey.[O+]>0 ))

				begin
					select *
					from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[O+] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
					where hey.block=@block and hey.city=@city and hey.[O+]>0 
					set @output=0
				end
			else
				
			begin
				set @output=1
			end
		end
			else if(@bloodtype='O-')
		begin
			if(exists(
			select *
				from (select BB.Id,BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[O-] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
				where hey.block=@block and hey.city=@city and hey.[O-]>0 ))

				begin
					select *
					from (select BB.name,BB.hospitalname,BB.[address],BB.block,BB.city,BBD.[O-] from [BLOODBANK] BB join [BLOODBANKDATA] BBD on BBD.id=BB.id ) as hey
					where hey.block=@block and hey.city=@city and hey.[O-]>0 
					set @output=0
				end
			else
				
			begin
				set @output=1
			end
		end



	end
	else
	begin 
		set @output=2
	end

end
drop proc RecBBSearch
declare @myout int
execute RecBBSearch @bloodtype='O+',
@city='Lahore',
@block='Faisal Town',
@output=@myout output

select @myout

select * from [BLOODBANK]


go
create procedure authRecSearchHist
@cnic bigint,
@bloodtype varchar(4),
@city varchar(50),
@block varchar(20),
@moutput int output,
@moutput2 int output
as
begin
	if(not exists(select * from [RECIEVER] where cnic=@cnic and [status]=1))
	begin
		declare @flag int
		set @flag=-1
		if(exists(select *from [RECIEVER] where cnic=@cnic))
		begin
			if(exists(select *from [RECIEVER] where cnic=@cnic and starttime is null))
				begin
					update [RECIEVER]
					set starttime=getdate()
					where cnic=@cnic;
					
				end
		
			if(exists(select R.cnic,count(*) from [RECIEVERSEARCHRECORD] RSR join [RECIEVER] R on R.cnic=RSR.cnic
			 where R.cnic=@cnic and DATEDIFF(MINUTE,R.starttime,getdate())<=60	 group by R.cnic having count(*)>4))
			begin
				update [RECIEVER]
				set [status]=1
				where cnic=@cnic
				update [RECIEVER]
				set [starttime] = null
				where cnic=@cnic
				delete from [RECIEVERSEARCHRECORD]
				where cnic=@cnic
				insert into BANNEDRECIEVER values(@cnic,getdate(),DATEADD(DAY, DATEDIFF(day, 0, getdate()), 1))
				set @flag=1;
				set @moutput=1
			end
			if(@flag!=1)
			begin
				if(not exists(select * from [RECIEVERSEARCHRECORD] where cnic=@cnic and bloodtype=@bloodtype))
				begin	
						insert into RECIEVERSEARCHRECORD values(@cnic,@bloodtype)
				end
				if(exists(select * from [RECIEVERSEARCHRECORD] where cnic=@cnic and bloodtype=@bloodtype))
				begin
						execute RecBBSearch 
						@bloodtype,
						@city,
						@block,
						@output=@moutput2 output
						if(@moutput2=0)
							begin
							set @moutput=0
							end
						else
							begin
								set @moutput=2
							end
						Print 'inside func'
				end
				/*@output=@moutput output*/
			end
		end
		else
		begin
			set @moutput=3
		end
	end
	else
	begin
		if(exists(select * from BANNEDRECIEVER where cnic=@cnic and banduration<getdate()))
		begin
			delete from [BANNEDRECIEVER] where cnic=@cnic
			delete from [RECIEVERSEARCHRECORD] where cnic=@cnic
						update [RECIEVER]
				set [starttime] = null,
				[status]=0
				where cnic=@cnic
				Print 'i am in it'
			execute authRecSearchHist @cnic=@cnic,
			@bloodtype=@bloodtype,
			@city=@city,
			@block=@block,
			@moutput=@moutput output,
			@moutput2=@moutput2 output
			if(@moutput2=0)
				
			return
			
		end
		else
		begin	

		set @moutput=-4
		set @moutput2=-4
		end
	end
end
drop proc authRecSearchHist

declare @myout int
declare @myout2 int
execute authRecSearchHist
@cnic=3520211477171,
@bloodtype='O+',
@city='Lahore',
@block='Faisal Town',
@moutput=@myout output,
@moutput2=@myout2 output



go
create procedure authRecSearchHistDoner
@cnic bigint,
@bloodtype varchar(4),
@city varchar(50),
@block varchar(20),
@moutput int output,
@moutput2 int output
as
begin
					execute RecDonSearch 
						@bloodtype,
						@city,
						@block,
						@output=@moutput2 output
						if(@moutput2=0)
							begin
							set @moutput=0
							end
						else
							begin
								set @moutput=2
							end
end
drop proc authRecSearchHistDoner

create proc authRecLogin 
@cnic bigint,
@password varchar(16),
@output int output
as
begin
	if(exists(select * from RECIEVER where cnic=@cnic and [password]=@password))
	begin
		set @output=0
	end	

	else
	begin
		set @output=1
	end

end