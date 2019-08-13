# The data updating script, brings in query from the file social.sql
# Working from file means the SQL code can be developed and tested
# directly within the Postgres environment and psycopg2 creates access
# to that code from within Python

# Unclear what context would require this psycopg2 setup with no real
# Python value-add. Seems a shell script could run the command
# 'psql socialmedia < social.sql' on a regular basis. Seems psycopg2
# is more useful when there is some additional manipulation of the query
# needed that is not easily done in shell

import psycopg2
conn = psycopg2.connect(dbname='socialmedia')
c = conn.cursor()
with open('social.sql', 'r') as q:
    query = q.read().replace('\n', ' ')
c.execute(query)
conn.commit()
conn.close()
