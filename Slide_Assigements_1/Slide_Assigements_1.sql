DROP DATABASE IF EXISTS fresher_training_management;
CREATE DATABASE fresher_training_management;
USE fresher_training_management;

-- tạo khoảng cách giữa đầu dòng và tên trường (TAB)
-- Tên cột và bảng sai
-- Kiểu training_class là Char
CREATE TABLE trainee(
	trainee_id			INT,
    full_name			VARCHAR(30),
    birth_date			DATE,
    gender				ENUM ('male', 'female', 'unknown'),
    et_iq				INT CHECK (et_iq>=0 AND et_iq<=20),
    et_gmath			INT CHECK (et_gmath>=0 AND et_gmath<=20),
    et_english			INT CHECK (et_english>=0 AND et_english<=50),
    training_class		VARCHAR(50),
    evauation_note		VARCHAR(255)
);