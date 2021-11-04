DROP DATABASE IF EXISTS Order_Karaoke_Room;
CREATE DATABASE Order_Karaoke_Room;


CREATE DATABASE IF NOT EXISTS Order_Karaoke_Room;

ALTER DATABASE testing_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE Order_Karaoke_Room;

DROP TABLE IF EXISTS KHACH_HANG;
CREATE TABLE KHACH_HANG(
	MaKH		TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    TenKH		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    DiaChi		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    SoDT		VARCHAR(50) CHAR SET utf8mb4 NOT NULL
    );

INSERT INTO KHACH_HANG(TenKH, DiaChi, SoDT)
    VALUES	('Lê Hồng Anh', '12 Lâm Quang Ky', '01234567'),
			('Nguyễn Khánh Linh', '19 Lộc Đỉnh Kí', '01245678'),
            ('Ngô Đình Bảo', '17 Tôn Ngộ Không', '01097567'),
            ('Lâm Tân Như', '15 Đường Tam Tạng', '017656567'),
            ('Trương Quân Bảo', '14 Trư Ngộ Năng', '07734567');
			
DROP TABLE IF EXISTS PHONG;
CREATE TABLE PHONG(
	MaPhong			TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    LoaiPhong		VARCHAR(20) CHAR SET utf8mb4 NOT NULL,
    SoKhachToiDa	TINYINT NOT NULL,
    GiaPhong		DECIMAL(10,0),
    Mota			VARCHAR(100) CHAR SET utf8mb4 NOT NULL
);

INSERT INTO PHONG(LoaiPhong, SoKhachToiDa, GiaPhong, Mota)
    VALUES	('Loại 1', 7, 300000, 'Vip 1'),
			('Loại 2', 10, 400000, 'Vip 2'),
            ('Loại 3', 13, 450000, 'Vip 3'),
            ('Loại 4', 15, 500000, 'Vip 4'),
            ('Loại 5', 17, 600000, 'Vip 5');
            
DROP TABLE IF EXISTS DICH_VU_DI_KEM;
CREATE TABLE DICH_VU_DI_KEM(
	MaDV		TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    TenDV		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    DonViTinh	VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    DonGia		DECIMAL(10,0)
);

INSERT INTO DICH_VU_DI_KEM(TenDV, DonViTinh, DonGia)
    VALUES	('Bia', 'Lon', 15000),
			('Nươc ngọt', 'Lon', 10000),
            ('Bánh','Bịch', 20000),
            ('Kẹo','Bịch', 70000),
            ('Bóng cười','Cái',30000);
DROP TABLE IF EXISTS DAT_PHONG;
CREATE TABLE DAT_PHONG(
	MaDatPhong		TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    MaPhong			TINYINT NOT NULL,
    MaKH			TINYINT NOT NULL,
    NgayDat			DATE,
    TienDatCoc		DECIMAL(10,0),
    GhiChu			VARCHAR(250) CHAR SET utf8mb4 NOT NULL,
    TrangThaiDat	BOOLEAN,			-- 1: đã đặt	0: đã huỷ
		FOREIGN KEY(MaPhong) REFERENCES PHONG(MaPhong) ON DELETE CASCADE ON UPDATE CASCADE, 
        FOREIGN KEY(MaKH) REFERENCES KHACH_HANG(MaKH) ON DELETE CASCADE ON UPDATE CASCADE 
);

INSERT INTO DAT_PHONG(MaPhong, MaKH, NgayDat, TienDatCoc, GhiChu, TrangThaiDat)
    VALUES	(1, 3, '2021-10-22', 500000, 'Chuyển Khoản', 1),
			(2, 4, '2021-10-21', 600000, 'Chuyển Khoản', 0),
            (2, 5, '2021-10-24', 500000, 'Chuyển Khoản', 0),
            (4, 1, '2021-10-13', 700000, 'Chuyển Khoản', 1),
            (5, 2, '2021-10-29', 500000, 'Chuyển Khoản', 1)
			;
            
DROP TABLE IF EXISTS CHI_TIET_SU_DUNG_DV;
CREATE TABLE CHI_TIET_SU_DUNG_DV(
	MaDatPhong		TINYINT PRIMARY KEY NOT NULL,
    MaDV			TINYINT PRIMARY KEY NOT NULL,
    SoLuong			TINYINT NOT NULL,
		FOREIGN KEY(MaDatPhong) REFERENCES DAT_PHONG(MaDatPhong) ON DELETE CASCADE ON UPDATE CASCADE, 
        FOREIGN KEY(MaDV) REFERENCES DICH_VU_DI_KEM(MaDV) ON DELETE CASCADE ON UPDATE CASCADE 
    );
    
INSERT INTO CHI_TIET_SU_DUNG_DV(MaDatPhong, MaDV, SoLuong)
    VALUES	(2, 1, 20),
			(3, 2, 10),
            (5, 3, 30),
            (2, 4, 30),
            (1, 5, 10)
			;
            
-- 2. Hiển thị loại phòng đã thuê, 
-- tên dịch vụ đã sử dụng của khách hàng có tên là “Nguyễn Khánh Linh” 

SELECT * From KHACH_HANG;
SELECT * From PHONG;
SELECT * From DICH_VU_DI_KEM;

SELECT KH.TenKH Where TenKH = 'Nguyễn Khánh Linh',
FROM KHACH_HANG KH
JOIN PHONG P ON 

Error Code: 1068. Multiple primary key defined

-- 4. Viết thủ tục tăng giá phòng thêm 10,000 VNĐ 
-- so với giá phòng hiện tại cho những phòng có số khách tối đa lớn hơn 5.