# Tuesday Apr 4 2017
# map to sqlite

import sqlite3

def create_connection(db_file):
    try:
        conn = sqlite3.connect(db_file)
        print 'connected to ' + db_file
        return conn
    except Error as e:
        print(e)
        print 'fail to connect to ' + db_file
    return None

def return_data(t_table):
    try:
        for row in c.execute('SELECT *  FROM t_table ORDER BY symbol, price'):
            print '-----------------------------------'
            print row
            for r in row:
                print r
    except Error as e:
            print (e)
    return None

conn = create_connection('example2.db1')

c = conn.cursor()

t_table = 'stocks1'
                
c.execute ('DROP TABLE if exists t_table')

# Create table
c.execute('''CREATE TABLE t_table
             (date text, trans text, symbol text, qty real, price real)''')

# Insert a row of data
c.execute("INSERT INTO t_table VALUES ('2006-01-05','BUY','RHAT',100,35.14)")

# Larger example that inserts many records at a time
purchases = [('2006-03-28', 'BUY', 'IBM', 1000, 45.00),
             ('2006-04-05', 'BUY', 'MSFT', 1000, 72.00),
             ('2006-04-06', 'SELL', 'IBM', 500, 53.00),
            ]
print type(purchases)

c.executemany('INSERT INTO t_table VALUES (?,?,?,?,?)', purchases)

# Save (commit) the changes
conn.commit()

conn.close()

# ------------------------------------------------------------
conn = create_connection('example.db1')

c = conn.cursor()

t = ('RHAT',)
c.execute('SELECT * FROM t_table WHERE symbol=?', t)
print  c.fetchone()

return_data(t_table)

conn.close()

# -------------------------------------------------------------------------

