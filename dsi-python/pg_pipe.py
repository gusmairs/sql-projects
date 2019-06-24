import psycopg2
from datetime import datetime

conn = psycopg2.connect(dbname='socialmedia')
c = conn.cursor()
today = datetime.strptime('2014-08-14', '%Y-%m-%d').strftime("%Y%m%d")
with open('social.sql', 'r') as q:
    query = q.read().replace('\n', '')
c.execute(query)
conn.commit()
conn.close()
