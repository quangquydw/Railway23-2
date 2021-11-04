DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;


CREATE DATABASE IF NOT EXISTS testing_system; -- Kiểm tra nếu không tồn tại database có tên là testing_system

ALTER DATABASE testing_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE testing_system;

-- Khoang cách giữa tên trường và kiểu dữ liệu
-- Khoảng cách lùi đầu dòng của các trường trong bảng

-- Table 1:Department
--  DepartmentID: định danh của phòng ban (auto increment)
--  DepartmentName: tên đầy đủ của phòng ban (VD: sale, marketing, ...)
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
                    
-- Table 2: Position
--  PositionID: định danh của chức vụ (auto increment)
--  PositionName: tên chức vụ (Dev, Test, Scrum Master, PM)				
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
                
-- Table 3: Account
--  AccountID: định danh của User (auto increment)
--  Email:
-- b Username:
--  FullName:
--  DepartmentID: phòng ban của user trong hệ thống
--  PositionID: chức vụ của User
--  CreateDate: ngày tạo tài khoản

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
					('tranngochung@gmail.com', 'ngoc_hung', 'Trần Ngọc Hưng', 1, 4, '2021-04-13'),
                    ('letrongtan@gmail.com', 'trong_tan', 'Lê TRọng Tấn', 1, 3, '2013-05-13'),
                    ('hoangthimai@gmail.com', 'hoang_mai', 'Hoàng Thị Mai', 1, 1, '2020-10-15'),
                    ('buicongthinh@gmail.com', 'cong_thinh', 'Bùi Công Thịnh', 6, 4, '2019-11-16'),
                    ('vohoanganh@gmail.com', 'hoang_anh', 'Võ Hoàng Anh', 8, 3, '2020-11-16');
                    
-- Table 4: Group
--  GroupID: định danh của nhóm (auto increment)
--  GroupName: tên nhóm
--  CreatorID: id của người tạo group
--  CreateDate: ngày tạo group

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
	group_id		TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_name		VARCHAR(30) CHAR SET utf8mb4 NOT NULL UNIQUE,
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
                    
-- Table 5: GroupAccount
--  GroupID: định danh của nhóm
--  AccountID: định danh của User
--  JoinDate: Ngày user tham gia vào nhóm
DROP TABLE IF EXISTS `group_account`;
CREATE TABLE `group_account`(
	group_id		TINYINT NOT NULL , -- QUAN HE NHIEU NHIEU
    account_id		TINYINT NOT NULL ,
    join_date		DATE,
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group`(group_id),
	FOREIGN KEY (account_id) REFERENCES `account`(account_id)
);
-- Thêm data vào bảng group_account
INSERT INTO `group_account`(group_id, account_id, join_date)
    VALUES 		(1,2, '2021-10-01'),
				(2,1, '2021-10-03'),
                (4,3, '2021-10-05'),
                (3,4, '2021-10-06'),
                (5,1, '2021-11-06');
SELECT * FROM `group_account`;

-- Table 6: TypeQuestion
--  TypeID: định danh của loại câu hỏi (auto increment)
--  TypeName: tên của loại câu hỏi (Essay, Multiple-Choice)
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
            
            
-- Table 7: CategoryQuestion
--  CategoryID: định danh của chủ đề câu hỏi (auto increment)
--  CategoryName: tên của chủ đề câu hỏi (Java, .NET, SQL, Postman, Ruby,
-- ...)

DROP TABLE IF EXISTS `category_question`;  
CREATE TABLE `category_question`(
	category_id			TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name		VARCHAR(50) CHAR SET utf8mb4 NOT NULL UNIQUE
);
-- Thêm dât vào bảng `category_question`
INSERT INTO `category_question`(category_name)
VALUES			('JAVA'),
				('.NET'),
                ('SQL'),
                ('Postman'),
                ('Ruby');
SELECT * FROM `category_question`; 

-- Table 8: Question
--  QuestionID: định danh của câu hỏi (auto increment)
--  Content: nội dung của câu hỏi
--  CategoryID: định danh của chủ đề câu hỏi
--  TypeID: định danh của loại câu hỏi
--  CreatorID: id của người tạo câu hỏi
--  CreateDate: ngày tạo câu hỏi          
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`(
	question_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    content			VARCHAR(250) CHAR SET utf8mb4 NOT NULL,
    category_id		TINYINT NOT NULL,
    type_id			TINYINT NOT NULL,
    creator_id		TINYINT NOT NULL,
    create_date		DATE,
    FOREIGN KEY(category_id) REFERENCES `category_question`(category_id) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY(type_id) REFERENCES `type_question`(type_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(creator_id) REFERENCES `account`(account_id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Thêm dât vào bảng `question`
	INSERT INTO `question`(content, category_id, type_id, creator_id, create_date)
    VALUES 		('Câu hỏi 1', 1, 2, 3, '2021-10-01'),
				('Câu hỏi 2', 2, 4, 5, '2021-01-01'),
                ('Câu hỏi 3', 3, 2, 1, '2021-02-01'),
                ('Câu hỏi 4', 2, 2, 2, '2021-03-01'),
                ('Câu hỏi 5', 1, 3, 4, '2021-04-01'),
                ('Câu hỏi 6', 1, 3, 4, '2021-04-01');
SELECT * FROM `question`; 

-- Table 9: Answer
--  AnswerID: định danh của câu trả lời (auto increment)
--  Content: nội dung của câu trả lời
--  QuestionID: định danh của câu hỏi
--  isCorrect: câu trả lời này đúng hay sai
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

-- Table 10: Exam
--  ExamID: định danh của đề thi (auto increment)
--  Code: mã đề thi
--  Title: tiêu đề của đề thi
--  CategoryID: định danh của chủ đề thi
--  Duration: thời gian thi
--   CreatorID: id của người tạo đề thi
--  CreateDate: ngày tạo đề thi

DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`(
	exam_id			TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	`code`			TINYINT UNIQUE KEY NOT NULL,
    title			VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    category_id		TINYINT NOT NULL,
    duration		TINYINT,
    creator_id		TINYINT NOT NULL,
    create_date		DATE,
    FOREIGN KEY(category_id) REFERENCES `category_question`(category_id),
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);
INSERT INTO `exam`(`code`, title, category_id, duration, creator_id, create_date)
    VALUES 		(102, 'Tiêu đề 1', 1, 90,1, '2018-10-11'),
				(101, 'Tiêu đề 2', 2, 45,2, '2021-10-13'),
                (103, 'Tiêu đề 3', 3, 45,3, '2021-10-14'),
                (104, 'Tiêu đề 4', 4, 90,4, '2021-10-15'),
                (105, 'Tiêu đề 5', 5, 15,5, '2021-10-16');
SELECT * FROM `exam`;



-- Table 11: ExamQuestion
--  ExamID: định danh của đề thi
--  QuestionID: định danh của câu hỏi
DROP TABLE IF EXISTS `exam_question`;
CREATE TABLE `exam_question`(
	exam_id			TINYINT NOT NULL,
    question_id		TINYINT NOT NULL,
		PRIMARY KEY(exam_id, question_id),
        FOREIGN KEY(exam_id) REFERENCES `exam`(exam_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(question_id) REFERENCES `question`(question_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `exam_question`(exam_id, question_id)
    VALUES	(1, 2),
			(2, 3),
            (3, 1),
            (4, 2);
SELECT * FROM `exam_question`;
