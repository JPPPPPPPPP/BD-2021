#!/usr/bin/python3
import psycopg2

import login

import cgi

form = cgi.FieldStorage()

super_name = form.getvalue('cat_name')
#super_name = 'supersuper'
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>list of events</title>')
print('</head>')
print('<body>')
print('<h1>Subcategories for {}</h1>'.format(super_name))

connection = None

try:
	# Creating connection
	connection = psycopg2.connect(login.credentials)
	cursor = connection.cursor()

	# Making query spacing is weird but if it wasnt like this it doesnt run
	sql = 'SELECT * FROM simple_category;'
	data = (super_name,)
	cursor.execute(sql)
	result = cursor.fetchall()
	num = len(result)


	# Displaying results
	print('<p>{} record(s) retrieved:</p>'.format(num))
	print('<table border="5">')
	print('<tr><td>subcategories of {}</td></tr>'.format(super_name))
	for row in result:
		print('<tr>')
		if(row[1] == super_name):
		        print('<td> %s </td>' % row[0])
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
