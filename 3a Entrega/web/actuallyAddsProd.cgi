#!/usr/bin/python3
import psycopg2, cgi

import login

form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
ean = form.getvalue('ean')
descr = form.getvalue('descr')
cat_name = form.getvalue('cat_name')
priSuppNif = form.getvalue('priSuppNif')
priSuppDate = form.getvalue('priSuppDate')
secSuppNif1 = form.getvalue('secSuppNif1')
secSuppNif2 = form.getvalue('secSuppNif2')
secSuppNif3 = form.getvalue('secSuppNif3')

"""
ean = "4567890123123"
descr = "ting"
cat_name = "Milk"
priSuppNif = "121212121"
priSuppDate = "2020-08-21"
secSuppNif1 = "232323232"
secSuppNif2 = "343434343"
secSuppNif3 = ""
"""

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
	
	#adding product
	sql = 'INSERT INTO product values(%s, %s, %s);'
	data = (ean, descr, cat_name)
	print('<p>{}</p>'.format(sql % data))
	cursor.execute(sql, data)

	#adding primary supp
	sql = 'INSERT INTO primary_supplier values(%s, %s, %s);'
	data = (priSuppNif, ean, priSuppDate)
	print('<p>{}</p>'.format(sql % data))
	cursor.execute(sql, data)

	#adding secondary supp(s)
	sql = 'INSERT INTO secondary_supplier values(%s, %s);'
	data = (secSuppNif1, ean)
	print('<p>{}</p>'.format(sql % data))
	cursor.execute(sql, data)

	if(secSuppNif2 != None):
		sql = 'INSERT INTO secondary_supplier values(%s, %s);'
		data = (secSuppNif2, ean)
		print('<p>{}</p>'.format(sql % data))
		cursor.execute(sql, data)

	if(secSuppNif3 != None):
		sql = 'INSERT INTO secondary_supplier values(%s, %s);'
		data = (secSuppNif3, ean)
		print('<p>{}</p>'.format(sql % data))
		cursor.execute(sql, data)

	# The string has the {}, the variables inside format() will replace the {}
	print('<p>{}</p>'.format(sql % data))

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
