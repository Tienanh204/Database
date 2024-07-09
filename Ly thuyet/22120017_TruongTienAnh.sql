--Họ tên: Trương Tiến Anh
--MSSV: 22120017
--Ca: 02
--Mã đề: 1

﻿Create database QLHocVienCK
Go
USE [QLHocVienCK]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN](
	[MaGV] [nchar](10) NOT NULL,
	[TenGV] [nvarchar](50) NULL,
	[NgaySinh] [datetime] NULL,
	[GioiTinh] [nvarchar](10) NULL,
	[DienThoai] [nchar](10) NULL,
	[MaGVQuanLi] [nchar](10) NULL,
 CONSTRAINT [PK_GIAOVIEN] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GIAOVIEN_DAY_MONHOC]    Script Date: 18/5/2022 8:13:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN_DAY_MONHOC](
	[MaGV] [nchar](10) NOT NULL,
	[MaMH] [nchar](10) NOT NULL,
	[ThamNien] [int] NULL,
	[SoLopDaDay] [int] NULL,
 CONSTRAINT [PK_GIAOVIEN_DAY_MONHOC] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOCVIEN]    Script Date: 18/5/2022 8:13:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOCVIEN](
	[MaHocVien] [nchar](10) NOT NULL,
	[TenHocVien] [nvarchar](50) NULL,
	[NgaySinh] [datetime] NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[MaLop] [nchar](10) NULL,
 CONSTRAINT [PK_Table1] PRIMARY KEY CLUSTERED 
(
	[MaHocVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KETQUA]    Script Date: 18/5/2022 8:13:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KETQUA](
	[MaHV] [nchar](10) NOT NULL,
	[MaMonHoc] [nchar](10) NOT NULL,
	[LanThi] [int] NOT NULL,
	[Diem] [float] NULL,
 CONSTRAINT [PK_KETQUA] PRIMARY KEY CLUSTERED 
(
	[MaHV] ASC,
	[MaMonHoc] ASC,
	[LanThi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOPHOC]    Script Date: 18/5/2022 8:13:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOPHOC](
	[MaLop] [nchar](10) NOT NULL,
	[SiSo] [int] NULL,
	[LopTruong] [nchar](10) NULL,
	[GVQuanLi] [nchar](10) NULL,
	[NamBatDau] [int] NULL,
	[NamKetThuc] [int] NULL,
 CONSTRAINT [PK_LOPHOC] PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MONHOC]    Script Date: 18/5/2022 8:13:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONHOC](
	[MaMonHoc] [nchar](10) NOT NULL,
	[TenMonHoc] [nvarchar](50) NULL,
	[SoChi] [int] NULL,
 CONSTRAINT [PK_MONHOC] PRIMARY KEY CLUSTERED 
(
	[MaMonHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHANCONG]    Script Date: 18/5/2022 8:13:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHANCONG](
	[MaGV] [nchar](10) NOT NULL,
	[MaMH] [nchar](10) NOT NULL,
	[MaLop] [nchar](10) NOT NULL,
 CONSTRAINT [PK_PHANCONG] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaMH] ASC,
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00001   ', N'Nguyễn Văn An', CAST(N'1981-01-02T00:00:00.000' AS DateTime), N'Nam', NULL, N'GV00002   ')
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00002   ', N'Nguyễn Thị Như Lan', CAST(N'1984-12-02T00:00:00.000' AS DateTime), N'Nữ', NULL, N'GV00005   ')
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00003   ', N'Trần Minh Anh', CAST(N'1986-03-23T00:00:00.000' AS DateTime), N'Nam', N'0909123999', N'GV00002   ')
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00004   ', N'Trương Tường Vi', CAST(N'1988-02-01T00:00:00.000' AS DateTime), N'Nữ', N'0998990909', N'GV00008   ')
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00005   ', N'Hà Anh Tuấn', CAST(N'1986-12-03T00:00:00.000' AS DateTime), N'Nam', N'0909909000', N'GV00008   ')
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00006   ', N'Trần Anh Dũng', CAST(N'1979-04-04T00:00:00.000' AS DateTime), N'Nam', NULL, N'GV00010   ')
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00007   ', N'Trần Duy Tân', CAST(N'1978-01-04T00:00:00.000' AS DateTime), N'Nam', NULL, N'GV00002   ')
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00008   ', N'Nguyễn Thị Linh', CAST(N'1979-07-08T00:00:00.000' AS DateTime), N'Nữ', N'0938079700', N'GV00009   ')
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00009   ', N'Trần Thị Kiều', CAST(N'1977-01-03T00:00:00.000' AS DateTime), N'Nữ', NULL, NULL)
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [TenGV], [NgaySinh], [GioiTinh], [DienThoai], [MaGVQuanLi]) VALUES (N'GV00010   ', N'Trần Phương Loan', CAST(N'1978-04-30T00:00:00.000' AS DateTime), N'Nữ', NULL, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00001   ', N'MH00001   ', 3, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00001   ', N'MH00004   ', 2, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00002   ', N'MH00001   ', 1, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00002   ', N'MH00002   ', 1, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00003   ', N'MH00006   ', 2, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00003   ', N'MH00007   ', 3, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00003   ', N'MH00010   ', 4, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00004   ', N'MH00009   ', 6, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00004   ', N'MH00010   ', 1, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00005   ', N'MH00008   ', 4, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00005   ', N'MH00010   ', 2, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00006   ', N'MH00008   ', 4, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00006   ', N'MH00009   ', 2, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00006   ', N'MH00010   ', 4, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00007   ', N'MH00010   ', 7, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00008   ', N'MH00001   ', 2, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00008   ', N'MH00002   ', 1, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00009   ', N'MH00010   ', 2, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00010   ', N'MH00001   ', 3, NULL)
GO
INSERT [dbo].[GIAOVIEN_DAY_MONHOC] ([MaGV], [MaMH], [ThamNien], [SoLopDaDay]) VALUES (N'GV00010   ', N'MH00002   ', 1, NULL)
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000001  ', N'Nguyễn Thùy Linh', CAST(N'1990-02-01T00:00:00.000' AS DateTime), N'buộc thôi học', N'LH000001  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000002  ', N'Nguyễn Thị Kiều Trang', CAST(N'1993-12-20T00:00:00.000' AS DateTime), N'đang học', N'LH000001  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000003  ', N'Nguyễn Xuân Thu', CAST(N'1994-12-30T00:00:00.000' AS DateTime), N'đang học', N'LH000002  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000004  ', N'Trần Trung Chính', CAST(N'1992-03-12T00:00:00.000' AS DateTime), N'đang học', N'LH000003  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000005  ', N'Trần Minh An', CAST(N'1991-12-03T00:00:00.000' AS DateTime), N'đang học', N'LH000003  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000006  ', N'Trương Mỹ Linh', CAST(N'1989-12-12T00:00:00.000' AS DateTime), N'đã tốt nghiệp', N'LH000004  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000007  ', N'Trần Hào', CAST(N'1989-02-02T00:00:00.000' AS DateTime), N'đã tốt nghiệp', N'LH000004  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000008  ', N'Nguyễn Huỳnh', CAST(N'1992-03-03T00:00:00.000' AS DateTime), N'đang học', N'LH000004  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000009  ', N'Nguyễn Xuân Trường', CAST(N'1993-03-13T00:00:00.000' AS DateTime), N'đang học', N'LH000005  ')
GO
INSERT [dbo].[HOCVIEN] ([MaHocVien], [TenHocVien], [NgaySinh], [TinhTrang], [MaLop]) VALUES (N'HV000010  ', N'Nguyễn Bình Minh', CAST(N'1992-03-12T00:00:00.000' AS DateTime), N'đang học', N'LH000004  ')
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000001  ', N'MH00001   ', 1, 5.5)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000001  ', N'MH00004   ', 1, 6)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000002  ', N'MH00001   ', 1, 7)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000002  ', N'MH00004   ', 1, 8)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000003  ', N'MH00008   ', 1, 8.7)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000003  ', N'MH00009   ', 1, 9)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000003  ', N'MH00010   ', 1, 4.5)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000004  ', N'MH00008   ', 1, 4)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000004  ', N'MH00008   ', 2, 3)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000004  ', N'MH00009   ', 1, 2)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000004  ', N'MH00009   ', 2, 5)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000004  ', N'MH00010   ', 1, 6)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000005  ', N'MH00004   ', 1, 10)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000005  ', N'MH00008   ', 1, 7.5)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000005  ', N'MH00009   ', 1, 1)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000005  ', N'MH00009   ', 2, 7)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000005  ', N'MH00009   ', 3, 10)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000005  ', N'MH00010   ', 1, 7)
GO
INSERT [dbo].[KETQUA] ([MaHV], [MaMonHoc], [LanThi], [Diem]) VALUES (N'HV000005  ', N'MH00010   ', 2, 4)
GO
INSERT [dbo].[LOPHOC] ([MaLop], [SiSo], [LopTruong], [GVQuanLi], [NamBatDau], [NamKetThuc]) VALUES (N'LH000001  ', 1, N'HV000002  ', N'GV00001   ', 2010, 2014)
GO
INSERT [dbo].[LOPHOC] ([MaLop], [SiSo], [LopTruong], [GVQuanLi], [NamBatDau], [NamKetThuc]) VALUES (N'LH000002  ', 1, N'HV000003  ', N'GV00003   ', 2009, 2013)
GO
INSERT [dbo].[LOPHOC] ([MaLop], [SiSo], [LopTruong], [GVQuanLi], [NamBatDau], [NamKetThuc]) VALUES (N'LH000003  ', 2, N'HV000004  ', N'GV00008   ', 2010, 2014)
GO
INSERT [dbo].[LOPHOC] ([MaLop], [SiSo], [LopTruong], [GVQuanLi], [NamBatDau], [NamKetThuc]) VALUES (N'LH000004  ', 4, N'HV000008  ', N'GV00010   ', 2011, 2015)
GO
INSERT [dbo].[LOPHOC] ([MaLop], [SiSo], [LopTruong], [GVQuanLi], [NamBatDau], [NamKetThuc]) VALUES (N'LH000005  ', 1, N'HV000009  ', N'GV00009   ', 2010, 2014)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00001   ', N'Cơ sở dữ liệu', 5)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00002   ', N'Cấu trúc dữ liệu', 6)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00003   ', N'Mạng máy tính', 4)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00004   ', N'Toán cao cấp', 6)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00005   ', N'Tin học cơ sở', 3)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00006   ', N'Công nghệ phân mềm', 4)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00007   ', N'Trí tuệ nhân tạo', 4)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00008   ', N'Khai thác dữ liệu', 3)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00009   ', N'Phân tích thiết kế hệ thống thông tin', 3)
GO
INSERT [dbo].[MONHOC] ([MaMonHoc], [TenMonHoc], [SoChi]) VALUES (N'MH00010   ', N'Hệ thống thông minh', 4)
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00001   ', N'MH00001   ', N'LH000001  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00001   ', N'MH00004   ', N'LH000001  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00003   ', N'MH00010   ', N'LH000005  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00004   ', N'MH00009   ', N'LH000004  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00005   ', N'MH00008   ', N'LH000002  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00005   ', N'MH00008   ', N'LH000004  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00006   ', N'MH00008   ', N'LH000003  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00006   ', N'MH00009   ', N'LH000002  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00006   ', N'MH00009   ', N'LH000003  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00006   ', N'MH00010   ', N'LH000004  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00007   ', N'MH00010   ', N'LH000002  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00007   ', N'MH00010   ', N'LH000003  ')
GO
INSERT [dbo].[PHANCONG] ([MaGV], [MaMH], [MaLop]) VALUES (N'GV00008   ', N'MH00002   ', N'LH000004  ')
GO
ALTER TABLE [dbo].[GIAOVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_GIAOVIEN] FOREIGN KEY([MaGVQuanLi])
REFERENCES [dbo].[GIAOVIEN] ([MaGV])
GO
ALTER TABLE [dbo].[GIAOVIEN] CHECK CONSTRAINT [FK_GIAOVIEN_GIAOVIEN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DAY_MONHOC]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DAY_MONHOC_GIAOVIEN] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GIAOVIEN] ([MaGV])
GO
ALTER TABLE [dbo].[GIAOVIEN_DAY_MONHOC] CHECK CONSTRAINT [FK_GIAOVIEN_DAY_MONHOC_GIAOVIEN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DAY_MONHOC]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DAY_MONHOC_MONHOC] FOREIGN KEY([MaMH])
REFERENCES [dbo].[MONHOC] ([MaMonHoc])
GO
ALTER TABLE [dbo].[GIAOVIEN_DAY_MONHOC] CHECK CONSTRAINT [FK_GIAOVIEN_DAY_MONHOC_MONHOC]
GO
ALTER TABLE [dbo].[HOCVIEN]  WITH CHECK ADD  CONSTRAINT [FK_Table1_LOPHOC] FOREIGN KEY([MaLop])
REFERENCES [dbo].[LOPHOC] ([MaLop])
GO
ALTER TABLE [dbo].[HOCVIEN] CHECK CONSTRAINT [FK_Table1_LOPHOC]
GO
ALTER TABLE [dbo].[KETQUA]  WITH CHECK ADD  CONSTRAINT [FK_KETQUA_MONHOC] FOREIGN KEY([MaMonHoc])
REFERENCES [dbo].[MONHOC] ([MaMonHoc])
GO
ALTER TABLE [dbo].[KETQUA] CHECK CONSTRAINT [FK_KETQUA_MONHOC]
GO
ALTER TABLE [dbo].[KETQUA]  WITH CHECK ADD  CONSTRAINT [FK_KETQUA_Table1] FOREIGN KEY([MaHV])
REFERENCES [dbo].[HOCVIEN] ([MaHocVien])
GO
ALTER TABLE [dbo].[KETQUA] CHECK CONSTRAINT [FK_KETQUA_Table1]
GO
ALTER TABLE [dbo].[LOPHOC]  WITH CHECK ADD  CONSTRAINT [FK_LOPHOC_GIAOVIEN] FOREIGN KEY([GVQuanLi])
REFERENCES [dbo].[GIAOVIEN] ([MaGV])
GO
ALTER TABLE [dbo].[LOPHOC] CHECK CONSTRAINT [FK_LOPHOC_GIAOVIEN]
GO
ALTER TABLE [dbo].[LOPHOC]  WITH CHECK ADD  CONSTRAINT [FK_LOPHOC_Table1] FOREIGN KEY([LopTruong])
REFERENCES [dbo].[HOCVIEN] ([MaHocVien])
GO
ALTER TABLE [dbo].[LOPHOC] CHECK CONSTRAINT [FK_LOPHOC_Table1]
GO
ALTER TABLE [dbo].[PHANCONG]  WITH CHECK ADD  CONSTRAINT [FK_PHANCONG_GIAOVIEN] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GIAOVIEN] ([MaGV])
GO
ALTER TABLE [dbo].[PHANCONG] CHECK CONSTRAINT [FK_PHANCONG_GIAOVIEN]
GO
ALTER TABLE [dbo].[PHANCONG]  WITH CHECK ADD  CONSTRAINT [FK_PHANCONG_LOPHOC] FOREIGN KEY([MaLop])
REFERENCES [dbo].[LOPHOC] ([MaLop])
GO
ALTER TABLE [dbo].[PHANCONG] CHECK CONSTRAINT [FK_PHANCONG_LOPHOC]
GO
ALTER TABLE [dbo].[PHANCONG]  WITH CHECK ADD  CONSTRAINT [FK_PHANCONG_MONHOC] FOREIGN KEY([MaMH])
REFERENCES [dbo].[MONHOC] ([MaMonHoc])
GO
ALTER TABLE [dbo].[PHANCONG] CHECK CONSTRAINT [FK_PHANCONG_MONHOC]
GO
	

--1. Cho danh sách các giảng viên (mã giảng viên, họ tên, số lớp) tham gia giảng dạy nhiều lớp nhất.
SELECT GV.MAGV, GV.TenGV, COUNT(PC.MaLop) AS SoLop
FROM GIAOVIEN GV 
JOIN PHANCONG PC ON GV.MaGV=PC.MaGV
GROUP BY GV.MAGV, GV.TenGV
HAVING COUNT(PC.MaLop) >= ALL(SELECT COUNT(MaLop)
							  FROM PHANCONG 
							  GROUP BY MaGV)
								

--2. Cho danh sách các học viên (mã học viên, họ tên, điểm trung bình) cao nhất của mỗi lớp.
--Biết rằng, dtb = (điểm * số tín chỉ)/tổng số tín chỉ của các môn đã thi đậu.
GO
CREATE FUNCTION DIEMTB(@MAHV VARCHAR(10))
	RETURNS FLOAT
AS
BEGIN
	DECLARE @SOTIN INT
	DECLARE @SOTINDAU INT
	DECLARE @DIEMTONG FLOAT
	DECLARE @DIEMTB FLOAT


	SET @SOTIN = (SELECT SUM(MH.SOCHI) 
				  FROM MONHOC MH
				  JOIN KETQUA KQ ON MH.MaMonHoc=KQ.MaMonHoc
				  WHERE KQ.MaHV=@MAHV)

	SET @SOTINDAU = (SELECT SUM(MH.SOCHI) 
					 FROM MONHOC MH
					 JOIN KETQUA KQ ON MH.MaMonHoc=KQ.MaMonHoc
					 WHERE KQ.MaHV=@MAHV AND KQ.Diem>=5)
				
	SET @DIEMTONG = (SELECT SUM(KQ.DIEM * MH.SOCHI)
					 FROM MONHOC MH
					 JOIN KETQUA KQ ON MH.MaMonHoc=KQ.MaMonHoc
					 WHERE KQ.MaHV=@MAHV)
	IF @SOTIN > 0
		BEGIN
			SET @DIEMTB = @DIEMTONG / @SOTIN * 1.0
		END
	ELSE
		BEGIN
			SET @DIEMTB = 0
		END
	RETURN @DIEMTB
END
GO
DECLARE @DIEM FLOAT
SET @DIEM = dbo.DIEMTB('HV000001')
PRINT @DIEM
GO

SELECT HV.MaHocVien, HV.TenHocVien, DBO.DIEMTB(HV.MaHocVien) AS DIEMTBM
FROM HOCVIEN HV
INNER JOIN LOPHOC LP ON HV.MaLop=LP.MaLop
WHERE DBO.DIEMTB(HV.MaHocVien) > ALL(SELECT DBO.DIEMTB(HV1.MaHocVien)
									  FROM HOCVIEN HV1 
									  JOIN LOPHOC LP1 ON HV1.MaLop=LP1.MaLop
									  WHERE HV1.MaHocVien<>HV.MaHocVien AND LP1.MaLop=LP.MaLop)

--3. Cho biết các giảng viên đã giảng dạy tất cả các môn học.
SELECT*
FROM GIAOVIEN GV
WHERE NOT EXISTS(
	  SELECT MaMonHoc FROM MONHOC
	  EXCEPT
	  SELECT DISTINCT PC1.MaMH
	  FROM GIAOVIEN GV1
	  JOIN PHANCONG PC1 ON GV1.MaGV=PC1.MaGV
	  WHERE GV1.MaGV=GV.MaGV)
GO

--4. Viết thủ tục thêm một đăng ký cho học viên. Biết rằng, mỗi học viên chỉ được học lại
--môn học tối đa 3 lần. Và không được đăng ký trùng môn khi đang học (chỉ đăng ký môn
--học khi đã đủ điểm của các lần thi môn học này). Lần thi được xác định là lần thi tiếp
--theo tính từ lần thi gần nhất.
CREATE PROC THEMDK
	@MAHV VARCHAR(10),
	@MAMH VARCHAR(10)
AS
BEGIN
	IF NOT EXISTS(SELECT MaHocVien FROM HOCVIEN WHERE @MAHV=MaHocVien)
		BEGIN
			RAISERROR('Học viên không tồn tại',15,1)
			RETURN
		END
	IF NOT EXISTS(SELECT MaMonHoc FROM MONHOC WHERE @MAMH=MaMonHoc)
		BEGIN
			RAISERROR('Học viên không tồn tại',15,1)
			RETURN
		END
	IF EXISTS(SELECT* FROM KETQUA WHERE MaHV=@MAHV AND MaMonHoc=@MAMH AND Diem IS NULL)
		BEGIN
			RAISERROR('Học viên đã đăng ký môn học trước đó',15,1)
			RETURN
		END
	IF (SELECT COUNT(LanThi) FROM KETQUA WHERE MaHV=@MAHV AND MaMonHoc=@MAMH) >= 3
		BEGIN
			RAISERROR('Học viên đã học môn học quá 3 lần',15,1)
			RETURN
		END
	DECLARE @LanThi INT
	SET @LanThi = ((SELECT COUNT(LanThi) FROM KETQUA WHERE MaHV=@MAHV AND MaMonHoc=@MAMH)) 
	INSERT INTO KETQUA (MaHV, MaMonHoc, LanThi, Diem) VALUES(@MAHV, @MAMH, @LanThi+1, NULL)
END
GO
EXEC THEMDK 'HV000001', 'MH00001'
GO
