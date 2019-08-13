# Refined from the dsi starter code
# Parameters passed with the '%s' marker, values held in a tuple following
# the query text object. Parameters may also be named as '%(<name>)s' and
# in this case the values are held in a dictionary format following the
# query text object, as '{<name>: <value>}'

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
