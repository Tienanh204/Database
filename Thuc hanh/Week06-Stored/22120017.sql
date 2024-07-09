go 
use QuanLyDeTai
go
--j. Xuất ra toàn bộ danh sách giáo viên.
create proc DanhSachGV
as
begin
	select * from GIAOVIEN
end
go
exec DanhSachGV
go

--k. Tính số lượng đề tài mà một giáo viên đang thực hiện.
create proc SoLuongDT
	@magv varchar(5)
as
begin
	if exists (select Magv from GIAOVIEN where Magv=@magv)
		begin
			select COUNT(*) as N'Số đề tài'
			from  DETAI dt
			where Gvcndt = @magv
		end
	else
		begin
			raiserror(N'Giáo viên không tồn tại', 16, 1)
			return
		end
end
go
exec SoLuongDT '001'
go

--l. In thông tin chi tiết của một giáo viên(sử dụng lệnh print): Thông tin cá
--nhân, Số lượng đề tài tham gia, Số lượng thân nhân của giáo viên đó.
create proc ThongTinGV
	@magv varchar(5)
as
begin
	--Thông tin GV
	declare @Hoten nvarchar(20)
	declare @Luong int
	declare @Phai nvarchar(20)
	declare @Ngsinh datetime
	declare @Diachi varchar(50)

	select @Hoten = Hoten from GIAOVIEN where Magv=@magv
	select @Luong = Luong from GIAOVIEN where Magv=@magv
	select @Phai = Phai from GIAOVIEN where Magv=@magv
	select @Ngsinh = Ngaysinh from GIAOVIEN where Magv=@magv
	select @Diachi = Diachi from GIAOVIEN where Magv=@magv

	print N'Mã giáo viên: ' + @magv
	print N'Họ tên: ' + @Hoten
	print N'Lương: ' + cast(@Luong as varchar(5))
	print N'Ngày sinh: ' + cast(@Ngsinh as varchar(20))
	print N'Địa chỉ: ' + @Diachi

	--Số đề tài tham gia, số thân nhân
	declare @Sodetai int
	declare @Songuoithan int

	set @Sodetai = (
	select COUNT(*)
	from THAMGIADETAI 
	where Magv=@magv )

	set @Songuoithan = (
	select COUNT(*)
	from NGUOITHAN 
	where Magv=@magv )

	print N'Số đề tài TG: ' + cast(@Sodetai as varchar(5))
	print N'Số người thân: ' + cast(@Songuoithan as varchar(5))
end
go
exec ThongTinGV '002'
go

--m. Kiểm tra xem một giáo viên có tồn tại hay không (dựa vào MAGV).
create proc KiemTraGV
	@magv varchar(5)
as
begin
	if exists (select Magv from GIAOVIEN where Magv=@magv)
		begin
			print N'Giáo viên tồn tại'
			return
		end
	else
		begin
			raiserror(N'Giáo viên không tồn tại', 16, 1)
			return
		end
end
go
exec KiemTraGV '001'
go

--n. Kiểm tra quy định của một giáo viên: Chỉ được thực hiện các đề tài mà bộ
--môn của giáo viên đó làm chủ nhiệm.
create function KiemTraQD (@magv varchar(5), @madt varchar(5))
	returns int
as
begin
	if exists (
	    select dt.Tendt
		from GIAOVIEN gv 
		join BOMON bm on bm.Mabm=gv.Mabm
		join DETAI dt on dt.Gvcndt=bm.Truongbm
		where gv.Magv=@magv and dt.Madt=@madt)
		return 1
	else
		return 0
	return 0
end
go

/*giáo viên phải tham gia đề tài
do trưởng bộ môn của giáo viên 
đó làm chủ nhiệm*/
--proc chính
create proc QuyDinhGV
	@magv varchar(5),
	@madt varchar(5)
as
begin
	if dbo.KiemTraQD(@magv, @madt) = 1
		begin
			print N'Giáo viên được phép thực hiện đề tài '+ @madt
			return
		end
	else
		begin
			print N'Giáo viên không được phép thực hiện đề tài '+@madt
			return
		end
end
go
exec QuyDinhGV '009', '007'
go

/* o. Thực hiện thêm một phân công cho giáo viên thực hiện một công việc của
đề tài:
+ Kiểm tra thông tin đầu vào hợp lệ: giáo viên phải tồn tại, công việc
phải tồn tại, thời gian tham gia phải >0
+ Kiểm tra quy định ở câu n. */
create proc PhanCongGV
	@magv varchar(5),
	@madt varchar(5),
	@stt varchar(5)
as
begin
	if not exists (select Magv from GIAOVIEN where Magv=@magv)
		begin
			print N'Thêm không thành công'
			raiserror(N'Mã giáo viên không tồn tại', 16, 1)
			return
		end
	if not exists (select Madt from CONGVIEC where Madt=@madt and Stt=@stt and 
					DAY(Ngaybd) > 0 and MONTH(Ngaybd) > 0 and YEAR(Ngaybd) > 0 )
		begin
			print N'Thêm không thành công'
			raiserror(N'Công việc không tồn tại', 16, 1)
			return
		end
	if dbo.KiemTraQD (@magv, @madt) = 0
		begin
			print N'Thêm không thành công'
			raiserror(N'Giáo viên không được phép thực hiện công việc', 16, 1)
			return
		end
	--Kiểm tra nếu insert trùng thì báo lỗi
	if exists (select * from THAMGIADETAI where Magv=@magv and Madt=@madt and Stt=@stt)
		begin
			print N'Thêm không thành công'
			raiserror(N'Công việc đã được phân công trước đó', 16, 1)
			return
		end

	insert into THAMGIADETAI (Magv, Madt, Stt) values (@magv, @madt, @stt)
	print N'Thêm thành công'

end
go
exec PhanCongGV '001', '001', '1'
go

/* p. Thực hiện xoá một giáo viên theo mã. Nếu giáo viên có thông tin liên quan
(Có thân nhân, có làm đề tài, ...) thì báo lỗi.*/
create proc XoaGV
	@magv varchar(5)
as
begin
	if not exists (select Magv from GIAOVIEN where Magv=@magv)
		begin
			print N'Không thể xóa giáo viên'
			raiserror(N'Giáo viên không tồn tại', 16, 1)
			return
		end
	if exists (select Magv from NGUOITHAN where Magv=@magv)
		begin
			raiserror(N'Không thể xóa giáo viên', 16, 1)
			return
		end
	if exists (select Magv from THAMGIADETAI where Magv=@magv)
		begin
			raiserror(N'Không thể xóa giáo viên', 16, 1)
			return
		end
	if exists (select Truongbm from BOMON where Truongbm=@magv)
		begin
			raiserror(N'Không thể xóa giáo viên', 16, 1)
			return
		end	
	if exists (select Truongkhoa from KHOA where Truongkhoa=@magv)
		begin
			raiserror(N'Không thể xóa giáo viên', 16, 1)
			return
		end
	if exists (select Gvcndt from DETAI where Gvcndt=@magv)
		begin
			raiserror(N'Không thể xóa giáo viên', 16, 1)
			return
		end
	if exists (select Magv from GV_DT where Magv=@magv)
		begin
			raiserror(N'Không thể xóa giáo viên', 16, 1)
			return
		end

	delete from GIAOVIEN where Magv=@magv
	print N'Đã xóa giáo viên + ' + @magv

end
go
exec XoaGV '002'
go

/* q. In ra danh sách giáo viên của một phòng ban nào đó cùng với số lượng đề
tài mà giáo viên tham gia, số thân nhân, số giáo viên mà giáo viên đó quản
lý nếu có, ...*/ 
alter proc InDanhSachGV
	@mabm varchar(5)
as
begin
	if not exists (select Mabm from BOMON where Mabm=@mabm)
		begin
			raiserror(N'Phòng ban không tôn tại', 16, 1)
			return
		end
	select gv.Magv,gv.Hoten,
	(select count(distinct tg.Madt) from THAMGIADETAI tg where tg.Magv=gv.Magv) as SoDTThamGia,
	/*(select count(nt.Magv) from NGUOITHAN nt where nt.Magv=gv.Magv 
	group by nt.Magv having count(nt.Magv) = 2
	) as SoTNBM,*/
	(select count(Magv) from Giaovien gv1 where Gvqlbm = gv.Magv) as SoGVDangQL,
	count(nt.Magv) 
	from Giaovien gv join NGUOITHAN nt on nt.Magv=gv.Magv 
	where gv.Mabm=@mabm
	group by gv.Magv,gv.Hoten
	having count(nt.Magv) >= all(select count(nt1.Magv) from GIAOVIEN gv1 join NGUOITHAN nt1 on gv1.Magv=nt1.Magv group by gv1.Magv)

end
go
exec InDanhSachGV 'HPT'
go

select 

/* r. Kiểm tra quy định của 2 giáo viên a, b: Nếu a là trưởng bộ môn c của b thì
lương của a phải cao hơn lương của b. (a, b: mã giáo viên)*/
create proc KiemTraAB 
		@magvA varchar(5), 
		@magvB varchar(5)
as
begin
	if not exists (select Magv from GIAOVIEN where Magv=@magvA)
		begin
			raiserror(N'Giáo viên A không tôn tại', 16, 1)
			return
		end
	if not exists (select Magv from GIAOVIEN where Magv=@magvB)
		begin
			raiserror(N'Giáo viên B không tôn tại', 16, 1)
			return
		end
	if exists ( 
		select * 
		from GIAOVIEN gv1
		join BOMON bm on gv1.Magv=bm.Truongbm
		join GIAOVIEN gv2 on gv2.Mabm=bm.Mabm
		where gv1.Magv=@magvA and gv2.Magv=@magvB and gv1.Luong > gv2.Luong )
		print N'A là trưởng bộ môn của B'
	else
		print N'A không là trưởng bộ môn của B'
end
go
exec KiemTraAB '001', '002'
go

/* s. Thêm một giáo viên: Kiểm tra các quy định: Không trùng tên, tuổi > 18,
lương > 0 */
create proc ThemGV
	@magv varchar(5),
	@hoten nvarchar(30),
	@luong int,
	@phai nvarchar(30),
	@ngaysinh datetime,
	@diachi nvarchar(50)
as
begin
	if exists (select Magv from GIAOVIEN where Magv=@magv)
		begin
			print N'Không thể thêm giáo viên'
			raiserror(N'Giáo viên đã tồn tại', 16, 1)
			return
		end
	if exists (select * from GIAOVIEN where Hoten=@hoten)
		begin
			print N'Không thể thêm giáo viên'
			raiserror(N'Tên giáo viên đã tồn tại', 16, 1)
			return
		end
	if @luong < 0 
		begin
			print N'Không thể thêm giáo viên'
			raiserror(N'Lương < 0', 16, 1)
			return
		end
	if (YEAR(GETDATE())-YEAR(@ngaysinh)) <=18 
		begin
			print N'Không thể thêm giáo viên'
			raiserror(N'Tuổi <= 18', 16, 1)
			return
		end
	insert into GIAOVIEN (Magv, Hoten, Luong, Phai, Ngaysinh, Diachi)
						values (@magv, @hoten, @luong, @phai, @ngaysinh, @diachi)
	print N'Thêm giáo viên thành công'
end
go
exec ThemGV '011', N'Trương Tiến Anh', 20000, 'Nam', '2004-6-21', N'Gia lai'
go

/* t. Mã giáo viên được xác định tự động theo quy tắc: Nếu đã có giáo viên 001,
002, 003 thì MAGV của giáo viên mới sẽ là 004. Nếu đã có giáo viên 001,
002, 005 thì MAGV của giáo viên mới là 003.*/
create proc XacDinhMaGV
as
begin
	declare @magv varchar(5)
	declare @cnt int
	declare @i int
	
	set @cnt = (select COUNT(*) from GIAOVIEN)
	set @i = 1
	
	while (@i <= @cnt)
		begin
			set @magv = REPLICATE('0', 3-len(cast(@i as varchar(5)))) + cast(@i as varchar(5))
			if not exists (select Magv from GIAOVIEN where Magv=@magv)
				begin
					print N'Mã giáo viên mới: ' + @magv
					return
				end
			set @i = @i+1
		end
	set @magv = REPLICATE('0', 3-len(cast(@i as varchar(5)))) + cast(@i as varchar(5))
	print N'Mã giáo viên mới: ' + @magv
end
go
exec XacDinhMaGV
go
