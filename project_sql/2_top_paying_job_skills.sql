with top_paying_jobs as (
    select
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name as company_name
    from
        job_postings_fact
    left join company_dim on
        job_postings_fact.company_id = company_dim.company_id
    where
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' and
        salary_year_avg is not null
    order by
        salary_year_avg desc
    limit 10
)
select 
    top_paying_jobs.*,
    skills
from
    top_paying_jobs
inner join skills_job_dim ON
    top_paying_jobs.job_id = skills_job_dim.job_id
inner join skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
order by
    salary_year_avg desc
limit 10
