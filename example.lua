local abbrex = require 'abbrex'

print(abbrex('div#main>ul.a-list>li.list-item.also-item*3>area#an-area',2))

print(abbrex('html>head>title{Hello}',2))

print(abbrex('html>body>main.container>article*3>p{Article}',2))
