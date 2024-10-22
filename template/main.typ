#import "../lib.typ": *

#show: project.with(
  title: "Test Title",
  title_2: "Project 1",
  author: ("crd233", "张三"),
  date: (2024, 2, 30),
  cover_style: "report",   // report, report1, report2, report3 或其它，false 或 "" 表示无封面
  header: "type1", // true or "type1" 使用默认页眉，"type2" 为一个略详细一点的页眉
  footer: "type1",
  show_toc: true,
  show_name: true,   // 是否匿名
  lang: "zh",   // 支持切换语言为 en、zh，会连带更改日期格式、图表标题等
)

= 大标题测试

== 小标题测试

=== 三级标题测试 <title>

引用标题@title

== 文字测试

=== 关于字体
字体：先在"Arial"中寻找，找不到才在黑体、宋体等中文字体中寻找，通过这种方法实现*先英文字体、后中文字体*的效果。这个字体可以先去搜索下载（#link("https://github.com/notofonts/noto-cjk/releases")[下载链接]，下载Noto Serif CJK和Noto Sans CJK），或者直接在终端中输入"typst fonts"查看你电脑上的字体，然后修改`font.typ`相关内容为你拥有且喜爱的字体。

English test: Let's have a try! And
this is a dot. This is a quote "". 英文标点也是正常显示。

_斜体_与*粗体*，_Italic_ and *bold*。但是中文没有斜体（事实上，如果字体选择不佳，连粗体都没有），一般用楷体代替 ```typ #show emph: text.with(font: ("Arial", "LXGW WenKai"))```

如果需要真正的斜体，可以使用伪斜体（旋转得到，可能会有 bug？）：#fake-italic[中文伪斜体]。

中英文字体之间正常情况下会自动添加空格，像这样test一下。手动添加空格也可以（对Arial和思源字体而言），像这样 test 一下，间隙增加可以忽略不计。如果换用其它字体，可能会出现手动空格导致间隙过大的情况。

=== 关于缩进
使用一个比较 tricky 的包 #link("https://github.com/flaribbit/indenta")[indenta] 来达到类似 LaTeX 中的缩进效果：两行文字间隔一行则缩进，否则不缩进。可能会遇到一些 bug，此时可以使用```typ #noindent[Something]```来取消缩进，比如下面这样：

#hline()

#noindent[
  这是一个没有缩进的段落。

  空一行，本来应该缩进，但被取消。\
  采用连接符换行。
]

#hline()

而在原始情况下是这样：

这是一个有缩进的段落。

空一行，缩进，但被取消。
不空行，视为跟之前同一段落。\
采用连接符换行。
#hline()

#indent 另外，通过 `#indent`（或 `#tab`）能缩进内容，在 indenta 失效时可以使用。

== 图表测试
=== 图片
#fig(caption: "测试图片, 浙江大学", "../assets/校名.jpg") <test>

图片测试引用 @test

=== 公式
Given an $N times N$ integer matrix $(a_(i j))_(N times N)$, find the maximum value of $sum_(i=k)^m sum_(j=l)^n a_(i j)$ for all $1 <= k <= m <= N$ and $1 <= l <= n <= N$.

$ F_n = floor(1 / sqrt(5) phi.alt^n) $ <fib>
$ F_n = floor(1 / sqrt(5) phi.alt^n) $ <->

引用公式Fibonacci: @fib。添加 `<->` 后不再有编号和计数，但也不能引用了。

为了更加简化符号输入，有这么一个包 #link("https://github.com/typst/packages/tree/main/packages/preview/quick-maths/0.1.0")[quick-maths]，定义一些快捷方式，比如：

```typ
#show: shorthands.with(
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
  ($<=$, math.arrow.l.double) // Replaces '≤', use =< as '≤'
)
```

$ x^2 = 9 quad <==> quad x = +-3 $
$ A or B |- A $
$ x <= y $

=== 代码
code使用codly实现，会自动捕捉所有成块原始文本，像下面这样，不一定非要调用code命令（调用code命令则是套一层 figure，加上 caption）。

#no-codly[
  ```raw
  disabled code
  ```
]
```raw
enabled code
```

#strike[代码块经过特殊处理，注释内的斜体、粗体、数学公式会启用 eval]。感觉经常遇到 bug，先禁用了（`lib.typ` 中 ```typ // show raw: comment_process```）
```cpp
cout << "look at the comment" << endl; // _italic_, *bold*, and math $sum$
```
#code(
  caption: "This is a code listing",
)[
  ```c
  #include <stdio.h>
  int main() {
    printf("Hello World!");
    return 0;
  }
  ```
] <code>

引用 @code

=== 表格
表格通过原生 table 封装到 figure 中，并添加自动数学环境参数：```typ automath: true```，通过正则表达式检测数字并用 `$` 包裹。
#tbl(
  automath: true,
  caption: "《计算机组成》：Multiplier",
  fill: (x, y) => if y == 0 {aqua.lighten(40%)},
  columns: 4,
  [Iteration],[Step],[Multiplicand],[Product / Multiplicator],
  [0],[initial values],[01100010],[00000000 00010010],
  table.cell(rowspan: 2)[1],[0 $=>$ no op],[01100010],[00000000 00010010],
  [shift right],[01100010],[00000000 00001001],
  table.cell(rowspan: 2)[2],[1 $=>$ prod += Mcand],[01100010],[01100010 00001001],
  [shift right],[01100010],[00110001 00000100],
  table.cell(rowspan: 2)[3],[0 $=>$ no op],[01100010],[00110001 00000100],
  [shift right],[01100010],[00011000 10000010],
  table.cell(colspan: 4)[......]
)

#align(center, (stack(dir: ltr)[
  #tbl(
    // automath: true,
    fill: (x, y) => if y == 0 {aqua.lighten(40%)},
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
    caption: [常规表],
  ) <timing>
  ][
    #h(50pt)
  ][
  #tlt(
    // automath: true,
    columns: 4,
    [t], [1], [2], [3],
    [y], [123.123s], [0.4s], [0.8s],
    caption: [三线表],
  ) <timing-tlt>
]))

引用@timing，引用@timing-tlt。

由于习惯了 markdown 的表格，所以 typst 的表格语法可能不太习惯（其实强大很多），但是也有类 markdown 表格 package 的实现：
#tblm(caption: "tablem 实现的类 markdown 表格")[
  | *Name* | *Location* | *Height* | *Score* |
  | ------ | ---------- | -------- | ------- |
  | John   | Second St. | 180 cm   |  5      |
  | Wally  | Third Av.  | 160 cm   |  10     |
]

使用 typst 的数据加载语法，可以读取 csv, json 等格式的数据，以此实现了一些更加快捷（但比较简单，如果要支持合并单元格之类则较困难）的表格。比如下面这个 csv 表格：
#csvtable(
  caption: "CSV Table",
  ```
  1,2,3
  4,5,6
  ```
)

= Chapter 2 <caption_2>
#fig("../assets/校名.jpg", caption: "测试图片, 浙江大学", width: 50%) <test2>

图片测试引用 @test2，可以看到现在的编号是 2 开头。

== 列表
Bubble list 语法（更改了图标，使其更类似 markdown，且更大）和 enum 语法：
- 你说
  - 得对
    - 但是
      - 原神
+ 是一款
+ 由米哈游
  + 开发的
  + 开放世界
    + 冒险
    + 游戏

Term list 语法：
/ a: Something
/ b: Something

== 添加脚注
我们可以添加一个脚注。#footnote[脚注内容]

== 参考文献
可以像这样引用参考文献：@wang2010guide 和 @kopka2004guide。

== 其它工具
从第三方包中（or自己编写）预先挑选了一些比较实用的工具，比如：

=== Fletcher
Typst 中的 cetz 就像 LaTeX 中的 tikz 一样，提供强大的画图功能，但是个人感觉略繁琐。#link("https://github.com/Jollywatt/typst-fletcher")[Fletcher] 基于 cetz 提供了 diagrams with arrows 的简单画法。

#import fletcher.shapes: diamond
#diagram(
  node-stroke: .1em,
  node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),
  spacing: 4em,
  edge((-1,0), "r", [open(path)], label-pos: 0, label-side: center),
  node((0,0), [reading], radius: 2em),
  edge([read()]),
  node((1,0), [eof], radius: 2em),
  edge([close()]),
  node((2,0), [closed], radius: 2em, extrude: (-2.5, 0)),
  edge((0,0), (0,0), [read()], marks: "--|>", bend: 130deg),
  edge((0,0), (2,0), [close()], bend: -40deg),
)
#align(center, grid(
  columns: 3,
  gutter: 8pt,
  diagram(cell-size: 15mm, $
    G edge(f) edge("d", pi) & im(f) \
    G slash ker(f) edge("ur", tilde(f))
  $),
  diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0,0), [Start], corner-radius: 2pt, extrude: (0, 3)),
    edge(),
    node((0,1), align(center)[
      Hey, wait,\ this flowchart\ is a trap!
    ], shape: diamond),
    edge("d,r,u,l", [Yes], label-pos: 0.1)
  ),
  diagram($
    e^- edge("rd", marks: "-<|-") & & & edge("ld") e^+ \
    & edge(gamma, "wave") \
    e^+ edge("ru", marks: "-|>-") & & & edge("lu") e^- \
  $)
))

=== syntree & treet
语法树，像这样，可以用字符串解析的方式来写，不过个人更喜欢后一种自己写 `tree` 的方式，通过合理的缩进更加易读。
#let bx(col) = box(fill: col, width: 1em, height: 1em)

#grid(
  columns:2,
  gutter: 4em,
  syntree(
    nonterminal: (font: "Linux Biolinum"),
    terminal: (fill: red),
    child-spacing: 3em, // default 1em
    layer-spacing: 2em, // default 2.3em
    "[S [NP This] [VP [V is] [^NP a wug]]]"
  ),
  tree("colors",
    tree("warm", bx(red), bx(orange)),
    tree("cool", bx(blue), bx(teal)))
)

#tab 文件夹型的树，像这样

#tree-list(root: "root")[
- 1
  - 1.1
  - 1.2
    - 1.2.1
- 2
- 3
  - 3.1
    - 3.1.1
]

=== timeline
#timeline(show-grid: true, caption: "Timeline",
  {
  headerline(group(([*2023*], 4)), group(([*2024*], 4)))
  headerline(
    group(..range(4).map(n => strong("Q" + str(n + 1)))),
    group(..range(4).map(n => strong("Q" + str(n + 1)))),
  )

  taskgroup(title: [*Research*], {
    task("Research the market", (0, 2), style: (stroke: 2pt + gray))
    task("Conduct user surveys", (1, 3), style: (stroke: 2pt + gray))
  })

  milestone(
    at: 3.75,
    style: (stroke: (dash: "dashed")),
    align(center, [
      *Conference demo*\
      Dec 2023
    ])
  )

  milestone(
    at: 6.5,
    style: (stroke: (dash: "dashed")),
    align(center, [
      *App store launch*\
      Aug 2024
    ])
  )
})

=== emojis
直接使用(directly): 😆🛖🐡

内置表情(built-in emoji namespace): `#emoji.rocket` #emoji.rocket

由 #link("https://fontawesome.com/download")[Font awesome] 提供的图标（需要下载字体）：#fa-github()，具体有哪些可查 #link("https://fontawesome.com/search?o=r&m=free")[Font awesome gallery]。

=== boxes(admonitions & thms)
下面是我自己写的基于 showybox 的 admonitions 块和定理块。
#note()[我自己写的admonition块]
#info(caption: "标题与字号可以自定义", caption_size: 18pt, size: 9pt)[图标、内容字号也可以传入修改]

#tab 好康且自动计数的定理块：

#theorem(title: [#text(fill: green, "This is a title")])[Now the counter increases by 1 for type `Theorem`.] <thm2>

#theorem(footer: [The showybox allowes you add footer for boxes, useful when giving some explanation.])[#lorem(10)] <thm1>

#definition[The counter will be reset after the first level of heading changes, i.e. counting within one chapter(can be changed)).]

#corollary(title: "a title", [Another body!])[Corollary counter based on theorem(can be changed).]

#lemma[#lorem(20)]

#proof[By default the `Proof` will not count itself.\ And the `Proof` box will have a square at the right bottom corner.]

#example()[By default the `example` will not count itself.]

#noindent[
  @thm1, @thm2
]

=== 伪代码（算法）
lovelace包，可以用来写伪代码，body 最好用 typ，比如：

#algo(title: [caption for algorithm])[
  - *input:* integers $a$ and $b$
  - *output:* greatest common divisor of $a$ and $b$
  + *if* $a > b$ *then*
    + $a <- a - b$ #comment[and a comment]
  + *else*
    + $b <- b - a$ #comment[and another comment]
  + *end*
  + *return* $a$
]

算法默认情况下不启用每一章节的计数清空功能，如有需要可以自己实现。

=== wrap_content
文字图片包裹，不用自己考虑分栏了。在大多数时候是比较有效的，但有的时候不是很好看，可能还是得自己手动 grid。

#let fig = figure(
  rect(fill: teal, radius: 0.5em, width: 8em),
  caption: [A figure],
)
#let body = lorem(40)

#wrap-content(
  align: bottom + right,
  column-gutter: 2em,
  fig
)[
  #indent #body
]

#wrap-top-bottom(fig, fig, body)

=== 真值表

快速制作真值表，只支持 $not and or xor => <=>$，新版还支持卡诺图画法？
#truth-tbl(caption: "真值表", $A and B$, $B or A$, $A => B$, $(A => B) <=> A$, $ A xor B$)

#tab 更复杂的用法（自己填data），三个参数分别是样式函数、表头、表内容：
#truth-tbl-empty(
  caption: "空真值表",
  sc: (a) => {if (a) {"T"} else {"F"}},
  ($a and b$, $a or b$),
  (false, [], true, [] , true, false)
)

=== todo(checklist)
#grid(
  columns: 2,
  column-gutter: 8pt,
  [
    - [ ] 加入更多layouts，比如前言、附录
    - [x] 重构代码，使得可以根据语言切换文档类型
    - [-] Jupiter
    - [/] Saturn
    - [>] Forwarded
    - [<] Scheduling
    - [?] question
    - [!] important
    - [\*] star
  ],
  [
    - [b] bookmark
    - [I] idea
    - [p] pros
    - [c] cons
    - [f] fire
    - [k] key
    - [w] win
    - [u] up
    - [d] down
  ]
)

=== Pinit
#warning()[You should add a blank line before the `#pinit-xxx` function call, otherwise it will cause misalignment.]

#v(1.5em)

$ (#pin(1)q_T^* p_T#pin(2))/(p_E#pin(3))#pin(4)p_E^*#pin(5) >= (c + q_T^* p_T^*)(1+r^*)^(2N) $

#pinit-highlight-equation-from((1, 2, 3), 3, height: 3.5em, pos: bottom, fill: rgb(0, 180, 255))[
  In math equation
]

#pinit-highlight-equation-from((4, 5), 5, height: 1.5em, pos: top, fill: rgb(150, 90, 170))[
  price of Terran goods, on Trantor
]

`print(pin6"hello, world"pin7)`

#pinit-highlight(6, 7)
#pinit-point-from(7)[In raw text]

#v(4em)

这玩意儿的用法略灵活，可以看它的仓库 #link("https://github.com/typst/packages/tree/main/packages/preview/pinit/0.2.0")[pinit]

=== mitex
使用 #link("https://github.com/typst/packages/tree/main/packages/preview/mitex/0.2.4")[mitex] 包渲染 LaTeX 数学环境，比如：

通过这个包，可以快速把已经在 Markdown 或 LaTeX 中的公式重复利用起来；同时，利用市面上众多的 LaTeX 公式识别工具，可以减少很多工作。

#mitex(`
  \newcommand{\f}[2]{#1f(#2)}
  \f\relax{x} = \int_{-\infty}^\infty
    \f\hat\xi\,e^{2 \pi i \xi x}
    \,d\xi
`)
#mitext(`
  \iftypst
    #set math.equation(numbering: "(1)", supplement: "equation")
  \fi

  A \textbf{strong} text, a \emph{emph} text and inline equation $x + y$. And here we set the equation numbering to be like (1), (2), ...

  Block equation \eqref{eq:pythagoras}.

  \begin{equation}
    a^2 + b^2 = c^2 \label{eq:pythagoras}
  \end{equation}
`)

#pagebreak()
#bibliography("../assets/exbib.bib", style: "ieee", title: "References")
