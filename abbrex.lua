local re = require 're'

local empty = {
  ['area'] = true,
  ['base'] = true,
  ['br'] = true,
  ['col'] = true,
  ['embed'] = true,
  ['hr'] = true,
  ['img'] = true,
  ['input'] = true,
  ['keygen'] = true,
  ['link'] = true,
  ['meta'] = true,
  ['param'] = true,
  ['source'] = true,
  ['track'] = true,
  ['wbr'] = true
}

local abbrex = {}

setmetatable(abbrex, {
  __call = function (_,abbr,idt)

    local idt_sum = 0
    for _,_ in string.gmatch(abbr, '>') do
      idt_sum = idt_sum + idt
    end

    local patt = re.compile([[
    EXPR <- {| {:el: IDENT :} CLASSID AMMOUNT? TEXT? ('>' {:nested: EXPR :})? |}
      -> transform_data
    CLASSID <- ({| ('#' {:id: IDENT :}) / ('.' {:class: IDENT :}) |})*
    TEXT <- '{' {:text: [^}]* :} '}'
    AMMOUNT <- '*' {:ammount: %d+ :}
    IDENT <- [%w%-]+
    ]],{
      transform_data = function (data)
        local classes = {}
        local id = ""
        for _,v in ipairs(data) do
          if v.class then
            table.insert(classes,v.class)
          elseif v.id then
            id = v.id
          end
        end
        local class_str = (#classes > 0) and
          string.format(' class="%s"', table.concat(classes,' ')) or ""
        local id_str = (#id > 0) and string.format(' id="%s"', id) or ""
        local nested_text = data.nested or (data.text and
          string.rep(' ',idt_sum+idt) ..
          data.text ..
          (idt == 0 and "" or "\n") or nil) or ""
        local str
        if empty[data.el] then
          str = string.format('%s<%s%s%s>%s',
            string.rep(' ',idt_sum),
            data.el,
            id_str,
            class_str,
            idt == 0 and "" or "\n"
          )
        else
          str = string.format('%s<%s%s%s>%s%s%s</%s>%s',
            string.rep(' ',idt_sum),
            data.el,
            id_str,
            class_str,
            idt == 0 and "" or "\n",
            nested_text,
            string.rep(' ',idt_sum),
            data.el,
            idt == 0 and "" or "\n"
          )
        end
        idt_sum = idt_sum - idt
        return string.rep(str,data.ammount and tonumber(data.ammount) or 1,
          idt == 0 and "" or "\n")
      end
    })
    return patt:match(abbr)
  end
})

return abbrex
