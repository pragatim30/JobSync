USE JobSync;

-- Skill-match examples
SELECT CalculateMatch(1, 1) AS Tanvi_Java_Developer_Match;
SELECT CalculateMatch(2, 2) AS Pragati_SQL_Analyst_Match;
SELECT CalculateMatch(3, 2) AS Pragati_Frontend_Match;

-- Apply through stored procedure
CALL ApplyForJob(2, 2);
CALL ApplyForJob(3, 3);

-- View saved jobs
SELECT * FROM saved_jobs;

-- Close a job and verify saved-job status synchronization
UPDATE jobs
SET status = 'CLOSED'
WHERE job_id = 1;

SELECT * FROM saved_jobs
WHERE job_id = 1;

-- Candidate-job match report
SELECT * FROM Candidate_Match_View;

-- Company application report
SELECT * FROM Company_Applications_View;

-- Stored procedure examples
CALL AddSkill('C++');
CALL AddJob(1, 'Backend Developer', 'Backend development role');
-- CALL AddJobSeeker(2, 'Pragati Maurya'); -- user_id 2 already has a seeker profile
