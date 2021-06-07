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
print('<form action="actuallyAddsSimple.cgi" method="post">')
print('<p><input type="hidden" name="ean5" value="{}"/></p>')
print('<p>cat_name: <input type="text" name="cat_name"/></p>')
print('<p>super_name: <input type="text" name="super_name"/></p>')
print('<p><input type="submit" value="Submit"/></p>')
print('</form>')

print('</body>')
print('</html>')