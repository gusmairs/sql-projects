# Refined from the dsi starter code

import psycopg2

conn = psycopg2.connect(dbname='socialmedia')
c = conn.cursor()
today = '2014-08-14'
c.execute(
    '''
    drop table if exists logins_7d
    ;
    create table logins_7d as
        select userid, count(*) as cnt, date(timestamp %s) as date_7d
        from logins
        where logins.tmstmp > timestamp %s - interval '7 days'
        group by userid
    ;
    ''', (today, today)
)
conn.commit()
conn.close()
