import sqlite3 as sql
import pandas as pd

db = 'markets.sqlite'
con = sql.connect(db)
c = con.cursor()
with open('lite_q.sql', 'r') as q:
    query = q.read().replace('\n', ' ')
data = c.execute(query)
df = pd.DataFrame(data.fetchall(), columns=['state', 'ppl_mkt'])
df.head()
con.close()
