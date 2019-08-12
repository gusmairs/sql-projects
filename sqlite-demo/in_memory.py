# Demo of using in-memory mode to manage data with sqlite
# Also shows use of the executemany() method with an existing
# Python iterable instead of looping over execute()

import sqlite3

persons = [
    ('Hugo', 'Boss'),
    ('Calvin', 'Klein')
]

con = sqlite3.connect(':memory:')
con.execute('''
    create table person(firstname, lastname)
    ;
    ''')
con.executemany('''
    insert into person values (?, ?)
    ;
    ''', persons)
for row in con.execute('''select * from person'''):
    print(row)
print('I just deleted',
      con.execute('''delete from person''').rowcount,
      'rows')
