

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    cd.name AS company_name
FROM 
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
    And salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;