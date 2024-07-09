go
use QuanLyDeTai
go

--Tinh tong 2 so
--C1: In ra tong 2 so
create proc SumAB
   @a int,
   @b int
as
begin
    declare @Tong int
	set @Tong = @a + @b
	print N'Tổng hai số: '
	print @Tong
end

exec SumAB 3, 2

go
--1. Stored Procedure
--C2: Tra ve tong qua 2 so
create proc SumAB1
   @a int,
   @b int
as
begin
	return @a + @b
end

declare @Tong int
exec @Tong = SumAB1 5 ,4
print @Tong

go

--Cho biet luong cua 1 giao vien
--C1: In ra luong 
create proc XuatLuongNV
    @manv varchar(5)
as
begin
    select Luong from GIAOVIEN where Magv = @manv
end

exec XuatLuongNV '004'

go

--C2: cho biet luong cua GV la chan hay le (Tra ve luong)
alter proc KiemTraLuongNV
    @magv varchar(5)
as
begin
    declare @Luong int
    --C1: Dung tu khoa set
	--set @Luong = (select Luong from GIAOVIEN) where Magv = @magv)
	--C2: Gán trực tiếp vào tên cột mà mình muốn trả về
	/*Note: lưu ý với 2 cách trên ta chỉ có thể gán @Luong cho 1 tập hợp mà nó trả về duy 
	nhất một giá trị, nếu gán cho 1 tập hợp trả về nhiều giá trị -> nó sẽ không 
	biết lấy cái nào -> nó sẽ lấy đại 1 giá trị nào đó để gán vô biến Luong hoặc báo lỗi */
	select @Luong = Luong from GIAOVIEN where Magv = @magv
	if @Luong % 2 = 0
		print N'Lương: ' + cast(@Luong as varchar(5)) + N' Chẵn'
	else
		print N'Lương: ' +  cast(@Luong as varchar(5)) + N' Lẻ'
end

exec KiemTraLuongNV '001'

go

--2. Function 
-- Cho danh sach cac giang vien lon hon 30 tuoi
--SQL:
select Magv, Hoten,  (YEAR(getdate())-YEAR(ngaysinh)) as Tuoi
from GIAOVIEN 
where  (YEAR(getdate())-YEAR(ngaysinh)) > 30
go
--C1: Dung ham
alter proc DSNhanVien_Tuoi
	@Sotuoi int
as
begin
	select Magv, Hoten, dbo.Fn_TinhTuoiNV(ngaysinh)  as Tuoi
    from GIAOVIEN  
    where  dbo.Fn_TinhTuoiNV(ngaysinh) > @Sotuoi
end

exec DSNhanVien_Tuoi 30
go
create function Fn_TinhTuoiNV(@ngaysinh datetime)
	returns int
as
begin
	return (YEAR(getdate())-YEAR(@ngaysinh))
end
go
--Cach goi ham
select dbo.Fn_TinhTuoiNV('1989-04-05')


--Tạo proc thêm gv (magv, hoten, mabm)
create proc ThemGV
	@magv varchar(5),
	@hoten nvarchar(30),
	@mabm varchar(5)
as
begin
	if exists (select *from GIAOVIEN where Magv=@magv)
		begin
			--Magv đã tồn tại -> báo lỗi trùng khóa
			raiserror(N'Mã giáo viên đã tồn tại', 16,1)
			return
		end
	else if exists (select * from GIAOVIEN where Mabm=@mabm)
		begin
			--Mabm không tồn tại, không hợp lệ -> báo lỗi trùng khóa
			raiserror(N'Mã bộ môn đã tồn tại', 16, 1)
			return
		end
	--insert into 
end

--Thêm một phân công cho giảng viên tham gia đề tài 001. Dự kiến: mỗi giáo viên không tham gia quá 2 đề tài
--Kiểm tra magv, madt tồn tại
--Kiểm tra số đt mà gv 001 đã tham gia hiện tại (count madt của gv 001)
--nếu số đề tài >=2 --> không cho phân công thêm nữa, báo lỗi , thoát
--Ngược lại: thêm mới phân công
