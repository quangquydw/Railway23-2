DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;


CREATE DATABASE IF NOT EXISTS testing_system; -- Kiểm tra nếu không tồn tại database có tên là testing_system

ALTER DATABASE testing_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE testing_system;

-- Khoang cách giữa tên trường và kiểu dữ liệu
-- Khoảng cách lùi đầu dòng của các trường trong bảng

DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_id	TINYINT AUTO_INCREMENT PRIMARY KEY,
    department_name	VARCHAR(30) CHAR SET utf8mb4 NOT NULL
    );
   INSERT INTO department(department_name)
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
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (position_id) REFERENCES `position`(position_id)
);
INSERT INTO `account`(email, user_name, full_name, department_id, position_id)
    VALUES			('lethanhhung@gmail.com', 'le_hung', 'Lê Thanh Hùng', 1, 2),
					('tranngochung@gmail.com', 'ngoc_hung', 'Trần Ngọc Hưng', 3, 4),
                    ('letrongtan@gmail.com', 'trong_tan', 'Lê TRọng Tấn', 1, 3);
DROP TABLE IF EXISTS `account`;
CREATE TABLE `group`(
	group_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    group_name		VARCHAR(30) CHAR SET utf8mb4 NOT NULL,
    creator_id		TINYINT,
		FOREIGN KEY(creator_id) REFERENCES `account`(account_id),
    create_date		DATE
);
DROP TABLE IF EXISTS `group_account`;
CREATE TABLE `group_account`(
	group_id		TINYINT NOT NULL PRIMARY KEY, -- QUAN HE NHIEU NHIEU
    account_id		TINYINT NOT NULL PRIMARY KEY,
		FOREIGN KEY (group_id) REFERENCES `group`(group_id),
		FOREIGN KEY (account_id) REFERENCES `account`(account_id),
    join_date		DATE
);

INSERT INTO `group_account`(group_id, account_id, join_date)
    VALUES 		(1,2, 2021-10-01),
				(2,1, 2021-10-03),
                (4,4, 2021-10-05),
                (3,3, 2021-10-06);
                
DROP TABLE IF EXISTS `type_question`;
CREATE TABLE `type_question`(
	type_id			TINYINT AUTO_INCREMENT PRIMARY KEY,
    type_name		ENUM('Essay', 'Multiple-Choice')
); 
DROP TABLE IF EXISTS `category_question`;  
CREATE TABLE `category_question`(
	category_id			TINYINT AUTO_INCREMENT PRIMARY KEY,
    category_name		VARCHAR(50) CHAR SET utf8mb4 NOT NULL
);
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`(
	question_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    content			VARCHAR(250) CHAR SET utf8mb4 NOT NULL,
    category_id		TINYINT NOT NULL,
    type_id			TINYINT NOT NULL,
    creator_id		TINYINT UNIQUE KEY NOT NULL,
    create_date		DATE,
    FOREIGN KEY(category_id) REFERENCES `category_question`(category_id),
	FOREIGN KEY(type_id) REFERENCES `type_question`(type_id)
);
	INSERT INTO `question`(question_id, content, category_id, type_id, creator_id, create_date)
    VALUES 		(1, 'Câu hỏi 1', 1, 2, 3, 2021/10/01),
				(2, 'Câu hỏi 2', 2, 4, 5, 2021/10/01),
                (4, 'Câu hỏi 3', 3, 2, 1, 2021/10/01),
                (2, 'Câu hỏi 4', 2, 2, 2, 2021/10/01),
                (1, 'Câu hỏi 5', 1, 3, 4, 2021/10/01);
CREATE TABLE `answer`(
	answer_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    content			VARCHAR(250) CHAR SET utf8mb4 NOT NULL,
    question_id		TINYINT,
    is_correct		BOOLEAN,
    FOREIGN KEY(question_id) REFERENCES `question`(question_id)
);
	INSERT INTO `answer`(content, question_id, is_correct)
    VALUES		('Câu trả lời 1', 1, 2, 3, 2021/10/01),
				('Câu trả lời 2', 2, 4, 5, 2021/10/01),
                ('Câu trả lời 2', 3, 2, 1, 2021/10/01),
                ('Câu trả lời 2', 2, 2, 2, 2021/10/01),
                ('Câu trả lời 2', 1, 3, 4, 2021/10/01);		
CREATE TABLE `exam`(
	exam_id			TINYINT AUTO_INCREMENT PRIMARY KEY,
	`code`			TINYINT UNIQUE KEY NOT NULL,
    title			VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    category_id		TINYINT UNIQUE KEY NOT NULL,
    duration		ENUM ('15', '30', '45', '90'),
    creator_id		TINYINT UNIQUE KEY NOT NULL,
    create_date		DATE,
    FOREIGN KEY(category_id) REFERENCES `category_question`(category_id),
    FOREIGN KEY(creator_id) REFERENCES `account`(creator_id)
);
INSERT INTO `question`(question_id, content, category_id, type_id, creator_id, create_date)
    VALUES 		(102, 'Câu hỏi 1', 1, 2, 3, 2021/10/01),
				(101, 'Câu hỏi 2', 2, 4, 5, 2021/10/01),
                (103, 'Câu hỏi 3', 3, 2, 1, 2021/10/01),
                (104, 'Câu hỏi 4', 2, 3, 2, 2021/10/01),
                (105, 'Câu hỏi 5', 1, 3, 4, 2021/10/01);
CREATE TABLE exam_question(
	exam_id			TINYINT,
    question_id		TINYINT,
		FOREIGN KEY(exam_id) REFERENCES `exam`(exam_id),
        FOREIGN KEY(question_id) REFERENCES `question`(question_id)
);


-- Question 4: Lấy thông tin account có full name dài nhất

SELECT *
FROM `account`
WHERE length(full_name) = 
	(SELECT MAX(LENGTH(full_name))
		FROM `account`);
        
        
-- Question 7: Lấy ra ID của question có >= 4 câu trả lời

SELECT * FROM question_id
SELECT question_id
FORM


