<h2 align="center">abbrex</h2>

This is a tool & module which expands HTML abbreviations into indented HTML markup.

It is meant to be used in editors to simplify writing HTML.

It contains a Lua module named `abbrex` and an executable script with the same name,
which can be used from the terminal (it uses the module).

It depends on `LPeg.re` which is used for abbreviation parsing.

#### Abbreviations

They are very similar to those in `Emmet`.

- **#** produces an `id`
- **.** appends a `class`
- **{}** translates into text
- **>** is used for nesting
- **\*N** repeats the element (with everything it contains) N times

#### Installation

`sudo luarocks install html-abbrex-dev-1.rockspec`

This will install both the module and executable.

#### Usage

For the module, check and run the `example.lua` file.

The executable script has a `-h` argument option which gives a short description.
It works as a filter and uses pipes. You pipe the abbreviation from another command
and it poops out the generated HTML.
