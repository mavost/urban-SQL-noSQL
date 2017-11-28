/* Common Metrics
Common Metrics Conclusion

While every business has different metrics to track their success, most are based on revenue and usage.

The metrics in this lesson are merely a starting point, and from here you'll be able to create and customize metrics to track whatever is most important to your company.

And remember, data science is exploratory! The current set of metrics can always be improved and there's usually more to any spike or dip than what immediately meets the eye.

Let's generalize what we've learned so far:

    Key Performance Indicators are high level health metrics for a business.
    Daily Revenue is the sum of money made per day.
    Daily Active Users are the number of unique users seen each day
    Daily Average Revenue Per Purchasing User (ARPPU) is the average amount of money spent by purchasers each day.
    Daily Average Revenue Per User (ARPU) is the average amount of money across all users.
	1 Day Retention is defined as the number of players from Day N who came back to play again on Day N+1.
 */



-- ###############################ONE DAY RETENTION##############################
select
  date(g1.created_at) as dt,
  g1.user_id,
  g2.user_id
from gameplays as g1
  join gameplays as g2 on
    g1.user_id = g2.user_id
    and date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
order by 1
limit 100;

-- STEP 2
select
  date(g1.created_at) as dt,
  count(distinct g1.user_id) as total_users,
  count(distinct g2.user_id) as retained_users
from gameplays as g1
  LEFT JOIN gameplays as g2 on
    g1.user_id = g2.user_id
    and date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
group by 1
order by 1
limit 100;
-- RESULT
select
  date(g1.created_at) as dt,
  round(100 * count(distinct g2.user_id) /
        count(distinct g1.user_id)) as retention
from gameplays as g1
	left join gameplays as g2 on 
		g1.user_id=g2.user_id and
		date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
group by 1
order by 1
limit 100;