#import "fonts.typ": *
#import "utils.typ": *
#import "covers.typ": show_cover
#import "figures.typ": *
#import "math.typ": *

#let project(
  title: "Title1",
  title_2: "Title2",
  title_3: "Title3",
  author: ("author1", "author2"),
  date: (2023, 5, 14),
  cover_style: "normal",
  class: "your class",
  major: "your major",
  mentor: "your mentor",
  mailbox: "your mailbox",
  department: "your department",
  id: "your student ID",
  lang: "en",
  show_toc: true,
  show_name: true,
  header: true,
  footer: true,
  toc_break: true,
  toc_depth: 4,
  body
) = {
  // 信息处理和打包
  if type(author) == "array" {author = author.join(", ")} // 多作者（array）时，分隔为字符串
  let infos = (
    title: title,
    title_2: title_2,
    title_3: title_3,
    author: author,
    date: date,
    class: class,
    major: major,
    mentor: mentor,
    mailbox: mailbox,
    department: department,
    id: id,
  ) + (lang: lang, cover_style: cover_style, show_name: show_name)

  // 设置 page
  let header1 = context { // ignore cover and toc
    if (counter(page).get().first() <= 2) {none}
    else {align(right, text(size: 10pt, weight: "bold", title))}
  }
  let header2 = { // all
    align(right, text(size: 10pt, weight: "bold", title))
  }
  let header3 = { // header with more information
    place(left+horizon, text(size: 10pt, title))
    place(center+horizon, text(size: 10pt, title_2))
    place(right+horizon, date_format(date: date, lang: lang, size: 10pt))
    pad(y: 8pt, hline())
  }
  let footer1 = context { // ignore cover and toc
    set align(center)
    set text(10pt)
    if (counter(page).get().first() <= 2) {none}
    else {"Page " + counter(page).display("1 of 1", both: true)}
  }
  let footer2 = context { // all
    set align(center)
    set text(10pt)
    "Page " + counter(page).display("1 of 1", both: true)
  }
  set document(title: title, author: author)
  set page(
    paper: "a4",
    numbering: "1",
    margin: (x: 2cm, y: 1.5cm),
    header:
      if (header == true or header == "type1") {header1}
      else if (header == "type2") {header2}
      else if (header == "type3") {header3}
      else {none},
    footer:
      if (footer == true or footer == "type1") {footer1}
      else if (footer == "type2") {footer2}
      else {none},
  )

  set-page-properties() // drafting

  // 导入 show 规则
  show: process_figure_and_equation.with(unnumbered-label: "-")
  show: checklist.with(fill: luma(95%), stroke: blue, radius: .2em)
  show: thmrules  // 导入 theorem 环境
  show: shorthand // 导入 math shorthand
  show: codly-init.with()
  // 行内公式与文字之间的自动空格
  show math.equation.where(block: false): it => h(0.25em, weak: true) + it + h(0.25em, weak: true)
  // 矩阵用方括号显示
  set math.mat(delim: "[")
  set math.vec(delim: "[")
  // 引用与链接字体蓝色显示
  show ref: set text(colors.blue)
  show link: set text(colors.blue)
  // 设置字体与语言
  set text(font: 字体.宋体, size: 字号.小四, lang: lang)
  set par(first-line-indent: 2em)
  set list(marker: ([●], [○], [■], [□], [►])) // 设置 bullet list 的 marker，相比默认更像 markdown，另外刻意调大了一点（适合老年人
  set enum(numbering: numbly("{1}.", "{2:a}.", "{3:i}."), full: true)
  show emph: text.with(font: 字体.楷体) // 中文斜体显示为楷体

  // 设置标题
  show heading.where(level: 1): it => {
    set block(spacing: 1em)
    align(center, text(weight: "bold", font: 字体.黑体, size: 18pt, it))
  }
  show heading.where(level: 2): set text(weight: "bold", font: 字体.黑体, size: 17pt)
  show heading.where(level: 3): set text(weight: "bold", font: 字体.黑体, size: 16pt)
  show heading.where(level: 4): set text(weight: "bold", font: 字体.黑体, size: 15pt)
  show heading.where(level: 5): set text(weight: "bold", font: 字体.黑体, size: 14pt)
  set heading(numbering: (..nums) => { // 设置标题编号
    nums.pos().map(str).join(".") + " "
  })

  // 代码相关设置
  codly(
    languages: (
      c: (name: "", icon: h(2pt)+c_svg, color: rgb("#A8B9CC")),
      C: (name: "", icon: h(2pt)+c_svg, color: rgb("#A8B9CC")),
      cpp: (name: "Cpp", icon: cpp_svg, color: rgb("#00599C")),
      Cpp: (name: "Cpp", icon: cpp_svg, color: rgb("#00599C")),
      py: (name: "Python", icon: python_svg, color: rgb(("#3D8FD1"))),
      python: (name: "Python", icon: python_svg, color: rgb(("#3D8FD1"))),
      rust: (name: "Rust", icon: rust_svg, color: rgb("#CE412B")),
      java: (name: "Java", icon: java_svg, color: rgb("#5382A1")),
      typ: (name: "Typst", icon: typst_svg, color: rgb("#FFD700")),
      sql: (name: "SQL", icon: sql_svg, color: rgb("#F0A103")),
      SQL: (name: "SQL", icon: sql_svg, color: rgb("#F0A103")),
      verilog: (name: "Verilog", icon: verilog_svg, color: rgb("#FF6666")),
      Verilog: (name: "Verilog", icon: verilog_svg, color: rgb("#FF6666")),
    ),
    // zebra-color: luma(250),
    fill: luma(250),
    // stroke: 1pt,
    // display-name: false,
    // display-icon: false
  )
  // 行内代码，灰色背景
  show raw.where(block: false): box.with(
    fill: colors.gray,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  // 行内代码与文字之间的自动空格
  show raw.where(block: false): it => h(0.25em, weak: true) + it + h(0.25em, weak: true)
  show raw: set text(font: (字体.meslo-mono, 字体.思源宋体)) // 代码中文字体
  show raw: it => {
    show regex("pin\d"): it => pin(eval(it.text.slice(3))) // pinit package for raw
    it
  }
  // show raw: comment_process // maybe bugs
  set raw(syntaxes: "assets/Assembly.sublime-syntax") // 汇编代码的语法高亮

  show: fix-indent() // 一个很 tricky 的包，需放在所有 show 规则的最后

  show_cover(infos: infos) // 封面
  if show_toc {toc(toc_break: toc_break, depth: toc_depth)} // 目录

  body
}
