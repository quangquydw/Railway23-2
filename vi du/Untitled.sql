-- *********************** Tạo một Cơ sở dữ liệu là Quản lý sinh viên và thực hiện truy vấn ************************************


-- kiểm tra nếu đã tồn tại Database quan_ly_sinh_vien thì xóa đi
DROP DATABASE IF EXISTS quan_ly_sinh_vien;

-- Kiểm tra nếu chưa tồn tại Database quan_ly_sinh_vien thì tạo mới 
CREATE DATABASE IF NOT EXISTS quan_ly_sinh_vien;

-- Sử dụng quan_ly_sinh_vien
USE quan_ly_sinh_vien;

-- Thiết lập hỗ trợ gõ tiếng việt cho Database quan_ly_sinh_vien
ALTER DATABASE quan_ly_sinh_vien CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Kiểm tra nếu đã tồn tại bảng sinh_vien thì xóa đi
DROP TABLE IF EXISTS sinh_vien;

-- Kiểm tra nếu đã tồn tại bảng khoa thì xóa đi
DROP TABLE IF EXISTS khoa;

-- Kiểm tra nếu chưa tồn tại bảng khoa thì tạo mới bảng khoa
CREATE TABLE IF NOT EXISTS khoa(
	ma_khoa SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten_khoa VARCHAR(30) CHARACTER SET utf8mb4 NOT NULL UNIQUE
);
-- Thiết lập lại AUTO_INCREMENT cho bảng khoa
ALTER TABLE khoa AUTO_INCREMENT = 1;

-- Thêm mới dữ liệu cho bảng khoa
INSERT INTO khoa(ten_khoa) 
VALUES 
	('Công Nghệ Thông Tin'), 
	('Tiếng Nhật'),
	('Điện');
    
 -- Xem dữ liệu của bảng khoa   
SELECT * FROM khoa;

-- -- Kiểm tra nếu đã tồn tại bảng sinh_vien thì xóa đi
DROP TABLE IF EXISTS sinh_vien;

-- Kiểm tra nếu chưa tồn tại bảng sinh_vien thì tạo mới bảng sinh_vien
CREATE TABLE IF NOT EXISTS sinh_vien(
	ma_sv SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ma_khoa SMALLINT,
    ho_ten  VARCHAR(30) CHARACTER SET utf8mb4,
    ngay_sinh DATE,
	que_quan VARCHAR(50) CHARACTER SET utf8mb4
);

-- Thiết lập lại AUTO_INCREMENT cho bảng sinh_vien
ALTER TABLE sinh_vien AUTO_INCREMENT = 1;

-- Thêm mới dữ liệu cho bảng sinh_vien
INSERT INTO sinh_vien(ma_khoa,ho_ten,ngay_sinh,que_quan) 
VALUES 
	(1,'Nguyễn Văn Vinh','1993-01-01','Hà Nội'),
	(1,'Pha Hà Giang','1992-01-02','HCM'),
	(1,'Nguyễn Văn Nam','1995-01-03','Cao Bằng'),
	(1,'Phan Linh','1997-01-04','Lạng Sơn'), 
	(2,'Nguyễn Duy Tuấn','1999-01-01','Bắc Giang'),
	(2,'Trình Thanh Bình','1998-01-02','Thái Nguyên'),
	(2,'Hoàng Văn Thế','1993-01-03','Ninh Bình'),
	(4,'Đặng Thị Hà','1993-01-04','Hà Giang');
    
-- Xem dữ liệu của bảng sinh viên
SELECT * FROM sinh_vien; 

-- *************************I. Cách sử dụng LEFT JOIN, INNER JOIN, RIGHT JOIN, LEFT EXCLUDING JOIN, CROSS JOIN***********************

-- 1. LEFT JOIN
-- LEFT JOIN: dùng để lấy những bản ghi chung của 2 bảng và những bản ghi thuộc bảng bên trái nhưng không thuộc bên phải
	SELECT * FROM
		sinh_vien sv LEFT JOIN khoa kh ON sv.ma_khoa = kh.ma_khoa;

-- 2. INNER JOIN Hoặc JOIN
-- INNER JOIN: dùng để lấy những bản ghi chung của 2 bảng
	SELECT * FROM
		sinh_vien sv  INNER JOIN khoa kh ON sv.ma_khoa = kh.ma_khoa;

-- 3. RIGHT JOIN
-- RIGHT JOIN: dùng để lấy những bản ghi chung của 2 bảng và những bản ghi thuộc bảng bên phải nhưng không thuộc bên trái
	SELECT * FROM
		sinh_vien sv RIGHT JOIN khoa kh ON sv.ma_khoa = kh.ma_khoa;

-- 4. LEFT EXCLUDING JOIN
-- LEFT EXCLUDING JOIN: dùng để lấy những bản ghi chỉ thuộc bảng bên trái
	SELECT * FROM
		sinh_vien sv LEFT JOIN khoa kh ON sv.ma_khoa = kh.ma_khoa
		WHERE kh.ma_khoa IS NULL;

-- 5. RIGHT EXCLUDING JOIN
-- RIGHT EXCLUDING JOIN: dùng để lấy những bản ghi chỉ thuộc bảng bên phải
	SELECT * FROM
		sinh_vien sv RIGHT JOIN khoa kh ON sv.ma_khoa = kh.ma_khoa
		WHERE sv.ma_khoa IS NULL;
        
-- 6. CROSS JOIN
-- CROSS JOIN: dùng để kết hợp hai bảng, mỗi bản ghi của bảng bên trái được kết hợp với tất cả các bản ghi của bảng bên phải, 
-- tạo thành một tích Đề-các giữa hai bảng với kết quả trả về bằng tích của số bản ghi trong hai bảng
	SELECT * FROM
		sinh_vien CROSS JOIN khoa;
              

-- *************************II. Cách sử dụng UNION, UNION ALL***********************
 -- 7.UNION
 -- UNION được sử dụng để lấy các bản ghi duy nhất giữa 2 câu lệnh SELECT
 SELECT * 
	FROM sinh_vien 
	WHERE ma_sv IN(1,2)
 UNION
 SELECT * 
	FROM sinh_vien 
	WHERE ma_sv IN(2,3);
    
 -- 8.UNION
 -- UNION được sử dụng để lấy tất các bản ghi của 2 câu lệnh SELECT, bao gồm cả những bản ghi trùng lặp
  SELECT * 
	FROM sinh_vien 
	WHERE ma_sv IN(1,2)
 UNION ALL
 SELECT * 
	FROM sinh_vien 
	WHERE ma_sv IN(2,3);