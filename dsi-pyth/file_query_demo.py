# Demo of setting up psycopg2 to incorporate a query from a .sql file
# Uses test.sql, path depends on where Atom is run from

import psycopg2
import pandas as pd

conn = psycopg2.connect(dbname='socialmedia')
c = conn.cursor()
with open('test.sql', 'r') as q:
    query = q.read().replace('\n', ' ')
c.execute(query)
df = pd.DataFrame(c.fetchall(), columns=['id', 'stamp', 'type'])
df.head()
df.loc[:, 'type'].value_counts()
conn.commit()
conn.close()
