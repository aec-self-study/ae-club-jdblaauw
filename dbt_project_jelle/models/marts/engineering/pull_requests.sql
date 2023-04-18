with 

pull_requests as (
    select * from {{ ref('stg_github_pull_requests') }}
),

repository as (
    select * from {{ ref('stg_github_repository') }}
),

issue as (
    select * from {{ ref('stg_github_issue') }}
),

issue_merged as (
    select * from {{ ref('stg_github_issue_merged') }}
),

final as (
    select
        pull_requests.pull_request_id,
        repository.name as repo_name,
        issue.number as pull_request_number,
        cast(null as string) as type, -- (bug, eng, feature)
        case 
            when pull_requests.is_draft then 'draft'
            when issue_merged.merged_at is not null then 'merged'
            when issue.closed_at is not null then 'closed_without_merge'
            else 'open'
        end as state,

        issue.created_at as opened_at,
        issue_merged.merged_at,
        date_diff(issue.opened_at, issue_merged.merged_at, hour)/24 as days_open_to_merge

    from pull_requests

    left join repository
        on pull_requests.head_repo_id = repository.repository_id

    left join issue
        on pull_requests.issue_id = issue.issue_id

    left join issue_merged
        on pull_requests.issue_id = issue_merged.issue_id
        )

select * from final 
