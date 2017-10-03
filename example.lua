local abbrex = require 'abbrex'
local txt = 'div#main>ul.a-list>li.list-item.also-item*3>a{Content here}'

print(abbrex(txt,2))
