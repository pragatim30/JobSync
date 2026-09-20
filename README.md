# JobSync — Job Portal Database Management System

JobSync is a MySQL-based database project for managing a job portal. It models
job seekers, companies, jobs, skills, applications, interviews, and saved jobs.

## Features

- User and role management for job seekers and companies
- Job and skill management
- Many-to-many skill mapping between candidates and jobs
- Job application tracking
- Interview scheduling and feedback storage
- Candidate-job skill matching percentage
- Duplicate application prevention
- Phone-number validation using a trigger
- Automatic synchronization of saved-job status when a job is closed
- SQL views for candidate matching and company application statistics
- Stored procedures for common database operations
- Foreign-key constraints and cascading deletes

## Database Design

Main tables:

- `users`
- `job_seekers`
- `companies`
- `skills`
- `jobs`
- `applications`
- `interviews`
- `job_seeker_skills`
- `job_skills`
- `saved_jobs`

Database objects:

- Function: `CalculateMatch`
- Procedures: `ApplyForJob`, `AddCompany`, `AddSkill`, `AddJob`, `AddJobSeeker`
- Triggers: `trg_phone_validation`, `trg_saved_job_status_update`
- Views: `Candidate_Match_View`, `Company_Applications_View`

## Project Structure

```text
JobSync/
├── README.md
└── sql/
    ├── 01_schema.sql
    ├── 02_procedures_functions.sql
    ├── 03_triggers_views.sql
    ├── 04_sample_data.sql
    └── 05_test_queries.sql
```

## How to Run

Use MySQL 8.x or a compatible MySQL version.

Run the files in this order:

1. `01_schema.sql`
2. `02_procedures_functions.sql`
3. `03_triggers_views.sql`
4. `04_sample_data.sql`
5. `05_test_queries.sql`

You can run them using MySQL Workbench, MySQL Shell, or the MySQL command line.

## Important Implementation Details

### Candidate-job matching

`CalculateMatch(jobId, seekerId)` compares the skills required by a job
against the skills possessed by a job seeker and returns the percentage of
required skills matched.

### Application control

`ApplyForJob` checks whether the candidate has already applied for the same
job and raises an error for duplicate applications.

### Data validation

`trg_phone_validation` ensures that newly inserted phone numbers contain
exactly 10 digits.

### Saved job status

When a job changes from `OPEN` to `CLOSED`, `trg_saved_job_status_update`
automatically updates the corresponding records in `saved_jobs`.

## Notes

The original SQL transcript contained Oracle-style syntax in an initial
`users` table attempt. The GitHub version uses MySQL syntax consistently.

The original transcript also incremented `application_count` both inside
`ApplyForJob` and through an application trigger. The cleaned version keeps
this responsibility in the stored procedure to avoid double-counting.

## Technologies

- MySQL
- SQL
- Stored Procedures
- User-Defined Function
- Triggers
- Views
- Foreign Keys
- Relational Database Design

## Author

Pragati Maurya
