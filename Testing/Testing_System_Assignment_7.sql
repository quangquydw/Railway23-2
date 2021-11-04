
use testing_system;
-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước

DROP TRIGGER IF EXISTS Trg_nhap_vao_group;
DELIMITER $$
CREATE TRIGGER Trg_nhap_vao_group
BEFORE INSERT ON `group`
FOR EACH ROW
BEGIN
DECLARE v_ngay_tao DATE;
SET v_ngay_tao = DATE_SUB(NOW(), interval 1 year);
IF (NEW.create_date <= v_ngay_tao) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'khong_the_tao_duoc_group';
END IF;

END$$
DELIMITER ;
INSERT INTO ``
SELECT * FROM `group`;
INSERT INTO `group` (group_name, creator_id, create_date)
VALUES ('sale 1', 1, '2018-04-10');

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa, 
-- khi thêm thì hiện ra thông báo "Department "Sale" cannot add more user"

SELECT * FROM `department`;
DROP TRIGGER IF EXISTS TrG_KhongAddUserToSale;
DELIMITER $$
CREATE TRIGGER TrG_KhongAddUserToSale
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN

	DECLARE v_depID TINYINT;
	SELECT d.department_id INTO v_depID FROM `department` d WHERE

d.department_name = 'Sale';

IF (NEW.department_id = v_depID) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'Khong the them user vao phong ban Sale';

END IF;

END$$
DELIMITER ;

-- Question 6:

SELECT * FROM `department`;
SELECT * FROM `account`;

DROP TRIGGER IF EXISTS set_default_for_account_which_not_input_department_id;
DELIMITER $$
CREATE TRIGGER set_default_for_account_which_not_input_department_id
	BEFORE INSERT ON `account`
    
-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
-- đáp án đúng: 1
-- đáp án sai: 0
DROP TRIGGER IF EXISTS trigger_check_answer;
DELIMITER $$
CREATE TRIGGER trigger_check_answer
	BEFORE INSERT ON answer
	FOR EACH ROW
	BEGIN
		DECLARE cntAnswer TINYINT;	-- biến chứa số đáp án của question nhập vào
        DECLARE cntTrueCorrect TINYINT;	-- biến chứa số đáp án đúng của question nhập vào
        -- lấy số đáp án của question nhập vào
		SELECT count(answer_id) INTO cntAnswer
		FROM answer
		WHERE question_id = NEW.question_id; -- question nhập vào
        
		-- lấy số đáp án đúng của question nhập vào
		SELECT count(is_correct) INTO cntTrueCorrect
		FROM answer
		WHERE question_id = NEW.question_id -- question nhập vào
		AND is_correct = 1;
        
        -- nếu question_id nhập vào đã có 4 câu trả lời hoặc question_id đó đã có 2 đáp án đúng thì show lỗi
        IF cntAnswer >= 4 OR (cntTrueCorrect >= 2 AND NEW.is_correct = 1) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'câu hỏi không được quá 4 answers và 2 đáp án đúng';
        END IF;       
	END $$
DELIMITER ;

-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
DROP TRIGGER IF EXISTS trigger_check_gender;
DELIMITER $$
CREATE TRIGGER trigger_check_gender
	BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN
		IF NEW.gender = 'nam' then
			SET NEW.gender = 'M';
		END IF;
		IF NEW.gender = 'nữ' then
			SET NEW.gender = 'F';
		END IF;
		IF NEW.gender = 'chưa xác định' then
			SET NEW.gender = 'U';
        END IF;
    END $$
DELIMITER ;

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
-- Nghĩa là ngày 1 ngày 2 không xóa được
DROP TRIGGER IF EXISTS trigger_check_delete_exam;
DELIMITER $$
CREATE TRIGGER trigger_check_delete_exam
	BEFORE DELETE ON exam
	FOR EACH ROW
	BEGIN
		DECLARE beforeTwoDay DATE; -- biến chứa 2 ngày trước
        SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) INTO beforeTwoDay;
        IF OLD.create_date > beforeTwoDay THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'không được phép xóa bài thi mới tạo được 2 ngày';
        END IF;        
	END $$
DELIMITER ;

-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time" Duration > 60 thì sẽ đổi thành giá trị "Long time"


    

-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên 
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal 
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
USE testing_system;

SELECT g.group_name, COUNT(ga.account_id),
CASE 
	WHEN COUNT(ga.account_id) <= 5 THEN 'few'
    WHEN COUNT(ga.account_id) > 5 AND COUNT(ga.account_id) <= 20 THEN 'normal'
	WHEN COUNT(ga.account_id) > 20	THEN 'higher'
END
AS the_number_user_amount

FROM `group` g LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id;