/*
Made Grade Details, OtherAv, JobRequirements fields Optional
Added field Major/Minor Name(Study Title) 
Added Teaching Assignment Table to include many to many relationships between faculty and courses
Corrected CourseInfo and Enrollment Details Relationship  
Corrected my mistake of using the separate table for EnrollmentStatus and included EnrollmentStatus in Enrollment Table  
*/


CREATE TABLE dbo.Address(
       AddressId    INT            PRIMARY KEY   IDENTITY(1,1),
	   Street1      VARCHAR(50)    NOT NULL,
	   Street2      VARCHAR(50)            ,
	   City         VARCHAR(30)    NOT NULL,
	   State        VARCHAR(30)    NOT NULL,
	   ZipCode      VARCHAR(10)    NOT NULL
	   );
DROP TABLE dbo.Address
	  

CREATE TABLE dbo.PersonDetails(
       PersonId         INT                PRIMARY KEY   IDENTITY(1,1),
	   FirstName        VARCHAR(50)        NOT NULL,
	   MiddleName       VARCHAR(50)                ,
	   LastName         VARCHAR(50)        NOT NULL,
	   NetId            VARCHAR(20)        NOT NULL      UNIQUE,
	   DateOfBirth      DATE               NOT NULL,
	   SSN              VARCHAR(10)                      UNIQUE,
	   EmailAddress     VARCHAR(50)        NOT NULL                           CHECK(EmailAddress LIKE '%_@_%_._%'),
	   AddressId        INT                NOT NULL      UNIQUE               REFERENCES Address(AddressId)
	   );
DROP TABLE dbo.PersonDetails

CREATE TABLE dbo.StatusType(
       StatusTypeId             INT                PRIMARY KEY    IDENTITY(1,1),
	   StatusTypeName           VARCHAR(50)        NOT NULL       UNIQUE
	   );
DROP TABLE dbo.StatusType

CREATE TABLE dbo.StudentInstance(
       StudentInstanceId      INT               PRIMARY KEY     IDENTITY(1,1),
	   Password               VARCHAR(50)       NOT NULL        CHECK(LEN(Password)>4),
	   PersonId               INT               NOT NULL        REFERENCES PersonDetails(PersonId),
	   AddressId              INT               NOT NULL        REFERENCES Address(AddressId)             UNIQUE,
	   StatusTypeId           INT               NOT NULL        REFERENCES StatusType(StatusTypeId)
	   );
DROP TABLE dbo.StudentInstance

CREATE TABLE dbo.College(
       CollegeId             INT                PRIMARY KEY     IDENTITY(1,1),
       CollegeName           VARCHAR(50)        NOT NULL        UNIQUE
	   );
DROP TABLE dbo.College


CREATE TABLE dbo.Streams(
       StreamId            INT                  PRIMARY KEY    IDENTITY(1,1),
	   IsMajor             BIT                  NOT NULL,
	   CollegeId           INT                  NOT NULL       REFERENCES College(CollegeId),
	   StudyTitle          VARCHAR(50)          NOT NULL
	   );


DROP TABLE dbo.Streams


CREATE TABLE dbo.MajorMinorDetails(
       MajorMinorDetailsId          INT         PRIMARY KEY   IDENTITY(1,1),
	   StudentInstanceId            INT         NOT NULL      REFERENCES StudentInstance(StudentInstanceId),
	   StreamId                     INT         NOT NULL      REFERENCES Streams(StreamId)
	   );
DROP TABLE MajorMinorDetails

CREATE TABLE dbo.JobDetails(
       JobDetailsId          INT              PRIMARY KEY    IDENTITY(1,1),
	   Title                 VARCHAR(50)      NOT NULL,
	   MaximumPay            DECIMAL(8,2)     NOT NULL       CHECK(MaximumPay>=0.00),
	   MinimumPay            DECIMAL(8,2)     NOT NULL       CHECK(MinimumPay>=0.00),
	   JobDescription        VARCHAR(5000)    NOT NULL,
       IsUnionJob            BIT              NOT NULL,
	   JobRequirements       VARCHAR(5000)             
	   );

DROP TABLE JobDetails

CREATE TABLE dbo.EmployeeStatus(
       EmployeeStatusId          INT            PRIMARY KEY    IDENTITY(1,1),
	   EmployeeStatusType        VARCHAR(50)    NOT NULL       UNIQUE
	   );
DROP TABLE EmployeeStatus

CREATE TABLE dbo.SelectionType(
       SelectionTypeId        INT              PRIMARY KEY     IDENTITY(1,1),
	   SelectionTypeName      VARCHAR(50)	   NOT NULL        UNIQUE,
	   );
DROP TABLE SelectionType

CREATE TABLE dbo.BenefitType(
       BenefitTypeId             INT              PRIMARY KEY    IDENTITY(1,1),
	   BenefitTypeName           VARCHAR(50)	  NOT NULL       UNIQUE,
	   );	
DROP TABLE BenefitType

CREATE TABLE dbo.EmployeeBenefitDetails(
       BenefitDetailsId          INT       PRIMARY KEY    IDENTITY(1,1),
	   Cost                      INT       NOT NULL       CHECK(Cost>=0),
	   BenefitTypeId             INT       NOT NULL       REFERENCES BenefitType(BenefitTypeId),
	   SelectionTypeId           INT       NOT NULL       REFERENCES SelectionType(SelectionTypeId),
	   );				
DROP TABLE EmployeeBenefitDetails	   
		
CREATE TABLE dbo.EmployeeInstance(
       EmployeeInstanceId       INT            PRIMARY KEY     IDENTITY(1,1),
	   YearlyPay                DECIMAL(8,2)   NOT NULL        CHECK(YearlyPay>=0.00),
	   EmployeeStatusId         INT            NOT NULL        REFERENCES EmployeeStatus(EmployeeStatusId),
	   JobDetailsId             INT            NOT NULL        REFERENCES JobDetails(JobDetailsId),
	   PersonDetaildId          INT            NOT NULL        REFERENCES PersonDetails(PersonId), 
	   ); 
DROP TABLE EmployeeInstance

CREATE TABLE dbo.BenefitDetails(
        BenefitDetailsTypeId      INT      PRIMARY KEY        IDENTITY(1,1),
		BenefitDetailsId          INT      NOT NULL           REFERENCES EmployeeBenefitDetails(BenefitDetailsId),
		EmployeeInstanceId        INT      NOT NULL           REFERENCES EmployeeInstance(EmployeeInstanceId),
		);
DROP TABLE BenefitDetails

CREATE TABLE dbo.GradeDetails(
       GradeDetailsId           INT                 PRIMARY KEY   IDENTITY(1,1),
	   GradeDetailsType         VARCHAR(50)         NOT NULL      UNIQUE,
	   );
DROP TABLE GradeDetails

CREATE TABLE dbo.EnrollmentStatus(
       EnrollmentStatusId           INT              PRIMARY KEY    IDENTITY(1,1),
	   EnrollmentStatusType         VARCHAR(15)      NOT NULL       UNIQUE,
	   );

DROP TABLE EnrollmentStatus

CREATE TABLE dbo.CourseInfo(
       CourseInfoId           INT               PRIMARY KEY   IDENTITY(1,1),
	   CourseCode             VARCHAR(10)       NOT NULL,
	   CourseNumber           INT               NOT NULL      CHECK(CourseNumber>0),
	   CourseDescription      VARCHAR(5000)     NOT NULL,
	   CourseTitle            VARCHAR(50)       NOT NULL,
	   );

DROP TABLE CourseInfo

CREATE TABLE dbo.EnrollmentDetails(
       EnrollmentId            INT              PRIMARY KEY   IDENTITY(1,1),
	   StudentInstanceId       INT              NOT NULL      REFERENCES StudentInstance(StudentInstanceId),
	   CourseInfoId            INT              NOT NULL      REFERENCES CourseInfo(CourseInfoId),
	   EnrollmentStatusId      INT              NOT NULL      REFERENCES EnrollmentStatus(EnrollmentStatusId),
	   GradeDetailsId          INT                            REFERENCES GradeDetails(GradeDetailsId)
	   );

DROP TABLE EnrollmentDetails

CREATE TABLE dbo.TeachingAssignment(
       CourseInfoId            INT              NOT NULL        REFERENCES CourseInfo(CourseInfoId),
	   EmployeeInstanceId      INT              NOT NULL        REFERENCES EmployeeInstance(EmployeeInstanceId),
	   PRIMARY KEY(CourseInfoId,EmployeeInstanceId),
	   );
DROP TABLE TeachingAssignment

CREATE TABLE dbo.DayOfWeekDetails(
       DayDetailsId            INT             PRIMARY KEY   IDENTITY(1,1),
	   DayType                 VARCHAR(50)     NOT NULL      UNIQUE,
	   );
DROP TABLE DayOfWeekDetails

CREATE TABLE dbo.CourseTimingDetails(
       CourseTimingId          INT            PRIMARY KEY    IDENTITY(1,1),
	   StartTime               TIME           NOT NULL,
	   EndTime                 TIME           NOT NULL,
	   DayDetailsId            INT            NOT NULL       REFERENCES DayOfWeekDetails(DayDetailsId),
	   CONSTRAINT              TimeCheck      CHECK(StartTime<EndTime)
	   );
DROP TABLE CourseTimingDetails
SELECT * FROM CourseTimingDetails


CREATE TABLE dbo.ProjectorOptions(
       ProjectorOptionsId               INT               PRIMARY KEY    IDENTITY(1,1),
	   ProjectorOptionsType             VARCHAR(50)       NOT NULL       UNIQUE,
	   );
DROP TABLE ProjectorOptions

CREATE TABLE dbo.SemesterType(
       SemesterTypeId                  INT               PRIMARY KEY     IDENTITY(1,1),
	   SemesterTypeName                VARCHAR(50)       NOT NULL        UNIQUE,
	   );
DROP TABLE SemesterType

CREATE TABLE dbo.SemesterDetails(
       SemesterDetailsId             INT                PRIMARY KEY         IDENTITY(1,1),
	   SemesterTypeId                INT                                    REFERENCES SemesterType(SemesterTypeId),
	   PresentYear                   INT                NOT NULL            CHECK(PresentYear>1000),
	   StartDateOfClass              DATE               NOT NULL,
	   EndDateOfClass                DATE               NOT NULL,
	   CONSTRAINT                    CheckTime          CHECK(StartDateOfClass<=EndDateOfClass),
 	   );
DROP TABLE SemesterDetails


CREATE TABLE dbo.ClassRoom(
       ClassRoomId                INT                  PRIMARY KEY    IDENTITY(1,1),
	   BuildingName               VARCHAR(50)          NOT NULL,
	   RoomNumber                 INT                  NOT NULL,
	   MaximumSeating             INT                  NOT NULL       CHECK(MaximumSeating>0),
	   ProjectorOptionsId         INT                  NOT NULL       REFERENCES dbo.ProjectorOptions(ProjectorOptionsId),
	   WhiteBoardCount            INT                  NOT NULL       CHECK(WhiteBoardCount>=0),
	   OtherAV                    VARCHAR(50)
	   );
DROP TABLE ClassRoom

CREATE TABLE dbo.CourseSchedule(
       CourseScheduleId          INT          PRIMARY KEY     IDENTITY(1,1),
	   NoOfSeats                 INT          NOT NULL        CHECK(NoOfSeats>=0),
	   ClassRoomId               INT          NOT NULL        REFERENCES ClassRoom(ClassRoomId),
	   SemesterDetailsId         INT          NOT NULL        REFERENCES SemesterDetails(SemesterDetailsId),
	   EmployeeInstanceId        INT          NOT NULL        REFERENCES EmployeeInstance(EmployeeInstanceId),
	   CourseInfoId              INT          NOT NULL        REFERENCES CourseInfo(CourseInfoId),
	   );
DROP TABLE dbo.CourseSchedule

CREATE TABLE dbo.TimingSchedule(
       TimingScheduleId          INT           PRIMARY KEY    IDENTITY(1,1),
	   CourseTimingId            INT           NOT NULL       REFERENCES CourseTimingDetails(CourseTimingId),
	   CourseScheduleId          INT           NOT NULL       REFERENCES CourseSchedule(CourseScheduleId),
	   );
DROP TABLE dbo.TimingSchedule	   

CREATE TABLE dbo.CoursePrerequisites(
       CourseInfoId              INT          NOT NULL        REFERENCES CourseInfo(CourseInfoId),
	   CoursePrerequisitesId     INT          NOT NULL        REFERENCES CourseInfo(CourseInfoId),
	   PRIMARY KEY(CourseInfoId,CoursePrerequisitesId)
	   );

DROP TABLE dbo.CoursePrerequisites

INSERT INTO ADDRESS (Street1,Street2,City,State,ZipCode)
       VALUES ('111WestCott',NULL,'Syracuse','NewYork',13210),
			  ('222WestCott',NULL,'Syracuse','NewYork',13210),
			  ('333FellowsAve','NULL','Syracuse','NewYork',13210),
			  ('444MainStreet',NULL,'Syracuse','NewYork',13209),
			  ('555BurnetAve',NULL,'Syracuse','NewYork',13211),
			  ('666DellStreet',NULL,'Syracuse','NewYork',13212),
			  ('777LancasterAve',NULL,'Syracuse','NewYork',13210),
			  ('888KensingtonRoad',NULL,'Syracuse','NewYork',13210),
			  ('999WaltonStreet','DownTown','Syracuse','NewYork',13212),
			  ('1050FayetteStreet',NULL,'Syracuse','NewYork',13202),
			  ('1108ErnieDavis','SyracuseResidenceHall','Syracuse','NewYork',13210),
			  ('1212Waltonstreet','DownTown','Syracuse','NewYork',13212);

INSERT INTO PersonDetails(FirstName,MiddleName,LastName,NetId,DateOfBirth,SSN,EmailAddress,AddressId)
       VALUES ('Chandra','Harsha','Jupalli','cjupalli','1993-11-25','094045047','cjupalli@syr.edu',1),
	          ('Rishith',NULL,'Reddy','rreddy','1994-02-12','087865432','rreddy@syr.edu',2),
			  ('Sravanth',NULL,'Lakshmi','Slakshmi','1992-10-11','085473452','slakshmi@syr.edu',3),
			  ('Alison',NULL,'Williams','awilliams','1990-02-09',NULL,'awilliams@syr.edu',4),
			  ('Jose','De','Cruz','jCruz','1991-09-07','073453987','jcruz@syr.edu',5),
			  ('Jim',NULL,'Fawcett','jfawcett','1941-07-07','034035032','jfawcett@syr.edu',6),
			  ('Andrew',NULL,'Lee','alee108','1961-09-11','078125457','alee108@syr.edu',7),
			  ('Dusan',NULL,'Palider','dpalider','1982-05-03','063456781','dpalider@syr.edu',8),
			  ('Joyce',NULL,'Kathy','jkathy','1962-06-04','076546543','jkathy@syr.edu',9),
			  ('Kevin',NULL,'DU','kdu','1965-07-03','067895432','kdu@syr.edu',10),
			  ('Prakhar',NULL,'Agarwal','pagarwal','1993-08-01','754354965','pararwal@syr.edu',11),
			  ('John',NULL,'Walter','jwalter','1975-09-02','654567698','jwaiter@syr.edu',12);

INSERT INTO StatusType(StatusTypeName)
       VALUES  ('undergraduate'),
	           ('graduate'),
			   ('matriculated'),
			   ('graduated');

INSERT INTO StudentInstance(StatusTypeId,Password,PersonId,AddressId)
       VALUES (2,'cjupalli',1,1),
	          (2,'rreddy',2,2),
			  (2,'slakshmi',3,3),
			  (1,'awilliams',4,4),
			  (1,'JCruz',5,5),
			  (1,'pagarwal',11,11);

INSERT INTO College(CollegeName)
       VALUES('LCSMITH College of Engineering'),
	         ('ISchool'),
			 ('SU College of Arts and Science'),
			 ('SU College of Law'),
			 ('SU College of PublicRelations'),
			 ('School of Business');

INSERT INTO Streams(IsMajor,CollegeId,StudyTitle)
       VALUES (1,1,'Computer Engineering'),
	          (1,1,'Computer Science'),
			  (0,5,'International Relations'),
			  (0,3,'Forensics'),
	          (0,1,'Computer Science'),
			  (0,1,'Electrical Engineering'),
			  (1,6,'MBA');

INSERT INTO MajorMinorDetails(StudentInstanceId,StreamId)
            VALUES(1,1),
			      (2,2),
				  (3,1),
				  (4,5),
				  (5,3),
				  (6,6);

INSERT INTO JobDetails(Title,MaximumPay,MinimumPay,JobDescription,IsUnionJob,JobRequirements)
       VALUES ('Professor',150000.00,100000.00,'Work on Research Projects and Teaches Courses',1,'Should finish PHD and have teaching experience of 4 years'),
	          ('Assistant Professor',120000.00,80000.00,'Teaches courses primarily',0,'Should Finish Masters degree'),
			  ('Research Assistant',100000.00,70000.00,'Work under a professor',1,'Interest to work in that field and supporting academicbackround'),
			  ('Teaching Assistant',60000.00,40000.00,'Help clarify doubts of students enrolled in that course',0,'Have sufficient knowledge and is selected by professor teaching the course'),
			  ('Admission Officer',120000.00,150000.00,'Check if admission criteria is met',0,NULL),
			  ('Dean',200000.00,150000.00,'Manages school of Business',0,'Experience in adminstration and teaching');

INSERT INTO EmployeeStatus(EmployeeStatusType)
       VALUES ('Active'),
	          ('Inactive');

INSERT INTO SelectionType(SelectionTypeName)
       VALUES('Single'),
	         ('Family'),
			 ('Opt-out');

INSERT INTO BenefitType(BenefitTypeName)
       VALUES('Health'),
	         ('Vision'),
			 ('Dental');

INSERT INTO EmployeeBenefitDetails(Cost,SelectionTypeId,BenefitTypeId)
       VALUES (30000,1,1),
	           (30000,2,3),
			   (1000,1,2),
			   (3000,2,1),
			   (2000,2,2),
			   (3000,1,3);

INSERT INTO EmployeeInstance(YearlyPay,EmployeeStatusId,JobDetailsId,PersonDetaildId)
            VALUES(145000.00,1,1,6),
			      (115000.00,1,2,8),
				  (55000.00,1,4,7),
				  (95000.00,1,3,10),
				  (135000.00,1,5,9),
				  (180000.00,1,6,12);

INSERT INTO BenefitDetails(BenefitDetailsid,EmployeeInstanceId)
       VALUES (1,1),
	          (2,2),
			  (3,3),
			  (4,4),
			  (5,5),
			  (6,6);

INSERT INTO GradeDetails(GradeDetailsType)
       VALUES('A'),
	         ('A-'),
			 ('B+'),
			 ('B'),
			 ('B-'),
			 ('C'),
			 ('F');

INSERT INTO EnrollmentStatus(EnrollmentStatusType)
       VALUES('Regular'),
	         ('Audit'),
			 ('Pass'),
			 ('Fail');

INSERT INTO CourseInfo(CourseCode,CourseNumber,CourseDescription,CourseTitle)
       VALUES ('CSE',581,'Get to work on real time Example of DataBases','Intro to DataBase Management '),
	          ('CSE',684,'Get to implement advanced data structres','Advance Data Structures'),
			  ('CSE',634,'Work on OS principles','Principles of Operating Systems'),
			  ('ANS',520,'get to work on solving crime scenes','Intro to CrimeScene Inverstigation'),
			  ('PRL',487,'Help to express and make your presence in a group','Public Relations Management'),
              ('CSE',681,'Use C# and work on Complex design Projects','Software Modelling and Analysis'),
			  ('CSE',111,'Basics of computer Engineering','Into to computer Engineering'),
	          ('CSE',222,'Work on elementary Data Structures','Into to Data Structures'),
			  ('CSE',333,'Operating System Introduction','Introduction to Operating Systems'),
              ('ANS',444,'Get basics of Mathematics','Mathematics for Forensic'),
			  ('PRL',555,'Intro on keeping relations','Intro to Public Relations Management'),
			  ('MBA',654,'Understand techniques to manage inventory','Inventory Analysis'),
			  ('BBA',566,'Introduce basic principles of Business Management','Introduction to Business Management');

INSERT INTO EnrollmentDetails(StudentInstanceId,CourseInfoId,GradeDetailsId,EnrollmentStatusId)
       VALUES(1,6,3,3),
	         (2,1,2,3),
			 (3,3,1,3),
			 (4,5,6,3),
			 (5,4,7,4),
			 (6,12,4,3);

INSERT INTO TeachingAssignment(CourseInfoId,EmployeeInstanceId)
       VALUES(1,2),
	         (2,3),
			 (3,1),
			 (4,4),
			 (5,5),
			 (6,1),
			 (12,6);

INSERT INTO DayOfWeekDetails(DayType)
       VALUES('Monday'),
	         ('Tuesday'),
			 ('Wednesday'),
			 ('Thursday'),
			 ('Friday'),
			 ('Saturday'),
			 ('Sunday');

INSERT INTO CourseTimingDetails(StartTime,EndTime,DayDetailsId)
       VALUES('08:00 AM','09:20 AM',1),
	         ('08:00AM','09:20 AM',3),
			 ('06:45 PM','08:05 PM',1),
			 ('06:45 PM','08:05 PM',3),
			 ('05:00 PM','08:00 PM',5),
			 ('02:00 PM','05:00 PM',4);

INSERT INTO ProjectorOptions(ProjectorOptionsType)
       VALUES ('Yes-Basic'),
	          ('Yes-SmartBox'),
			  ('No');

INSERT INTO SemesterType(SemesterTypeName)
       VALUES ('Spring'),
	          ('Summer'),
			  ('Fall');

INSERT INTO SemesterDetails(SemesterTypeId,PresentYear,StartDateOfClass,EndDateOfClass)
       VALUES(3,2016,'10-10-2016','12-16-2016'),
	         (3,2017,'10-12-2017','12-16-2017'),
			 (1,2017,'01-04-2017','05-05-2017'),
			 (1,2016,'01-04-2016','05-05-2016'),
			 (1,2015,'01-04-2015','05-05-2015'),
			 (1,2016,'10-05-2015','12-16-2015'),
			 (2,2015,'05-05-2015','08-10-2015'),
			 (2,2016,'06-05-2016','08-05-2016');

INSERT INTO ClassRoom(BuildingName,RoomNumber,MaximumSeating,ProjectorOptionsId,WhiteBoardCount,OtherAV)
       VALUES ('LifeSciences',105,160,2,2,NULL),
	          ('LinkHall',105,160,2,2,NULL),
			  ('LifeSciences',401,180,1,3,NULL),
			  ('Ischool',201,180,1,2,NULL),
			  ('MaxwellSchool',302,180,3,2,NULL),
			  ('MaxwellSchool',402,160,2,3,NULL);

INSERT INTO CourseSchedule(NoOfSeats,ClassRoomId,SemesterDetailsId,EmployeeInstanceId,CourseInfoId)
       VALUES(160,1,3,1,6),
	          (140,2,3,3,2),
			  (100,3,1,1,3),
			  (80,4,3,2,1),
			  (50,5,3,5,5),
			  (100,6,1,6,6);

INSERT INTO TimingSchedule(CourseTimingId,CourseScheduleId)
       VALUES(1,1),
	         (2,2),
			 (3,3),
			 (4,2),
			 (5,1),
			 (6,6);

INSERT INTO CoursePrerequisites(CourseInfoId,CoursePrerequisitesId)
       VALUES(1,7),
	          (2,8),
			  (3,9),
			  (4,10),
			  (5,11),
			  (12,13);

SELECT * FROM dbo.PersonDetails
SELECT * FROM dbo.Address
SELECT * FROM dbo.StatusType
SELECT * FROM dbo.College
SELECT * FROM dbo.Streams
SELECT * FROM dbo.StudentInstance
SELECT * FROM MajorMinorDetails


SELECT * FROM dbo.JobDetails
SELECT * FROM dbo.EmployeeStatus
SELECT * FROM dbo.SelectionType
SELECT * FROM dbo.BenefitType
SELECT * FROM dbo.EmployeeInstance
SELECT * FROM dbo.EmployeeBenefitDetails
SELECT * FROM dbo.BenefitDetails


SELECT * FROM dbo.GradeDetails
SELECT * FROM dbo.EnrollmentStatus
SELECT * FROM dbo.CourseInfo
SELECT * FROM dbo.EnrollmentDetails
SELECT * FROM dbo.TeachingAssignment
SELECT * FROM DayOfWeekDetails
SELECT * FROM dbo.ProjectorOptions



SELECT * FROM dbo.SemesterType
SELECT * FROM dbo.SemesterDetails
SELECT * FROM dbo.ClassRoom
SELECT * FROM dbo.CourseTimingDetails
SELECT * FROM dbo.CourseSchedule
SELECT * FROM dbo.TimingSchedule
SELECT * FROM dbo.CoursePrerequisites


--View that displays the student's Name, Date of Birth and the courses into which students are enrolled
CREATE VIEW dbo.StudentEnrolledInCourses AS
 SELECT pd.FirstName,pd.LastName,pd.DateOfBirth,ci.CourseCode,ci.CourseDescription,ci.CourseNumber,ci.CourseTitle 
	  FROM EnrollmentDetails ed,StudentInstance si,PersonDetails pd, CourseInfo ci
	  WHERE pd.PersonId = si.PersonId
	      AND si.StudentInstanceId = ed.StudentInstanceId
		  AND ed.CourseInfoId = ci.CourseInfoId

SELECT * FROM dbo.StudentEnrolledInCourses


--View that displays the Employee details(Name,Job,Job Details,Benefit Costs)
CREATE VIEW dbo.EmployeeDetails AS
 SELECT pd.FirstName, pd.LastName, pd.EmailAddress,jd.Title,ei.YearlyPay, jd.JobDescription,jd.JobRequirements,ebd.cost AS EmployeeMedicalAllowance
	 FROM PersonDetails pd , JobDetails jd ,EmployeeInstance ei,BenefitDetails bd, EmployeeBenefitDetails ebd
	 WHERE pd.personId = ei.personDetaildId 
	       AND ei.JobDetailsId = jd.jobdetailsId
		   AND bd.EmployeeInstanceId = ei.EmployeeInstanceId
		   AND bd.BenefitDetailsId = ebd.BenefitDetailsId
		   
DROP VIEW dbo.EmployeeDetails
SELECT * FROM dbo.EmployeeDetails


--Class Details View Contains Information like(Where the class is located,when is class going to start,end(year,semester),Infrastructure in class)
CREATE VIEW dbo.ClassDetails AS
SELECT cs.NoOfSeats,sd.StartDateOfClass,sd.EndDateOfClass,cr.BuildingName,cr.RoomNumber,st.SemesterTypeName,po.ProjectorOptionsType
	  FROM CourseSchedule cs,SemesterDetails sd,ClassRoom cr,SemesterType st,ProjectorOptions po
	  WHERE cs.ClassRoomId = cr.ClassRoomId 
	      AND cs.SemesterDetailsId = sd.SemesterDetailsId
		  AND St.SemesterTypeId = sd.SemesterTypeId
		  AND cr.ProjectorOptionsId = po.ProjectorOptionsId
        
SELECT * FROM dbo.ClassDetails

DROP VIEW dbo.ClassDetails
--Student Details view contains student's details like(Name,DateOfBirth,address,Major/Minor Title,)
CREATE VIEW dbo.StudentDetails AS 
SELECT pd.FirstName,Pd.MiddleName,pd.LastName, pd.DateOfBirth, ad.street1,st.StatusTypeName,s.StudyTitle
	   FROM StudentInstance si,PersonDetails pd,StatusType st,Address ad,MajorMinorDetails mmd,Streams s
	   WHERE si.PersonId = pd.PersonId
	   AND si.Addressid = ad.AddressId
	   AND si.StatusTypeId = st.StatusTypeid 	   AND si.StudentInstanceId = mmd.StudentInstanceId
	   AND mmd.StreamId = s.StreamId
	  
SELECT * FROM dbo.StudentDetails
	
	 
--Function that takes course id as input and returns the Faculty name teaching the course 
CREATE FUNCTION dbo.EmployeeTeachingCourse(@CourseId AS INT)
 RETURNS VARCHAR(50)
 BEGIN 
    DECLARE @EmployeeName VARCHAR(50)
     
      SET @EmployeeName = (SELECT PersonDetails.FirstName+' '+PersonDetails.LastName 
                               FROM CourseInfo JOIN TeachingAssignment
							   ON TeachingAssignment.CourseInfoId = CourseInfo.CourseInfoId 
							   INNER JOIN EmployeeInstance
							   ON EmployeeInstance.EmployeeInstanceId = TeachingAssignment.EmployeeInstanceId
							   JOIN PersonDetails
							   ON EmployeeInstance.PersonDetaildId = PersonDetails.PersonId
							   WHERE CourseInfo.CourseInfoId = @CourseId)    
     RETURN @EmployeeName
 END

DROP FUNCTION dbo.EmployeeTeachingCourse
SELECT dbo.EmployeeTeachingCourse(4)

--Function that takes CourseId as input and returns a table containing details of which days of week,at what time and where the course is taught
CREATE FUNCTION dbo.CourseTimingInformation(@CourseId AS INT)
RETURNS @return TABLE(CourseTitle VARCHAR(50),BuildingName VARCHAR(50),RoomNumber VARCHAR(50),StartTime TIME,EndTime TIME,DayType  VARCHAR(50))
 BEGIN 

   INSERT INTO @return
      SELECT CourseInfo.CourseTitle,ClassRoom.BuildingName,ClassRoom.RoomNumber,CourseTimingDetails.StartTime,CourseTimingDetails.EndTime,DayOfWeekDetails.DayType
	     FROM CourseInfo,CourseSchedule,ClassRoom,TimingSchedule,CourseTimingDetails,DayOfWeekDetails
		   WHERE CourseInfo.CourseInfoId = CourseSchedule.CourseInfoId
		    AND CourseSchedule.ClassRoomId =Classroom.ClassRoomId
			AND TimingSchedule.TimingScheduleId = TimingSchedule.CourseScheduleId
			AND TimingSchedule.TimingScheduleId = CourseTimingDetails.CourseTimingId
			AND CourseTimingDetails.DayDetailsId = DayOfWeekDetails.DayDetailsId
			AND @CourseId = CourseInfo.CourseInfoId

  RETURN
 END;

SELECT * FROM dbo.CourseTimingInformation(3)

--Procedure to update the salary of employees based on JobTitle
CREATE PROCEDURE dbo.EmployeeSalaryIncrement(@EmployeeId AS INT)
AS
 BEGIN 
  
  DECLARE @Title AS VARCHAR(50)
  BEGIN TRY 
  IF EXISTS (SELECT JobDetails.Title 
                FROM EmployeeInstance,JobDetails
				WHERE JobDetails.JobDetailsId = EmployeeInstance.EmployeeInstanceId
				AND EmployeeInstance.EmployeeInstanceId = @EmployeeId)
    
	BEGIN
	 SELECT @Title = (SELECT JobDetails.Title  
                FROM EmployeeInstance,JobDetails
				WHERE JobDetails.JobDetailsId = EmployeeInstance.EmployeeInstanceId
				AND EmployeeInstance.EmployeeInstanceId = @EmployeeId)
	IF(@Title='Professor' OR @Title = 'Assistant Professor')
	    BEGIN 
	      UPDATE EmployeeInstance
		  SET YearlyPay = YearlyPay*1.08
		  FROM EmployeeInstance,JobDetails
		  WHERE JobDetails.JobDetailsId = EmployeeInstance.EmployeeInstanceId
		  AND EmployeeInstance.EmployeeInstanceId = @EmployeeId
	    END

	ELSE IF(@Title='Research Assistant' OR @Title = 'Teaching Assistant')
	    BEGIN 
	      UPDATE EmployeeInstance
		  SET YearlyPay = YearlyPay*1.04
		  FROM EmployeeInstance,JobDetails
		  WHERE JobDetails.JobDetailsId = EmployeeInstance.EmployeeInstanceId
		  AND EmployeeInstance.EmployeeInstanceId = @EmployeeId
	    END
    ELSE IF(@Title='Admission Officer' OR @Title = 'Dean')
	    BEGIN 
	      UPDATE EmployeeInstance
		  SET YearlyPay = YearlyPay*1.10
		  FROM EmployeeInstance,JobDetails
		  WHERE JobDetails.JobDetailsId = EmployeeInstance.EmployeeInstanceId
		  AND EmployeeInstance.EmployeeInstanceId = @EmployeeId
	    END
	END
  ELSE
   BEGIN 
     Print 'Employee Id given is not found'
   END
   
 END TRY

 BEGIN CATCH
	   PRINT 'An error has occured' 
 END CATCH

 END

EXEC dbo.EmployeeSalaryIncrement '9'
EXEC dbo.EmployeeSalaryIncrement '3'


DROP PROCEDURE dbo.EmployeeSalaryIncrement

SELECT * FROM Streams

--Procedure that displays all the students and their Area of Interest based on their collegeId 
CREATE PROCEDURE dbo.StudentsInParticalularCollege(@CollegeId AS INT)
AS
BEGIN 
 DECLARE @Display TABLE(StudentName VARCHAR(50), AreaOfStudy VARCHAR(50))
  BEGIN TRY    
     INSERT INTO @Display
     SELECT  PersonDetails.FirstName+' '+PersonDetails.LastName, Streams.StudyTitle
         FROM College,Streams,MajorMinorDetails,StudentInstance,PersonDetails
		 WHERE College.CollegeId = streams.CollegeId
		   AND MajorMinorDetails.StreamId = Streams.StreamId
		   AND MajorMinorDetails.StudentInstanceId = StudentInstance.StudentInstanceId
		   AND PersonDetails.PersonId = StudentInstance.PersonId
		   AND College.CollegeId = @CollegeId

   SELECT * FROM @Display
   END TRY 

   BEGIN CATCH
      PRINT 'An error has occured in the process of fetching students from particalular college '
   END CATCH 
END 

EXEC  dbo.StudentsInParticalularCollege '5'
EXEC dbo.StudentsInParticalularCollege '1'
              
