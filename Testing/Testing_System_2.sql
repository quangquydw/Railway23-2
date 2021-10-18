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
	INSERT INTO department (department_name)
    VALUES		(Marketing),
				
    
CREATE TABLE `position`(
	position_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    position_name	ENUM ('Dev', 'Test', 'Scrum Master', 'PM')
);
CREATE TABLE `account`(
	account_id		SMALLINT AUTO_INCREMENT PRIMARY KEY,
    email			VARCHAR(30) ,
    user_name		VARCHAR(30),
    full_name		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    department_id	TINYINT ,
    position_id		SMALLINT AUTO_INCREMENT PRIMARY KEY,
		FOREIGN KEY (position_id) REFERENCES `position`(position_id),
    create_date		DATE 
);
CREATE TABLE `group`(
	group_id		SMALLINT AUTO_INCREMENT,
    group_name		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    creator_id		SMALLINT,
    create_date		DATE
);
CREATE TABLE group_account(
	group_id		TINYINT,
    account_id		TINYINT,
    join_date		DATE
);
CREATE TABLE type_question(
	type_id			INT,
    type_name		ENUM('Essay', 'Multiple-Choice')
);   
CREATE TABLE category_question(questionquestion
	category_id			INT,
    category_name		VARCHAR(50)
);
CREATE TABLE question(
	question_id		INT,
    content			VARCHAR(100),
    category_id		INT,
    type_id			INT,
    creator_id		INT,
    create_date		DATE
);    
CREATE TABLE answer(
	answer_id		INT,
    content			VARCHAR(100),
    question_id		INT,
    is_correct		BOOLEAN
);
CREATE TABLE exam(
	exam_id			INT,
	`code`			CHAR(20),
    title			VARCHAR(50),
    category		INT,
    duration		INT,
    creator_id		INT,
    create_date		DATE
);
CREATE TABLE exam_question(
	exam_id			INT,
    question_id		INT
);