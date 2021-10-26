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
    VALUES 		(102, 'Tiêu đề 1', 1, '90m',1, '2018-10-11'),
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
        FOREIGN KEY(exam_id) REFERENCES `exam`(exam_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(question_id) REFERENCES `question`(question_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `exam_question`(exam_id, question_id)
    VALUES	(1, 2),
			(2, 3),
            (3, 1),
            (4, 2);
SELECT * FROM `exam_question`;


-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT ac.full_name, d.*
FROM `account` ac
JOIN `department` d ON ac.department_id = d.department_id;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `account`
WHERE create_date >('2010-12-20');

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT ac.full_name
FROM `account` ac
JOIN `position` p ON ac.position_id = p.position_id
WHERE p.position_name = 'Dev';

SHOW TABLES;
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT 
	dedepartment_name phong_ban, COUNT(ac.department_id) nhan_vien
FROM 
	`department` de
JOIN `account` ac ON de.department_id = ac.department_id
GROUP BY ac.department_id
HAVING COUNT(ac.account_id) > 3;

SELECT * FROM `department`;


-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
	select * from `question`;
    select * from `exam_question`;
    SELECT q.*, COUNT(eq.exam_id) AS 'Sô bài thi'
    FROM question q
    JOIN exam_question eq ON q.question_id = eq.question_id
    GROUP BY q.question_id
    HAVING COUNT(eq.exam_id) = (
		SELECT MAX(t1.exam_count) 
        FROM (
			SELECT COUNT(exam_id) AS exam_count
			FROM exam_question 
			GROUP BY question_id
		) t1
	);

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT * FROM `question`;
SELECT * FROM `category_question`;


SELECT cq.category_name, COUNT(q.question_id) AS 'Số lần được sử dụng' -- Thêm cột COUNT để kiểm tra
FROM `category_question` cq
RIGHT JOIN `question` q ON cq.category_id = q.category_id
GROUP BY q.category_id;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam


-- Question 8: Lấy ra Question có nhiều câu trả lời nhất

SELECT q.content, COUNT(ans.answer_id) AS 'Số câu trả lời'
FROM question q
	JOIN answer ans ON q.question_id = ans.question_id
    GROUP BY ans.question_id
    HAVING COUNT(ans.answer_id) = (
		SELECT MAX(answer_count) AS 'Số câu trả lời'
        FROM (
			SELECT question_id, COUNT(answer_id) AS answer_count
            FROM answer
            GROUP BY question_id
            ) AS t2
	);
    
-- Question 9: Thống kê số lượng account trong mỗi group

SELECT g.group_name, COUNT(ga.account_id) AS 'Số lượng Account'
FROM `group_account` ga
	RIGHT JOIN `group` g ON g.group_id = ga.group_id
		GROUP BY g.group_id;

-- Question 10: Tìm chức vụ có ít người nhất

SELECT p.position_name, COUNT(a.account_id) AS 'Số lượng người trong phòng ban này'
FROM `position` p LEFT JOIN `account` a ON p.position_id = a.position_id
GROUP BY p.position_id
HAVING COUNT(a.account_id) =
	(SELECT MIN(so_luong_nhan_vien_it_nhat)
		FROM (SELECT p.position_id, p.position_name, COUNT(account_id) as so_luong_nhan_vien_it_nhat
			FROM `account` a RIGHT JOIN `position` p ON a.position_id = P. position_id
			GROUP BY p.position_id) AS nhom);
            
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM

SELECT d.department_name, p.position_name, COUNT(a.account_id) 'so_luong_nv'
	FROM department d
    LEFT JOIN `account` a ON d.department_id = a.department_id
    LEFT JOIN `position` p ON a.position_id = p.position_id
		GROUP BY p.position_id, d.department_id;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của

SELECT * FROM `question`;

SELECT * FROM `type_question`;

SELECT * FROM `category_question`;

SELECT	q.question_id, q.content 'câu hỏi',
		t.type_name 'dạng câu hỏi',
        a.full_name 'người tạo',
        an.content 'trả lời',
        cq.category_name 'loại câu hỏi'
	FROM question q
		LEFT JOIN typy_question t ON q.question_id = t.type_id
        LEFT JOIN `account` ac ON q.creator_id = ac.account_id
        LEFT JOIN answer an ON q.question_id = an.question_id
        LEFT JOIN category_question cq ON cq.category_id = q.category_id;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

SELECT * 
FROM `question`;

SELECT * 
FROM `type_question`;

SELECT type_name, COUNT(tq. type_id) AS so_luong_cau_hoi
FROM type_question tq
JOIN question q ON tq.type_id = q.type_id
GROUP BY tq.type_id
;

-- Question 15: Lấy ra group không có account nào

SELECT *
FROM `group`;
SELECT *
FROM `group_account`;
SELECT g.group_id, group_name
	FROM `group` g
	LEFT JOIN group_account ga ON g.group_id = ga.group_id
    WHERE ga.account_id IS NULL;

-- Question 17:
	-- a) Lấy các account thuộc nhóm thứ 1
    
	SELECT *
	FROM `group_account`;
	SELECT *
	FROM `account`;
    
    SELECT ac.user_name, ga.group_id
    FROM `group_account` ga JOIN `account` ac ON ga.account_id = ac.account_id
    WHERE group_id = 1;
    
	-- b) Lấy các account thuộc nhóm thứ 2
    
    SELECT ac.user_name, ga.group_id
    FROM `group_account` ga JOIN `account` ac ON ga.account_id = ac.account_id
    WHERE group_id = 2;
    
	-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
	SELECT ac.user_name, ga.group_id
    FROM `group_account` ga JOIN `account` ac ON ga.account_id = ac.account_id
    WHERE group_id = 1
    UNION
	SELECT ac.user_name, ga.group_id
    FROM `group_account` ga JOIN `account` ac ON ga.account_id = ac.account_id
    WHERE group_id = 2;
-- Question 18:
-- 		a) Lấy các group có lớn hơn 5 thành viên
SELECT g.group_id, COUNT(ga.account_id) AS 'số thành viên trong nhóm' 
	FROM `group` g JOIN group_account ga ON g.group_id = ga.group_id
	GROUP BY g.group_idß
	HAVING COUNT(ga.account_id) > 5;
-- 		b) Lấy các group có nhỏ hơn 7 thành viên
SELECT g.group_id, COUNT(ga.account_id) AS 'số thành viên trong nhóm' 
FROM `group` g LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING COUNT(ga.account_id) < 7;
-- 		c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.group_id, COUNT(ga.account_id) AS 'số thành viên trong nhóm' 
FROM `group` g JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING COUNT(ga.account_id) > 5
	UNION ALL
SELECT g.group_id, COUNT(ga.account_id) AS 'số thành viên trong nhóm' 
FROM `group` g LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING COUNT(ga.account_id) < 7;


    