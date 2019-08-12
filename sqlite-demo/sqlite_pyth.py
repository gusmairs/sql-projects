# Demo of Python scripting of SQL query of a sqlite database
# Uses the markets.db database sample
# Uses a file script so that development of query can happen
# directly in sqlite using command line tools
# Unpacks the cursor object into a Pandas df

import sqlite3 as sql
import pandas as pd

db = 'data/markets.db'
con = sql.connect(db)
c = con.cursor()
with open('sqlite_pyth.sql', 'r') as q:
    query = q.read().replace('\n', ' ')
data = c.execute(query)
df = pd.DataFrame(data.fetchall(), columns=['state', 'ppl_mkt'])
df.head()
con.close()
