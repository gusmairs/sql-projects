# Shows direct use of a generator object, in this case enumerate(),
# instead of producing a list of tuples first

import sqlite3 as sql

db = 'new.db'
con = sql.connect(db)
c = con.cursor()
c.execute('''
    create table if not exists foo (
        num int,
        name text
        )
    ''')
names = ['tom', 'jim', 'jane', 'fred', 'kelly']
c.executemany('''
    insert into foo values (?, ?)
    ;
    ''', enumerate(names))
con.commit()
con.close()
