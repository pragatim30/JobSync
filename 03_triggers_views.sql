USE JobSync;

DELIMITER $$

CREATE TRIGGER trg_phone_validation
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.phone NOT REGEXP '^[0-9]{10}$' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Phone number must be exactly 10 digits.';
    END IF;
END$$

CREATE TRIGGER trg_saved_job_status_update
AFTER UPDATE ON jobs
FOR EACH ROW
BEGIN
    IF NEW.status = 'CLOSED' AND OLD.status = 'OPEN' THEN
        UPDATE saved_jobs
        SET job_status = 'CLOSED'
        WHERE job_id = NEW.job_id;
    END IF;
END$$

DELIMITER ;

CREATE OR REPLACE VIEW Candidate_Match_View AS
SELECT
    js.job_seeker_id,
    j.job_id,
    j.job_title,
    CalculateMatch(j.job_id, js.job_seeker_id) AS match_percent
FROM job_seekers js
CROSS JOIN jobs j;

CREATE OR REPLACE VIEW Company_Applications_View AS
SELECT
    c.company_name,
    j.job_title,
    COUNT(a.application_id) AS total_applications
FROM companies c
JOIN jobs j ON c.company_id = j.company_id
LEFT JOIN applications a ON j.job_id = a.job_id
GROUP BY c.company_name, j.job_title;
