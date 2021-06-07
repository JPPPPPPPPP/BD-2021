#!/usr/bin/python3
import cgi

form = cgi.FieldStorage()

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>change designation</title>')
print('</head>')
print('<body>')

# The string has the {}, the variables inside format() will replace the {}
print('<h3>New product info</h3>')

# The form will send the info needed for the SQL query
print('<form action="actuallyAddsProd.cgi" method="post">')
print('<p><input type="hidden" name="ean5" value="{}"/></p>')
print('<p>product ean: <input type="text" name="ean"/></p>')
print('<p>product description: <input type="text" name="descr"/></p>')
print('<p>product category: <input type="text" name="cat_name"/></p>')
print('<p>product primary supplier nif: <input type="text" name="priSuppNif"/></p>')
print('<p>product date of primary supply: <input type="text" name="priSuppDate"/></p>')
print('<p>product 1st secondary supplier nif: <input type="text" name="secSuppNif1"/></p>')
print('<p>product 2nd secondary supplier nif: <input type="text" name="secSuppNif2"/></p>')
print('<p>product 3rd secondary supplier nif: <input type="text" name="secSuppNif3"/></p>')
print('<p><input type="submit" value="Submit"/></p>')
print('</form>')

print('</body>')
print('</html>')
