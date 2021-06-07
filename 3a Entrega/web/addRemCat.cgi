#!/usr/bin/python3
import psycopg2

import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>product.cgi</title>')
print('</head>')
print('<body>')

connection = None
try:
	# Creating connection
	connection = psycopg2.connect(login.credentials)
	print('<p>Connected to Postgres with: {}.</p>'.format(login.credentials[:51]))
	cursor = connection.cursor()

	# Making query
	sql = 'SELECT * FROM category;'
	cursor.execute(sql)
	result = cursor.fetchall()
	num = len(result)

	# Displaying results
	print('<p>{} records retrieved:</p>'.format(num))
	print('<table border="5">')
	print('<tr><td>category name</td></tr>')
	for row in result:
		print('<tr>')
		for value in row:
		# The string has the {}, the variables inside format() will replace the {}
			print('<td>{}</td>'.format(value))
		print('<td><a href="actuallyRemoveCat.cgi?cat_name={}">Remove</a></td>'.format(row[0]))
		print('</tr>')
	print('</table>')

	print('<h1><a href="newCategoryForm.cgi">Add a new category</a></h1>')
	print('<h1><a href="newSubCategoryForm.cgi">Add a new sub category</a></h1>')
	
	#Closing connection
	cursor.close()

except Exception as e:
	print('<h1>An error occurred.</h1>')
	print('<p>{}</p>'.format(e))
finally:
	if connection is not None:
		connection.close()

print('</body>')
print('</html>')
