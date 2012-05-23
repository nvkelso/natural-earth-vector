from sys import argv
from zipfile import ZipFile
from os.path import splitext
from re import match

if __name__ == '__main__':
    
    file = ZipFile(argv[1], 'r')
    
    try:
        info = file.open('info.txt', 'r')
    except:
        print 'no info', argv[1]
        exit(0)
    
    lines = info.read().strip().split('\n')
    
    info, fields = [], []
    
    for line in lines:
        parts = match(r'^(.+?):( (.+))?$', line)
        
        if not parts:
            break
        
        field, value = parts.group(1), parts.group(3)
        
        if field == 'Layer SRS WKT':
            break
        
        info.append((field, value))
            
    for line in reversed(lines):
        parts = match(r'^(.+?): (.+)$', line)
        
        if not parts:
            break
        
        field, value = parts.group(1), parts.group(2)
        fields.insert(0, (field, value))
    
    out = open(splitext(argv[1])[0] + '.html', 'w')
    
    try:
        title = dict(info).get('Layer name').replace('_', ' ').title()
    except:
        print 'no title', argv[1]
        exit(0)
    
    print >> out, '''<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>%(title)s</title>
</head>
<body>
    <h1>%(title)s</h1>
    <dl>''' % locals()

    for (field, value) in info:
        print >> out, '<dt>%(field)s</dt><dd>%(value)s</dd>' % locals()
    
    print >> out, '''<dt>Fields</dt><dd><dl>'''
    
    for (field, value) in fields:
        print >> out, '<dt>%(field)s</dt><dd>%(value)s</dd>' % locals()
    
    print >> out, '''</dl></dd></dl></body></html>'''
