#import "fonts.typ":*

// 导入本地包
// todo、emoji、两种 box
#import "packages/todo/0.1.0/lib.typ": todo
#import "packages/svg-emoji/0.1.0/lib.typ": setup-emoji, github
#import "packages/admonition/0.3.0/lib.typ": *
#import "packages/thms/0.1.0/lib.typ": *

// 导入 preview 包
// 可变长箭头、树、图文包裹、图标、真值表
#import "@preview/xarrow:0.3.0": xarrow, xarrowSquiggly, xarrowTwoHead
#import "@preview/syntree:0.2.0": syntree, tree
#import "@preview/treet:0.1.0": tree-list
#import "@preview/wrap-it:0.1.0": wrap-content, wrap-top-bottom
#import "@preview/fontawesome:0.1.0": *

// 假段落
#let fake_par = style(styles => {
  let b = par[#box()]
  let t = measure(b + b, styles)
  b
  v(-t.height * 0.9)
})

// 中文缩进
#let indent = h(2em)
#let noindent(body) = {
  set par(first-line-indent: 0em)
  body
}
#let tab = indent // alias
#let notab = noindent // alias

// 封装 tree-list，使其无缩进、视为整体且支持根节点；选用这个字体使线段连续
#let tree-list = (root: "", breakable: false, body) => {
  let root = if root != "" {[#root\ ]}
  block(breakable: breakable)[
    #noindent()[
      #root
      #tree-list(
        marker-font: "MesloLGS NF",
        marker: [├──#h(0.3em)], // modify as you like
        indent: [│#h(1.5em)],
        last-marker: [└──#h(0.3em)],
        empty-indent: h(2.2em),
        body
      )
    ]
  ]
}

#let date_format(
  date: (2023, 5, 14),
  lang: "en",
  size: "四号",
  font_style: 字体.宋体,
) = {
  if type(size) != length {size = 字号.at(size)}
  set text(font: font_style, size: size);
  if lang == "zh" {
    [#date.at(0)年#date.at(1)月#date.at(2)日]
  } else {   // 美式日期格式，月日年
    [#date.at(1).#date.at(2).#date.at(0)]
  }
}

// 目录
#let toc(
  lang: "en"
) = {
  if lang == "en" {
    align(center)[
      #text(font: (字体.ntl, 字体.思源黑体), size: 字号.小二, "Catalog")
    ]
  } else if lang == "zh" {
    align(center)[
      #text(font: (字体.ntl, 字体.思源黑体), size: 字号.小二, "目录")
    ]
  }

  parbreak()
  set text(font: (字体.ntl, 字体.思源黑体), size: 字号.小四)
  set par(first-line-indent: 0pt)
  show outline: it => {
    set text(font: (字体.ntl, 字体.思源黑体), size: 字号.小四)
    it
    parbreak()
  }
  outline(
    title: none,
    indent: true,
  )
}

#let colors = (
  gray: luma(240),
  blue: rgb(29, 144, 208),
  green: rgb(102, 174, 62),
  red: rgb(237, 32, 84),
  yellow: rgb(255, 201, 23),
  purple: rgb(158, 84, 159),
)

// 双下划线
#let double-line(body) = style(styles => {
  let size = measure(body, styles)
  stack(
    body,
    v(1pt),
    line(length: size.width),
    v(2pt),
    line(length: size.width),
  )
})

// 一条水平横线
#let hline() = {
  line(length: 100%)
}

// 快捷文字着色，实现了红色蓝色，黑色则为粗体，两个 * 即可
#let redt(body) = text(fill: colors.red, body) // red-text
#let bluet(body) = text(fill: colors.blue, body) // blue-text

// 自动数学环境，在 block 中以 `show: automath` 使用，或对表格等使用
#let automath = it => {
  show regex("\d+(.\d+)*"): it => $it$
  it
}