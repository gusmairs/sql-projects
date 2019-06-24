import psycopg2
# from datetime import datetime

conn = psycopg2.connect(dbname='socialmedia', user='postgres', host='/tmp')
c = conn.cursor()

c.execute('''CREATE TABLE lastlogin AS
             SELECT logins.userid,
                    registrations.tmstmp as regdate,
                    MAX(logins.tmstmp) as lastlogin
             FROM registrations
             JOIN logins ON registrations.userid = logins.userid
             GROUP BY logins.userid, registrations.tmstmp;''')

conn.commit()
conn.close()
