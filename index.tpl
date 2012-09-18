%#template for the form for a new task
<head>
    <title>Macro Expander</title>
    <link href="/static/Site.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.js"></script>
    <script type="text/javascript" >
        (function () {
            window.onload = function () {
                var oldtext, textbox, timer;
                oldtext = " ";
                textbox = function (id) {
                    return document.getElementById(id);
                };
                return timer = setInterval(
                (function () {
                    var newtext;
                    newtext = textbox("input").value.replace(/\n/g, "<br>").replace(/#/g, "%23");
                    if (newtext !== oldtext) {
                        $.get('process/' + newtext,
                            function (data) {
                                textbox("output").value = data;
                            }
                        );
                    }
                    return oldtext = newtext;
                }), 2000);
            };
        }).call(this);
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
                        <textarea rows="2" cols="20" name="input" id="input" style="font-family:Consolas;height:400px;width:100%;"></textarea>
                    </td>
                    <td style="width:50%;"><span id="t2">preprocessor output</span>
                        <textarea rows="2" cols="20" name="output" id="output" style="font-family:Consolas;height:400px;width:100%;"></textarea>
                    </td>
                </tr>
            </table>
        </form>
    </p>
    </div></div>
</body>

</html>
