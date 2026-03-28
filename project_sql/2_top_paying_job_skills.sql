
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    sd.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim AS sjd
    ON top_paying_jobs.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
ORDER BY
    salary_year_avg DESC
