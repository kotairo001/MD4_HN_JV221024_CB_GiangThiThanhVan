 -- create database QUANLYDIEMTHI;
use QUANLYDIEMTHI;
-- Bai 1
create table subject (
subjectId varchar(4)			primary key,
subjectName varchar(45)			not null,
priority int(11)				not null
);

create table student(
studentId varchar(4)			primary key,
studentName varchar(100)		not null,
birthday date					not null,
gender bit(1)					not null,
address text					not null,
phoneNumber varchar(45)
);
alter table student add CONSTRAINT unique (phoneNumber);

create table mark (
subjectId varchar(4),
studentId varchar(4),	
point float 					not null,
primary key (subjectId, studentId),
foreign key (subjectId) references subject (subjectId),
foreign key (studentId) references student (studentId)
);
-- drop table mark;

-- Bai 2
-- Bai 2-1
insert into student values 
("S001", "Nguyễn Thế Anh", "1998-01-11",1,"Hà Nội","984678082"),
("S002", "Đặng Bảo Trâm", "1998-12-22",0,"Lào Cai","904982654"),
("S003", "Trần Hà Phương", "2000-05-05",0,"Nghệ An","947645363"),
("S004", "Đỗ Tiến Mạnh", "1999-03-26",1,"Hà Nội","983665353"),
("S005", "Phạm Duy Nhất", "1998-04-10",1,"Tuyên Quang","987242678"),
("S006", "Mai Văn Thái", "2002-06-22",1,"Nam Định","982654268"),
("S007", "Giang Gia Hân", "1996-10-11",0,"Phú Thọ","982364753"),
("S008", "Nguyễn Ngọc Bảo My", "1999-01-22",0,"Hà Nam","927867453"),
("S009", "Nguyễn Thế Đạt", "1998-08-07",1,"Tuyên Quang","989274673"),
("S010", "Nguyễn Thiều Quang", "2000-09-18",1,"Hà Nội","984378291");

insert into subject values 
("MH01","Toán",2),
("MH02","Vật Lý",2),
("MH03","Hóa Học",1),
("MH04","Ngữ Văn",1),
("MH05","Tiếng Anh",2);

insert into mark values 
("MH01", "S001",8.5),
("MH02", "S001",7),
("MH03", "S001",9),
("MH04", "S001",9),
("MH05", "S001",5),
("MH01", "S002",9),
("MH02", "S002",8),
("MH03", "S002",6.5),
("MH04", "S002",8),
("MH05", "S002",6),
("MH01", "S003",7.5),
("MH02", "S003",6.5),
("MH03", "S003",8),
("MH04", "S003",7),
("MH05", "S003",7),
("MH01", "S004",6),
("MH02", "S004",7),
("MH03", "S004",5),
("MH04", "S004",6.5),
("MH05", "S004",8),
("MH01", "S005",5.5),
("MH02", "S005",8),
("MH03", "S005",7.5),
("MH04", "S005",8.5),
("MH05", "S005",9),
("MH01", "S006",8),
("MH02", "S006",10),
("MH03", "S006",9),
("MH04", "S006",7.5),
("MH05", "S006",6.5),
("MH01", "S007",9.5),
("MH02", "S007",9),
("MH03", "S007",6),
("MH04", "S007",9),
("MH05", "S007",4),
("MH01", "S008",10),
("MH02", "S008",8.5),
("MH03", "S008",8.5),
("MH04", "S008",6),
("MH05", "S008",9.5),
("MH01", "S009",7.5),
("MH02", "S009",7),
("MH03", "S009",9),
("MH04", "S009",5),
("MH05", "S009",10),
("MH01", "S010",6.5),
("MH02", "S010",8),
("MH03", "S010",5.5),
("MH04", "S010",4),
("MH05", "S010",7);

-- Bai 2-2
update student set studentName = "Đỗ Đức Mạnh" where studentId = "S004" ;
update subject set subjectName = "Ngoại Ngữ", priority = 1  where subjectId = "MH05";
update mark set point = 8.5 where studentId ="S009" and subjectId = "MH01";
update mark set point = 7 where studentId ="S009" and subjectId = "MH02";
update mark set point = 5.5 where studentId ="S009" and subjectId = "MH03";
update mark set point = 6 where studentId ="S009" and subjectId = "MH04";
update mark set point = 9 where studentId ="S009" and subjectId = "MH05";

-- Bai 2-3
delete from mark where studentId = "S010";
delete from student where studentId = "S010";


-- Bai 3
-- Bai 3-1
select * from student;

-- Bai 3-2
select sub.subjectId, sub.subjectName from subject sub where priority = 1;

-- Bai 3-3
select st.studentId, st.studentName, year(curdate())-year(st.birthday) as age, if(st.gender=1,"Nam","Nữ") as gender, st.address from student st;

-- Bai 3-4
select st.studentName, sub.subjectName, m.point from mark m
join student st on st.studentId = m.studentId 
join subject sub on sub.subjectId = m.subjectId where sub.subjectName = "Toán" order by m.point desc;

-- Bai 3-5
select if(st.gender=1,"Nam","Nữ") as gender, count(st.gender) as number from student st group by st.gender;

-- Bai 3-6
select m.studentid, st.studentName, avg(m.point) as Average, sum(m.point) as Total from mark m
join student st on m.studentid = st.studentid group by st.studentName;

-- Bai 4
-- Bai 4-1
create view STUDENT_VIEW as select st.studentid, st.studentName, st.gender, st.address from student st;

-- Bai 4-2
create view AVERAGE_MARK_VIEW as select m.studentid, st.studentName, avg(m.point) as Average from mark m
join student st on st.studentId = m.studentid group by st.studentName;

-- Bai 4-3
create index PHONE_NUMBER on student(phoneNumber);

-- Bai 4-4
DELIMITER //
create procedure PROC_INSERTSTUDENT 
(in	studentID varchar(4),
	studentName varchar(100),
    birthday date,
	gender bit(1),
	address text,
	phoneNumber varchar(45)
)
begin
	insert into student values (studentID,studentName,birthday,gender,address,phoneNumber);
end //

-- call PROC_INSERTSTUDENT ("S010", "Nguyễn Thiều Quang", "2000-09-18",1,"Hà Nội","984378291");

DELIMITER //
create procedure PROC_UPDATESUBJECT 
(in	subjectId varchar(4),
	updateSubName varchar(45)
)
begin
	update subject set subjectName = updateSubName where subjectId = subjectId;
end //

-- call PROC_UPDATESUBJECT  ("MH05", "Tieng Anh");

create procedure PROC_DELETEMARK
(in	studentID varchar(4)
)
begin
	delete from mark where mark.studentID = studentID;
end //