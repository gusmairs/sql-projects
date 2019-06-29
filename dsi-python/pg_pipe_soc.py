import psycopg2

conn = psycopg2.connect(dbname='socialmedia')
c = conn.cursor()
with open('dsi-python/social.sql', 'r') as q:
    query = q.read().replace('\n', ' ')
c.execute(query)
conn.commit()
conn.close()
