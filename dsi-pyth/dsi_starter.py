# This is the starter template from dsi

import psycopg2
from datetime import datetime

conn = psycopg2.connect(
    dbname='socialmedia',
    user='postgres',
    host='/tmp'
)
c = conn.cursor()
today = '2014-08-14'

# Not needed but demonstrates how to convert a date to another format
ts = datetime.strptime(today, '%Y-%m-%d').strftime("%Y%m%d")

c.execute(
    '''CREATE TABLE logins_7d AS
    SELECT userid, COUNT(*) AS cnt, timestamp %(ts)s AS date_7d
    FROM logins
    WHERE logins.tmstmp > timestamp %(ts)s - interval '7 days'
    GROUP BY userid;''', {'ts': ts}
)

conn.commit()
conn.close()
