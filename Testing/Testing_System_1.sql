DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;


CREATE DATABASE IF NOT EXISTS testing_system; -- Kiểm tra nếu không tồn tại database có tên là testing_system
USE testing_system;

-- Khoang cách giữa tên trường và kiểu dữ liệu
-- Khoảng cách lùi đầu dòng của các trường trong bảng

DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_id	INT,
    department_name	VARCHAR(50)
);
CREATE TABLE `position`(
	position_id		INT,
    position_name	ENUM ('Dev', 'Test', 'Scrum Master', 'PM')
);
CREATE TABLE `account`(
	account_id		INT,
    email			VARCHAR(50),
    user_name		VARCHAR(50),
    full_name		VARCHAR(50),
    department_id	INT,
    position_id		INT,
    create_date		DATE 
);
CREATE TABLE `group`(
	group_id		INT,
    group_name		VARCHAR(50),
    creator_id		INT,
    create_date		DATE
);
CREATE TABLE group_account(
	group_id		INT,
    account_id		INT,
    join_date		DATE
);
CREATE TABLE type_question(
	type_id			INT,
    type_name		ENUM('Essay', 'Multiple-Choice')
);   
CREATE TABLE category_question(
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