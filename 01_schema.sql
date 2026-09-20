CREATE DATABASE IF NOT EXISTS JobSync;
USE JobSync;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE job_seekers (
    job_seeker_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    full_name VARCHAR(150),
    application_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
);

CREATE TABLE companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    company_name VARCHAR(150),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
);

CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT,
    job_title VARCHAR(150),
    description VARCHAR(500),
    status VARCHAR(20) DEFAULT 'OPEN',
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
        ON DELETE CASCADE
);

CREATE TABLE applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    job_seeker_id INT,
    status VARCHAR(50) DEFAULT 'APPLIED',
    UNIQUE(job_id, job_seeker_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
        ON DELETE CASCADE,
    FOREIGN KEY (job_seeker_id) REFERENCES job_seekers(job_seeker_id)
        ON DELETE CASCADE
);

CREATE TABLE interviews (
    interview_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT,
    interview_date DATE,
    feedback VARCHAR(500),
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
        ON DELETE CASCADE
);

CREATE TABLE job_seeker_skills (
    job_seeker_id INT,
    skill_id INT,
    PRIMARY KEY(job_seeker_id, skill_id),
    FOREIGN KEY(job_seeker_id) REFERENCES job_seekers(job_seeker_id)
        ON DELETE CASCADE,
    FOREIGN KEY(skill_id) REFERENCES skills(skill_id)
        ON DELETE CASCADE
);

CREATE TABLE job_skills (
    job_id INT,
    skill_id INT,
    PRIMARY KEY(job_id, skill_id),
    FOREIGN KEY(job_id) REFERENCES jobs(job_id)
        ON DELETE CASCADE,
    FOREIGN KEY(skill_id) REFERENCES skills(skill_id)
        ON DELETE CASCADE
);

CREATE TABLE saved_jobs (
    job_seeker_id INT,
    job_id INT,
    saved_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    job_status VARCHAR(20) DEFAULT 'OPEN',
    PRIMARY KEY(job_seeker_id, job_id),
    FOREIGN KEY(job_seeker_id) REFERENCES job_seekers(job_seeker_id)
        ON DELETE CASCADE,
    FOREIGN KEY(job_id) REFERENCES jobs(job_id)
        ON DELETE CASCADE
);
