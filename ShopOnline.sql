use master
go

drop database ShopOnline
go
-- Tạo database ShopOnline_Demo
create database ShopOnline
go
use ShopOnline
go
-- 1: Tạo Table [Accounts] chứa tài khoản thành viên được phép sử dụng các trang quản trị ----
create table TaiKhoan
(
	taiKhoan varchar(20) primary key not null,
	matKhau varchar(20) not null,
	hoDem nvarchar(50) null,
	tenTV nvarchar(30) not null,
	ngaysinh datetime ,
	gioiTinh bit default 1,
	soDT nvarchar(20),
	email nvarchar(50),
	diaChi nvarchar(250),
	trangThai bit default 0,
	ghiChu ntext
)
go

-- 2: Tạo Table [Customers] chứa Thông tin khách hàng  ---------------------------------------
create table KhachHang
(
	maKH varchar(10) primary key not null,
	tenKH nvarchar(50) not null,
	soDT varchar(20) ,
	email varchar(50),
	diaChi nvarchar(250),
	ngaySinh datetime ,
	gioiTinh bit default 1,
	ghiChu ntext
)
go

-- 3: Tạo Table [Articles] chứa thông tin về các bài viết phục vụ cho quảng bá sản phẩm, ------
--    xu hướng mua sắm hiện nay của người tiêu dùng , ...             ------------------------- 
create table BaiViet
(
	maBV varchar(10) primary key not null,
	tenBV nvarchar(250) not null,
	hinhDD varchar(max),
	ndTomTat nvarchar(2000),
	ngayDang datetime ,
	loaiTin nvarchar(30),
	noiDung nvarchar(4000),
	taiKhoan varchar(20) not null ,
	daDuyet bit default 0,
	foreign key (taiKhoan) references taiKhoan(taiKhoan) on update cascade 
)
go
-- 4: Tạo Table [LoaiSP] chứa thông tin loại sản phẩm, ngành hàng -----------------------------
create table LoaiSP
(
	maLoai int primary key not null identity,
	tenLoai nvarchar(88) not null,
	ghiChu ntext default ''
)
go
-- 4: Tạo Table [Products] chứa thông tin của sản phẩm mà shop kinh doanh online --------------
create table SanPham
(
	maSP varchar(10) primary key not null,
	tenSP nvarchar(500) not NULL,
	hinhDD varchar(max) DEFAULT '',
	ndTomTat nvarchar(2000) DEFAULT '',
	ngayDang DATETIME DEFAULT CURRENT_TIMESTAMP,
	maLoai int not null references LoaiSP(maLoai),
	noiDung nvarchar(4000) DEFAULT '',
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade,
	dvt nvarchar(32) default N'Cái',
	daDuyet bit default 0,
	giaBan INTEGER DEFAULT 0,
	giamGia INTEGER DEFAULT 0 CHECK (giamGia>=0 AND giamGia<=100),
	nhaSanXuat nvarchar(168) default ''
)
go

-- 5: Tạo Table [Orders] chứa danh sách đơn hàng mà khách đã đặt mua thông qua web ------------
create table DonHang
(
	soDH varchar(10) primary key not null ,
	maKH varchar(10) not null foreign key references khachHang(maKH),
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade ,
	ngayDat datetime,
	daKichHoat bit default 1,
	ngayGH datetime,
	diaChiGH nvarchar(250),
	ghiChu ntext
)
go	

-- 6: Tạo Table [OrderDetails] chứa thông tin chi tiết của các đơn hàng ---
--    mà khách đã đặt mua với các mặt hàng cùng số lượng đã chọn ---------- 
create table CtDonHang	
(
	soDH varchar(10) not null foreign key references donHang(soDH),
	maSP varchar(10) not null foreign key references sanPham(maSP),
	soLuong int,
	giaBan bigint,
	giamGia BIGINT,
	PRIMARY KEY (soDH, maSP)
)
go


/*========================== Nhập dữ liệu mẫu ==============================*/

GO
insert into LoaiSP(tenLoai) values(N'Sản phẩm mới')
insert into LoaiSP(tenLoai) values(N'Top Bán Chạy')
insert into LoaiSP(tenLoai) values(N'Sắp Ra Mắt')
go
-- YC3: Nhập thông tin bài viết, Tối thiểu 10 bài viết thuộc loại: giới thiệu sản phẩm, khuyến mãi, quảng cáo, ... 
--      liên quan đến sản phẩm mà bạn dự định kinh doanh trong đồ án sẽ thực hiện
-- Dụng cụ nhà bếp -------------------------------------------------------------------------------------------------------
go
			-------------------- Dữ liệu LapG Gigabyte----------------------
			-----------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Gigabyte1', N'Laptop GIGABYTE AERO 15 OLED KD 72S1623GH', N'~/Storage/Image/laptop/LapG/Gigabyte/Laptop GIGABYTE AERO 15 OLED KD 72S1623GH.png',
			          N'Nhà sản xuất: GIGABYTE
						Xuất xứ: Chính hãng
						Bảo hành: 24 Tháng 
						Tình trạng: Mới ', 'admin',47990000,3,6,N'Gigabyte', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Gigabyte2', N'Laptop GIGABYTE AORUS 15P KD 72S1223GH', N'~/Storage/Image/laptop/LapG/Gigabyte/Laptop GIGABYTE AORUS 15P KD 72S1223GH.png',
			          N'Nhà sản xuất: GIGABYTE
						Xuất xứ: Chính hãng
						Bảo hành: 24 tháng 
						Tình trạng: Mới 100% ', 'admin',45990000,2,6,N'Gigabyte', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Gigabyte3', N'Laptop GIGABYTE AORUS 15P XD 73S1324GH', N'~/Storage/Image/laptop/LapG/Gigabyte/Laptop GIGABYTE AORUS 15P XD 73S1324GH.png',
			          N'Nhà sản xuất: GIGABYTE
						Xuất xứ: Chính hãng
						Bảo hành: 24 tháng 
						Tình trạng: Mới 100%', 'admin',51990000,5,6,N'Gigabyte', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Gigabyte4', N'Laptop GIGABYTE AORUS 15P YD 73S1224GH', N'~/Storage/Image/laptop/LapG/Gigabyte/Laptop GIGABYTE AORUS 15P YD 73S1224GH.png',
			          N'Nhà sản xuất: GIGABYTE
						Xuất xứ: Chính hãng
						Bảo hành: 24 tháng 
						Tình trạng: Mới 100%', 'admin',72490000,3,6,N'Gigabyte', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Gigabyte5', N'Laptop GIGABYTE G5 KC 5S11130SB', N'~/Storage/Image/laptop/LapG/Gigabyte/Laptop GIGABYTE G5 KC 5S11130SB.png',
			          N'Nhà sản xuất : GIGABYTE
						Xuất xứ : Chính hãng
						Bảo hành : 24 tháng 
						Tình trạng : Mới 100%
 ', 'admin',27990000,3,6,N'Gigabyte', N'Bộ');
go

go
				-------------------------- Dữ liệu MSIG ------------------------
				----------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIG1', N'Laptop Gaming MSI Bravo 15 B5DD 275VN', N'~/Storage/Image/laptop/LapG/MSI/Laptop Gaming MSI Bravo 15 B5DD 275VN.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',25990000,3,3,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIG2', N'Laptop Gaming MSI Bravo 15 B5DD 276VN', N'~/Storage/Image/laptop/LapG/MSI/Laptop Gaming MSI Bravo 15 B5DD 276VN.jpg',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',39990000,5,3,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIG3', N'Laptop Gaming MSI GF63 Thin 10SC 020VN', N'~/Storage/Image/laptop/LapG/MSI/Laptop Gaming MSI GF63 Thin 10SC 020VN.png',
			          N'Nhà sản xuất : MSI 
Xuất xứ : Chính hãng
Bảo hành : 24 tháng 
Tình trạng : Mới 100%
Màu sắc : Đen Đỏ', 'admin',30990000,2,3,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIG4', N'Laptop MSI Creator Z16 A11UET 217VN', N'~/Storage/Image/laptop/LapG/MSI/Laptop MSI Creator Z16 A11UET 217VN.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',59990000,4,3,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIG5', N'Laptop MSI Creator Z16 A11UET 218VN', N'~/Storage/Image/laptop/LapG/MSI/Laptop MSI Creator Z16 A11UET 218VN.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',69990000,4,3,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIG6', N'Laptop MSI Creator Z16 A11UET 217VN', N'~/Storage/Image/laptop/LapG/MSI/Laptop MSI Creator Z16 A11UET 217VN.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',69990000,4,3,N'MSI', N'Bộ');
go

go
				-------------------------- Dữ liệu LenovoG -------------------------
				--------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LenovoG1', N'Laptop Lenovo IdeaPad 5 Pro 14ACN6 82L7007XVN', N'~/Storage/Image/laptop/LapG/Lenovo/Laptop Lenovo IdeaPad 5 Pro 14ACN6 82L7007XVN.png',
			          N'Thương hiệu: LENOVO
Tình trạng: Mới 
Bảo hành: 12 Tháng
Màu sắc: Bạc', 'admin',22990000,2,4,N'Lenovo', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LenovoG2', N'Laptop Lenovo IdeaPad 5 Pro 14ACN6 82L7007YVN', N'~/Storage/Image/laptop/LapG/Lenovo/Laptop Lenovo IdeaPad 5 Pro 14ACN6 82L7007YVN.png',
			          N'Thương hiệu: LENOVO
Tình trạng: Mới 
Bảo hành: 12 Tháng
Màu sắc: Xám', 'admin',25990000,1,4,N'Lenovo', N'Bộ');
go

go
				-------------------------- Dữ liệu HPG ---------------------------
				------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HPG1', N'Laptop Gaming HP Omen 16 b0123TX 4Y0W6PA', N'~/Storage/Image/laptop/LapG/HP/Laptop Gaming HP Omen 16 b0123TX 4Y0W6PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',58490000,5,5,N'HP', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HPG2', N'Laptop Gaming HP Omen 16 b0127TX 4Y0W7PA', N'~/Storage/Image/laptop/LapG/HP/Laptop Gaming HP Omen 16 b0127TX 4Y0W7PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',45990000,3,5,N'HP', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HPG3', N'Laptop Gaming HP Omen 16 b0141TX 4Y0Z7PA', N'~/Storage/Image/laptop/LapG/HP/Laptop Gaming HP Omen 16 b0141TX 4Y0Z7PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',38490000,3,5,N'HP', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HPG4', N'Laptop Gaming HP Omen 16 b0142TX 4Y0Z8PA', N'~/Storage/Image/laptop/LapG/HP/Laptop Gaming HP Omen 16 b0142TX 4Y0Z8PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',28490000,3,5,N'HP', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HPG5', N'Laptop Gaming HP VICTUS 16 d0197TX 4R0T9PA', N'~/Storage/Image/laptop/LapG/HP/Laptop Gaming HP VICTUS 16 d0197TX 4R0T9PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',38490000,2,5,N'HP', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HPG6', N'Laptop Gaming HP VICTUS 16 e0175AX 4R0U8PA', N'~/Storage/Image/laptop/LapG/HP/Laptop Gaming HP VICTUS 16 e0175AX 4R0U8PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',24990000,3,5,N'HP', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HPG7', N'Laptop Gaming HP VICTUS 16 e0177AX 4R0U9PA', N'~/Storage/Image/laptop/LapG/HP/Laptop Gaming HP VICTUS 16 e0177AX 4R0U9PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',22990000,1,5,N'HP', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HPG8', N'Laptop Gaming HP VICTUS 16 e0179AX 4R0V0PA', N'~/Storage/Image/laptop/LapG/HP/Laptop Gaming HP VICTUS 16 e0179AX 4R0V0PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',26490000,3,5,N'HP', N'Bộ');
go

go
				------------------------- Dữ liệu DellG ---------------------------
				-------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellG', N'Laptop Gaming Dell Alienware M15 R6 P109F001BBL', N'~/Storage/Image/laptop/LapG/Dell/Laptop Gaming Dell Alienware M15 R6 P109F001BBL.png',
			          N'Nhà sản xuất : DELL
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng (Premium Support)
Tình trạng : Mới 100%', 'admin',61990000,2,7,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellG2', N'Laptop Gaming Dell G15 5511 70266676', N'~/Storage/Image/laptop/LapG/Dell/Laptop Gaming Dell G15 5511 70266676.jpg',
			          N'Nhà sản xuất : DELL
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng (Premium Support)
Tình trạng : Mới 100%', 'admin',61990000,2,7,N'Dell', N'Bộ');
go

go
				--------------- Dữ liệu AcerG -----------------------
				-----------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG1', N'Laptop Gaming Acer Aspire 7 A715 42G R05G', N'~/Storage/Image/laptop/LapG/Acer/Laptop Gaming Acer Aspire 7 A715 42G R05G.png',
			          N'Nhà sản xuất : ACER
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới ', 'admin',20490000,0,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG2', N'Laptop gaming Acer Nitro 5 AN515 45 R9SC', N'~/Storage/Image/laptop/LapG/Acer/Laptop gaming Acer Nitro 5 AN515 45 R9SC.png',
			          N'Nhà sản xuất : ACER
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',37990000,2,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG3', N'Laptop Gaming Acer Nitro 5 AN515 57 56S5', N'~/Storage/Image/laptop/LapG/Acer/Laptop Gaming Acer Nitro 5 AN515 57 56S5.png',
			          N'Nhà sản xuất : ACER
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới ', 'admin',20990000,0,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG4', N'Laptop Gaming Acer Nitro 5 AN515 57 71VV', N'~/Storage/Image/laptop/LapG/Acer/Laptop Gaming Acer Nitro 5 AN515 57 71VV.png',
			          N'Nhà sản xuất : ACER
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới ', 'admin',28990000,2,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG5', N'Laptop gaming Acer Nitro 5 Eagle AN515 57 54MV', N'~/Storage/Image/laptop/LapG/Acer/Laptop gaming Acer Nitro 5 Eagle AN515 57 54MV.png',
			          N'Nhà sản xuất : ACER
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới ', 'admin',25990000,2,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG6', N'Laptop Gaming Acer Nitro 5 Eagle AN515 57 5669', N'~/Storage/Image/laptop/LapG/Acer/Laptop Gaming Acer Nitro 5 Eagle AN515 57 5669.png',
			          N'Nhà sản xuất: ACER
Bảo hành: 12 Tháng
Tình trạng: Mới', 'admin',23990000,2,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG7', N'Laptop Gaming Acer Predator Helios 300 PH315 54 75YD', N'~/Storage/Image/laptop/LapG/Acer/Laptop Gaming Acer Predator Helios 300 PH315 54 75YD.png',
			          N'Nhà sản xuất : ACER
Bảo hành : 12 tháng
Tình trạng : Mới 100%', 'admin',39990000,5,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG8', N'Laptop ConceptD 3 Ezel CC314 72G 75SM', N'~/Storage/Image/laptop/LapG/Acer/Laptop ConceptD 3 Ezel CC314 72G 75SM.png',
			          N'Nhà sản xuất : ACER
Bảo hành : 12 tháng
Tình trạng : Mới 100%', 'admin',39990000,5,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG9', N'Laptop ConceptD 3 Ezel Pro CC314 72P 75EG', N'~/Storage/Image/laptop/LapG/Acer/Laptop ConceptD 3 Ezel Pro CC314 72P 75EG.png',
			          N'Nhà sản xuất : ACER
Bảo hành : 12 tháng
Tình trạng : Mới 100%', 'admin',39990000,5,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG10', N'Laptop ConceptD 7 Ezel CC715 71 7940', N'~/Storage/Image/laptop/LapG/Acer/Laptop ConceptD 7 Ezel CC715 71 7940.png',
			          N'Nhà sản xuất : ACER
Bảo hành : 12 tháng
Tình trạng : Mới 100%', 'admin',39990000,5,2,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerG11', N'Laptop ConceptD 7 Ezel Pro CC715 91P X8CX(150tr)', N'~/Storage/Image/laptop/LapG/Acer/Laptop ConceptD 7 Ezel Pro CC715 91P X8CX(150tr).png',
			          N'Nhà sản xuất : ACER
Bảo hành : 12 tháng
Tình trạng : Mới 100%', 'admin',39990000,5,2,N'Acer', N'Bộ');
go

go
				-------------- Dữ liệu AsusG ------------------------
				-----------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG1', N'Laptop Asus ROG Strix SCAR 15 G533QR HQ098T', N'~/Storage/Image/laptop/LapG/Asus/Laptop Asus ROG Strix SCAR 15 G533QR HQ098T.png',
			          N' Nhà sản xuất : ASUS
- Xuất xứ : Chính hãng
- Bảo hành : 24 Tháng
- Tình trạng : Mới 100%', 'admin',59990000,2,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG2', N'Laptop ASUS TUF Gaming F15 FX506HCB HN139T', N'~/Storage/Image/laptop/LapG/Asus/Laptop ASUS TUF Gaming F15 FX506HCB HN139T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',25490000,3,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG3', N'Laptop Gaming Asus ROG Flow X13 GV301QC K6029T', N'~/Storage/Image/laptop/LapG/Asus/Laptop Gaming Asus ROG Flow X13 GV301QC K6029T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Màu sắc : Off Black', 'admin',79990000,4,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG4', N'Laptop Gaming Asus ROG Flow X13 GV301QC K6052T', N'~/Storage/Image/laptop/LapG/Asus/Laptop Gaming Asus ROG Flow X13 GV301QC K6052T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Màu sắc : Off Black', 'admin',39990000,3,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG5', N'Laptop Gaming Asus ROG Strix G15 G513IH HN015T', N'~/Storage/Image/laptop/LapG/Asus/Laptop Gaming Asus ROG Strix G15 G513IH HN015T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới', 'admin',23990000,2,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG6', N'Laptop Gaming Asus ROG Strix SCAR 15 G533QM HF089T', N'~/Storage/Image/laptop/LapG/Asus/Laptop Gaming Asus ROG Strix SCAR 15 G533QM HF089T.png',
			          N'- Nhà sản xuất : ASUS
- Xuất xứ : Chính hãng
- Bảo hành : 24 Tháng
- Tình trạng : Mới 100%
 ', 'admin',49990000,3,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG7', N'Laptop Gaming Asus ROG Zephyrus G14 GA401QE K2097T', N'~/Storage/Image/laptop/LapG/Asus/Laptop Gaming Asus ROG Zephyrus G14 GA401QE K2097T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Màu sắc : Eclipse Gray (không có AniMe Matrix)', 'admin',39990000,2,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG8', N'Laptop Gaming Asus ROG Zephyrus G15 GA503QM HQ158T', N'~/Storage/Image/laptop/LapG/Asus/Laptop Gaming Asus ROG Zephyrus G15 GA503QM HQ158T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Màu sắc : Eclipse Gray', 'admin',45990000,3,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG9', N'Laptop Gaming Asus TUF Dash F15 FX516PC HN002T', N'~/Storage/Image/laptop/LapG/Asus/Laptop Gaming Asus TUF Dash F15 FX516PC HN002T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',28490000,0,1,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusG10', N'Laptop Gaming Asus TUF Dash F15 FX516PM HN002W', N'~/Storage/Image/laptop/LapG/Asus/Laptop Gaming Asus TUF Dash F15 FX516PM HN002W.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',28490000,0,1,N'Asus', N'Bộ');
go


go
				-------------------------- Dữ liệu DellHT ----------------------
				----------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT1', N'Laptop Dell 15 Inspiron 3501 P90F005N N3501B', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell 15 Inspiron 3501 P90F005N N3501B.png',
			          N'Nhà sản xuất : Dell
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới ', 'admin',18990000,1,20,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT2', N'Laptop Dell Inspiron 14 5415 70262929', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell Inspiron 14 5415 70262929.png',
			          N'Nhà sản xuất : Dell
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới ', 'admin',19590000,2,20,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT3', N'Laptop Dell Inspiron 15 3505 Y1N1T1', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell Inspiron 15 3505 Y1N1T1.png',
			          N'Thương hiệu: Dell
Tình trạng: Mới 
Bảo hành: 12 Tháng', 'admin',12990000,0,20,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT4', N'Laptop Dell Inspiron 15 3505 Y1N1T2', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell Inspiron 15 3505 Y1N1T2.png',
			          N'Thương hiệu: Dell
Tình trạng: Mới 
Bảo hành: 12 Tháng', 'admin',17790000,0,20,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT5', N'Laptop Dell Inspiron 3505 Y1N1T3', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell Inspiron 3505 Y1N1T3.png',
			          N'Thương hiệu: Dell
Tình trạng: Mới 
Bảo hành: 12 Tháng
', 'admin',15190000,2,20,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT6', N'Laptop Dell Inspiron 3511 P112F001BBL (Black)', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell Inspiron 3511 P112F001BBL (Black).png',
			          N'Nhà sản xuất : Dell
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',19290000,2,20,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT7', N'Laptop Dell Vostro 3400 70234073', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell Vostro 3400 70234073.png',
			          N'Hãng sản xuất: Dell
Tình trạng: Mới
Bảo hành: 12 Tháng', 'admin',18290000,1,20,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT8', N'Laptop Dell Vostro 3510 (P112F002ABL)', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell Vostro 3510 (P112F002ABL).png',
			          N'Hãng sản xuất: Dell
Tình trạng: Mới
Bảo hành: 12 Tháng', 'admin',22790000,1,20,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('DellHT9', N'Laptop Dell Vostro 15 3500 7G3981', N'~/Storage/Image/laptop/LapHT/Dell/Laptop Dell Vostro 15 3500 7G3981.png',
			          N'Hãng sản xuất: Dell
Tình trạng: Mới
Bảo hành: 12 Tháng', 'admin',22790000,1,20,N'Dell', N'Bộ');
go

go
				------------------ Dữ liệu LenovoHT ------------------
				------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LenovoHT1', N'Laptop IdeaPad 5 14ALC05 82LM00D5VN', N'~/Storage/Image/laptop/LapHT/Lenovo/Laptop IdeaPad 5 14ALC05 82LM00D5VN.png',
			          N'Hãng: LENOVO
Tình trạng: Mới 100%
Bảo hành: 12 Tháng', 'admin',18690000,1,19,N'Lenovo', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LenovoHT2', N'Laptop Lenovo IdeaPad 5 15ALC05 82LN00CDVN', N'~/Storage/Image/laptop/LapHT/Lenovo/Laptop Lenovo IdeaPad 5 15ALC05 82LN00CDVN.png',
			          N'Hãng: LENOVO
Tình trạng: Mới 100%
Bảo hành: 12 Tháng', 'admin',18790000,0,19,N'Lenovo', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LenovoHT3', N'Laptop Lenovo IdeaPad Slim 3 14ITL6 82H700G1VN', N'~/Storage/Image/laptop/LapHT/Lenovo/Laptop Lenovo IdeaPad Slim 3 14ITL6 82H700G1VN.png',
			          N'Hãng: LENOVO
Tình trạng: Mới 100%
Bảo hành: 12 Tháng', 'admin',16190000,0,19,N'Lenovo', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LenovoHT4', N'Laptop LENOVO ThinkPad L13 Gen 2 20VH004AVA', N'~/Storage/Image/laptop/LapHT/Lenovo/Laptop LENOVO ThinkPad L13 Gen 2 20VH004AVA.png',
			          N'Hãng: LENOVO
Tình trạng: Mới 100%
Bảo hành: 36 Tháng', 'admin',27290000,0,19,N'Lenovo', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LenovoHT5', N'Laptop LENOVO ThinkPad L13 Gen 2 20VH0049VA', N'~/Storage/Image/laptop/LapHT/Lenovo/Laptop LENOVO ThinkPad L13 Gen 2 20VH0049VA.png',
			          N'Hãng: LENOVO
Tình trạng: Mới 100%
Bảo hành: 36 Tháng', 'admin',24490000,0,19,N'Lenovo', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LenovoHT6', N'Laptop Lenovo V15 G2 ITL 82KB00CKVN', N'~/Storage/Image/laptop/LapHT/Lenovo/Laptop Lenovo V15 G2 ITL 82KB00CKVN.png',
			          N'Hãng: LENOVO
Tình trạng: Mới 100%
Bảo hành: 12 Tháng', 'admin',19990000,1,19,N'Lenovo', N'Bộ');
go

go
				-------------------- Dữ liệu MSIHT--------------------
				------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT1', N'Laptop MSI Modern 14 B5M 064VN', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Modern 14 B5M 064VN.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',16990000,1,18,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT2', N'Laptop MSI Modern 14 B11MOU 848VN', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Modern 14 B11MOU 848VN.png',
			          N'Nhà sản xuất: MSI
Xuất xứ: Chính hãng
Bảo hành: 12 Tháng
Tình trạng: Mới 100', 'admin',21490000,1,18,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT3', N'Laptop MSI Modern 14 B11MOU 851VN', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Modern 14 B11MOU 851VN.png',
			          N'Nhà sản xuất: MSI
Xuất xứ: Chính hãng
Bảo hành: 12 Tháng
Tình trạng: Mới 100', 'admin',14190000,1,18,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT4', N'Laptop MSI Modern 14 B11SBU 668VN', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Modern 14 B11SBU 668VN.png',
			          N'Nhà sản xuất : MSI
Xuất xứ: Chính hãng
Bảo hành: 12 Tháng
Tình trạng: Mới 100%', 'admin',22990000,1,18,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT5', N'Laptop MSI Modern 15 A5M 238VN', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Modern 15 A5M 238VN.png',
			          N'Nhà sản xuất :  MSI
Xuất xứ: Chính hãng
Bảo hành: 12 Tháng
Tình trạng: Mới 100%', 'admin',17990000,0,18,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT6', N'Laptop MSI Modern 15 A10MU 667VN', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Modern 15 A10MU 667VN.png',
			          N'Nhà sản xuất: MSI
Xuất xứ: Chính hãng
Bảo hành: 12 Tháng
Tình trạng: Mới 100%', 'admin',17990000,1,18,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT7', N'Laptop MSI Modern 15 A11MU 678VN', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Modern 15 A11MU 678VN.png',
			          N'Nhà sản xuất: MSI
Xuất xứ: Chính hãng
Bảo hành: 12 Tháng
Tình trạng: Mới 100%', 'admin',18990000,1,18,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT8', N'Laptop MSI Summit E13 Flip Evo A11MT 211V', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Summit E13 Flip Evo A11MT 211V.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',37990000,3,18,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIHT9', N'Laptop MSI Modern 14 B10MW 646VN', N'~/Storage/Image/laptop/LapHT/MSI/Laptop MSI Modern 14 B10MW 646VN.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',37990000,3,18,N'MSI', N'Bộ');
go

go
				-------------------- Dữ liệu AcerHT ---------------------
				---------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerHT1', N'Laptop Acer Aspire 3 A315 56 37DV', N'~/Storage/Image/laptop/LapHT/Acer/Laptop Acer Aspire 3 A315 56 37DV.png',
			          N'Nhà sản xuất : ACER
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',11190000,0,17,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerHT2', N'Laptop Acer Aspire 3 A315 56 502X', N'~/Storage/Image/laptop/LapHT/Acer/Laptop Acer Aspire 3 A315 56 502X.png',
			          N'Nhà sản xuất : Acer
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 
', 'admin',13990000,0,17,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerHT3', N'Laptop Acer Aspire 3 A315 57G 31YD', N'~/Storage/Image/laptop/LapHT/Acer/Laptop Acer Aspire 3 A315 57G 31YD.png',
			          N'Hãng sản xuất : Acer
Bảo hành : 12 tháng', 'admin',12490000,0,17,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerHT4', N'Laptop Acer Aspire 3 A315 58 3939', N'~/Storage/Image/laptop/LapHT/Acer/Laptop Acer Aspire 3 A315 58 3939.png',
			          N'Nhà sản xuất : ACER
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',11590000,0,17,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerHT5', N'Laptop Acer Aspire 3 A315 58G 50S4', N'~/Storage/Image/laptop/LapHT/Acer/Laptop Acer Aspire 3 A315 58G 50S4.png',
			          N'Nhà sản xuất: ACER
Xuất xứ: Chính hãng
Bảo hành: 12 Tháng
Tình trạng: Mới ', 'admin',18990000,1,17,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerHT6', N'Laptop Acer Aspire 5 A514 54 540F', N'~/Storage/Image/laptop/LapHT/Acer/Laptop Acer Aspire 5 A514 54 540F.png',
			          N'Nhà sản xuất : Acer
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 
 ', 'admin',17090000,1,17,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerHT7', N'Laptop Acer Aspire A315 57G 524Z', N'~/Storage/Image/laptop/LapHT/Acer/Laptop Acer Aspire A315 57G 524Z.png',
			          N'Nhà sản xuất : Acer
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới ', 'admin',16990000,1,17,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AcerHT8', N'Laptop Acer Swift 3 Evo SF314 511 59LV', N'~/Storage/Image/laptop/LapHT/Acer/Laptop Acer Swift 3 Evo SF314 511 59LV.png',
			          N'Nhà sản xuất : Acer
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới ', 'admin',20990000,1,17,N'Acer', N'Bộ');
go

go
				---------------------- Dữ liệu AsusHT ---------------------
				-----------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT1', N'Laptop ASUS VivoBook A515EA BQ498T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS VivoBook A515EA BQ498T.png',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Xám', 'admin',19490000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT2', N'Laptop ASUS Vivobook Flip 14 TP470EA EC027T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS Vivobook Flip 14 TP470EA EC027T.png',
			          N'Hãng sản xuất : Asus 
Tình trạng : Mới
Bảo hành : 24 tháng', 'admin',15990000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT3', N'Laptop Asus Vivobook S433EA AM439T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop Asus Vivobook S433EA AM439T.png',
			          N'Hãng sản xuất: Asus 
Bảo hành: 24 Tháng 
Tình trạng: Mới 100%', 'admin',18290000,5,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT4', N'Laptop ASUS X515EA EJ1046T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS X515EA EJ1046T.png',
			          N'Hãng sản xuất : Asus 
Tình trạng : Mới
Bảo hành : 24 tháng', 'admin',17390000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT5', N'Laptop ASUS ZenBook UX325EA KG363T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS ZenBook UX325EA KG363T.png',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Xám đen', 'admin',25290000,3,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT6', N'Laptop ASUS ZenBook UX425EA KI429T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS ZenBook UX425EA KI429T.png',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT7', N'Laptop ASUS Vivobook A515EA L11171T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS Vivobook A515EA L11171T.jpg',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT8', N'Laptop Asus Vivobook A515EA L12033T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop Asus Vivobook A515EA L12033T.png',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT9', N'Laptop ASUS Vivobook X515EA BQ1006T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS Vivobook X515EA BQ1006T.png',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT10', N'Laptop ASUS Zenbook Duo 14 UX482EG KA166T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS Zenbook Duo 14 UX482EG KA166T.jpg',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT11', N'Laptop ASUS Zenbook Flip UX363EA HP548T', N'~/Storage/Image/laptop/LapHT/Asus/Laptop ASUS Zenbook Flip UX363EA HP548T.png',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,2,16,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusHT12', N'Laptop Asus Zenbook Flip UX363EA HP726W', N'~/Storage/Image/laptop/LapHT/Asus/Laptop Asus Zenbook Flip UX363EA HP726W.png',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,2,16,N'Asus', N'Bộ');
go

go
				----------------- Dữ liệu LGHT --------------------
				-------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LG1', N'Laptop LG Gram 14Z90P-G.AH75A5', N'~/Storage/Image/laptop/LapHT/LG/Laptop LG Gram 14Z90P-G.AH75A5.png',
			          N'Hãng sản xuất: LG
Tình Trạng: Mới-Fullbox 100%
Bảo hành: 12 Tháng', 'admin',47990000,3,8,N'LG', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LG2', N'Laptop LG Gram 16Z90P-G.AH73A5', N'~/Storage/Image/laptop/LapHT/LG/Laptop LG Gram 16Z90P-G.AH73A5.png',
			          N'Nhà sản xuất : LG
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%
Màu sắc: Trắng', 'admin',48990000,2,8,N'LG', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('LG3', N'Laptop LG Gram 17ZD90P-G.AX71A5', N'~/Storage/Image/laptop/LapHT/LG/Laptop LG Gram 17ZD90P-G.AX71A5.png',
			          N'Nhà sản xuất : LG
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%
Màu sắc: Trắng', 'admin',44990000,3,8,N'LG', N'Bộ');
go

go
				-------------- Dữ liệu Windows 10 Home ---------------------
				------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Windows10H', N'Phần mềm Microsoft Windows 10 Home Online DwnLd NR KW9-00265', N'~/Storage/Image/laptop/Windows/Phần mềm Microsoft Windows 10 Home Online DwnLd NR KW9-00265.png',
			          N'Nhà sản xuất : Mircosoft
-Mã sản phẩm:  KW9-00265
-Tên sản phẩm: Phần mềm Microsoft Windows 10 Home 32-bit/64-bit All Lng PK Lic Online DwnLd NR KW9-00265
-Hình thức : FPP(ESD) (Full Packaged Product) - sản phẩm có thể kích hoạt khi thay đổi phần cứng.', 'admin',3290000,10,12,N'Microsoft', N'Bộ');
go
				-------------- Dữ liệu Windows 10 Pro ---------------------
				-----------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Windows10P', N'Phần mềm Windows 10 Pro Online DwnLd NR FQC-09131', N'~/Storage/Image/laptop/Windows/Phần mềm Windows 10 Pro Online DwnLd NR FQC-09131.png',
			          N'Nhà sản xuất : Mircosoft
-Mã sản phẩm:  FQC-09131
-Tên sản phẩm: Phần mềm Windows 10 Pro 32-bit/64-bit All Lng PK Lic Online DwnLd NR FQC-09131
-Hình thức : FPP(ESD) (Full Packaged Product) - sản phẩm có thể kích hoạt khi thay đổi phần cứng.', 'admin',4990000,10,13,N'Microsoft', N'Bộ');
go
				-------------- Dữ liệu Windows 11 Home --------------------
				-----------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Windows11H', N'Windows 11 Home', N'~/Storage/Image/laptop/Windows/Windows 11 Home.png',
			          N'Chính hãng Microsoft
Thời hạn sử dụng: vĩnh viễn
Cài lại Win/ Update Win thoả mái
Bảo hành trọn đời key / 1 máy tính
Hoàn tiền 100% nếu kích hoạt không thành công', 'admin',4500000,10,14,N'Microsoft', N'Bộ');
go
				-------------- Dữ liệu Windows 11 Pro --------------------
				----------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Windows11P', N'Windows 11 Pro', N'~/Storage/Image/laptop/Windows/Windows 11 Pro.png',
			          N'Chính hãng Microsoft
Thời hạn sử dụng: vĩnh viễn
Cài lại Win/ Update Win thoả mái
Bảo hành trọn đời key / 1 máy tính
Hoàn tiền 100% nếu kích hoạt không thành công', 'admin',5200000,10,15,N'Microsoft', N'Bộ');
go
				-------------- Dữ liệu Office 365 --------------------
				------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Office365', N'Phần mềm Microsoft 365 Personal QQ2-00003', N'~/Storage/Image/laptop/Office/Phần mềm Microsoft 365 Personal QQ2-00003.png',
			          N'Nhà sản xuất : Mircosoft
-Mã sản phẩm:  QQ2-00003
(Sản phẩm là Key điện tử, không thể hoàn lại khi mua.)
- Thời hạn 1 năm 
- Số tài khoản: 1 người dùng
- Số thiết bị: 5 thiết bị ( Lưu ý: 5 thiết bị/ tài khoản)', 'admin',1290000,10,10,N'Microsoft', N'Bộ');
go
				-------------- Dữ liệu Office 2021 --------------------
				-------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Office2021', N'Phần mềm Office Home & Student 2021 79G-05337', N'~/Storage/Image/laptop/Office/Phần mềm Office Home & Student 2021 79G-05337.png',
			          N'Hãng sản xuất : Mircosoft
Mã sản phẩm:  79G-05337
Dành cho 1 người, 1 thiết bị', 'admin',2390000,10,11,N'Microsoft', N'Bộ');
go

go
				---------------------------- Dữ liệu MSI Chuột ----------------------
				----------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MSIC1', N'Chuột MSI Clutch GM41 Lightweight Wireless', N'~/Storage/Image/laptop/MSIC/Chuột MSI Clutch GM41 Lightweight Wireless.png',
			          N'Nhà Sản Xuất: MSI
Bảo Hành: 12tháng 
Led: RGB
Kết nối: Wireless 2.4G
Thời lượng pin: Lên đến 80 giờ sử dụng, hỗ trợ dock sạc', 'admin',1890000,0,26,N'MSI', N'Bộ');
go

go
				------------------------ Dữ liệu Asus Chuột -----------------------------
				--------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusC1', N'Chuột Asus ROG Chakram', N'~/Storage/Image/laptop/AsusC/Chuột Asus ROG Chakram.png',
			          N'Nhà Sản Xuất: ASUS
Tình Trạng : Mới 100% - Fullbox
Bảo Hành : 24 tháng  
Led: RGB', 'admin',3890000,2,27,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusC2', N'Chuột ASUS ROG Gladius III Wireless', N'~/Storage/Image/laptop/AsusC/Chuột ASUS ROG Gladius III Wireless.png',
			          N'Nhà Sản Xuất: ASUS
Tình Trạng : Mới 100% - Fullbox
Bảo Hành : 24 Tháng
Kết nối : 2.4 GHz Wireless / Bluetooth® LE', 'admin',2590000,0,27,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusC3', N'Chuột Asus ROG Strix Impact II Electro Punk', N'~/Storage/Image/laptop/AsusC/Chuột Asus ROG Strix Impact II Electro Punk.png',
			          N'Hãng sản xuất: Asus
Tình trạng: Mới
Bảo hành: 24 Tháng', 'admin',1190000,0,27,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusC4', N'Chuột Gaming ASUS ROG Gladius II Core', N'~/Storage/Image/laptop/AsusC/Chuột Gaming ASUS ROG Gladius II Core.png',
			          N'Nhà sản xuất : Asus
Tình trạng : Mới 100%
Bảo hành : 24 Tháng', 'admin',1090000,12,27,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusC5', N'Chuột Gaming ASUS ROG Keris', N'~/Storage/Image/laptop/AsusC/Chuột Gaming ASUS ROG Keris.png',
			          N'Nhà sản xuất: Asus
Bảo hành: 36 tháng
Tình trạng: Mới 100%
Kết nối: Có dây', 'admin',1250000,0,27,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AsusC6', N'Chuột gaming Asus TUF M3', N'~/Storage/Image/laptop/AsusC/Chuột gaming Asus TUF M3.png',
			          N'Nhà sản xuất : ASUS
Tình trạng : Fullbox-100%
Bảo hành : 24 tháng ', 'admin',690000,12,27,N'Asus', N'Bộ');
go

go
				---------------- Dữ liệu Logitech ---------------------
				-------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Logitech1', N'Chuột Logitech G304 Lightspeed Wireless', N'~/Storage/Image/laptop/Logitech/Chuột Logitech G304 Lightspeed Wireless.png',
			          N'Nhà Sản Xuất : Logitech
Tình Trạng : Mới
Bảo Hành : 24 tháng ', 'admin',1090000,1,9,N'Logitech', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Logitech2', N'Chuột Logitech G402 Hyperion', N'~/Storage/Image/laptop/Logitech/Chuột Logitech G402 Hyperion.png',
			          N'Nhà Sản Xuất : Logitech
Tình Trạng : Mới
Bảo Hành : 24 tháng 
Led : Logo Xanh ', 'admin',999000,1,9,N'Logitech', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Logitech3', N'Logitech G502 Proteus Spectrum', N'~/Storage/Image/laptop/Logitech/Logitech G502 Proteus Spectrum.png',
			          N'Nhà Sản Xuất : Logitech
· Tình Trạng : Mới 100% - Fullbox
· Bảo Hành : 36 tháng ( 1 đổi 1 )
· Led : RGB', 'admin',1490000,0,9,N'Logitech', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Logitech4', N'Logitech M238 Wireless - World Cup Edition - Argentina', N'~/Storage/Image/laptop/Logitech/Logitech M238 Wireless - World Cup Edition - Argentina.png',
			          N'Nhà Sản Xuất : Logitech
Tình Trạng : Mới 100%- Fullbox
Bảo Hành : 24 tháng ( 1 đổi 1 )', 'admin',490000,0,9,N'Logitech', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Logitech5', N'Logitech M238 Wireless - World Cup Edition - France', N'~/Storage/Image/laptop/Logitech/Logitech M238 Wireless - World Cup Edition - France.png',
			          N'Nhà Sản Xuất : Logitech
Tình Trạng : Mới 100%- Fullbox
Bảo Hành : 24 tháng ( 1 đổi 1 )
', 'admin',490000,0,9,N'Logitech', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Logitech6', N'Logitech M238 Wireless - World Cup Edition - Germany', N'~/Storage/Image/laptop/Logitech/Logitech M238 Wireless - World Cup Edition - Germany.png',
			          N'Nhà Sản Xuất : Logitech
Tình Trạng : Mới 100%- Fullbox
Bảo Hành : 24 tháng ( 1 đổi 1 )
', 'admin',490000,0,9,N'Logitech', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Logitech7', N'Logitech M238 Wireless - World Cup Edition - Spain', N'~/Storage/Image/laptop/Logitech/Logitech M238 Wireless - World Cup Edition - Spain.png',
			          N'Nhà Sản Xuất : Logitech
Tình Trạng : Mới 100%- Fullbox
Bảo Hành : 24 tháng ( 1 đổi 1 )', 'admin',490000,0,9,N'Logitech', N'Bộ');
go

-------------------------------------Dữ liệu Bán chạy---------------
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Best1', N'Laptop ASUS TUF Gaming F15 FX506HCB HN139T', N'/Storage/Image/laptop/BestSell/Laptop ASUS TUF Gaming F15 FX506HCB HN139T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',25490000,0,29,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Best2', N'Laptop Gaming Acer Nitro 5 Eagle AN515 57 5669', N'/Storage/Image/laptop/BestSell/Laptop Gaming Acer Nitro 5 Eagle AN515 57 5669.png',
			          N'Nhà sản xuất: ACER
Bảo hành: 12 Tháng
Tình trạng: Mới', 'admin',23990000,0,29,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Best3', N'Laptop Gaming Acer Predator Helios 300 PH315 54 75YD', N'/Storage/Image/laptop/BestSell/Laptop Gaming Acer Predator Helios 300 PH315 54 75YD.png',
			          N'Nhà sản xuất : ACER
Bảo hành : 12 tháng
Tình trạng : Mới 100%', 'admin',39990000,0,29,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Best4', N'Laptop Gaming Asus ROG Strix G15 G513IH HN015T', N'/Storage/Image/laptop/BestSell/Laptop Gaming Asus ROG Strix G15 G513IH HN015T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới', 'admin',23990000,0,29,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Best5', N'Laptop Gaming Asus TUF Dash F15 FX516PC HN002T', N'/Storage/Image/laptop/BestSell/Laptop Gaming Asus TUF Dash F15 FX516PC HN002T.png',
			          N'Nhà sản xuất : ASUS
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',28490000,0,29,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Best6', N'Laptop LG Gram 16Z90P-G.AH73A5', N'/Storage/Image/laptop/BestSell/Laptop LG Gram 16Z90P-G.AH73A5.png',
			          N'Nhà sản xuất : LG
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%
Màu sắc: Trắng', 'admin',48990000,0,29,N'LG', N'Bộ');
go

-----------------------------Dữ Liệu New-----------------------------------
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('New1', N'Laptop Acer Aspire 3 A315 58G 50S4', N'/Storage/Image/laptop/New/Laptop Acer Aspire 3 A315 58G 50S4.png',
			          N'Nhà sản xuất: ACER
Xuất xứ: Chính hãng
Bảo hành: 12 Tháng
Tình trạng: Mới ', 'admin',18990000,0,28,N'Acer', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('New2', N'Laptop Asus Zenbook Flip UX363EA HP726W', N'/Storage/Image/laptop/New/Laptop Asus Zenbook Flip UX363EA HP726W.png',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,0,28,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('New3', N'Laptop LG Gram 17ZD90P-G.AX71A5', N'/Storage/Image/laptop/New/Laptop LG Gram 17ZD90P-G.AX71A5.png',
			          N'Nhà sản xuất : LG
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%
Màu sắc: Trắng', 'admin',44990000,0,28,N'LG', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('New4', N'Laptop MSI Creator Z16 A11UET 218VN', N'/Storage/Image/laptop/New/Laptop MSI Creator Z16 A11UET 218VN.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',69990000,0,28,N'MSI', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('New5', N'Windows 11 Home', N'/Storage/Image/laptop/New/Windows 11 Home.png',
			          N'Chính hãng Microsoft
Thời hạn sử dụng: vĩnh viễn
Cài lại Win/ Update Win thoả mái
Bảo hành trọn đời key / 1 máy tính
Hoàn tiền 100% nếu kích hoạt không thành công', 'admin',4500000,0,28,N'Microsoft', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('New6', N'Windows 11 Pro', N'/Storage/Image/laptop/New/Windows 11 Pro.png',
			          N'Chính hãng Microsoft
Thời hạn sử dụng: vĩnh viễn
Cài lại Win/ Update Win thoả mái
Bảo hành trọn đời key / 1 máy tính
Hoàn tiền 100% nếu kích hoạt không thành công', 'admin',5200000,0,28,N'Microsoft', N'Bộ');

----------------------------Dữ liệu giá tốt---------------------------------------
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('GT', N'Laptop ASUS Zenbook Duo 14 UX482EG KA166T', N'/Storage/Image/laptop/Offer/Laptop ASUS Zenbook Duo 14 UX482EG KA166T.jpg',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,10,30,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('GT2', N'Laptop ASUS Zenbook Duo 14 UX482EG KA166T', N'/Storage/Image/laptop/Offer/Laptop ASUS Zenbook Duo 14 UX482EG KA166T.jpg',
			          N'Thương hiệu: Asus
Tình trạng: Mới 
Bảo hành: 24 Tháng
Màu sắc: Grey', 'admin',24690000,10,30,N'Asus', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('GT3', N'Laptop Dell Inspiron 3511 P112F001BBL (Black)', N'/Storage/Image/laptop/Offer/Laptop Dell Inspiron 3511 P112F001BBL (Black).png',
			          N'Nhà sản xuất : Dell
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',19290000,5,30,N'Dell', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('GT4', N'Laptop Gaming HP Omen 16 b0127TX 4Y0W7PA', N'/Storage/Image/laptop/Offer/Laptop Gaming HP Omen 16 b0127TX 4Y0W7PA.png',
			          N'Nhà sản xuất : HP
Xuất xứ : Chính hãng
Bảo hành : 12 Tháng
Tình trạng : Mới 100%', 'admin',45990000,10,30,N'HP', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('GT5', N'Laptop MSI Summit E13 Flip Evo A11MT 211V', N'/Storage/Image/laptop/Offer/Laptop MSI Summit E13 Flip Evo A11MT 211V.png',
			          N'Nhà sản xuất : MSI
Xuất xứ : Chính hãng
Bảo hành : 24 Tháng
Tình trạng : Mới 100%', 'admin',37990000,10,30,N'MSI', N'Bộ');

----------------------------chuột giá rẻ---------------------------------------
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('logi', N'Chuột Logitech B100', N'/Storage/Image/laptop/giare/giare1.png',
			          N'Thương hiệu: Logitech
Tình trạng: Mới 
Bảo hành: 3 Tháng
Màu sắc: Black', 'admin',80000,0,31,N'Logitech', N'Con');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('dare-u', N'Chuột Dare-U LM115G Multi Color Wireless', N'/Storage/Image/laptop/giare/giare2.png',
			          N'Thương hiệu: Dare-U
Tình trạng: Mới 
Bảo hành: 3 Tháng
Màu sắc: Pink', 'admin',220000,0,31,N'Dare-U', N'Con');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('fuhlen', N'Chuột không dây Fuhlen A06G Pink', N'/Storage/Image/laptop/giare/giare3.png',
			          N'Nhà sản xuất : Fuhlen
Xuất xứ : Chính hãng
Bảo hành : 3 Tháng
Tình trạng : Mới 100%', 'admin',150000,0,31,N'Fuhlen', N'Con');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('dare-u2', N'Chuột Dare-U LM115G - Pink', N'/Storage/Image/laptop/giare/giare4.png',
			          N'Nhà sản xuất : Dare-U
Xuất xứ : Chính hãng
Bảo hành : 3 Tháng
Tình trạng : Mới 100%', 'admin',150000,0,31,N'Dare-U', N'Con');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('durgod', N'Chuột Durgod M39', N'/Storage/Image/laptop/giare/giare5.png',
			          N'Nhà sản xuất : Durgod
Xuất xứ : Chính hãng
Bảo hành : 3 Tháng
Tình trạng : Mới 100%', 'admin',160000,0,31,N'Durgod', N'Con');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('ajazz', N'Chuột Ajazz AJ52 Black', N'/Storage/Image/laptop/giare/giare6.png',
			          N'Nhà sản xuất : Ajazz
Xuất xứ : Chính hãng
Bảo hành : 3 Tháng
Tình trạng : Mới 100%', 'admin',190000,0,31,N'Ajazz', N'Con');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('fuhlen2', N'Chuột Fuhlen G90s RGB', N'/Storage/Image/laptop/giare/giare7.png',
			          N'Nhà sản xuất : Fuhlen
Xuất xứ : Chính hãng
Bảo hành : 3 Tháng
Tình trạng : Mới 100%', 'admin',440000,0,31,N'Fuhlen', N'Con');
