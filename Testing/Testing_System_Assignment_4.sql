use testing_system;

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
	de.department_name phong_ban, COUNT(ac.department_id) nhan_vien
FROM 
	`department` de
JOIN `account` ac ON de.department_id = ac.department_id
GROUP BY de.department_id
HAVING COUNT(ac.account_id) > 3;

SELECT * FROM `department`;


-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
	select * from `question`;
    select * from `exam_question`;
    
    SELECT q.content, COUNT(eq.exam_id) AS 'Sô bài thi'
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
LEFT JOIN `question` q ON cq.category_id = q.category_id
GROUP BY cq.category_id;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

SELECT * FROM `question`;
SELECT * FROM `exam_question`;

SELECT q.content, COUNT(eq.exam_id) AS 'de thi'
FROM `question` q
	LEFT JOIN `exam_question` eq ON eq.question_id = q.question_id
    GROUP BY q.question_id;

-- Question 8: Lấy ra Question có nhiều câu tanswerrả lời nhất
USE testing_system;
SELECT * FROM `question`;
SELECT * FROM `answer`;
SELECT q.content, COUNT(an.answer_id) AS 'Số câu trả lời'
FROM question q
	LEFT JOIN answer an ON q.question_id = an.question_id
    GROUP BY q.question_id
    HAVING COUNT(an.answer_id) = (
		SELECT MAX(answer_count) AS 'Số câu trả lời'
        FROM (
			SELECT q.question_id, COUNT(answer_id) AS answer_count
            FROM question q
            LEFT JOIN answer an ON an.question_id = q.question_id
            GROUP BY q.question_id
            ) AS t2
	);
    
-- Question 9: Thống kê số lượng account trong mỗi group

SELECT g.group_name, COUNT(ga.account_id) AS 'Số lượng Account'
FROM `group_account` ga
	RIGHT JOIN `group` g ON g.group_id = ga.group_id
		GROUP BY g.group_id;

-- Question 10: Tìm chức vụ có ít người nhất

SELECT p.position_name, COUNT(a.account_id) AS 'Số lượng người trong group này'
FROM `position` p LEFT JOIN `account` a ON p.position_id = a.position_id
GROUP BY p.position_id
HAVING COUNT(a.account_id) =
	(SELECT MIN(so_luong_nhan_vien_it_nhat)
		FROM (SELECT p.position_id, p.position_name, COUNT(account_id) as so_luong_nhan_vien_it_nhat
			FROM `position` p LEFT JOIN `account` a ON p.position_id = a.position_id
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
        ac.full_name 'người tạo',
        an.content 'trả lời',
        cq.category_name 'loại câu hỏi'
	FROM question q
		LEFT JOIN type_question t ON q.question_id = t.type_id
        LEFT JOIN `account` ac ON q.creator_id = ac.account_id
        LEFT JOIN answer an ON q.question_id = an.question_id
        LEFT JOIN category_question cq ON cq.category_id = q.category_id;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

SELECT * 
FROM `question`;

SELECT * 
FROM `type_question`;

SELECT type_name, COUNT(q.question_id) AS so_luong_cau_hoi
FROM type_question tq
JOIN question q ON tq.type_id = q.type_id
GROUP BY tq.type_id;

-- Question 15: Lấy ra group không có account nào

SELECT *
FROM `group`;
SELECT *
FROM `group_account`;
SELECT g.group_id, group_name
	FROM `group` g
	LEFT JOIN group_account ga ON g.group_id = ga.group_id
    WHERE ga.account_id IS NULL;

-- Question 16: Lấy ra question không có answer nào


SELECT *
FROM `question`;
SELECT *
FROM `answer`;
SELECT q.content
	FROM `question` q
	LEFT JOIN answer an ON q.question_id = an.question_id
    WHERE an.question_id IS NULL;



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
	GROUP BY g.group_id
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


    