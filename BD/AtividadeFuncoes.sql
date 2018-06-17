
DECLARE @MyCounter int;
SET @MyCounter = 0
select @MyCounter

DECLARE @MyCounter int;
set @MyCounter = 1
select @MyCounter

declare @document varchar(64)
select @document = 'reflectors are vital safety' + ' components of your bicycle.';
select CHARINDEX('bicycle', @document);

declare @document varchar(64)
select @document = 'reflectors are vital safety' + ' components of your bicycle.';
select CHARINDEX('are',@document);

declare @document varchar(64)
select @document = 'reflectors are vital safety' + ' components of your bicycle.';
select CHARINDEX('Ref', @document)

declare @document varchar(64)
select @document = 'reflectors are vital safety' + ' components of your bicycle.';
select CHARINDEX('ect',@document);
go

select CONCAT ('Happy ','Birthday', 11, '/', '25') AS Result

select LTRIM('    Five spaces are at the beginning of this string.') from sys.databases;

select REPLACE('abcdefghicde','cde','xxx');

select CEILING($123.45),CEILING($-123.45),CEILING($0.0)

select REPLACE('abcdefghicde','cde','xxx');
go

select STR(123.45,6,1);
go

select CEILING($123.45),CEILING($-123.45), CEILING($0.0);
go

declare @DTA datetime;
select @DTA = GETDATE();

declare @DTA datetime;
select @DTA as '@DTA e getdate()'

declare @DTAMAIS30 date;
select @DTAMAIS30 = DATEADD(day, 30, getdate());

declare @DTAMAIS30 date;
select @DTAMAIS30 as 'data + 30 Dias'

declare @QTDOS_DIAS_DESSE_ANO int;
select @QTDOS_DIAS_DESSE_ANO = DATEDIFF(day,'01/01/2018',getdate())

