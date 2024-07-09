create database QuanLyDeTai
go
use QuanLyDeTai
go



--Q35. Cho biết mức lương cao nhất của các giảng viên.
select Luong as N'Lương'
from GIAOVIEN 
where Luong =(
 select max(Luong)
 from GIAOVIEN
 )
group by Luong

--Q36. Cho biết những giáo viên có lương lớn nhất.
select Magv as N'Mã giáo viên', Hoten as N'Tên giáo viên'
from GIAOVIEN
where Luong = all (
 select max(Luong)
 from GIAOVIEN
 )
 group by Magv, Hoten


--Q37. Cho biết lương cao nhất trong bộ môn “HTTT”.
select Luong as N'Luong'
from GIAOVIEN 
where Luong = (
select max(Luong)
from GIAOVIEN
where Mabm = N'HTTT'
)
group by Luong

--Q38. Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
select Hoten as N'Ho ten'
from GIAOVIEN
where YEAR(Ngaysinh)=(
select min(YEAR(Ngaysinh))
from GIAOVIEN
)
--Q39. Cho biết tên giáo viên nhỏ tuổi nhất khoa Công nghệ thông tin.
select Hoten as N'Họ tên'
from GIAOVIEN 
where YEAR(Ngaysinh)=(
select min(YEAR(Ngaysinh))
from GIAOVIEN gv 
join BOMON bm on gv.Mabm = bm.Mabm
join KHOA k on bm.Makhoa = k.Makhoa
where k.Tenkhoa like N'Công nghệ thông tin'
)

--Q40. Cho biết tên giáo viên và tên khoa của giáo viên có lương cao nhất.
select gv.Hoten as N'Họ tên', k.Tenkhoa as N'Tên khoa'
from GIAOVIEN gv 
join BOMON bm on gv.Mabm = bm.Mabm
join KHOA k on bm.Makhoa=k.Makhoa
where gv.Luong>=all(
select Luong from GIAOVIEN)

--Q41. Cho biết những giáo viên có lương lớn nhất trong bộ môn của họ.
select gv.Hoten as N'Họ tên', gv.Mabm as N'Mã bộ môn'
from GIAOVIEN gv join BOMON bm on gv.Mabm = bm.Mabm
where gv.Luong>=all(
select Luong from GIAOVIEN 
where Mabm=gv.Mabm)

--Q42. Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia.
select Tendt as N'Tên đề tài'
from DETAI
where Madt in(
  select  Madt
  from DETAI
  except
  select distinct Madt
  from THAMGIADETAI tg join GIAOVIEN gv on tg.Magv = gv.Magv
  where gv.Hoten like N'Nguyễn Hoài An'
)

--Q43. Cho biết những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia. Xuất ra tên đề tài, tên người chủ nhiệm đề tài.
select Tendt as N'Ten de tai', gv.Hoten as N'Giao vien CNDT'
from DETAI dt join GIAOVIEN gv on dt.Gvcndt = gv.Magv
where Madt in(
  select  Madt
  from DETAI
  except
  select distinct Madt
  from THAMGIADETAI tg join GIAOVIEN gv on tg.Magv = gv.Magv
  where gv.Hoten like N'Nguyễn Hoài An'
)

--Q44. Cho biết tên những giáo viên khoa Công nghệ thông tin mà chưa tham gia đề tài nào.
select gv.Hoten as N'Họ tên'
from GIAOVIEN gv 
join BOMON bm on gv.Mabm = bm.Mabm
join KHOA k on bm.Makhoa = k.Makhoa
where k.Tenkhoa like N'Công nghệ thông tin' and gv.Magv
not in (select  Magv from THAMGIADETAI)


--Q45. Tìm những giáo viên không tham gia bất kỳ đề tài nào
select Magv as N'mA GV'
from GIAOVIEN
where Magv
not in (select  Magv from THAMGIADETAI)

--Q46. Cho biết giáo viên có lương lớn hơn lương của giáo viên “Nguyễn Hoài An”
select gv1.Magv as N'Mã giáo viên'
from GIAOVIEN gv1
where gv1.Luong > (
select gv2.Luong 
from GIAOVIEN gv2 
where gv2.Hoten like N'Nguyễn Hoài An' and gv1.Magv <> gv2.Magv)

--Q47. Tìm những trưởng bộ môn tham gia tối thiểu 1 đề tài
select Magv as N'Ma giao vien'
from GIAOVIEN gv 
join BOMON bm on gv.Magv = bm.Truongbm
where gv.Magv in (
select Magv
from THAMGIADETAI
)
group by Magv

--Q48. Tìm giáo viên trùng tên và cùng giới tính với giáo viên khác trong cùng bộ môn
select gv1.Magv AS N'Mã giáo viên'
from GIAOVIEN gv1 
join GIAOVIEN gv2 on gv1.Mabm = gv2.Mabm
where gv1.Magv <> gv2.Magv and gv1.Phai=gv2.Phai and gv1.Hoten = gv2.Hoten

--Q49. Tìm những giáo viên có lương lớn hơn lương của ít nhất một giáo viên bộ môn “Công nghệ phần mềm”
select Magv as N'Mã giáo viên'
from GIAOVIEN
where Luong > (
select min(gv.Luong)
from GIAOVIEN gv
join BOMON bm on gv.Mabm = bm.Mabm
where bm.Tenbm like N'Công nghệ phần mềm')

--Q50. Tìm những giáo viên có lương lớn hơn lương của tất cả giáo viên thuộc bộ môn “Hệ thống thông tin”
select Magv as N'Mã giáo viên'
from GIAOVIEN
where Luong > (
select max(gv.Luong)
from GIAOVIEN gv
join BOMON bm on gv.Mabm = bm.Mabm
where bm.Tenbm like N'Hệ thống thông tin')

--Q51. Cho biết tên khoa có đông giáo viên nhất
select k.Tenkhoa as 'Tên khoa', count(gv.Magv) as N'Số giáo viên'
from GIAOVIEN gv
join BOMON bm on gv.Mabm = bm.Mabm
join KHOA k on bm.Makhoa = k.Makhoa
group by k.Tenkhoa
having count(gv.Magv) >= all(
  select count(gv1.Magv)
  from GIAOVIEN gv1
  join BOMON bm1 on gv1.Mabm = bm1.Mabm
  join KHOA k1 on bm1.Makhoa = k1.Makhoa
  group by k1.Makhoa
)

--Q52. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
select gv.Hoten as 'Họ tên', COUNT(gv.Magv) as N'Số đề tài'
from GIAOVIEN gv
join DETAI dt ON GV.Magv=dt.Gvcndt
group by gv.Hoten
having  COUNT(gv.Magv) >= all(
   select COUNT(gv1.Magv)
   from GIAOVIEN gv1
   join DETAI dt1 ON gv1.Magv=dt1.Gvcndt
   group by gv1.Magv
 )

--Q53. Cho biết mã bộ môn có nhiều giáo viên nhất
select bm.Mabm as 'Mã bộ môn', count(gv.Magv) as N'Số giáo viên'
from GIAOVIEN gv
join BOMON bm on gv.Mabm = bm.Mabm
group by  bm.Mabm 
having count(gv.Magv) >= all(
  select count(gv1.Magv)
  from GIAOVIEN gv1
  join BOMON bm1 on gv1.Mabm = bm1.Mabm
  group by bm1.Mabm
)

--Q54. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
select gv.Hoten as 'Tên giáo viên', bm.Tenbm as N'Tên bộ môn', COUNT(distinct tg.Madt) as N'Số đề tài tham gia'
from GIAOVIEN gv
join BOMON bm on gv.Mabm = bm.Mabm
join THAMGIADETAI tg on gv.Magv = tg.Magv
group by  gv.Hoten , bm.Tenbm 
having   COUNT(distinct tg.Madt) >= all(
   select COUNT(distinct tg1.Madt) 
   from GIAOVIEN gv1
   join THAMGIADETAI tg1 on gv1.Magv = tg1.Magv
   group by gv1.Magv
)

--Q55. Cho biết tên giáo viên tham gia nhiều đề tài nhất của bộ môn HTTT.
select gv.Hoten as 'Tên giáo viên', COUNT(distinct tg.Madt) as N'Số đề tài tham gia'
from GIAOVIEN gv
join THAMGIADETAI tg on gv.Magv = tg.Magv
where gv.Mabm = 'HTTT'
group by  gv.Hoten
having   COUNT(distinct tg.Madt) >= all(
   select COUNT(distinct tg1.Madt) 
   from GIAOVIEN gv1
   join THAMGIADETAI tg1 on gv1.Magv = tg1.Magv
   group by gv1.Magv
)

--Q56. Cho biết tên giáo viên và tên bộ môn của giáo viên có nhiều người thân nhất.
select gv.Hoten as 'Tên giáo viên', bm.Tenbm as N'Tên bộ môn', COUNT(gv.Magv) as N'Số người thân'
from GIAOVIEN gv
join BOMON bm on gv.Mabm = bm.Mabm
join NGUOITHAN nt on gv.Magv = nt.Magv
group by  gv.Hoten,bm.Tenbm
having  COUNT(gv.Magv) >= all(
   select COUNT(gv1.Magv) 
   from GIAOVIEN gv1
   join NGUOITHAN nt1 on gv1.Magv = nt1.Magv
   group by gv1.Magv
)
--Q57. Cho biết tên trưởng bộ môn mà chủ nhiệm nhiều đề tài nhất
select gv.Hoten as 'Họ tên',bm.Tenbm as N'Tên bộ môn', COUNT(gv.Magv) as N'Số đề tài'
from GIAOVIEN gv
join BOMON bm on gv.Magv = bm.Truongbm
join DETAI dt ON GV.Magv=dt.Gvcndt
group by gv.Hoten, bm.Tenbm 
having  COUNT(gv.Magv) >= all(
   select COUNT(gv1.Magv)
   from GIAOVIEN gv1
   join DETAI dt1 ON gv1.Magv=dt1.Gvcndt
   group by gv1.Magv
 )