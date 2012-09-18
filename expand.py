from bottle import *
import sys,string,os,subprocess
from random import randint
import re

@route('/')
def index():
    return template("index.tpl")

@route('/process/:mac#.+#', method='GET')
def process(mac):
    filename = "blah"
    to_process = ""
    mac = mac.replace("<br>","\n");
    # TODO: support permalinks
    if False: #len(mac) == 6 and re.search(r"\d+",mac):
        filename = './files/' + mac + '.c'
        if os.path.isfile(filename) == True:
            f = open(filename,'r')   
            to_process = f.read()
        else:
            return template("index.tpl")
    else:
        count = 0
        for i in range(0,10):
            filename = './files/' + str(randint(100000,999999)) + '.c'
            if os.path.isfile(filename) == False:
                break
            elif i == 9:
                return "ERROR"
        f = open(filename,'w')
        f.write(mac)
        f.close()
    p = subprocess.Popen(['gcc','-E',filename],stdout=subprocess.PIPE)
    out = p.communicate()[0].split('\n')
    #os.remove(filename)
    ret = ''
    for line in out:
        if line.startswith('#') == False:
            ret += line + '\n'
    return ret


@route('/static/:path#.+#', name='static')
def static(path):
    return static_file(path, root='static')

@error(403)
def mistake403(code):
    return 'There is a mistake in your url!'

@error(404)
def mistake404(code):
    return 'Sorry, this page does not exist!'

debug(True)
run(reloader=True,host='192.168.1.101', port=80)