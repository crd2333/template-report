#import "@preview/chic-hdr:0.3.0": *
#set page(paper: "a4")

#show: chic.with(
  chic-footer(
    left-side: strong(
        link("mailto:admin@chic.hdr", "admin@chic.hdr")
    ),
    right-side: chic-page-number()
  ),
  chic-header(
    left-side: emph(chic-heading-name()),
    right-side: smallcaps("Example")
  ),
  chic-separator(1pt),
  chic-offset(7pt),
  chic-height(1.5cm)
)
*chic-hdr: 用于创建优雅的页眉和页脚*

= Introduction
#lorem(30)

== Details
#lorem(30)

#v(3em)
#line(length: 100%, stroke: aqua)
*colorful-boxes: 预定义的多彩框*
#import "@preview/colorful-boxes:1.2.0": *
#colorbox(
  title: lorem(5),
  color: "blue",
  radius: 2pt,
  width: auto
)[#lorem(20)]
#outlinebox(
  title: lorem(5),
  color: none,
  width: auto,
  radius: 2pt,
  centering: false
)[#lorem(20)]

#v(3em)
#line(length: 100%, stroke: aqua)
*codelst: 用于渲染源代码的 Typst 包*
#import "@preview/codelst:1.0.0": sourcecode
#sourcecode[```typ
#show "ArtosFlow": name => box[
  #box(image(
    "logo.svg",
    height: 0.7em,
  ))
  #name
]
This report is embedded in the ArtosFlow project. ArtosFlow is a project of the Artos Institute.
```]

#v(3em)
#line(length: 100%, stroke: aqua)
*showybox: 为 Typst 创建丰富多彩且可自定义的框*
#import "@preview/showybox:2.0.1": showybox
#showybox([Hello world!])
#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.lighten(60%),
    body-color: red.lighten(80%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center
  ),
  shadow: (
    offset: 3pt,
  ),
  title: "Red-ish showybox with separated sections!",
  lorem(20),
  lorem(12)
)

#v(3em)
#line(length: 100%, stroke: aqua)
*lovelace: 伪代码书写的算法，没有预定立场，十分灵活*
#import "@preview/lovelace:0.1.0": *
#show: setup-lovelace
#algorithm(
  caption: [The Euclidean algorithm],
  pseudocode(
    no-number,
    [*input:* integers $a$ and $b$],
    no-number,
    [*output:* greatest common divisor of $a$ and $b$],
    [*while* $a != b$ *do*], ind,
      [*if* $a > b$ *then*], ind,
        $a <- a - b$, ded,
      [*else*], ind,
        $b <- b - a$, ded,
      [*end*], ded,
    [*end*],
    [*return* $a$]
  )
)

#v(3em)
#line(length: 100%, stroke: aqua)
*nth: 将英文序数添加到数字中，例如 1st、3nd、2rd、4th*
#import "@preview/nth:0.2.0": nth
#nth(2)\
#nth(3)\
#nth(4)



#v(3em)
#line(length: 100%, stroke: aqua)
*tablex: 在 Typst 中提供更强大和可定制的表格*
#import "@preview/tablex:0.0.5": tablex, gridx, hlinex, vlinex, colspanx, rowspanx
#tablex(
  columns: 4,
  auto-lines: false,
  // skip a column here         vv
  vlinex(), vlinex(), vlinex(), (), vlinex(),
  colspanx(2)[a], (),  [b], [J],
  [c], rowspanx(2)[d], [e], [K],
  [f], (),             [g], [L],
  //   ^^ '()' after the first cell are 100% ignored
)
#tablex(
  columns: 4,
  auto-vlines: false,
  colspanx(2)[a], (),  [b], [J],
  [c], rowspanx(2)[d], [e], [K],
  [f], (),             [g], [L],
)
#gridx(
  columns: 4,
  (), (), vlinex(end: 2),
  hlinex(stroke: yellow + 2pt),
  colspanx(2)[a], (),  [b], [J],
  hlinex(start: 0, end: 1, stroke: yellow + 2pt),
  hlinex(start: 1, end: 2, stroke: green + 2pt),
  hlinex(start: 2, end: 3, stroke: red + 2pt),
  hlinex(start: 3, end: 4, stroke: blue.lighten(50%) + 2pt),
  [c], rowspanx(2)[d], [e], [K],
  hlinex(start: 2),
  [f], (),             [g], [L],
)

#v(3em)
#line(length: 100%, stroke: aqua)
*tbl: 简洁编写复杂的表格*
#import "@preview/tbl:0.0.4"
#show: tbl.template.with(box: true, tab: "|")

```tbl
      R | L
      R   N.
software|version
_
     AFL|2.39b
    Mutt|1.8.0
    Ruby|1.8.7.374
TeX Live|2015
```

#v(3em)
#line(length: 100%, stroke: aqua)
*syntree: 用于渲染语言学中的语法树/解析树*
#import "@preview/syntree:0.2.0": syntree
#syntree(
  nonterminal: (font: "Linux Biolinum"),
  terminal: (fill: blue),
  child-spacing: 3em, // default 1em
  layer-spacing: 2em, // default 2.3em
  "[S [NP This] [VP [V is] [^NP a wug]]]"
)

#v(3em)
#line(length: 100%, stroke: aqua)
*使用 graphviz dot 语言生成图形的工具*
#import "@preview/gviz:0.1.0": *

#show raw.where(lang: "dot-render"): it => render-image(it.text)

```dot-render
digraph mygraph {
  node [shape=box];
  A -> B;
  B -> C;
  B -> D;
  C -> E;
  D -> E;
  E -> F;
  A -> F [label="one"];
  A -> F [label="two"];
  A -> F [label="three"];
  A -> F [label="four"];
  A -> F [label="five"];
}```

#let my-graph = "digraph {A -> B}"
#render-image(my-graph, width: 10%)

SVG:
#box(clip: true, width: 100%, height: 20em)[
#raw(render(my-graph), block: true, lang: "svg")
]

#v(3em)
#line(length: 100%, stroke: aqua)
做 slides，用 #link("https://github.com/typst/packages/tree/main/packages/preview/touying/0.3.1")[#text(fill: blue)[投影touying]]

