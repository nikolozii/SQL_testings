select
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
limit 10;