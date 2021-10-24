DROP DATABASE IF EXISTS Asignment4;
CREATE DATABASE Asignment4;


CREATE DATABASE IF NOT EXISTS Asignment4;

ALTER DATABASE Asignment4 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE Asignment4;

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`(
	department_number	TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department_name		VARCHAR(30) CHAR SET utf8mb4 NOT NULL
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
SELECT * FROM `department`; 
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`(
	employee_number		TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_name		VARCHAR(30) CHAR SET utf8mb4 NOT NULL,
    department_number	TINYINT NOT NULL,
		FOREIGN KEY(department_number) REFERENCES `department`(department_number)
    );
   INSERT INTO `employee`(employee_name, department_number)
    VALUES 			('Lê Hồng Anh', 1),
					('Hoàng Thuý Phụng', 2),
                    ('Nguyễn Thị Loan', 2),
                    ('Bùi Ngọc Danh', 4),
					('Nguyễn Anh Tuấn', 6),
                    ('Lê Thành Long', 5),
                    ('Lê Nhật Thành', 10),
                    ('Lại Thị Ngọc', 2),
                    ('Nguyễn Thị Yến', 1),
					('Lê Văn Công', 9);
SELECT * FROM `employee`; 

DROP TABLE IF EXISTS `employee_skill`;
CREATE TABLE `employee_skill`(
	employee_number		TINYINT NOT NULL,
    skill_code			VARCHAR(30) CHAR SET utf8mb4 NOT NULL,
    date_registered		DATE,
		FOREIGN KEY(employee_number) REFERENCES `employee`(employee_number)
    );
   INSERT INTO `employee_skill`(employee_number, skill_code, date_registered)
    VALUES 			(1, 'JAVA', '2014-10-23'),
					(2, 'Python', '2015-11-23'),
                    (4, 'Ruby', '2016-10-24'),
                    (5, 'PHP', '2014-09-23'),
					(3, 'Swift', '2017-10-23'),
                    (6, 'JavaScript', '2018-11-23'),
                    (8, 'Kotlin', '2019-01-23'),
                    (9, 'Go', '2011-10-23'),
                    (7, 'Matlab', '2021-10-23'),
					(10,'C/C++', '2017-10-23');
SELECT * FROM `employee_skill`; 

-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
SELECT *
FROM `employee`
WHERE employee_name

UNION

SELECT 	*
FROM 	`employee_skill`
WHERE 	skill_code = 'JAVA';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT *
FROM `department`
WHERE department_name

UNION

SELECT *
FROM `employee`
WHERE employee_name

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất