create database QuanLyPhim
go 
use QuanLyPhim
go

create table PHIM(
	Maphim char(5) primary key,
	Tenphim nvarchar(30),
	Dodai int,
	Namsx int,
	Matheloai char(5),
	Madaodien char(5),
)

create table THELOAI(
	Matheloai char(5) primary key,
	Tentheloai nvarchar(30)
)

create table DAODIEN(
	Madaodien char(5) primary key,
	Hoten nvarchar(30),
	NamSinh int,
	Diachi nvarchar(30),
	Phai nvarchar(30)
 )

   create table DONGPHIM(
	Maphim char(5),
	Madienvien char(5),
	Nhanvat nvarchar(30),
	Vaitro nvarchar(30),
	Sogio int,
	Dongia int
	primary key(Maphim,Madienvien)
 )

   create table DIENVIEN(
	Madienvien char(5) primary key,
	Hoten nvarchar(30),
	Namsinh int,
	Diachi nvarchar(30),
	Phai nvarchar(30),
	Theloaisotruong char(5)
 )

  --Khoa ngoai
 -- FK Phim(Matheloai) -> TheLoai(Matheloai)
alter table PHIM
add constraint FK_PH_MTL
foreign key (Matheloai)
references Theloai(Matheloai)

-- FK PHIM(Madaodien) -> DAODIEN(Madaodien)
alter table PHIM
add constraint FK_PH_MDD
foreign key (Madaodien)
references DAODIEN(Madaodien)

-- FK DIENVIEN(Theloaisotruong) -> THELOAI(Matheloai)
alter table DIENVIEN
add constraint FK_DV_TLST
foreign key (Theloaisotruong)
references THELOAI(Matheloai)

-- FK DONGPHIM(Maphim) -> PHIM(Maphim)
alter table DONGPHIM
add constraint FK_DP_MP
foreign key (Maphim)
references PHIM(Maphim)

 -- FK DONGPHIM(Madienvien) -> DIENVIEN(Madienvien)
alter table DONGPHIM
add constraint FK_DP_MDV
foreign key (Madienvien)
references DIENVIEN(Madienvien)

--Nhap du lieu
insert into PHIM values('P01', N'Bình minh trên biển', 180, 2008, NULL, NULL),
('P02', N'Anh hùng xa lộ', 120, 2009, NULL, NULL),
('P03', N'Cuộc phiêu lưu trong rừng', 150, 2007, NULL, NULL),
('P04', N'Ở cuối chân trời', 160, 2010, NULL, NULL),
('P05', N'Chú thỏ ham ăn', 60, 2009, NULL, NULL)

insert into THELOAI values('X', N'Phim truyền hình'),
('Y', N'Phim hoạt hình'), ('Z', N'Phim hành động'),
('T', N'Phim tình cảm'), ('U', N'Phim trinh thám')

insert into DAODIEN values('D01', N'Nguyễn Thanh Tùng', 1974, N'Hồ Chí Minh', N'Nam'),
('D02', N'Lê Nhật Nam', 1962, N'Hồ Chí Minh', N'Nữ'),
('D03', N'Nguyễn Thị Thanh', 1977, N'Cà Mau', N'Nữ'),
('D04', N'Lê Thị Lan', 1984, N'Bình Dương', N'Nữ'),
('D05', N'Trần Minh Quang', 1984, N'Đồng Nai', N'Nam'),
('D06', N'Lê Văn Hải', 1970, N'Hồ Chí Minh', N'Nam'),
('D07', N'Dương Văn Hai', 1988, N'Đồng Nai', N'Nam')

update PHIM 
set Matheloai = 'X', Madaodien = 'D03'
where Maphim = 'P01'

update PHIM
set Matheloai = 'Z', Madaodien = 'D03'
where Maphim = 'P02'

update PHIM
set Matheloai = 'U', Madaodien = 'D05'
where Maphim = 'P03'

update PHIM
set Matheloai = 'X', Madaodien = 'D05'
where Maphim = 'P04'

update PHIM
set Matheloai = 'Y', Madaodien = 'D06'
where Maphim = 'P05'

insert into DIENVIEN values('DV01', N'Nguyễn Thị Lan Hương', 1988, N'Hà Nội', N'Nữ', 'X'),
('DV02', N'Trần Nguyễn Thu Hà', 1992, N'Hồ Chí Minh', N'Nữ', 'T'),
('DV03', N'Lý Nhược Đồng', 1978, N'Hồ Chí Minh', N'Nữ', 'T'),
('DV04', N'Lý Mạnh Hùng', 1984, N'Bình Dương', N'Nam', 'Y'),
('DV05', N'Trần Văn Hoàng', 1977, N'Đà Nẵng', N'Nam', 'Z'),
('DV06', N'Phạm Thu Hiền', 1989, N'Đồng Tháp', N'Nữ', 'T'), 
('DV07', N'Trần Băng Băng', 1991, N'Cà Mau', N'Nữ', 'T')

insert into DONGPHIM values ('P01', 'DV01', N'Tuyết', N'Nữ chính', 50, 120),
('P01', 'DV04', N'Nam', N'Nam chính', 50, 100),
('P01', 'DV06', N'Lan', N'Phụ', 20, 60),
('P02', 'DV04', N'Mạnh', N'Nam chính', 40, 150),
('P02', 'DV05', N'Hồ', N'Nam chính', 60, 110),
('P03', 'DV05', N'Dũng', N'Nam chính', 60, 120),
('P04', 'DV06', N'Nga', N'Nữ chính', 50, 110),
('P04', 'DV05', N'Hoàng', N'Nam chính', 45, 140)

--TRUY VAN
--20 Cho biết mã phim có nhiều diễn viên tham gia nhất
select Maphim as N'Mã Phim', COUNT(Madienvien) as N'Số diễn viên tham gia'
from DONGPHIM
group by  Maphim
having COUNT(Madienvien)=(
 select max(num)
 from(
  select COUNT(*) as num
  from DONGPHIM
  group by Maphim )as maxActor
)

--21. Cho biết tên phim và tên đạo diễn mà có nhiều diễn viên tham gia nhất
select p.Tenphim as N'Tên phim', dd.Hoten as N'Tên đạo diễn', COUNT(dp.Madienvien) as N'Số lượng diễn viên tham gia'
from PHIM as p 
join DAODIEN as dd on p.Madaodien=dd.Madaodien
join DONGPHIM as dp on p.Maphim=dp.Maphim
group by p.Tenphim ,dd.Hoten 
having COUNT(dp.Madienvien) =(
select max(num)
from(
select COUNT(*) as num
from DONGPHIM
group by Maphim )as actor
)

--22 Cho biết tên những diễn viên không tham gia vào bộ phim “Bình minh trên biển”
select Hoten AS N'Tên diễn viên'
from DIENVIEN 
where Madienvien not in (
    select dp.Madienvien
    from DONGPHIM dp 
    join PHIM p on dp.Maphim = p.Maphim
    where p.Tenphim LIKE N'Bình minh trên biển'
)
group by Hoten;

--23 Cho biết những diễn viên đã từng đóng những phim có thể loại là “Phim truyền hình”
select Hoten as N'Tên diễn viên'
from DIENVIEN 
where Madienvien in (
select dp.Madienvien
from DONGPHIM dp 
join PHIM p on dp.Maphim=p.Maphim
join THELOAI tl on p.Matheloai=tl.Matheloai
where tl.Tentheloai like N'Phim truyền hình'
group by dp.Madienvien
)

--24 Cho biết tên những diễn viên chưa từng đóng phim có thể loại là “Phim truyền hình”
select Hoten as N'Tên diễn viên'
from DIENVIEN 
where Madienvien not in(
select dp.Madienvien
from DONGPHIM dp 
join PHIM p on dp.Maphim=p.Maphim
join THELOAI tl on p.Matheloai=tl.Matheloai
where tl.Tentheloai like N'Phim truyền hình'
group by dp.Madienvien
)

--25 Cho biết tên những phim mà có đạo diễn phim là một người ở “Hồ Chí Minh” và có diễn viên tham
--gia đóng phim cũng ở “Hồ Chí Minh”
select p.Tenphim as N'Tên phim'
from PHIM p
join DONGPHIM dp on dp.Maphim=p.Maphim
join DIENVIEN dv on dp.Madienvien=dv.Madienvien
join DAODIEN dd on p.Madaodien=dd.Madaodien
where dv.Diachi like N'Hồ Chí Minh' and dd.Diachi like N'Hồ Chí Minh'
group by  p.Tenphim

--26 Cho biết những diễn viên nhỏ tuổi hơn diễn viên “Lý Mạnh Hùng”
select dv2.Hoten as N'Tên diễn viên'
from DIENVIEN dv1 
join DIENVIEN dv2 on dv1.Namsinh < dv2.Namsinh
where dv1.Hoten like N'Lý Mạnh Hùng' and dv2.Hoten not like N'Lý Mạnh Hùng'
group by dv2.Hoten

--27 Cho biết tên diễn viên nhỏ tuổi nhất
select Hoten as N'Tên diễn viên', Namsinh as N'Năm sinh'
from DIENVIEN
where Namsinh = (
select max(Namsinh)
from DIENVIEN
)

--28 Cho biết số lượng phim mà có độ dài từ 120 phút trở lên
select count(*) as N'Số lượng'
from PHIM
where Dodai >=120
