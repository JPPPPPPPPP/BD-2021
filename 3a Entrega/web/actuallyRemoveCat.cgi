#!/usr/bin/python3
import psycopg2, cgi

import login

form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
cat_name = form.getvalue('cat_name')

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

	# Making query that gets ean of products in the category or sub categories
	sql0 = 'SELECT cat_name FROM simple_category WHERE super_name = %s;'
	data0 = (cat_name,)
	cursor.execute(sql0, data0)
	result0 = cursor.fetchall()
	num0 = len(result0)

	#simple and super cats cant be named the same
	#removing from category and sub category tables
	sql = 'DELETE FROM simple_category WHERE cat_name = %s;'
	data = (cat_name,)
	print('<p>{}</p>'.format(sql % data))
	cursor.execute(sql, data)

	sql = 'DELETE FROM simple_category WHERE super_name = %s;'
	data = (cat_name,)
	print('<p>{}</p>'.format(sql % data))
	cursor.execute(sql, data)

	sql = 'DELETE FROM super_category WHERE super_name = %s;'
	data = (cat_name,)
	print('<p>{}</p>'.format(sql % data))
	cursor.execute(sql, data)

	for simp_cat in result0:
		# Making query that gets ean of products in the category or sub categories
		sql = 'SELECT ean FROM product WHERE cat_name = %s;'
		data = (simp_cat,)
		cursor.execute(sql, data)
		result = cursor.fetchall()
		num = len(result)

		#remving products
		for row in result:
			for value in row:
				#removing suppliers
				sql1 = 'DELETE FROM primary_supplier WHERE ean = %s;'
				data1 = (value,)
				print('<p>{}</p>'.format(sql1 % data1))
				cursor.execute(sql1, data1)
				
				sql2 = 'DELETE FROM secondary_supplier WHERE ean = %s;'
				data2 = (value,)
				print('<p>{}</p>'.format(sql2 % data2))
				cursor.execute(sql2, data2)

				#remove replenish
				sql4 = 'DELETE FROM replenishment_event WHERE ean = %s;'
				data4 = (value,)
				print('<p>{}</p>'.format(sql4 % data4))
				cursor.execute(sql4, data4)
			    
			    #remove planogram
				sql3 = 'DELETE FROM planogram WHERE ean = %s;'
				data3 = (value,)
				print('<p>{}</p>'.format(sql3 % data3))
				cursor.execute(sql3, data3)
	    		
	    		#removing product
				sql = 'DELETE FROM product WHERE ean = %s;'
				data = (value,)
				# The string has the {}, the variables inside format() will replace the {}
				print('<p>{}</p>'.format(sql % data))
				# Feed the data to the SQL query as follows to avoid SQL injection
				cursor.execute(sql, data)
			#end for
		#end for
		sql7 = 'DELETE FROM category WHERE cat_name = %s;'
		data7 = (simp_cat,)
		print('<p>{}</p>'.format(sql7 % data7))
		cursor.execute(sql7, data7)
	#end for
	
	sql = 'SELECT ean FROM product WHERE cat_name = %s;'
	data = (cat_name,)
	cursor.execute(sql, data)
	result = cursor.fetchall()
	num = len(result)
	#remving products
	for row in result:
		for value in row:
			#removing suppliers
			sql1 = 'DELETE FROM primary_supplier WHERE ean = %s;'
			data1 = (value,)
			print('<p>{}</p>'.format(sql1 % data1))
			cursor.execute(sql1, data1)
			
			sql2 = 'DELETE FROM secondary_supplier WHERE ean = %s;'
			data2 = (value,)
			print('<p>{}</p>'.format(sql2 % data2))
			cursor.execute(sql2, data2)
	
			#remove replenish
			sql4 = 'DELETE FROM replenishment_event WHERE ean = %s;'
			data4 = (value,)
			print('<p>{}</p>'.format(sql4 % data4))
			cursor.execute(sql4, data4)
		    
		    #remove planogram
			sql3 = 'DELETE FROM planogram WHERE ean = %s;'
			data3 = (value,)
			print('<p>{}</p>'.format(sql3 % data3))
			cursor.execute(sql3, data3)
    		
	   		#removing product
			sql = 'DELETE FROM product WHERE ean = %s;'
			data = (value,)
			# The string has the {}, the variables inside format() will replace the {}
			print('<p>{}</p>'.format(sql % data))
			# Feed the data to the SQL query as follows to avoid SQL injection
			cursor.execute(sql, data)
		#end for
	#end for

	#removing category
	sql = 'DELETE FROM category WHERE cat_name = %s;'
	data = (cat_name,)
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
