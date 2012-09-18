from bottle import *
import sys,string,os,subprocess
from random import randint
import re

@route('/')
def index():
    return template("index.tpl",inpt="",outp="")

@route('/macro/:mac#.+#', method='GET')
def macro(mac):
    filepath = "blah"   
    to_process = ""
    filename = ""
    mac = mac.replace("<br>","\n");
    print mac
    if len(mac) == 8 and re.search(r"\d+",mac):
        filepath = './files/' + mac + '.c'
        if os.path.isfile(filepath) == True:
            f = open(filepath,'r')   
            to_process = f.read()
        else:
            return template("index.tpl",inpt="",outp="")
    else:
        for i in range(0,10):
            filename = str(randint(10000000,99999999))
            filepath = './files/' + filename + '.c'
            if os.path.isfile(filepath) == False:
                break
            elif i == 9:
                return "ERROR"
        f = open(filepath,'w')
        f.write(mac)
        f.close()
    p = subprocess.Popen(['gcc','-E',filepath],stdout=subprocess.PIPE)
    out = p.communicate()[0].split('\n')
    ret = ""
    for line in out:
        if line.startswith('#') == False:
            ret += line + '\n'
    if len(to_process) > 0:
        return template("index.tpl",inpt=to_process,outp=ret)
    else:
        ret = filename + "|" + ret
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