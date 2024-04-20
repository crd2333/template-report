#import "../lib.typ": *
#show: project.with(
  title: "Test Title",
  title_2: "Project 1",
  author: ("crd233", "张三"),
  date: (2024, 2, 30),
  cover_style: "report",   // report, report1, report2, report3 或其它
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

字体：先在"Arial"中寻找，找不到才在黑体、宋体等中文字体中寻找，通过这种方法实现*先英文字体、后中文字体*的效果。这个字体可以先去搜索下载，或者直接在终端中输入"typst fonts"查看你电脑上的字体，然后修改`font.typ`相关内容为你拥有且喜爱的字体。

English test: Let's have a try! And
this is a dot. This is a quote "". 英文标点也是正常显示。

_斜体_与*粗体*，_Italic_ and *bold*。但是中文没有斜体，一般用楷体代替 ```typ show emph: text.with(font: ("Arial", "LXGW WenKai"))```

如果真的需要斜体，可以使用伪斜体（旋转得到）：#fake-italic[中文伪斜体]。

中英文字体之间正常情况下会自动添加空格，像这样test一下。手动添加空格也可以（对Arial字体而言），像这样 test 一下，间隙增加可以忽略不计。如果换用其它字体，可能会出现手动空格导致间隙过大的情况。

=== 关于缩进

默认情况下，每段开头都会缩进，可以使用`#noindent[Something]`来取消缩进，比如下面这样：

#hline()

#noindent[
  这是一个没有缩进的段落。

  这是另一个没有缩进的段落。\
  采用连接符换行。
]

#hline()

而这样的内容在原始情况下是这样显示：

这是一个没有缩进的段落。

这是另一个没有缩进的段落。\
采用连接符换行。

#hline()

#indent 另外，通过 `#indent`（或`#tab`）能缩进内容，比如在图表之后，需要手动缩进。其实可以自动缩进，只是个人认为，图表后是否缩进还是由作者手动控制比较好。

== 图表测试

引用图表时，表格、图片和代码分别需要加上 `tbl:`、`fig:` 和 `lst:` 前缀。至于缩进问题前已述。

=== 图片

#fig(caption: "测试图片, 浙江大学", "../assets/校名.jpg") <test>

图片测试引用 @fig:test

=== 公式

Given an $N times N$ integer matrix $(a_(i j))_(N times N)$, find the maximum value of $sum_(i=k)^m sum_(j=l)^n a_(i j)$ for all $1 <= k <= m <= N$ and $1 <= l <= n <= N$.

$ F_n = floor(1 / sqrt(5) phi.alt^n) $ <fib>
$ F_n = floor(1 / sqrt(5) phi.alt^n) $ <->

引用公式Fibonacci: @eqt:fib，使用 `eqt:` 前缀来引用公式。标签改为`<->`后不再有编号，但也不能引用了。

为了更加简化符号输入，有这么一个包 #link("https://github.com/typst/packages/tree/main/packages/preview/quick-maths/0.1.0")[quick-maths]，定义一些快捷方式，比如：

```typ
#show: shorthands.with(
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
  ($<=$, math.arrow.l.double) // Replaces '≤'
)
```

$ x^2 = 9 quad <==> quad x = +-3 $
$ A or B |- A $
$ x <= y $

=== 代码

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

#indent 引用代码@lst:code

注意，code使用codly实现，会自动捕捉所有成块原始文本，像下面这样，如果不想这样，需要手动指定 ```typ #disable-codly()```，后续又要使用使再 ```typ #codly()``` 加回来

#disable-codly()
```raw
并没有调用code命令
```
#codly()
```raw
并没有调用code命令
```

=== 表格
表格内容自动数学环境：```typ #show table.cell: automath```
#show table.cell: automath
#tbl(
  caption: "Multiplier",
  fill: (x, y) =>
    if y == 0 {
      aqua.lighten(40%)
    },
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
    fill: (x, y) => if y == 0 {
        aqua.lighten(40%)
      },
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
    caption: [常规表],
  ) <timing>
][
  #h(50pt)
][
  #tlt(
    columns: 4,
    [t], [1], [2], [3],
    [y], [123.123s], [0.4s], [0.8s],
    caption: [三线表],
  ) <timing-tlt>
]))

引用@tbl:timing，引用@tbl:timing-tlt。

三线表，引用@tbl:test2。

#tlt(
columns: (auto, auto),
  [姓名], [性别],
  [张三], [男],
  [李四], [女],
  caption: "测试表格",
) <test2>

#tab 由于习惯了 markdown 的表格，所以 typst 的表格语法可能不太习惯，但是也有类 markdown 表格包的实现：
#tblm(caption: "tablem实现的类markdown表格")[
  | *Name* | *Location* | *Height* | *Score* |
  | ------ | ---------- | -------- | ------- |
  | John   | Second St. | 180 cm   |  5      |
  | Wally  | Third Av.  | 160 cm   |  10     |
]

= 第二个大标题 <caption_2>

#fig("../assets/校名.jpg", caption: "测试图片, 浙江大学", width: 50%) <test2>

图片测试引用@fig:test2，可以看到现在的编号是 2 开头。

== 列表
Bubble list 语法（更改了部分图标）：
- 无序列表项一
- 无序列表项二
  - 无序子列表项一
  - 无序子列表项二

+ 有序列表项一
+ 有序列表项二
  + 有序子列表项一
  + 有序子列表项二

#tab Term list 语法：
/ a: Something
/ b: Something

== 添加脚注

我们可以添加一个脚注。#footnote[脚注内容]

== 参考文献

可以像这样引用参考文献：@wang2010guide 和 @kopka2004guide。

== 其它工具

从第三方包中（or自己编写）预先挑选了一些比较实用的工具，比如：

=== 可变箭头(xarrow)

在数学环境中使用，目前有bug（且似乎暂时不好解决，参见#link("https://github.com/RubixDev/typst-i-figured/issues/6")[i-figured issue]）：

$a xarrow("text above arrow") b$

$a xarrow(sym: <->, "text above arrow") b$

=== todo(checklist)

- [ ] 加入更多layouts，比如前言、附录
- [x] 重构代码，使得可以根据语言切换文档类型

=== syntree & treet

语法树，像这样
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

=== emoji

直接使用(directly): 😆🛖🐡

内置表情(built-in emoji namespace): `#emoji.rocket` #emoji.rocket

GitHub表情(github-named emojis): `#github.blue_car` #github.blue_car

由 #link("https://fontawesome.com/download")[Font awesome] 提供的图标（需要下载字体）：#fa-github()，具体有哪些可查 #link("https://fontawesome.com/search?o=r&m=free")[Font awesome gallery]。

=== boxes(admonitions & thms)

#note()[我自己写的admonition块]
#info(caption: "标题与字号可以自定义", caption_size: 16pt, size: 9pt)[图标、内容字号也可以传入修改]

#tab 好康的定理块：

#theorem(title: "This is a title", lorem(20)) <thm2>

#theorem(footer: [The showybox allowes you add footer for boxes, useful when giving some explanation.])[#lorem(20)] <thm1>

#definition[The counter will be reset after the first level of heading changes (counting within one chapter).]

#theorem(title: [#text(fill: green, "This is another title")])[Now the counter increases by 1 for type `Theorem`.]

#corollary([One body.], footer: [As well as footer!])[Another body!]

#lemma[#lorem(20)]

#proof[By default the `Proof` will not count itself.\ And the `Proof` box will have a square at the right bottom corner.]

#noindent[
@thm1 (Use the label name to refer)\
@thm2
]

=== 伪代码（算法）

lovelace包，可以用来写伪代码，body 最好用 typ，比如：

#algo(
  caption: [caption for algorithm],
  ```typ
  #no-number
  *input:* integers $a$ and $b$
  #no-number
  *output:* greatest common divisor of $a$ and $b$
  <line:loop-start>
  *if* $a == b$ *goto* @line:loop-end
  *if* $a > b$ *then*
    $a <- a - b$ #comment[and a comment]
  *else*
    $b <- b - a$ #comment[and another comment]
  *end*
  *goto* @line:loop-start
  <line:loop-end>
  *return* $a$
  ```
)

当然内部的引用不是必须的，这里只是展示它的功能。

=== wrap_content

文字图片包裹，不用自己考虑分栏了。

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

快速制作真值表，只支持 $not and or xor => <=>$。
#truth-tbl(caption: "真值表", $A and B$, $B or A$, $A => B$, $(A => B) <=> A$, $ A xor B$)

#tab 更复杂的用法（自己填data），三个参数分别是样式函数、表头、表内容：
#truth-tbl-empty(
  caption: "空真值表",
  sc: (a) => {if (a) {"T"} else {"F"}},
  ($a and b$, $a or b$),
  (false, [], true, [] , true, false)
)

#pagebreak()
#bibliography("../assets/exbib.bib", style: "ieee", title: "References")
