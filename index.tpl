%#template for the form for a new task
<head>
    <title>Macro Expander</title>
    <link href="/static/Site.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.js"></script>
    <script type="text/javascript" >
        function sub() {
            var newtext = textinp("input").value.replace(/\n/g, "<br>").replace(/#/g, "%23");
            $.get('/macro/' + newtext,
                function (data) {
                    var split_data = data.split("|");
                    textinp("output").value = split_data[1];
                    var link = "http://" + window.location.hostname + '/macro/' + split_data[0];
                    $("#permalink").html("Permalink: <a href=\"" + link + "\">" + link + "</a>")
                }
            );
        }
        textinp = function (id) {
            return document.getElementById(id);
        }; 
    </script>

</head>
<body>
    <div class="page">
        <div class="main">
            <h2>
                C/C++ Macro Expander
            </h2>
            <p>
                <form name="expander" action="">
                    <table id="Table1" cellspacing="3" cellpadding="3" style="width:100%;">
                        <tr>
                            <td style="width:50%;"><span id="t1">code on this side</span>
                                <textarea rows="2" cols="20" name="input" id="input" style="font-family:Consolas;height:400px;width:100%;">{{inpt}}</textarea>
                            </td>
                            <td style="width:50%;"><span id="t2">preprocessor output</span>
                                <textarea rows="2" cols="20" name="output" id="output" style="font-family:Consolas;height:400px;width:100%;">{{outp}}</textarea>
                            </td>
                        </tr>
                    </table>
                    <center><input id="b1" type="button" value="Submit" onclick="sub();" /><br>
                    <label name="permalink" id="permalink" style="font-family:Consolas;height:400px;width:100%;"></label></center>
                </form>
            </p>
        </div>
    </div>
</body>

</html>