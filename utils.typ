// 导入本地包
#import "fonts.typ":*
#import "packages/admonition/0.3.0/lib.typ": *
#import "packages/thms/0.2.0/lib.typ": *

// 导入 preview 包
// 树、图文包裹、图标、真值表
#import "@preview/syntree:0.2.0": syntree, tree
#import "@preview/treet:0.1.1": tree-list
#import "@preview/wrap-it:0.1.0": wrap-content, wrap-top-bottom
#import "@preview/fontawesome:0.4.0": *
#import "@preview/cheq:0.2.0": checklist
#import "@preview/pinit:0.2.0": *
#import "@preview/indenta:0.0.3": fix-indent
#import "@preview/numbly:0.1.0": numbly
#import "@preview/drafting:0.2.0": *
#import "@preview/oxifmt:0.2.1": strfmt

// 假段落，deprecated
#let fake_par = context{box();v(-measure(block()+block()).height)}

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
  font: 字体.宋体,
) = {
  if type(size) != length {size = 字号.at(size)}
  set text(font: font, size: size);
  if lang == "zh" {
    [#date.at(0)年#date.at(1)月#date.at(2)日]
  } else {   // 美式日期格式，月日年
    [#date.at(1).#date.at(2).#date.at(0)]
  }
}

// 目录
#let toc(
  depth: 4,
  toc_break: true
) = {
  set par(first-line-indent: 0pt)
  set text(font: (字体.ntl, 字体.思源黑体), size: 字号.小四)
  outline(
    indent: true,
    depth: depth
  )
  if toc_break {pagebreak()}
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

// 快捷 grid
#let grid2(body1, body2) = grid(
  columns: 2,
  grid.cell(align: center+horizon)[#body1],
  grid.cell(align: center+horizon)[#body2]
)
#let grid3(body1, body2, body3) = grid(
  columns: 3,
  grid.cell(align: center+horizon)[#body1],
  grid.cell(align: center+horizon)[#body2],
  grid.cell(align: center+horizon)[#body3]
)

// 快捷文字着色，实现了红色蓝色，黑色则为粗体，两个 * 即可
#let redt(body) = text(fill: colors.red, body) // red-text
#let bluet(body) = text(fill: colors.blue, body) // blue-text

// pinit 的公式高亮指针
#let pinit-highlight-equation-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), highlight-pins, point-pin, body) = {
  pinit-highlight(..highlight-pins, dy: -0.6em, fill: rgb(..fill.components().slice(0, -1), 40))
  pinit-point-from(
    fill: fill, pin-dx: -0.6em, pin-dy: if pos == bottom { 0.8em } else { -0.6em }, body-dx: 0pt, body-dy: if pos == bottom { -1.7em } else { -1.6em }, offset-dx: -0.6em, offset-dy: if pos == bottom { 0.8em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      }
    )
  )
}

// 对各种语言的注释启用 eval，使得可以在注释中使用斜体、粗体和数学公式等
#let comment_process = it => {
  let slash_lang = ("c", "c++", "cpp", "Cpp", "typ", "typc", "rust", "rs", "js", "javascript", "ts", "typescript")
  let comment-style = if it.lang in slash_lang or it.lang == none {"//"} else {"#"}
  show raw.line: it => {
    let body = it.body
    let comment-token = if "children" in it.body.fields() {
      it.body.children.position(it => {
        if "child" in it.fields() {
          it.child.text.starts-with(comment-style)
        } else {
          it.text.starts-with(comment-style)
        }
      })
    }
    if comment-token == none {return it}
    it.body.children.slice(0, comment-token).join()
    let matched = it.text.match(regex(comment-style + "[\s\S]*")).text
    let comment = matched.match(regex("^" + comment-style + "+")) // ^//+ or ^#+
    let comment_len = if comment != none {comment.end} else {0}
    let e = matched.slice(comment_len).trim(at: start)
    let comment-style = if comment-style == "//" {"/"} else {comment-style}
    text(fill: gray.darken(15%), comment-style * comment_len)
    matched.slice(comment_len, matched.len() - e.len())
    // change * to be \*, other wise pointers in Cpp will be regarded as bold symbol, the same reason for "<" and ">"
    let e = e.replace("*", "\*").replace("<", "\<").replace(">", "\>")
    text(fill: gray.darken(15%), eval(e, mode: "markup"))
  }
  it
}
