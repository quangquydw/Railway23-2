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
				
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`(
	position_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    position_name	ENUM ('Dev', 'Test', 'Scrum Master', 'PM')
);
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`(
	account_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    email			VARCHAR(50) UNIQUE KEY NOT NULL,
    user_name		VARCHAR(30) UNIQUE KEY NOT NULL,
    full_name		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    department_id	TINYINT UNIQUE KEY NOT NULL,
    position_id		TINYINT,
		FOREIGN KEY (position_id) REFERENCES `position`(position_id),
    create_date		DATE 
);
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
	group_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    group_name		VARCHAR(30) CHAR SET utf8mb4 NOT NULL,
    creator_id		TINYINT,
		FOREIGN KEY(creator_id) REFERENCES `account`(account_id),
    create_date		DATE
);
DROP TABLE IF EXISTS `group_account`;
CREATE TABLE `group_account`(
	group_id		TINYINT,
		FOREIGN KEY (group_id) REFERENCES `group`(group_id),
    account_id		TINYINT ,
		FOREIGN KEY (account_id) REFERENCES `account`(account_id),
    join_date		DATE
);
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
    category_id		TINYINT,
		FOREIGN KEY(category_id) REFERENCES `category_question`(category_id),
    type_id			TINYINT,
		FOREIGN KEY(type_id) REFERENCES `type_question`(type_id),
    creator_id		TINYINT UNIQUE KEY NOT NULL,
    create_date		DATE
);    
CREATE TABLE `answer`(
	answer_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    content			VARCHAR(250) CHAR SET utf8mb4 NOT NULL,
    question_id		TINYINT,
		FOREIGN KEY(question_id) REFERENCES `question`(question_id),
    is_correct		BOOLEAN
);
CREATE TABLE `exam`(
	exam_id			TINYINT AUTO_INCREMENT PRIMARY KEY,
	`code`			CHAR(20) UNIQUE KEY NOT NULL,
    title			VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    category_id		TINYINT UNIQUE KEY NOT NULL,
    duration		TINYINT,
    creator_id		TINYINT UNIQUE KEY NOT NULL,
    create_date		DATE
);
CREATE TABLE exam_question(
	exam_id			TINYINT,
		FOREIGN KEY(exam_id) REFERENCES `exam`(exam_id),
    question_id		TINYINT,
		FOREIGN KEY(question_id) REFERENCES `question`(question_id)
);