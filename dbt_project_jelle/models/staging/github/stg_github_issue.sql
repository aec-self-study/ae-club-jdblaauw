with source as (
    select * from {{ source('github', 'issue') }}
),

renamed as (
    select
        id as issue_id,
        body,
        closed_at,
        created_at,
        locked,
        milestone_id,
        number,
        pull_request,
        repository_id,
        state,
        title,
        updated_at,
        user_id,

        --excluded 
        _fivetran_synced
    from source
)

select * from renamed