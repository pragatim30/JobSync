USE JobSync;

INSERT INTO users(username, email, phone) VALUES
('tanvi_js', 'tanvi@gmail.com', '9876543210'),
('pragati_js', 'pragati@gmail.com', '9123456780'),
('srishti_js', 'srishti@gmail.com', '9001122334'),
('infosys_hr', 'hr@infosys.com', '9998887776'),
('tcs_hr', 'hr@tcs.com', '9090909090');

INSERT INTO job_seekers(user_id, full_name) VALUES
(1, 'Tanvi Jindal'),
(2, 'Pragati Maurya'),
(3, 'Srishti Mehta');

INSERT INTO companies(user_id, company_name) VALUES
(4, 'Infosys'),
(5, 'TCS');

INSERT INTO skills(skill_name) VALUES
('Java'),
('SQL'),
('Python'),
('HTML'),
('CSS'),
('JavaScript');

INSERT INTO jobs(company_id, job_title, description, status) VALUES
(1, 'Java Developer', 'Backend Java role', 'OPEN'),
(1, 'SQL Analyst', 'Database management role', 'OPEN'),
(2, 'Frontend Developer', 'HTML/CSS/JS required', 'OPEN');

INSERT INTO job_skills(job_id, skill_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 4),
(3, 5),
(3, 6);

INSERT INTO job_seeker_skills(job_seeker_id, skill_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 1),
(3, 4);

INSERT INTO applications(job_id, job_seeker_id, status) VALUES
(1, 1, 'APPLIED'),
(3, 2, 'APPLIED'),
(2, 3, 'APPLIED');

INSERT INTO interviews(application_id, interview_date, feedback) VALUES
(1, '2025-02-10', 'Good technical knowledge'),
(2, '2025-02-12', 'Front-end skills are strong'),
(3, '2025-02-15', 'Strong analytical skills');

INSERT INTO saved_jobs(job_seeker_id, job_id, job_status) VALUES
(1, 1, 'OPEN'),
(1, 2, 'OPEN'),
(2, 3, 'OPEN'),
(3, 1, 'OPEN');
