package = "html-abbrex"
version = "dev-1"

source = {
    url = "git://github.com/rokf/html-abbrex.git"
}

description = {
    summary = "HTML abbrevation expansion",
    homepage = "https://github.com/rokf/html-abbrex",
    maintainer = "Rok Fajfar <snewix7@gmail.com>",
    license = "MIT"
}

dependencies = {
  "lua >= 5.1",
  "lpeg"
}

build = {
    type = "builtin",
    modules = {
      abbrex = "abbrex.lua"
    },
    install = {
      bin = {
        "bin/abbrex"
      }
    }
}
