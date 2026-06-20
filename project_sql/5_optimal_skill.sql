with skills_demand as (
    select 
        skills_dim.skill_id,
        skills,
        count(skills_job_dim.job_id) as demand_count
    from
        job_postings_fact   
    inner join skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    where 
        job_title_short = 'Data Analyst' and
        job_work_from_home = true
    group by skills_dim.skill_id
),
average_salary as (
    select 
        skills_dim.skill_id,
        round(avg(salary_year_avg),0) as avg_salary
    from
        job_postings_fact   
    inner join skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    where 
        job_title_short = 'Data Analyst' and
        salary_year_avg is not null
    group by skills_dim.skill_id
)

select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from
    skills_demand
inner join average_salary ON skills_demand.skill_id = average_salary.skill_id
where 
    demand_count>10
order BY demand_count DESC, avg_salary desc
limit 25;