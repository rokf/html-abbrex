
local abbrex = require 'abbrex'

describe('the abbrex module', function ()
  it('should produce correct output without indentation', function ()
    for k,v in pairs ({
      ['html>head'] = '<html><head></head></html>',
      ['div.a-class#an-id>ul.list>li{list element}'] =
        '<div id="an-id" class="a-class"><ul class="list"><li>list element</li></ul></div>'
    }) do
      assert.is_equal(v, abbrex(k,0))
    end
  end)

  it('should correctly produce multiple nested children without indentation', function ()
    assert.is_equal('<ul><li>Child</li><li>Child</li><li>Child</li></ul>',
      abbrex('ul>li*3{Child}',0))
    assert.is_equal('<main class="container"><article class="article">article</article><article class="article">article</article></main>',
      abbrex('main.container>article.article*2{article}',0))
  end)

  it('should produce correct output when the class and id are the same', function ()
    assert.is_equal('<div id="div-id" class="div-class"></div>',
      abbrex('div.div-class#div-id',0))
    assert.is_equal('<ul id="ul" class="ul"><li id="li" class="li"></li></ul>',
      abbrex('ul.ul#ul>li#li.li',0))
  end)
end)
