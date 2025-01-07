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

\
\
\
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

\
\
\
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

\
\
\
*showybox: 为 Typst 创建丰富多彩且可自定义的框*
#import "@preview/showybox:2.0.3": showybox
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

\
\
\
*easy-pinyin: 轻松编写汉语拼音*
#import "@preview/easy-pinyin:0.1.0": pinyin, zhuyin
汉（#pinyin[ha4n]）语（#pinyin[yu3]）拼（#pinyin[pi1n]）音（#pinyin[yi1n]）。
#let per-char(f) = [#f(delimiter: "|")[汉|语|拼|音][ha4n|yu3|pi1n|yi1n]]
#let per-word(f) = [#f(delimiter: "|")[汉语|拼音][ha4nyu3|pi1nyi1n]]
#let all-in-one(f) = [#f[汉语拼音][ha4nyu3pi1nyi1n]]
#let example(f) = (per-char(f), per-word(f), all-in-one(f))
// argument of scale and spacing
#let arguments = ((0.5, none), (0.7, none), (0.7, 0.1em), (1.0, none), (1.0, 0.2em))
#table(
  columns: (auto, auto, auto, auto),
  align: (center + horizon, center, center, center),
  [arguments], [per char], [per word], [all in one],
  ..arguments.map(((scale, spacing)) => (
    text(size: 0.7em)[#scale,#repr(spacing)],
    ..example(zhuyin.with(scale: scale, spacing: spacing))
  )).flatten(),
)

\
\
\
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

\
\
\
*nth: 将英文序数添加到数字中，例如 1st、3nd、2rd、4th*
#import "@preview/nth:0.2.0": nth
#nth(2)\
#nth(3)\
#nth(4)

// \
// \
// \
// *lemmify: 定理排版*
// #import "@preview/lemmify:0.1.4": *
// #let my-thm-style(
//   thm-type, name, number, body
// ) = grid(
//   columns: (1fr, 3fr),
//   column-gutter: 1em,
//   stack(spacing: .5em, strong(thm-type), number, emph(name)),
//   body
// )
// #let my-styling = (
//   thm-styling: my-thm-style
// )
// #let (
//   theorem, rules
// ) = default-theorems("thm-group", lang: "en", ..my-styling)
// #show: rules
// #show thm-selector("thm-group"): box.with(inset: 1em)
// #lorem(20)
// #theorem[
//   #lorem(40)
// ]
// #lorem(20)
// #theorem(name: "Some theorem")[
//   #lorem(30)
// ]

\
\
\
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

\
\
\
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

\
\
\
*用于渲染语言学中的语法树/解析树*
#import "@preview/syntree:0.2.0": syntree
#syntree(
  nonterminal: (font: "Linux Biolinum"),
  terminal: (fill: blue),
  child-spacing: 3em, // default 1em
  layer-spacing: 2em, // default 2.3em
  "[S [NP This] [VP [V is] [^NP a wug]]]"
)

\
\
\
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

\
\
\
*polylux: 使用 Typst 制作演示幻灯片*
#import "@preview/polylux:0.3.1": *
#import themes.simple: *
#set text(font: "Inria Sans")
#show: simple-theme.with(
  footer: [Simple slides],
)
#title-slide[
  = Keep it simple!
  #v(2em)

  Alpha #footnote[Uni Augsburg] #h(1em)
  Bravo #footnote[Uni Bayreuth] #h(1em)
  Charlie #footnote[Uni Chemnitz] #h(1em)

  July 23
]
#slide[
  == First slide

  #lorem(20)
]
#focus-slide[
  _Focus!_

  This is very important.
]
#centered-slide[
  = Let's start a new section!
]
#slide[
  == Dynamic slide
  Did you know that...

  #pause
  ...you can see the current section at the top of the slide?
]