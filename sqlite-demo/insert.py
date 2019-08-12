# Creating and inserting into a sqlite db
# Note two approaches to Python variables being incoporated into the
# SQL code: with '?' and a tuple of values, or with ':var' and a
# dictionary of values
# See 'insert2.py' for use of a generator object

import sqlite3 as sql

db = 'data/insert.db'
con = sql.connect(db)
c = con.cursor()
c.execute('''
    create table if not exists foo (
        name text,
        num int
        )
    ;
    ''')
for i, n in enumerate(['tom', 'jim', 'jane', 'fred', 'kelly']):
    # c.execute('''
    #     insert into foo values (:name, :num)
    #     ''', {'name': n, 'num': i})
    c.execute('''
        insert into foo values (?, ?)
        ;
        ''', (n, i))
con.commit()
con.close()
