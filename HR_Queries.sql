CREATE DATABASE Hr_Project;
use hr_project;
select *from employees;

CREATE TABLE employees (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    NumCompaniesWorked INT,
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

CREATE DATABASE Hr_Project;
show tables;

select count(*) from `hr attrition analytics project`;

select *
from `hr attrition analytics project`
limit 5;

rename table `hr attrition analytics project`
to employees;
drop table employees;

#queries

#1)Attrition rate by department(in%)
select department,
count(*) as total_employees,
sum(case when attrition = 'yes' then 1 else 0 end) as attrition_count,
round(sum(case when attrition = 'yes' then 1 else 0 end) * 100.0/count(*),2) as arrition_rate
from employees
group by department;

#2) TOP 3 jobroles with Higest Attrirtion
select jobrole,
sum(case when attrition = 'yes' then 1 else 0 end) as attrition_count
from employees
group by jobrole
order by attrition_count desc
limit 3;

#3)AVERAGE monthly income of employees who left vs stayed
select attrition,
avg(monthlyincome) as average_salary
from employees
group by attrition;

#4)which age group has highest attrition?
select
case when ï»¿Age < 30 then 'young' 
	when ï»¿Age between 30 and 45 then 'mid'
    else 'senior'
    end as age_group,
 sum(case when attrition = 'yes' then 1 else 0 end)as attrition_count
 from employees
 group by age_group
 order by attrition_count desc;

# SUBQUERY 

# Q)employees earning more than their department average
SELECT 
e1.department,
e1.jobrole,
e1.monthlyincome
from employees e1
where monthlyincome > (select avg(e2.monthlyincome)
from employees e2
where e1.department = e2.department)
order by department, monthlyincome desc;


# WINDOW FUNCTIONS
#  Q)FIND TOP 2 HIGHEST PAID EMPLOYEES IN EACH DEPARTMENT

SELECT *
FROM (
     SELECT DEPARTMENT,
             JOBROLE,
             MONTHLYINCOME,
             RANK()over(partition by department order by monthlyincome desc) as rnk
 from employees)  t
 where rnk <= 2;
             
             
             






