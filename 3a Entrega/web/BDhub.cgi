#!/usr/bin/python3
import psycopg2

import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>product.cgi</title>')
print('</head>')
print('<body>')

print('<h1>Choose what you want to do:</h1>')
print('<table border="5">')
	
#Options
print('<tr><td><a href="addRemCat.cgi">Insert and remove categories and sub-categories</a></td></tr>')
print('<tr><td><a href="addRemProd.cgi">Insert and remove a new product and its respective suppliers (primary or secondary)</a></td></tr>')
print('<tr><td><a href="listReplenish.cgi">List replenishment events for a given product, including the number of replenished units</a></td></tr>')
print('<tr><td><a href="product.cgi">Change the designation of a product</a></td></tr>')
print('<tr><td><a href="listSubCats.cgi">List all the sub-categories of a super-category, at all levels of depth</a></td></tr>')


print('</body>')
print('</html>')
