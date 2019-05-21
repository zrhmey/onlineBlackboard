create database onlineclassroom;
	use onlineclassroom;

create table teacher(
	teacher_id int(100) not null auto_increment,
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	username varchar(100) not null,
	email_address varchar(100) not null,
	password varchar(100) not null,
	image varchar(100) null,
	primary key(teacher_id)
);

create table student(
	student_id int(100) not null auto_increment,
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	username varchar(100) not null,
	email_address varchar(100) not null,
	password varchar(100) not null,
	image varchar(100) null,
	primary key(student_id)
);

create table enrolls (
	student_id int(100) not null,
	subject_id int(100) not null,
	status varchar(1000) not null
);

create table subject(
	subject_id int(100) not null auto_increment,
	subject_code varchar(100) not null,
	course_title varchar(100) not null,
	course_description varchar(100) not null,
	course_about varchar(100) not null,
	teacher_id int(100) not null,
	primary key(subject_id),
	foreign key(teacher_id) references teacher(teacher_id)
);

create table chat(
	sender varchar(100) not null,
	receiver varchar(100) not null,
	message varchar(1000) not null,
	date_posted timestamp not null,
	subject_id int(100) not null,
	opened varchar(100) not null,
	foreign key(subject_id) references subject(subject_id)
);

create table uploaded_files(
	file_id int(100) not null auto_increment,
	filename varchar(255) not null,
	date_posted timestamp not null,
	primary key(file_id)
);

create table learning_materials(
	id int(100) not null auto_increment,
	title varchar(100) not null,
	date_posted timestamp not null,
	subject_id int(100) not null,
	file_id int(100) not null,
	primary key(id),
	foreign key(file_id) references uploaded_files(file_id),
	foreign key(subject_id) references subject(subject_id)
);

create table announcement(
	announcement_id int(100) not null auto_increment,
	subject_id int(100) not null,
	date_posted timestamp not null,
	title varchar(100) not null,
	content varchar(1000) not null,
	primary key(announcement_id),
	foreign key(subject_id) references subject(subject_id)
);

create table announcement_comment(
	id int(100) not null auto_increment,
	announcement_id int(100) not null,
	username varchar(100) not null,
	content varchar(1000) not null,
	date_posted timestamp not null,
	primary key(id),
	foreign key(announcement_id) references announcement(announcement_id)
);

create table see_announcement(
	announcement_id int(100) not null,
	subject_id int(100) not null,
	student_id int(100) not null,
	opened varchar(1000) not null default 'false'
);

create table assignment(
	assignment_id int(100) not null auto_increment,
	subject_id int(100) not null,
	date_posted timestamp not null,
	deadline_date date not null,
	deadline_time time not null,
	title varchar(100) not null,
	instruction varchar(1000) not null,
	score int(100) not null,
	file_id int(100) null,
	assignment_type varchar(100) NOT NULL DEFAULT 'individual',
	primary key(assignment_id),
	foreign key(file_id) references uploaded_files(file_id),
	foreign key(subject_id) references subject(subject_id)
);

create table answer_assignment(
	id int(100) not null auto_increment,
	content varchar(1000) not null,
	date_posted timestamp not null,
	grade int(100) not null,
	student_id int(100) not null,
	file_id int(100) null,
	assignment_id int(100) not null,
	primary key(id),
	foreign key(student_id) references student(student_id),
	foreign key(file_id) references uploaded_files(file_id),
	foreign key(assignment_id) references assignment(assignment_id)
);

create table individual_assignment(
	assignment_id int(100) not null,
	subject_id int(100) not null,
	student_id int(100) not null,
	opened varchar(1000) not null default 'false'
);

create table group_assignment(
	assignment_id int(100) not null,
	subject_id int(100) not null,
	group_number int(100) not null,
	student_id int(100) not null,
	indicator int(100) not null,
	opened varchar(1000) not null default 'false'
);

create table answer_group_assignment(
	id int(100) not null auto_increment,
	content varchar(1000) not null default 0,
	date_posted timestamp not null,
	grade int(100) null,
	student_id int(100) not null,
	file_id int(100) null,
	assignment_id int(100) not null,
	group_number int(100) not null,
	primary key(id)
);

create table graded_assignment(
	assignment_id int(100) not null,
	subject_id int(100) not null,
	group_number int(100) not null,
	student_id int(100) not null,
	graded varchar(1000) not null default 'false',
	opened varchar(1000) not null default 'false'
);

create table quiz(
	quiz_id int(100) not null auto_increment,
	subject_id int(100) not null,
	quiz_title varchar(1000) not null,
	date_posted timestamp not null,
	deadline_date date not null,
	deadline_time time not null,
	total_grade int(100) not null,
	time_limit int(100) not null,
	primary key(quiz_id),
	foreign key(subject_id) references subject(subject_id)
);

create table see_quiz(
	quiz_id int(100) not null,
	subject_id int(100) not null,
	student_id int(100) not null,
	opened varchar(1000) not null default 'false'
);

create table identification_quiz(
	quiz_id int(100) not null,
	question_number int(100) not null,
	question varchar(100) not null,
	answer varchar(100) not null,
	grade int(100) not null,
	foreign key(quiz_id) references quiz(quiz_id)
);

create table multiplechoice_quiz(
	quiz_id int(100) not null,
	question_number int(100) not null,
	question varchar(100) not null,
	answer varchar(100) not null,
	grade int(100) not null,
	foreign key(quiz_id) references quiz(quiz_id)
);

create table multiplechoice_choices(
	quiz_id int(100) not null,
	question_number int(100) not null,
	option varchar(1000) not null,
	foreign key(quiz_id) references quiz(quiz_id)
);

create table multipleanswer_quiz(
	quiz_id int(100) not null,
	question_number int(100) not null,
	question varchar(1000) not null,
	grade int(100) not null,
	foreign key(quiz_id) references quiz(quiz_id)
);

create table multipleanswer_choices(
	quiz_id int(100) not null,
	question_number int(100) not null,
	option varchar(1000) not null,
	foreign key(quiz_id) references quiz(quiz_id)
);

create table multipleanswer_answers(
	quiz_id int(100) not null,
	question_number int(100) not null,
	answer varchar(1000) not null,
	foreign key(quiz_id) references quiz(quiz_id)
);

create table essay_quiz(
	quiz_id int(100) not null,
	question_number int(100) not null,
	question varchar(100) not null,
	grade int(100) not null,
	foreign key(quiz_id) references quiz(quiz_id)
);

create table answer_quiz(
	answer_id int(100) not null auto_increment,
	date_posted timestamp not null,
	total_grade int(100) not null,
	student_id int(100) not null,
	quiz_id int(100) not null,
	primary key(answer_id),
	foreign key(student_id) references student(student_id),
	foreign key(quiz_id) references quiz(quiz_id)
);

create table answer_iden_quiz(
	answer_id int(100) not null,
	question_number int(100) not null,
	answer varchar(100) not null,
	grade int(100) not null
);

create table answer_mc_quiz(
	answer_id int(100) not null,
	question_number int(100) not null,
	answer varchar(100) not null,
	grade int(100) not null
);

create table answer_ma_quiz(
	answer_id int(100) not null,
	question_number int(100) not null,
	answer varchar(100) not null,
	grade int(100) not null
);

create table answer_essay_quiz(
	answer_id int(100) not null,
	question_number int(100) not null,
	answer varchar(100) not null,
	grade int(100) not null
);

INSERT INTO `student` (`first_name`, `last_name`, `username`, `email_address`, `password`, `image`) VALUES
('Student', 'One', 'student1', 'student1@gmail.com', 'student1', 'def.png'),
('Student', 'Two', 'student2', 'student2@gmail.com', 'student2', 'def.png'),
('Student', 'Three', 'student3', 'student3@gmail.com', 'student3', 'def.png'),
('Student', 'Four', 'student4', 'student4@gmail.com', 'student4', 'def.png'),
('Student', 'Five', 'student5', 'student5@gmail.com', 'student5', 'def.png'),
('Student', 'Six', 'student6', 'student6@gmail.com', 'student6', 'def.png'),
('Student', 'Seven', 'student7', 'student7@gmail.com', 'student7', 'def.png'),
('Student', 'Eight', 'student8', 'student8@gmail.com', 'student8', 'def.png'),
('Student', 'Nine', 'student9', 'student9@gmail.com', 'student9', 'def.png'),
('Student', 'Ten', 'student10', 'student10@gmail.com', 'student10', 'def.png'),
('Student', 'Eleven', 'student11', 'student11@gmail.com', 'student11', 'def.png'),
('Student', 'Twelve', 'student12', 'student12@gmail.com', 'student12', 'def.png'),
('Student', 'Thirteen', 'student13', 'student13@gmail.com', 'student13', 'def.png'),
('Student', 'Fourteen', 'student14', 'student14@gmail.com', 'student14', 'def.png'),
('Student', 'Fifteen', 'student15', 'student15@gmail.com', 'student15', 'def.png'),
('Student', 'Sixteen', 'student16', 'student16@gmail.com', 'student16', 'def.png'),
('Student', 'Seventeen', 'student17', 'student17@gmail.com', 'student17', 'def.png'),
('Student', 'Eighteen', 'student18', 'student18@gmail.com', 'student18', 'def.png'),
('Student', 'Nineteen', 'student19', 'student19@gmail.com', 'student19', 'def.png'),
('Student', 'Twenty', 'student20', 'student20@gmail.com', 'student20', 'def.png'),
('Student', 'TwentyOne', 'student21', 'student21@gmail.com', 'student21', 'def.png'),
('Student', 'TwentyTwo', 'student22', 'student22@gmail.com', 'student22', 'def.png'),
('Student', 'TwentyThree', 'student23', 'student23@gmail.com', 'student23', 'def.png'),
('Student', 'TwentyFour', 'student24', 'student24@gmail.com', 'student24', 'def.png'),
('Student', 'TwentyFive', 'student25', 'student25@gmail.com', 'student25', 'def.png'),
('Student', 'TwentySix', 'student26', 'student26@gmail.com', 'student26', 'def.png'),
('Student', 'TwentySeven', 'student27', 'student27@gmail.com', 'student27', 'def.png'),
('Student', 'TwentyEight', 'student28', 'student28@gmail.com', 'student28', 'def.png'),
('Student', 'TwentyNine', 'student29', 'student29@gmail.com', 'student29', 'def.png'),
('Student', 'Thirty', 'student30', 'student30@gmail.com', 'student30', 'def.png');

INSERT INTO `teacher` (`first_name`, `last_name`, `username`, `email_address`, `password`, `image`) VALUES
('teacher', 'one', 'teacher1', 'teacher1@gmail.com', 'teacher1', 'def.png'),
('teacher', 'two', 'teacher2', 'teacher2@gmail.com', 'teacher2', 'def.png');

INSERT INTO `subject` (`subject_code`, `course_title`, `course_description`, `course_about`, `teacher_id`) VALUES
('MXBsYzRv', 'CMSC 56', 'Discrete Mathematics 1', 'Discrete Mathematics 1 About', 1),
('MXBsYzRz', 'CMSC 198.1', 'Special Problem', 'Special Problem About', 2);

INSERT INTO `enrolls` (`student_id`, `subject_id`, `status`) VALUES
(1, 1, 'enrolled'), (1, 2, 'enrolled'),
(2, 1, 'enrolled'), (2, 2, 'enrolled'),
(3, 1, 'enrolled'), (3, 2, 'enrolled'),
(4, 1, 'enrolled'), (4, 2, 'enrolled'),
(5, 1, 'enrolled'), (5, 2, 'enrolled'),
(6, 1, 'enrolled'), (6, 2, 'enrolled'),
(7, 1, 'enrolled'), (7, 2, 'enrolled'),
(8, 1, 'enrolled'), (8, 2, 'enrolled'),
(9, 1, 'enrolled'), (9, 2, 'enrolled'),
(10, 1, 'enrolled'), (10, 2, 'enrolled'),
(11, 1, 'enrolled'), (11, 2, 'enrolled'),
(12, 1, 'enrolled'), (12, 2, 'enrolled'),
(13, 1, 'enrolled'), (13, 2, 'enrolled'),
(14, 1, 'enrolled'), (14, 2, 'enrolled'),
(15, 1, 'enrolled'), (15, 2, 'enrolled'),
(16, 1, 'enrolled'), (16, 2, 'enrolled'),
(17, 1, 'enrolled'), (17, 2, 'enrolled'),
(18, 1, 'enrolled'), (18, 2, 'enrolled'),
(19, 1, 'enrolled'), (19, 2, 'enrolled'),
(20, 1, 'enrolled'), (20, 2, 'enrolled'),
(21, 1, 'enrolled'), (21, 2, 'enrolled'),
(22, 1, 'enrolled'), (22, 2, 'enrolled'),
(23, 1, 'enrolled'), (23, 2, 'enrolled'),
(24, 1, 'enrolled'), (24, 2, 'enrolled'),
(25, 1, 'enrolled'), (25, 2, 'enrolled'),
(26, 1, 'enrolled'), (26, 2, 'enrolled'),
(27, 1, 'enrolled'), (27, 2, 'enrolled'),
(28, 1, 'enrolled'), (28, 2, 'enrolled'),
(29, 1, 'enrolled'), (29, 2, 'enrolled'),
(30, 1, 'enrolled'), (30, 2, 'enrolled');