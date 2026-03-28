

WITH skills_demand AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS demand_count
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
        INNER JOIN skills_dim AS sd
            ON sjd.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY 
        sd.skill_id
), average_salary AS (
    SELECT
        sjd.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
        INNER JOIN skills_dim AS sd
            ON sjd.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY 
        sjd.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
    WHERE demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;