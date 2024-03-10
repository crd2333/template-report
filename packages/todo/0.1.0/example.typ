#align(center, heading([Typst Todo], outlined: false))

#set heading(numbering: "1.")

#outline(indent: true)

#import "./lib.typ": todo, missing_figure, list_of_todos

#let itodo = todo.with(inline:true)

#list_of_todos(numbers:"1.1:")

= On some content

#todo[Add some content]

== Todo with note text

#todo(note: [test])[some text that needs fixing]

#todo(note: [bad header])[#heading([todonotes are ok, I guess], level:2)]

== Works with columns too

#box(height:5em)[
#columns(2)[
  #lorem(10)
  #todo(note: [left column])[this text is in the left column]
  #lorem(10)
  #todo(note: [right column])[this text is in the right column]
  #lorem(10)
]]

= Inline

#todo(inline: true)[Add some content]

== Using a shortcut, and with colour

#itodo(fill:blue)[an itodo]

== And with some numbers

#itodo(numbers: "1.1")[a numbered inline todo]

== But can't specify a note

```typst
#todo(inline: true, note: "test note")[broken] // error
```

== A very long todo, only the first line is shown in the list_of_todos

#itodo(numbers: "1.1")[#lorem(50)]

#itodo(numbers: "1.1")[Something big is coming

#lorem(50)]

= Todo figures too

#missing_figure[my pretty graph]