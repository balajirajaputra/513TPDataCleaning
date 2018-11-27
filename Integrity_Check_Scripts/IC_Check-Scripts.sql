--check if duplicate ID's in 4 tables
select FMID, Count(1) from Farmers_Markets_Address group by FMID having count(1)>1;
select FMID, Count(1) from Farmers_Markets_Products group by FMID having count(1)>1;
select FMID, Count(1) from Farmers_Markets_SocialMedia group by FMID having count(1)>1;
select FMID, Count(1) from farmersmarkets_SeasonsData group by FMID having count(1)>1;



select distinct FMA.*, FMP.* from Farmers_Markets_Address FMA 
	inner join Farmers_Markets_Products FMP on FMA.FMID = FMP.FMID
	and FMA.latitude = '' and FMA.street = ''

-- Exclude Blank values in address, products and season details
select distinct FMA.*, FMP.*, FMS.*, FMSD.* from Farmers_Markets_Address FMA 
	inner join Farmers_Markets_Products FMP on FMA.FMID = FMP.FMID
	inner join Farmers_Markets_SocialMedia FMS on FMS.FMID = FMA.FMID
	inner join farmersmarkets_SeasonsData FMSD on FMSD.FMID = FMA.FMID
	and FMA.latitude = '' and FMA.street = ''


alter table Farmers_Markets_Address add column Delete_Flag int default 0
alter table Farmers_Markets_Products add column Delete_Flag int default 0
alter table Farmers_Markets_SocialMedia add column Delete_Flag int default 0
alter table Farmers_Markets_SeasonsData add column Delete_Flag int default 0

create temporary table temp as
select distinct FMA.FMID from Farmers_Markets_Address FMA 
	inner join Farmers_Markets_Products FMP on FMA.FMID = FMP.FMID
	inner join Farmers_Markets_SocialMedia FMS on FMS.FMID = FMA.FMID
	inner join Farmers_Markets_SeasonsData FMSD on FMSD.FMID = FMA.FMID
	and FMA.latitude = '' and FMA.street = ''

--Update Delete flag for the blank recors OR delete these reocrds perminanntly from all tables
Update Farmers_Markets_Address set Delete_Flag = 1 where FMID in (select FMID from temp)
Update Farmers_Markets_Products set Delete_Flag = 1 where FMID in (select FMID from temp)
Update Farmers_Markets_SocialMedia set Delete_Flag = 1 where FMID in (select FMID from temp)
Update Farmers_Markets_SeasonsData set Delete_Flag = 1 where FMID in (select FMID from temp)
	

-- Check the data can filter by date range
select *
--,(substr(season1_Start_Date,1,2) || '/' || substr(season1_Start_Date,4,2) || '/' || substr(season1_Start_Date,7,10)) as [SSD]
--, season1_Start_Date
		 from farmersmarkets_SeasonsData 
		 where 
		-- (substr(season1_Start_Date,1,2) || '/' ||substr(season1_Start_Date,4,2) || '/' || substr(season1_Start_Date,7,10)) between '01/01/2016' and '01/31/2018'
		 substr(season1_Start_Date,7,10) < '2012' -- >'2014' --between '2015' and '2018'
		 and delete_flag = 0
		 
		 
/*select substr(season1_Start_Date,7,10), count(*) 
		 from farmersmarkets_SeasonsData 
		 where	  delete_flag = 0
		and substr(season1_Start_Date,7,10) <> '' 
		 group by substr(season1_Start_Date,7,10) order by 2 desc
		 
*/
update Farmers_Markets_SeasonsData set Delete_Flag = 1
--select * from Farmers_Markets_SeasonsData 
	where  season1_Start_Date = '' and season1_End_Date = ''
		and season2_Start_Date = '' and season2_End_Date = ''
		and season3_Start_Date = '' and season3_End_Date = ''
		and season4_Start_Date = '' and season4_End_Date = ''
		
select strftime('%Y', season1_Start_Date) as "Year", count(1)
		 from Farmers_Markets_SeasonsData 
		where season1_Start_Date is not null 	group by "Year"	 order by 2 desc
		 
		 
select * from Farmers_Markets_SeasonsData 
	where strftime('%Y', season1_Start_Date) > '2014'

select * from Farmers_Markets_Address where delete_flag = 0 
select * from farmersmarkets_SeasonsData where delete_flag = 0
select * from Farmers_Markets_Products where delete_flag = 0 

select * from Farmers_Markets_Products
select distinct FMID from Farmers_Markets_SocialMedia

select distinct FMID from farmersmarkets_SeasonsData


-- Farmers_Markets_SocialMedia
-- check how many valid values in each column and see if we can delete any column permenently
-- Way 1
create temporary table SocialMedia_Count(ColumnName varchar(50), Cnt int)
insert into SocialMedia_Count
select 'MarketName', count(*)  from Farmers_Markets_SocialMedia where MarketName = '' union
select 'Website', count(*)  from Farmers_Markets_SocialMedia where Website = '' union
select 'Facebook', count(*)  from Farmers_Markets_SocialMedia where Facebook = '' union
select 'Twitter', count(*)  from Farmers_Markets_SocialMedia where Twitter = '' union
select 'Youtube', count(*)  from Farmers_Markets_SocialMedia where Youtube = '' union
select 'OtherMedia', count(*)  from Farmers_Markets_SocialMedia where OtherMedia = '' union
select 'TotalRecords', count(*) from Farmers_Markets_SocialMedia
-- OR Way 2
select count(*) [TotalRows], 
		sum(case when MarketName = '' then 0 else 1 end) [MarketName],
		sum(case when Website = '' then 0 else 1 end) [Website],
		sum(case when Facebook = '' then 0 else 1 end) [Facebook],
		sum(case when Twitter = '' then 0 else 1 end) [Twitter],
		sum(case when Youtube = '' then 0 else 1 end) [Youtube],
		sum(case when OtherMedia = '' then 0 else 1 end) [OtherMedia]
		from Farmers_Markets_SocialMedia


select case when OtherMedia = '' then 0 else 1 end [1A], OtherMedia from Farmers_Markets_SocialMedia
where OtherMedia <> ''
select * from SocialMedia_Count order by 2 desc
select 8687 - 7957
select * from Farmers_Markets_SocialMedia
	where MarketName = ''

select * from Farmers_Markets_SocialMedia
	where Website = ''

select * from Farmers_Markets_SocialMedia
	where Facebook = ''

select * from Farmers_Markets_SocialMedia
	where Twitter = ''

select * from Farmers_Markets_SocialMedia
	where Youtube = ''	
	
select * from Farmers_Markets_SocialMedia
	where OtherMedia = ''	

	select * from Farmers_Markets_SocialMedia where Delete_Flag = 1
	
select * from Farmers_Markets_Products where delete_flag = 1
	

	
	
	
	
	