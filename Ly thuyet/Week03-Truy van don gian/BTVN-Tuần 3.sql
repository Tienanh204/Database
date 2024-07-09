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

--1. Cho biết tên những bộ phim được sản xuất trong khoảng thời gian từ năm 2009 đến 2010
select Tenphim as N'Tên Phim'
from PHIM
where Namsx>=2009 AND Namsx<=2010

--2. Cho biết tên những bộ phim mà có thời lượng > 120 phút
select Tenphim as N'Tên Phim'
from PHIM
where Dodai>120

--3. Cho biết tên bộ phim và tên đạo diễn của những bộ phim được sản xuất trong năm 2008.
select x.Tenphim, y.Hoten
from PHIM x, DAODIEN y
where x.Madaodien = y.Madaodien AND x.Namsx=2008

select x.Tenphim, y.Hoten
from PHIM x join DAODIEN y on x.Madaodien=Y.Madaodien
where x.Namsx=2008

--4. Cho biết tên phim, tên đạo diễn và tên thể loại của phim “Bình minh trên biển”
select x.Tenphim, y.Hoten,z.Tentheloai
from PHIM x, DAODIEN y, THELOAI z
where x.Madaodien=y.Madaodien AND
      x.Matheloai=z.Matheloai AND
	  x.Tenphim=N'Bình Minh Trên Biển'

select x.Tenphim as N'Tên Phim', y.Hoten as N'Tên Đạo Diễn',z.Tentheloai as N'Thể Loại'
from PHIM x 
join DAODIEN y on x.Madaodien=y.Madaodien
join THELOAI z on x.Matheloai=z.Matheloai
where x.Tenphim=N'Bình Minh Trên Biển'

SELECT PHIM.Tenphim AS N'Tên Phim', DAODIEN.Hoten AS N'Tên Đạo Diễn', THELOAI.Tentheloai AS N'Tên Thể Loại'
FROM PHIM
JOIN DAODIEN ON PHIM.Madaodien = DAODIEN.Madaodien
JOIN THELOAI ON PHIM.Matheloai = THELOAI.Matheloai
WHERE PHIM.Tenphim = N'Bình Minh Trên Biển'

--5 Cho biết mã những thể loại phim mà chưa được sản xuất lần nào.
select THELOAI.Matheloai
from THELOAI
where Matheloai not in 
      (select distinct Matheloai 
	   from PHIM)

--6 Cho biết mã và tên những thể loại phim chưa được sản xuất lần nào
select Matheloai as N'Ma Phim',Tentheloai as 'Ma The Loai'
from THELOAI
where THELOAI.Matheloai not in (select Matheloai from PHIM)

--7. Cho biết tên những diễn viên có địa chỉ tại thành phố “Hồ Chí Minh”
select Hoten as N'Ho Ten'
from DIENVIEN
where Diachi like N'Hồ chí minh'

--8. Cho biết tên diễn viên và tên thể loại sở trường của những diễn viên nữ
select DIENVIEN.Hoten as N'Họ tên', THELOAI.Tentheloai as N'Thể loại sở trường'
from DIENVIEN join THELOAI on DIENVIEN.Theloaisotruong=THELOAI.Matheloai
where DIENVIEN.Phai like N'Nữ'

--9. Cho biết tên và địa chỉ của những diễn viên và đạo diễn có năm sinh trong khoảng 1970 đến 1980.
select Hoten as N'Họ Tên', Diachi as N'Địa chỉ'
from 
(
select Hoten, Diachi
from DIENVIEN
where Namsinh between 1971 AND 1979
union
select Hoten, Diachi
from DAODIEN
where Namsinh between 1971 AND 1979
) as DVDD


--10 Cho biết mã diễn viên và thu nhập từ việc đóng phim của mỗi diễn viên
select  DIENVIEN.Madienvien as 'Mã diễn viên', sum((DONGPHIM.Dongia * DONGPHIM.Sogio)) as N'Thu nhập'
from DIENVIEN join DONGPHIM on DIENVIEN.Madienvien=DONGPHIM.Madienvien
GROUP BY DIENVIEN.Madienvien;

--11 Cho biết tên diễn viên và thu nhập từ việc đóng phim của mỗi diễn viên
select  DIENVIEN.Hoten as 'Tên diễn viên', sum((DONGPHIM.Dongia * DONGPHIM.Sogio)) as N'Thu nhập'
from DIENVIEN left join DONGPHIM on DIENVIEN.Madienvien=DONGPHIM.Madienvien
GROUP BY DIENVIEN.Hoten;

--12 Với mỗi diễn viên cho biết mã diễn viên mà số bộ phim mà diễn viên đó đóng.
select dv.Madienvien as N'Mã diễn viên', count(dp.Madienvien) as N'Số bộ phim'
from DIENVIEN dv left join DONGPHIM dp on dv.Madienvien=dp.Madienvien
group by dv.Madienvien

--13. Với mỗi diễn viên, cho biết tên diễn viên mà số bộ phim mà diễn viên đó đóng
select dv.Hoten as N'Mã diễn viên', count(dp.Madienvien) as N'Số bộ phim'
from DIENVIEN dv left join DONGPHIM dp on dv.Madienvien=dp.Madienvien
group by dv.Hoten

--14 Cho biết những mã diễn viên có số lần đóng là từ 2 bộ phim trở lên
select dv.Madienvien as N'Mã diễn viên', COUNT(dp.Madienvien) as N'Số bộ phim'
from DIENVIEN dv join DONGPHIM dp on dv.Madienvien=dp.Madienvien
group by dv.Madienvien
having COUNT(dp.Madienvien)>=2

--15 Cho biết tên những diễn viên đã đóng từ 2 bộ phim trở lên
select dv.Hoten as N'Mã diễn viên', COUNT(dp.Madienvien) as N'Số bộ phim'
from DIENVIEN dv join DONGPHIM dp on dv.Madienvien=dp.Madienvien
group by dv.Hoten
having COUNT(dp.Madienvien)>=2

--16 Cho biết tên diễn viên và tên thể loại phim sở trường của diễn viên của những diễn viên đã đóng từ
--2 bộ phim trở lên
select dv.Hoten as N'Tên diễn viên',tl.Tentheloai as N'Thể loại phim sở trường', COUNT(dp.Maphim) as N'Số bộ phim'
from DIENVIEN dv
join DONGPHIM dp on dv.Madienvien=dp.Madienvien
join THELOAI tl on dv.Theloaisotruong=tl.Matheloai
group by dv.Hoten ,tl.Tentheloai 
having  COUNT(dp.Maphim)>=2

--17 Với mỗi vai trò trong phim, cho biết đã có bao nhiêu diễn viên tham gia 
select dp.Vaitro as N'Vai trò', COUNT(dv.Madienvien) as N'Số diễn viên tham gia'
from DONGPHIM dp join DIENVIEN dv on dp.Madienvien=dv.Madienvien
group by dp.Vaitro


--18 Với mỗi phim cho biết mã phim và số lượng diễn viên tham gia
select dp.Maphim as N'Mã Phim', COUNT(dv.Madienvien) as N'Số diễn viên tham gia'
from DONGPHIM dp join DIENVIEN dv on dp.Madienvien=dv.Madienvien
group by  dp.Maphim

--19 Với mỗi phim cho biết tên phim, tên đạo diễn và số lượng diễn viên tham gia
select p.Tenphim as N'Tên phim', dd.Hoten as N'Tên đạo diễn', COUNT(dv.Madienvien) as N'Số lượng diễn viên tham gia'
from 
((PHIM p join DAODIEN dd on p.Madaodien=dd.Madaodien)
join DONGPHIM dp on p.Maphim=dp.Maphim) join DIENVIEN dv on dp.Madienvien=dv.Madienvien
group by p.Tenphim ,dd.Hoten 


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
