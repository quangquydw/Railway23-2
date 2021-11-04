DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;


CREATE DATABASE IF NOT EXISTS testing_system; -- Kiểm tra nếu không tồn tại database có tên là testing_system

ALTER DATABASE testing_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE testing_system;

-- Khoang cách giữa tên trường và kiểu dữ liệu
-- Khoảng cách lùi đầu dòng của các trường trong bảng

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`(
	department_id	TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department_name	VARCHAR(30) CHAR SET utf8mb4 NOT NULL
    );
   INSERT INTO `department`(department_name)
    VALUES 			('Marketing'),
					('Sale'),
                    ('Bảo vệ'),
                    ('Nhân sự'),
					('Kỹ thuật'),
                    ('Tài chính'),
                    ('Phó giám đốc'),
                    ('Giám đốc'),
                    ('Thư ký'),
					('Bán hàng');
				
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`(
	position_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    position_name	ENUM ('Dev', 'Test', 'Scrum Master', 'PM')
);
INSERT INTO `position`(position_name)
    VALUES 		('Dev' ),
				('Test'),
                ('Scrum Master'),
                ('PM');
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`(
	account_id		TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    email			VARCHAR(50) UNIQUE KEY NOT NULL,
    user_name		VARCHAR(30) UNIQUE KEY NOT NULL,
    full_name		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    department_id	TINYINT  NOT NULL,
    position_id		TINYINT  NOT NULL,
    create_date		DATE,
    FOREIGN KEY (department_id) REFERENCES `department`(department_id),
    FOREIGN KEY (position_id) REFERENCES `position`(position_id)
);
INSERT INTO `account`(email, user_name, full_name, department_id, position_id,create_date)
    VALUES			('lethanhhung@gmail.com', 'le_hung', 'Lê Thanh Hùng', 1, 2, '2021-10-11'),
					('tranngochung@gmail.com', 'ngoc_hung', 'Trần Ngọc Hưng', 3, 4, '2021-04-13'),
                    ('letrongtan@gmail.com', 'trong_tan', 'Lê TRọng Tấn', 5, 3, '2013-05-13'),
                    ('hoangthimai@gmail.com', 'hoang_mai', 'Hoàng Thị Mai', 4, 1, '2020-10-15'),
                    ('buicongthinh@gmail.com', 'cong_thinh', 'Bùi Công Thịnh', 6, 4, '2019-11-16'),
                    ('nguyenvanthe@gmail.com', 'hoang_anh', 'Nguyễn Văn Thế', 8, 3, '2020-11-16');
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
	group_id		TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_name		VARCHAR(30) CHAR SET utf8mb4 NOT NULL,
    creator_id		TINYINT NOT NULL,
    create_date		DATE,
		FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);
INSERT INTO `group` (group_name, creator_id, create_date)
    VALUES			('sale 1', 6, '2021-02-21'),
					('sale 2', 3, '2021-03-21'),
					('Kỹ thuật 1', 4, '2020-04-21'),
                    ('Kỹ thuật 2', 2, '2021-05-21'),
                    ('Bán hàng 1', 3, '2021-06-21'),
                    ('Bán hàng 2', 5, '2021-07-21');
DROP TABLE IF EXISTS `group_account`;
CREATE TABLE `group_account`(
	group_id		TINYINT NOT NULL , -- QUAN HE NHIEU NHIEU
    account_id		TINYINT NOT NULL ,
    join_date		DATE,
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group`(group_id),
	FOREIGN KEY (account_id) REFERENCES `account`(account_id)
);
-- Thêm dât vào bảng group_account
INSERT INTO `group_account`(group_id, account_id, join_date)
    VALUES 		(1,2, '2021-10-01'),
				(2,1, '2021-10-03'),
                (4,3, '2021-10-05'),
                (3,4, '2021-10-06'),
                (5,1, '2021-11-06');
SELECT * FROM `group_account`;
-- TABLE 6
DROP TABLE IF EXISTS `type_question`;
CREATE TABLE `type_question`(
	type_id			TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type_name		ENUM('Essay', 'Multiple-Choice')
); 
-- Thêm dât vào bảng `type_question`
INSERT INTO `type_question`(type_name)
VALUES		('Essay'),
			('Multiple-Choice'),
            ('Multiple-Choice'),
            ('Essay'),
            ('Multiple-Choice');
            SELECT * FROM `type_question`;
-- TABLE 7
DROP TABLE IF EXISTS `category_question`;  
CREATE TABLE `category_question`(
	category_id			TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name		VARCHAR(50) CHAR SET utf8mb4 NOT NULL
);
-- Thêm dât vào bảng `category_question`
INSERT INTO `category_question`(category_name)
VALUES			('JAVA'),
				('.NET'),
                ('SQL'),
                ('Postman'),
                ('Ruby');
SELECT * FROM `category_question`; 
-- TABLE 8               
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`(
	question_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    content			VARCHAR(250) CHAR SET utf8mb4 NOT NULL,
    category_id		TINYINT NOT NULL,
    type_id			TINYINT NOT NULL,
    creator_id		TINYINT NOT NULL,
    create_date		DATE,
    FOREIGN KEY(category_id) REFERENCES `category_question`(category_id),
	FOREIGN KEY(type_id) REFERENCES `type_question`(type_id)
);
-- Thêm dât vào bảng `question`
	INSERT INTO `question`(content, category_id, type_id, creator_id, create_date)
    VALUES 		('Câu hỏi 1', 1, 2, 3, '2021-10-01'),
				('Câu hỏi 2', 2, 4, 5, '2021-01-01'),
                ('Câu hỏi 3', 3, 2, 1, '2021-02-01'),
                ('Câu hỏi 4', 2, 2, 2, '2021-03-01'),
                ('Câu hỏi 5', 1, 3, 4, '2021-04-01');
SELECT * FROM `question`; 
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer`(
	answer_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    content			VARCHAR(250) CHAR SET utf8mb4 NOT NULL,
    question_id		TINYINT NOT NULL,
    is_correct		BOOLEAN,
    FOREIGN KEY(question_id) REFERENCES `question`(question_id)
);
	INSERT INTO `answer`(content, question_id, is_correct)
    VALUES		('Câu trả lời 1', 1, 1),
				('Câu trả lời 3', 2, 1),
                ('Câu trả lời 4', 3, 0),
                ('Câu trả lời 5', 4, 1),
                ('Câu trả lời 2', 5, 0);
SELECT * FROM `answer`;
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`(
	exam_id			TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	`code`			TINYINT UNIQUE KEY NOT NULL,
    title			VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    category_id		TINYINT NOT NULL,
    duration		ENUM ('15m', '30m', '45m', '90m'),
    creator_id		TINYINT NOT NULL,
    create_date		DATE,
    FOREIGN KEY(category_id) REFERENCES `category_question`(category_id),
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);
INSERT INTO `exam`(`code`, title, category_id, duration, creator_id, create_date)
    VALUES 		(102, 'Tiêu đề 1', 1, '90m',1, '2018-10-11'),
				(101, 'Tiêu đề 2', 2, '45m',2, '2021-10-13'),
                (103, 'Tiêu đề 3', 3, '45m',3, '2021-10-14'),
                (104, 'Tiêu đề 4', 4, '90m',4, '2021-10-15'),
                (105, 'Tiêu đề 5', 5, '15m',5, '2021-10-16');
SELECT * FROM `exam`;

-- Ví dụ 1: tạo thủ tục lấy tên phòng ban theo mã phòng ban
-- tạo thủ tục
-- sp: store procedure
-- kiểm tra nếu tồn tại thủ tục có tên là sp_lay_ten_phong_theo_ma_phong thì xoá đi
drop procedure if exists sp_lay_ten_phong_theo_ma_phong;

-- Khai báo tạo thủ tục
DELIMITER $$
create procedure sp_lay_ten_phong_theo_ma_phong(in departmentID tinyint, out departmentName varchar(30))
	begin 
    select department_name into departmentName
		from department
			where department_id = departmentID;
	end $$
    DELIMITER ;
describe `department`;

-- sử dụng thủ tục/ gọi thủ tục

set @ten_phong_ban = '';
call sp_lay_ten_phong_theo_ma_phong(1, @ten_phong_ban);
select @ten_phong_ban;

-- Ví dụ 2: Viết thủ tục lấy thông tin câu hỏi của tác giả có tên là 'Nguyễn Văn Thế' hoặc địa chỉ email là 'nguyenvanthe@gmail.com'

Drop procedure if exists lay_thong_tin_cau_hoi;
DELIMITER $$
create procedure lay_thong_tin_cau_hoi(in tenTacGia varchar (50) CHAR SET utf8mb4, nhapEmail varchar (250))
	begin 
    select q.* 
		from `question` q JOIN `account`ac ON q.creator_id = ac.account_id
			where ac.full_name = tenTacGia OR ac.email = nhapEmail;
	end $$
    DELIMITER ;
    

call lay_thong_tin_cau_hoi('Nguyễn Văn Thế');

-- Ví dụ 3: tạo thủ tục lấy tên phòng ban theo mã phòng ban (ko dùng Parametter)

drop procedure if exists sp_lay_ten_phong_theo_ma_phong_2;

-- Khai báo tạo thủ tục
DELIMITER $$
create procedure sp_lay_ten_phong_theo_ma_phong_2(in departmentID tinyint) 
	begin 
    declare deName varchar (30);
		select department_name into deName
		from department 
			where department_id = departmentID;
            select deName;
	end $$
    DELIMITER ;
    
call sp_lay_ten_phong_theo_ma_phong_2(3);
describe `department`;

-- Viết hàm để lấy ra chức vụ của nhân viên có mã là 1;
SET GLOBAL log_bin_trust_function_creators = 1;

drop function if exists f_lay_chuc_vu_cua_nhan_vien;
DELIMITER $$
create function f_lay_chuc_vu_cua_nhan_vien( maNhanVien tinyint)
	returns  enum ('Dev','Test','Scrum Master','PM')
		begin 
			declare tenChucVu  enum('Dev','Test','Scrum Master','PM');
            select p.position_name into tenChucVu
            from `position` p join `account` ac on p.position_id = ac.position_id
            where ac.account_id = maNhanVien;
            return tenChucVu;
		end$$
DELIMITER ;

select f_lay_chuc_vu_cua_nhan_vien(2);
describe `account`;
describe `position`;

-- lấy giờ hiện tại
select current_date();

-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

describe `department`;
describe `account`;
Drop procedure if exists lay_thong_tin_account_cua_phong_ban;
DELIMITER $$
create procedure lay_thong_tin_account_cua_phong_ban(in departmentName varchar (30) CHAR SET utf8mb4)
	begin 
    select ac.full_name
		from `department` d JOIN `account` ac ON d.department_id = ac.account_id
			where d.department_name = department_name;
	end $$
    DELIMITER ;
describe `department`;  
describe `account`; 

call lay_thong_tin_account_cua_phong_ban('Sale');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group

Drop procedure if exists in_ra_so_luong_account_trong_group;
DELIMITER $$
create procedure in_ra_so_luong_account_trong_group(in departmentName varchar (30) CHAR SET utf8mb4)
	begin 
		select g.group_name, COUNT(ga.account_id) AS 'số lương ID'
		from `group` g 
			LEFT JOIN `group_account` ga ON g.group_id = ga.group_id
			GROUP BY g.group_id;
	end $$
    DELIMITER ;

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại

Drop procedure if exists thong_ke_loai_cau_hoi;
DELIMITER $$
create procedure thong_ke_loai_cau_hoi()
	begin 
		declare loai_cau_hoi enum('Essay','Multiple-Choice');
        select COUNT(q.question_id)
		from `typye_question` tq JOIN question q ON tq.type_id = q.type_id 
		where month(q.create_date) = month(curdate())
			GROUP BY q.type_id;
            select loai_cau_hoi;
	end $$
    DELIMITER ;

-- Question 6

DROP PROCEDURE IF EXISTS sp_ten_thanh_vien_hoac_nhom;
DELIMITER $$
CREATE PROCEDURE sp_ten_thanh_vien_hoac_nhom (IN nhap_ky_tu VARCHAR(20) CHAR SET utf8mb4)
BEGIN 
	DECLARE ten_nhom VARCHAR(20) CHAR SET utf8mb4;
    DECLARE ten_nv VARCHAR(20) CHAR SET utf8mb4;
		SELECT g.group_name,a.user_name 
			FROM `group` g
				JOIN group_account ga ON g.group_id = ga.group_id
				JOIN `account` a ON ga.account_id = a.account_id
					WHERE group_name LIKE CONCAT('%',nhap_ky_tu,'%') collate utf8mb4_general_ci
						OR user_name LIKE CONCAT('%',nhap_ky_tu,'%') collate utf8mb4_general_ci;
END$$
DELIMITER ;
CALL sp_ten_thanh_vien_hoac_nhom('n');
