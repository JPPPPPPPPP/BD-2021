#!/usr/bin/python3
import psycopg2, cgi

import login

form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
super_name = form.getvalue('super_name')
cat_name = form.getvalue('cat_name')

#super_name = "supersuper"

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
	
	#adding into category
	sql = 'INSERT INTO category values(%s);'
	data = (cat_name,)
	print('<p>{}</p>'.format(sql % data))
	cursor.execute(sql, data)

	##adding into super category
	sql = 'INSERT INTO simple_category values(%s, %s);'
	data = (cat_name, super_name)
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
