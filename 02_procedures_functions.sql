USE JobSync;

DELIMITER $$

CREATE FUNCTION CalculateMatch(jobId INT, seekerId INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalRequired INT DEFAULT 0;
    DECLARE matched INT DEFAULT 0;

    SELECT COUNT(*) INTO totalRequired
    FROM job_skills
    WHERE job_id = jobId;

    SELECT COUNT(*) INTO matched
    FROM job_skills js
    WHERE js.job_id = jobId
      AND js.skill_id IN (
          SELECT skill_id
          FROM job_seeker_skills
          WHERE job_seeker_id = seekerId
      );

    IF totalRequired = 0 THEN
        RETURN 0;
    END IF;

    RETURN ROUND((matched * 100.0) / totalRequired);
END$$

CREATE PROCEDURE ApplyForJob(IN jobId INT, IN seekerId INT)
BEGIN
    DECLARE alreadyApplied INT DEFAULT 0;

    SELECT COUNT(*) INTO alreadyApplied
    FROM applications
    WHERE job_id = jobId
      AND job_seeker_id = seekerId;

    IF alreadyApplied > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Duplicate Application Not Allowed';
    END IF;

    INSERT INTO applications(job_id, job_seeker_id)
    VALUES (jobId, seekerId);
END$$

CREATE PROCEDURE AddCompany(
    IN p_user_id INT,
    IN p_company_name VARCHAR(150)
)
BEGIN
    INSERT INTO companies(user_id, company_name)
    VALUES (p_user_id, p_company_name);
END$$

CREATE PROCEDURE AddSkill(
    IN p_skill_name VARCHAR(100)
)
BEGIN
    INSERT INTO skills(skill_name)
    VALUES (p_skill_name);
END$$

CREATE PROCEDURE AddJob(
    IN p_company_id INT,
    IN p_job_title VARCHAR(150),
    IN p_description VARCHAR(500)
)
BEGIN
    INSERT INTO jobs(company_id, job_title, description)
    VALUES (p_company_id, p_job_title, p_description);
END$$

CREATE PROCEDURE AddJobSeeker(
    IN p_user_id INT,
    IN p_full_name VARCHAR(150)
)
BEGIN
    INSERT INTO job_seekers(user_id, full_name)
    VALUES (p_user_id, p_full_name);
END$$

DELIMITER ;
