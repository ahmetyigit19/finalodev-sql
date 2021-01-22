create database banka /* veri taban� olu�turma komutu*/


 use banka
 create table �ube (�d char (10),banka char (30)) /* tablo olu�turma komutu */
 select * from �ube
 use banka
 insert into �ube (�d,banka) values (1,'ak bank') /* tabloya veri ekleme kodu*/
 insert into �ube values (2, 'i� bankas�')
 insert into �ube values (3, 'finans bank')
 insert into �ube values (4,' garanti ')
 insert into �ube values (5,'tep' )

 use banka
 create table musteri (adi char (15),soyadi char (15),bankas� char (30)) /*tablo olu�urma kodu*/
 select  *from musteri
 use banka
 insert into musteri values ('ahmet','uysal','finans bank')
 insert into musteri values ('mustafa','ko�','finans bank')
insert into musteri values ('efe','�zt�rk','garanti')
insert into musteri values ('burak','al','ak bank')
insert into musteri values ('hikmet','karaman','tep')
insert into musteri values ('emre','y�ld�r�m','ak bank')
insert into musteri values ('hakan','ayd�n','garanti')

use banka /*banka veri taban�nda olu�turmak i�in yazd�m*/
create table bor� (adi char (15),soyadi char (15),bor�miktar� money )
select *from bor�
insert into bor� values ('ahmet','uysal',135)
insert into bor� values ('mustafa','ko�',2255)
insert into bor� values ('efe','�zt�rk',16025)
insert into bor� values ('burak','al',36)
insert into bor� values ('emre','y�ld�r�m',558)
insert into bor� values ('hakan','ayd�n',1457)

use banka
create table b�lg�ler (adi char (15),soyadi char (15),i�i char (30),ikametetti�iyer  char (30) )
insert into b�lg�ler values ('ahmet','uysal','��renci','kartal-�stanbul')

insert into b�lg�ler values ('mustafa','ko�','mimar','�e�me-�zmir')

insert into b�lg�ler  values ('efe','�zt�rk','polis','mecit�z�-�orum')

insert into b�lg�ler values ('burak','al','muhasebeci','�e�me-�zmir')

insert into b�lg�ler values ('hikmet','karaman','zab�ta','sultanbeyli-�stanbul')

select*from b�lg�ler

use banka
select *from b�lg�ler b1 inner join bor� b2 on b1.adi= b2.adi /* iki tabloda ortak olan adlar� bulmak i�in yaz�ld�*/
use banka
select *from b�lg�ler left join bor� on b�lg�ler.adi=bor�.adi /*soldaki tablonun hepsini di�er tabloda sadece ortak olanlar� bulmak i�in yaz�ld�*/
use banka
select *from b�lg�ler right join bor� on b�lg�ler.adi=bor�.adi /* sa�daki tablonun hepsini di�er tabloda sadece ortak olanlar� bulmak i�in yaz�ld�*/





		
	
		create procedure sp_b�lgiler        /* sp olu�turdum */
		(
		@adi char(15),
		@soyadi char(15),
		@i�i char (30),
		@ikametetti�iyer char(30)

		)
		as 
		begin
		   insert into b�lg�ler (adi,soyadi,i�i,ikametetti�iyer)
		   values (@adi,@soyadi,@i�i,@ikametetti�iyer)
		   end




	

	 create procedure sp_bor�    /* sp olu�turdum */
	 (
	 @adi char(15),
	 @soyadi char(15),
	 @bor�miktar� money
	 )
	 as
	 begin
	 insert into bor� (adi,soyadi,bor�miktar�)
	 values (@adi,@soyadi,@bor�miktar�)
	 end






	create procedure sp_musteri    /* sp olu�turdum */
	(
	@adi char (15),
	@soyadi char (15),
	@bankas� char(30)
	)
	as
	begin
	insert into musteri
	values (@adi,@soyadi,@bankas�)
	end 






	create procedure sp_�ube     /* sp olu�turdum */
	(
	@�d char(10),
	@banka char (30)
	)
	as
	begin
	insert into �ube
	values (@�d,@banka)
	end 

	/*---------------------------------------------------------------------------------------------------------------------*/





	create procedure sp_bor�lugetir                                      /* inner join ile kar���k sorgu yazmaya �al��t�m :) */
	as
	select i�i,bor�miktar� from b�lg�ler a1 inner join bor� a2
	on
	a1.adi=a2.adi

	
	
	create procedure sp_m��teribelirle
	as 
	select adi,�d from musteri b1 inner join �ube b2
	on 
	b1.adi=b2.banka
	
	
	
	





    /*---------------------------------------------------------------------------------------------------------*/
	
	
	create clustered index cls_1 on musteri(adi)             /* rebu�ld edebilmek i�in 3 adet index olu�turdum */
	create clustered index cls_2 on b�lg�ler(i�i)
	create clustered index cls_3 on bor�(bor�miktar�)

	
 
GO
ALTER INDEX [cls_2] ON [dbo].[b�lg�ler] 
REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)


 USE [banka]
GO
ALTER INDEX [cls_3] ON [dbo].[bor�] 
REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

USE [banka]
GO
ALTER INDEX [cls_1] ON [dbo].[musteri] 
REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
  

  /* yukar�da olu�turdu�um indexleri rebu�ld ettim  */