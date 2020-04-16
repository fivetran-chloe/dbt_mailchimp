with activities as (

    select *
    from {{ ref('mailchimp_campaign_emails')}}

), pivoted as (

    select 
        member_id,
        count(*) as sends,
        sum(opens) as opens,
        sum(clicks) as clicks,
        count(distinct case when was_opened = True then member_id end) as unique_opens,
        count(distinct case when was_clicked = True then member_id end) as unique_clicks
    from activities
    group by 1
    
)

select *
from pivoted