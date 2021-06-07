#!/usr/bin/python3
import psycopg2

import login

import cgi

form = cgi.FieldStorage()

ean = form.getvalue('ean')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>list of events</title>')
print('</head>')
print('<body>')
print('<h1>Replenishment events for product {}</h1>'.format(ean))

connection = None

try:
	# Creating connection
	connection = psycopg2.connect(login.credentials)
	cursor = connection.cursor()

	# Making query spacing is weird but if it wasnt like this it doesnt run
	sql = 'SELECT	nif,	units	FROM	replenishment_event	WHERE	ean = {};'.format(ean)
	cursor.execute(sql)
	result = cursor.fetchall()
	num = len(result)


	# Displaying results
	print('<p>{} record(s) retrieved:</p>'.format(num))
	print('<table border="5">')
	print('<tr><td>supermarket nif</td><td>units</td></tr>')
	for row in result:
		print('<tr>')
		for value in row:
		# The string has the {}, the variables inside format() will replace the {}
			print('<td>{}</td>'.format(value))
		print('</tr>')
	print('</table>')
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
