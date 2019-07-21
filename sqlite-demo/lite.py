# Demo of Python scripting of sql query to sqlite database
# Uses the markets.db database sample
# Uses a file script so that development of query can happen
# directly in sqlite using command line tools

import sqlite3 as sql
import pandas as pd

db = 'markets.db'
con = sql.connect(db)
c = con.cursor()
with open('lite_query.sql', 'r') as q:
    query = q.read().replace('\n', ' ')
data = c.execute(query)
df = pd.DataFrame(data.fetchall(), columns=['state', 'ppl_mkt'])
df.head()
con.close()
