# University Database
  * You are asked to create a database design that will store information for the business problem described below. 
  * The business problem lists and describes the data in a way that made sense to me. In no way is it intended to suggest any design choices. It is up to you to create a valid design.

## Requirements
* Your design should be normalized to 3rd normal form.
* Your design should include the following:
  -	tables and columns
  -	primary and foreign keys
  -	relationships between tables
  -	nullability (whether the column is required or not)
	Your design needs to be able to store all of the data points listed in the business problem.
 * You may also submit a short explanation of non-obvious design choices or data assumptions you made .

## Important Considerations
* Getting to a working final product is only a part of the battle. Doing so correctly is crucial. Please make sure you follow the naming standards, and that your design is as neat as possible .
* I strongly urge you to use either Visio 2010 or Vertabello to create your design. 
* If you chose to use a different tool, I expect that the resulting schema will communicate (in an obvious way) all of the required design elements. Furthermore the template also needs to be VERY similar to the tools listed above (in how everything looks). If you chose to use a different tool, and it causes you to break with the above statements, you will lose points.
* I am not requiring your design to show the data types. If it does, I will not check these. 
* Try to place as few constraints on the business problem, as possible. If you aren’t sure about something, ask.
* Finally, I very strongly encourage you to follow the outlined schedule. If you try to start this project 24 hours before its due (or even later), you will very likely do VERY poorly. You have been warned. 

 
### Deliverable
	Your deliverable will be a single PDF document containing the optional explanation and your DB design.

Grading Outline 
1. Design explanation (3 pts)
   - not too long
   - not stating the obvious
2. Design cleanliness (2 pts)
   - general organization
   - of crossing/overlapping lines
3. Naming standards (10 pts)
4. Data (10 pts)
   - all of the data points from the business problem are included in the design
   - data is appropriately broken down
5. Design includes all of the required elements (30 pts)
   -	primary keys
   - foreign keys
   - relationships
   - nullability
6.	Normalization (45 pts)
   - the database is normalized to 3rd normal form
   - look up tables are broken out
   - correctly identified and handled one-to-one, one-to-many and many-to-many relationships
 
## Business Problem:
	Your job is to create a DB for a university. The following is the information that the customer needs to store. If the datatype is not provided, use common sense, or ask.
	
Students
-	name
-	NTID
-	student id
-	password
-	major(s) and minor(s) that the student is working on
o	college that the majors/minors belongs to
-	date of birth
-	SSN
-	home address
-	local address
-	status (possible options - undergraduate, graduate, non-matriculated, graduated)

Employees
-   name
-	NTID 
-	employee id
-	status (possible options – active, inactive)
-	SSN
-	address
-	yearly pay
-	health benefits – cost, selection (selection – possible options – single, family, op-out)
-	vision benefits – cost, selection (selection – possible options – single, family, op-out)
-	dental benefits – cost, selection (selection – possible options – single, family, op-out)
-	job information
-	job title
-	job description
-	job requirements 
-	min pay
-	max pay
-	union job (Yes/No)

Courses
-	course information
-   course code
-   course number
-	course title
-	course description
- 	course prerequisites (pointing to other course(s) could be 0 – unlimited number of prerequirements)
-	course schedule
- semester (semester, year, date of first and last classes in that semester)
- 	faculty teaching the course
-	time of the course – start, end (hours and minutes) and which days of the week
-	classroom in which the course is being taught
-	how many seats
-	a list of enrolled students
-	their ID
-	their status (possible options - regular, audit, Pass/Fail)
-	their grade

Classroom
-	building name
-	room number
-	maximum seating
-	projector (possible options Yes – Basic/Yes – SmartBoard/No)
-	number of white boards
-	other A/V equipment (text) 



## Database Implementation

### Requirements:
1.	Design – you are expected to make design adjustments  based on my feedback and issues you identify while working on project. You are required to submit a brief  list of the modifications. If your design was perfect, and you didn’t need to make a single change, please state that.
2.	Table creation – implement all of the tables from your design. Make sure you use identities, correct data types and all applicable constraints. You will submit all SQL used, as text. No screenshots.
3.	Data load – load test data into your tables. Most of the tables should have between 5 – 10 records, with an average of ~6 records per table. The data should demonstrate relationships properly, and make sense within the scope of the scope of the business problem. You will submit all SQL used, as text. No screenshots.
4.	Views – you are required to create 4 views that serve a valid purpose within the business problem. A short, 1 sentence explanation as to the purpose should accompany all views. You will submit all SQL used, as text. No screenshots.
5.	Stored procedures and functions – you are required to create at least 1 of each, with a total of 4 objects . Each object should have a short, 1 sentence explanation as to its purpose (which should be valid within the scope of the business problem). You will submit all SQL used, as text. 


### Deliverable
- Your deliverable will be a single PDF or .SQL document containing the design change statement (1) and all of the SQL you wrote for steps (2-5), along w/ the purpose explanations for all objects (in SQL comments). You will submit this document via blackboard.
- If you upload a file that does not follow these specifications , I reserve the right to lower your grade as I see fit. I may not grade parts of the project (and you will receive 0s for those), or, I may refuse to grade the entire project, and you will receive a 0 for it.

### Grading Outline
1.	Design Modifications (5 pts) 
2.	Your design is correct, and no duplicate data is being stored (10 pts)
3.	SQL Standards followed everywhere (30 pts)
4.	Table creation (15 pts)
    -	appropriate use of data types and their specification 
	- appropriate use of, and declaration of, identities
	- appropriate use of constraints (PK, FK, nullable, check, default)
5.	Data load (10 pts)
	- following datatypes (text vs numbers)
	- appropriate number of records loaded
	- data reflects real world
6.	Views (15 pts), SPs/Functions (15 pts)
	- correct number of objects
	- purpose is stated & accomplished
	- appropriate complexity
