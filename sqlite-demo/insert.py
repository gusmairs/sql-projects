# Note

import sqlite3 as sql

db = 'new.db'
con = sql.connect(db)
c = con.cursor()
c.execute('''
    create table if not exists foo (
        this text,
        that int
        )
    ;
    ''')
for i in range(5):
    t = 'thing ' + str(i)
    c.execute('''
        insert into foo values (?, ?)
        ;
        ''', (t, i))
    # t = "\'thing " + str(i) + "\'"
    # c.execute(f'''
    #     insert into foo values ({t}, {i})
    #     ;
    #     ''')
con.commit()
con.close()
