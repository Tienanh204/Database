--Ho ten: truong Tien Anh
--MSSV: 22120017
--Lop: Chieu T3
--Ca: 2
--Ma may: C201-WS29

create database QuanLyPortal

go 
use QuanLyPortal
go

create table Conferences
(
IDCore char(8),
IDConference char(8),
ConferenceName nvarchar(100),
Place nvarchar(100),
AcceptedDate datetime,
Rank char(8) check( Rank in('A','A*','B','C')),
PrimaryField int,
BestPaper char(10),
primary key(IDCore, IDConference)
)

create table Papers
(
IDCore char(8),
IDConference char(8),
IDPaper char(10),
PaperTitle nvarchar(100) NOT NULL,
Authors  char(100),
Status  char(100),
primary key(IDCore, IDConference, IDPaper)
)

create table ResearchField
(
FieldID int primary key,
FieldName char(100),
NumOfConf int
)
create table ConferenceDetails
(
IDCore char(8),
IDConference char(8),
FieldID int,
primary key(IDCore,IDConference,FieldID)
)


--rANG BUOC KHOA NGOAI
--FK Papers(IDCore,IDConference)->Conferences(IDCore,IDConference)
alter table Papers
ADD constraint FK_PP_CF
foreign key(IDCore,IDConference)
references Conferences(IDCore,IDConference)

--FK Conferences(IDCore,IDConference,BestPaper)->Papers(IDCore,IDConference,IDPaper)
alter table Conferences
ADD constraint FK_CF_PP
foreign key(IDCore,IDConference,BestPaper)
references Papers(IDCore,IDConference,IDPaper)

--FK ConferenceDetails(FieldID)->ResearchField(FieldID)
alter table ConferenceDetails
ADD constraint FK_CF_PP1
foreign key(FieldID)
references ResearchField(FieldID)


--FK Conferences(IDCore,IDConference,PrimaryField)->ConferenceDetails(IDCore,IDConference,FieldID)
alter table Conferences
ADD constraint FK_CF_CF1
foreign key(IDCore,IDConference,PrimaryField)
references ConferenceDetails(IDCore,IDConference,FieldID)


--Nhap lieu
insert into Conferences values
('CORE2023','KDD',N'29th ACM International Conference on Knowledge Discovery and Data Mining',N'Barcelona,Spain',10/8/2023,'A*',null,null),
('CORE2024','KDD',N'30th ACM International Conference on Knowledge Discovery and Data Mining',N'Long Beach CA USA',10/8/2024,'A*',null,null),
('CORE2021','DSAA',N'IEEE International Conference on Data Science and Advanced Analytics',N'Porto, Portugal',6/4/2021,'A',null,null),
('CORE2023','DSAA',N'IEEE International Conference on Data Science and Advanced Analytics',N'Thessaloniki, Greece',9/10/2023,'B',null,null)


insert into Papers values
('CORE2021','DSAA','PP01',N'A Framework for Effective Hierarchical Multiclass Classification of Software Vulnerabilities','SS Das; E Serra; M Halappanavar; A Pothen; E Al-Shaer','Accepted'),
('CORE2021','DSAA','PP02',N'A Personalized Overdraft Protection Framework','Karesia Ramlal; Patrick Hosein','Accepted'),
('CORE2023','KDD','PP01',N'Maximizing Neutrality in News Ordering','Rishi Advani; Paolo Papotti; Abolfazl Asudeh','Accepted'),
('CORE2023','KDD','PP02',N'Sketch-Based Anomaly Detection in Streaming Graphs','Siddharth Bhatia; Mohit Wadhwa','Accepted'),
('CORE2023','KDD','PP03',N'Exploring Challenges in Graph-Based Data Mining Manuscripts','Alice','Rejected')

insert into ResearchField values
(4605,'Data management and data science',3),
(4611,'Machine learning',2),
(0804,'Data format',1),
(4607,'Graphics, augument reality and games',1)


insert into ConferenceDetails values
('CORE2023','KDD',4605),
('CORE2023','KDD',4611),
('CORE2023','KDD',0804),
('CORE2021','DSAA',4605),
('CORE2023','DSAA',4605),
('CORE2024','KDD',4605)

update  Conferences
set PrimaryField = 4605, BestPaper = 'PP02'
where IDCore = 'CORE2023' and IDConference = 'KDD'

update  Conferences
set PrimaryField = 4605
where IDCore = 'CORE2024'  and IDConference = 'KDD'

update  Conferences
set PrimaryField = 4605, BestPaper = 'PP01'
where IDCore = 'CORE2021'  and IDConference = 'DSAA'

update  Conferences
set PrimaryField = 4605
where IDCore = 'CORE2023'  and IDConference = 'DSAA'


--Truy van
--1. Cho danh sách đầy đủ thông tin của các hội nghị Rank A,B sắp diễn ra trong năm 2024.
select *
from Conferences
where YEAR(AcceptedDate) = 2024 and (Rank like 'A' or Rank like 'B')

--2. Với mỗi hội nghị, cho biết số lượng bài bị từ chối của từng hội nghị trong năm 2023.
select cf.ConferenceName as N'Hoi Nghi', count(pp.IDPaper) as N'So bai bi tu choi'
from Conferences cf
join Papers pp on cf.IDCore = pp.IDCore
where YEAR(cf.AcceptedDate) = 2023 and pp.Status like 'Rejected'
group by cf.ConferenceName

--3. Cho danh sách các hội nghị chưa có công trình nào gởi đăng
select IDConference as 'Ma hoi nghi', ConferenceName as N'Ten hoi nghi'
from Conferences 
where IDConference not in (
select cf.IDConference
from Conferences cf
join ConferenceDetails cfd on cf.IDConference = cfd.IDConference
join ResearchField rs on cFD.FieldID = rs.FieldID 
)
group by IDConference, ConferenceName