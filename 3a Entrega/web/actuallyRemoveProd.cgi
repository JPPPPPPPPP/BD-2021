#!/usr/bin/python3
import psycopg2, cgi

import login

form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
ean = form.getvalue('ean')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>updateDescr</title>')
print('</head>')
print('<body>')

connection = None

try:
	# Creating connection
	connection = psycopg2.connect(login.credentials)
	cursor = connection.cursor()
	
	#removing suppliers
	sql1 = 'DELETE FROM primary_supplier WHERE ean = %s;'
	data1 = (ean,)
	print('<p>{}</p>'.format(sql1 % data1))
	cursor.execute(sql1, data1)
	
	sql2 = 'DELETE FROM secondary_supplier WHERE ean = %s;'
	data2 = (ean,)
	print('<p>{}</p>'.format(sql2 % data2))
	cursor.execute(sql2, data2)

	sql4 = 'DELETE FROM replenishment_event WHERE ean = %s;'
	data4 = (ean,)
	print('<p>{}</p>'.format(sql4 % data4))
	cursor.execute(sql4, data4)
    
	sql3 = 'DELETE FROM planogram WHERE ean = %s;'
	data3 = (ean,)
	print('<p>{}</p>'.format(sql3 % data3))
	cursor.execute(sql3, data3)
    

	#removing product
	sql = 'DELETE FROM product WHERE ean = %s;'
	data = (ean,)
	# The string has the {}, the variables inside format() will replace the {}
	print('<p>{}</p>'.format(sql % data))
	# Feed the data to the SQL query as follows to avoid SQL injection
	cursor.execute(sql, data)

	# Commit the update (without this step the database will not change)
	connection.commit()

	# Closing connection
	cursor.close()
except Exception as e:
	# Print errors on the webpage if they occur
	print('<h1>An error occurred.</h1>')
	print('<p>{}</p>'.format(e))
finally:
	if connection is not None:
		connection.close()
