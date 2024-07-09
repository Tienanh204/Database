create database QuanLyDeTai
go
use QuanLyDeTai
go

--Nhap bang
create  table GIAOVIEN
(
Magv char(10) primary key,
Hoten nvarchar(50),
Luong float,
Phai nvarchar(50),
Ngaysinh char(50),
Diachi nvarchar(50),
Gvqlbm char(10),
Mabm char(10),
)

create  table GV_DT
(
Magv char(10),
Dienthoai char(50),
primary key (Magv,Dienthoai)
)

create  table BOMON
(
Mabm char(10) primary key,
Tenbm nvarchar(50),
Phong char(50),
Dienthoai char(50),
Truongbm char(10),
Makhoa char(10),
Ngaync char(50),
)

create  table KHOA
(
Makhoa char(10) primary key,
Tenkhoa nvarchar(50),
Namtl int,
Phong char(10),
Dienthoai char(50),
Truongkhoa char(10),
Ngaync char(50),
)

create  table DETAI
(
Madt char(10) primary key,
Tendt nvarchar(50),
Capql nvarchar(50),
Kinhphi float,
Ngaybd char(50),
Ngaykt char(50),
Macd char(10),
Gvcndt char(10),
)

create  table CHUDE
(
Macd char(10) primary key,
Tencd nvarchar(50),
)

create  table CONGVIEC
(
Madt char(10),
Stt char(10),
Tencv nvarchar(50),
Ngaybd char(50),
Ngaykt char(50),
primary key (Madt,Stt)
)

create  table THAMGIADETAI
(
Magv char(10),
Madt char(10),
Stt char(10),
Phucap float,
Ketqua nvarchar(50),
primary key (Magv,Madt,Stt),
)

create  table NGUOITHAN
(
Magv char(10),
Ten nvarchar(50),
Ngaysinh char(50),
Phai nvarchar(50),
primary key (Magv, Ten),
)

--TAO KHOA NGOAI
--Giao vien
--FK GIAOVIEN(GVQLBM)->GIAOVIEN(MAGV)
alter table GIAOVIEN
add constraint FK_GV_GV
foreign key(Gvqlbm)
references GIAOVIEN(Magv)

--FK GIAOVIEN(Mabm)->BOMON(Mabm)
alter table GIAOVIEN
add constraint FK_GV_BM
foreign key(Mabm)
references BOMON(Mabm)

--GV_DT
--FK GV_DT(Magv)->GIAOVIEN(Magv)
alter table GV_DT
add constraint FK_GVDT_GV
foreign key(Magv)
references GIAOVIEN(Magv)

--Bo mon
--FK BOMON(Truongbm)->GIAOVIEN(Magv)
alter table BOMON
add constraint FK_BM_GV
foreign key(Truongbm)
references GIAOVIEN(Magv)

--FK BOMON(Makhoa)->KHOA(Makhoa)
alter table BOMON
add constraint FK_BM_KH
foreign key(Makhoa)
references KHOA(Makhoa)

--Khoa
--FK KHOA(Truongkhoa)->GIAOVIEN(Magv)
alter table KHOA
add constraint FK_KH_GV
foreign key(Truongkhoa)
references GIAOVIEN(Magv)

--Detai
--FK DETAI(Macd)->CHUDE(Macd)
alter table DETAI
add constraint FK_DT_CD
foreign key(Macd)
references CHUDE(Macd)

--FK DETAI(Gvcndt)->GIAOVIEN(Magv)
alter table DETAI
add constraint FK_DT_GV
foreign key(Gvcndt)
references GIAOVIEN(Magv)

--Cong viec
--FK CONGVIEC(Madt)->DETAI(Madt)
alter table CONGVIEC
add constraint FK_CV_DT
foreign key(Madt)
references DETAI(Madt)

--Tham gia de tai
--FK THAMGIADETAI(Magv)->GIAOVIEN(Magv)
alter table THAMGIADETAI
add constraint FK_TG_GV
foreign key(Magv)
references GIAOVIEN(Magv)


--FK THAMGIADETAI(Madt,Stt)->CONGVIEC(Madt,Stt)
alter table THAMGIADETAI
add constraint FK_TG_CV
foreign key(Madt,Stt)
references CONGVIEC(Madt,Stt)

--Nguoi than
--FK NGUOITHAN(Magv)->GIAOVIEN(Magv)
alter table NGUOITHAN
add constraint FK_NT_GV
foreign key(Magv)
references GIAOVIEN(Magv)


--NHAP DU LIEU
insert into GIAOVIEN values 
('001', N'Nguyễn Hoài An',2000.0,N'Nam','1973-02-15',N'25/3 Lạc Long Quân, Q.10, TP HCM',NULL,NULL),
('002', N'Trần Trà Hương',25000,N'Nữ','1960-06-20',N'125 Trần Hưng Đạo, Q.1, TP HCM',NULL,NULL),
('003', N'Nguyễn Ngọc Anh',22000,N'Nữ','1975-05-11',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM',NULL,NULL),
('004', N'Trương Nam Sơn',23000,N'Nam','1959-06-20',N'215 Lý Thường Kiệt, TP Biên Hòa',NULL,NULL),
('005', N'Lý Hoàng Hà',25000,N'Nam','1954-10-23',N'22/5 Mguyễn Xí, Q.Bình Thạnh, TP HCM',NULL,NULL),
('006', N'Trần Bạch Tuyết',15000,N'Nữ','1980-05-203',N'127 Hùng Vương, TP Mỹ Tho',NULL,NULL),
('007', N'Nguyễn An Trung',21000,N'Nam','1976-06-05',N'234 3/2, TP Biên Hòa',NULL,NULL),
('008', N'Trần Trung Hiếu',18000,N'Nam','1977-08-06',N'22/11 lý Thường Kiệt, TP Mỹ Tho',NULL,NULL),
('009', N'Trần Hoàng nam',200000,N'Nam','1975-11-22',N'234 Trần Não, An Phú, TP HCM',NULL,NULL),
('010', N'Phạm Nam Thanh',150000,N'Nam','1980-12-12',N'221 Hùng Vương, Q.5, TP HCM',NULL,NULL)


insert into GV_DT values
('001','0838912112'),('001','0903123123'),('002','0913454545'),('003','0838121212'),
('003','0903656565'),('003','0937125125'),('006','0937888888'),('008','0653717171'),
('008','0913232323')


insert into BOMON values 
('CNTT', N'Công nghệ tri thức','B15','0838126126',NULL,NULL,NULL),
('HHC', N'Hóa hữu cơ','B44','838222222',NULL,NULL,NULL),
('HL', N'Hóa lý','B42','0838878787',NULL,NULL,NULL),
('HPT', N'Hóa phân tích','B43','0838777777',NULL,NULL,'2007-10-15'),
('HTTT', N'Hệ thống thông tin','B13','0838125125',NULL,NULL,'2004-09-20'),
('MMT', N'Mạng máy tính','B16','0838676767',NULL,NULL,'2005-05-15'),
('SH', N'Sinh hóa','B33','0838898989',NULL,NULL,NULL),
('VLDT', N'Vật lý điện tử','B23','0838234234',NULL,NULL,NULL),
('VLUD', N'Vật lý ứng dụng','B24','0838454545',NULL,NULL,'2006-02-18'),
('VS', N'Vi sinh','B32','0838909090',NULL,NULL,'2007-01-01')


update GIAOVIEN
set GVqlbm=null, Mabm='MMT'
where Magv='001'
update GIAOVIEN
set GVqlbm=null, Mabm='HTTT'
where Magv='002'
update GIAOVIEN
set GVqlbm='002', Mabm='HTTT'
where Magv='003'
update GIAOVIEN
set GVqlbm=null, Mabm='VS'
where Magv='004'
update GIAOVIEN
set GVqlbm=null, Mabm='VLDT'
where Magv='005'
update GIAOVIEN
set GVqlbm='004', Mabm='VS'
where Magv='006'
update GIAOVIEN
set GVqlbm=null, Mabm='HPT'
where Magv='007'
update GIAOVIEN
set GVqlbm='007', Mabm='HPT'
where Magv='008'
update GIAOVIEN
set GVqlbm='001', Mabm='HPT'
where Magv='009'
update GIAOVIEN
set GVqlbm='007', Mabm='HPT'
where Magv='010'


insert into KHOA values
('CNTT',N'Công nghệ thông tin',1995,'B11','0838123456','002','2005-02-20'),
('HH',N'Hóa học',1980,'B41','0838456456','007','2001-10-15'),
('SH',N'Sinh học',1980,'B31','0838454545','004','2000-10-11'),
('VL',N'Vật lý',1976,'B21','0838223223','005','2003-09-18')

update BOMON
set Truongbm=null,Makhoa='CNTT'
where Mabm='CNTT'
update BOMON
set Truongbm=null,Makhoa='HH'
where Mabm='HHC'
update BOMON
set Truongbm=null,Makhoa='HH'
where Mabm='HL'
update BOMON
set Truongbm='007',Makhoa='HH'
where Mabm='HPT'
update BOMON
set Truongbm='002',Makhoa='CNTT'
where Mabm='HTTT'
update BOMON
set Truongbm='001',Makhoa='CNTT'
where Mabm='MMT'
update BOMON
set Truongbm=null,Makhoa='SH'
where Mabm='SH'
update BOMON
set Truongbm=null,Makhoa='VL'
where Mabm='VLDT'
update BOMON
set Truongbm='005',Makhoa='VL'
where Mabm='VLUD'
update BOMON
set Truongbm='004',Makhoa='SH'
where Mabm='VS'

insert into CHUDE values
('NCPT',N'Nghiên cứu phát triển'),
('QLGD',N'Quản lý giáo dục'),
('UDCN',N'Ứng dụng công nghệ')


insert into DETAI values
('001',N'HTTT quản lý các Trường đại học','DHQG',20.0, '2007-10-20','2008-10-20','QLGD','002'),
('002',N'HTTT quản lý giáo vụ cho một khoa','Trương',20.0, '2000-10-12','2001-10-12','QLGD','002'),
('003',N'HTTT nghiên cứu chế tạo sợi NaNô Platin','DHQG',300.0, '2008-05-15','2010-05-15','NCPT','005'),
('004',N'Tạo vật liệu sinh học bằng màng ối người','Nhà nước',100.0, '2007-01-01','2009-12-31','NCPT','004'),
('005',N'Ứng dụng hóa học xanh','Trường',200.0, '2003-10-10','2004-12-10','UDCN','007'),
('006',N'Nghiên cứu tế bào gốc','Nha Nuoc',4000.0, '2006-10-20','2000-10-20','NCPT','004'),
('007',N'HTTT quản lý thư viện ở các trường đại học','Trường',20.0, '2009-05-10','2010-05-10','QLGD','001')

insert into CONGVIEC values
('001','1' ,N'Khởi tạo và lập kế hoạch','2007-10-20','2008-12-20'),
('001','2' ,N'Xác định yêu cầu','2008-12-21','2008-03-21'),
('001','3' ,N'Phân tích hệ thống','2008-03-22','2008-05-22'),
('001','4' ,N'Thiết kế hệ thống','2008-05-23' ,'2008-06-23'),
('001','5' ,N'Cài đặt thử nghiệm','2008-06-24' ,'2008-10-20'),
('002','1' ,N'Khởi tạo và lập kế hoạch','2009-05-10' ,'2009-07-10'),
('002','2' ,N'Xác định yêu cầu','2009-07-11' ,'2009-10-11'),
('002','3' ,N'Phân tích hệ thống','2009-10-12' ,'2009-12-20'),
('002','4' ,N'Thiết kế hệ thống','2009-12-21' ,'2010-03-22'),
('002','5' ,N'Cài đặt thử nghiệm','2010-03-23' ,'2010-05-10'),
('006','1' ,N'Lấy mẫu','2006-10-20' ,'2007-02-20'),
('006','2' ,N'Nuôi cấy','2007-02-21' ,'2008-08-21')


insert into THAMGIADETAI values
('001','002','1',0.0,null),
('001','002','2',2.0,null),
('002','001','4',2.0,N'Đạt'),
('003','001','1',1.0,N'Đạt'),
('003','001','2',0.0,N'Đạt'),
('003','001','4',1.0,N'Đạt'),
('003','002','2',0.0,null),
('004','006','1',0.0,N'Đạt'),
('004','006','2',1.0,N'Đạt'),
('006','006','2',1.5,N'Đạt'),
('009','002','3',0.5,null),
('009','002','4',1.5,null)

insert into NGUOITHAN values
('001',N'Hùng','1990-01-14',N'Nam'),
('001',N'Thủy','1994-12-08',N'Nữ'),
('003',N'Hà','1998-09-03',N'Nữ'),
('003',N'Thu','1998-09-03',N'Nữ'),
('007',N'Mai','2003-03-26',N'Nữ'),
('007',N'Vy','2000-02-14',N'Nữ'),
('008',N'Nam','1991-05-06',N'Nam'),
('009',N'An','1996-08-19',N'Nam'),
('010',N'Nguyệt','2006-01-14',N'Nữ')


--TRUY VAN


 --Q28. Cho biết số lượng giáo viên và lương trung bình của từng bộ môn.
 select bm.Tenbm as N'Tên bộ môn', count(gv.Magv) as N'Số giáo viên', avg(gv.Luong) as N'Lương TB'
 from BOMON bm
 join GIAOVIEN gv on bm.Mabm=gv.Mabm
 group by bm.Tenbm

 --Q29. Cho biết tên chủ đề và số lượng đề tài thuộc về chủ đề đó nếu có.
 select cd.Tencd as N'Tên chủ đề', count(dt.Madt) as N'Số lượng đề tài'
 from CHUDE cd
 join DETAI dt on cd.Macd=dt.Macd
 group by cd.Tencd

 --Q30. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó tham gia.
 select gv.Hoten as N'Họ tên', COUNT(tg.Madt) as N'Số lượng đề tài tham gia'
 from GIAOVIEN gv 
 join THAMGIADETAI tg on tg.Magv=gv.Magv
 group by gv.Hoten

 --Q31. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó làm chủ nhiệm nếu có.
 select gv.Hoten as N'Tên giáo viên', COUNT(dt.Gvcndt) as N'Số lượng đề tài'
 from GIAOVIEN gv
 join DETAI dt on dt.Gvcndt=gv.Magv
 group by gv.Hoten

 --Q32. Với mỗi giáo viên cho tên giáo viên và số người thân của giáo viên đó.
 select gv.Hoten as N'Tên giáo viên', COUNT(nt.Magv) as N'Số người thân'
 from GIAOVIEN gv
 join NGUOITHAN nt on nt.Magv = gv.Magv
 group by gv.Hoten

 --Q33. Cho biết tên những giáo viên đã tham gia từ 3 đề tài trở lên.
 select gv.Hoten as N'Họ tên', COUNT(tg.Madt) as N'Số đề tài tham gia'
 from GIAOVIEN gv 
 join THAMGIADETAI tg on tg.Magv=gv.Magv
 group by gv.Hoten
 having COUNT(tg.Madt) >= 3

 --Q34. Cho biết số lượng giáo viên đã tham gia vào đề tài Ứng dụng hóa học xanh.
 select COUNT(distinct(tg.Magv)) as N'Số lượng giáo viên'
 from DETAI dt
 join THAMGIADETAI tg on tg.Madt = dt.Madt
 where dt.Tendt like N'Ứng dụng hóa học xanh'

