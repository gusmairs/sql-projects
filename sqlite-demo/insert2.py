# Shows direct use of a generator object, in this case enumerate(),
# instead of producing a list of tuples first. Note that sqlite3
# handles the enumerate object directly as tuples to be unpacked.

import sqlite3 as sql

db = 'data/insert.db'
con = sql.connect(db)
c = con.cursor()
c.execute('''
    create table if not exists bar (
        num int,
        name text
        )
    ''')
names = ['tom', 'jim', 'jane', 'fred', 'kelly']
c.executemany('''
    insert into bar values (?, ?)
    ;
    ''', enumerate(names))
con.commit()
con.close()
