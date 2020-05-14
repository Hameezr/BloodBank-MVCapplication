go
create proc updateBBBlock
@name varchar(50),
@newBlock varchar(20),
@output int output
as
begin
	if(exists(select * from [BLOODBANK] where name=@name))
		begin
			set @output=0
			update [BLOODBANK]
			set block=@newBlock
			where name=@name
				
		end
	else
		begin
			set @output=1
		end
end

go
create proc updateBBcity
@name varchar(50),
@city varchar(20),
@output int output
as
begin
	if(exists(select * from [BLOODBANK] where name=@name))
		begin
			set @output=0
			update [BLOODBANK]
			set city=@city
			where name=@name
				
		end
	else
		begin
			set @output=1
		end
end

go
create proc updateBBadd
@name varchar(50),
@add varchar(50),
@output int output
as
begin
	if(exists(select * from [BLOODBANK] where name=@name))
		begin
			set @output=0
			update [BLOODBANK]
			set [address]=@add
			where name=@name
				
		end
	else
		begin
			set @output=1
		end
end