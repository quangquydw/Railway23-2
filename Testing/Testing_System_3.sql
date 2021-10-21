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
                    ('vohoanganh@gmail.com', 'hoang_anh', 'Võ Hoàng Anh', 8, 3, '2020-11-16');
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
    VALUES 		(102, 'Tiêu đề 1', 1, '90m',1, '2021-10-11'),
				(101, 'Tiêu đề 2', 2, '45m',2, '2021-10-13'),
                (103, 'Tiêu đề 3', 3, '45m',3, '2021-10-14'),
                (104, 'Tiêu đề 4', 4, '90m',4, '2021-10-15'),
                (105, 'Tiêu đề 5', 5, '15m',5, '2021-10-16');
SELECT * FROM `exam`;
DROP TABLE IF EXISTS `exam_question`;
CREATE TABLE `exam_question`(
	exam_id			TINYINT NOT NULL,
    question_id		TINYINT NOT NULL,
		PRIMARY KEY(exam_id, question_id),
        FOREIGN KEY(exam_id) REFERENCES `exam`(exam_id),
        FOREIGN KEY(question_id) REFERENCES `question`(question_id)
);
SELECT * FROM `exam_question`;



-- Question 2: Lấy ra tất cả các phòng ban

SELECT *
FROM department;
-- Question 3: Lấy ra id của phòng ban Sale

SELECT department_id FROM `department`
	WHERE department_name = 'Sale';


-- Question 4: Lấy thông tin account có full name dài nhất

SELECT *
FROM `account`
WHERE length(full_name) = 
	(SELECT MAX(LENGTH(full_name))
		FROM `account`);
        
-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT * FROM `account`
WHERE length(full_name) = (SELECT MAX(length(full_name))
							FROM `account`) AND department_id = 3;

-- Question 6: Lấy ra group đã tham gia trước ngày 20/12/2019

SELECT group_name, create_date
FROM `group`
WHERE create_date <'2019-12-20';
        
-- Question 7: Lấy ra ID của question có >= 4 câu trả lời


-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"

SELECT full_name
FROM `account`
WHERE full_name LIKE 'D%o';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019--

SELECT *
FROM exam;
DELETE 
