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
  let header1 = locate(loc => {
    if (counter(page).at(loc).first()<=2) {none}
    else {align(right, text(size: 10pt, weight: "bold", title))}
  })
  let header2 = {
    place(left+horizon, text(size: 10pt, title))
    place(center+horizon, text(size: 10pt, title_2))
    place(right+horizon, date_format(date: date, lang: lang, size: 10pt))
    pad(y: 8pt, hline())
  }
  let footer1 = locate(loc => {
    set align(center)
    set text(10pt)
    if (counter(page).at(loc).first()<=2) {none}
    else {"Page " + counter(page).display("1 of 1", both: true)}
  })
  set document(title: title, author: author)
  set page(
    paper: "a4",
    numbering: "1",
    margin: (x: 2cm, y: 1.5cm),
    header:
      if (header == true or header == "type1") {header1}
      else if (header == "type2") {header2}
      else {none},
    footer:
      if (footer == true or footer == "type1") {footer1}
      else {none},
  )

  // 导入 show 规则
  show heading: i-figured.reset-counters
  show figure: i-figured.show-figure
  show math.equation: i-figured.show-equation
  show: setup-emoji
  show: setup-lovelace // 注意这一行必须在 i-figure 后，否则会被覆盖而出 bug
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
    zebra-color: luma(250),
    fill: luma(250),
    // stroke-width: 1pt,
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
    // 对各种语言的注释启用 eval，使得可以在注释中使用斜体、粗体和数学公式等
    let slash_lang = ("c", "c++", "cpp", "Cpp", "typ", "typc", "rust", "rs", "js", "javascript", "ts", "typescript")
    let comment-style = if it.lang in slash_lang or it.lang == none {"//"} else {"#"}
    show raw.line: it => {
      let body = it.body;
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
      let e = matched.slice(2).trim(at: start)
      text(fill: gray.darken(15%), comment-style)
      matched.slice(comment-style.len(), matched.len() - e.len())
      text(fill: gray.darken(15%), eval(e, mode: "markup"))
    }
    // pinit package for raw
    show regex("pin\d"): it => pin(eval(it.text.slice(3)))
    it
  }
  set raw(syntaxes: "assets/Assembly.sublime-syntax") // 汇编代码的语法高亮

  show: fix-indent() // 一个很 tricky 的包，需放在所有 show 规则的最后

  show_cover(infos: infos) // 封面
  if show_toc {toc(toc_break: toc_break, depth: toc_depth)} // 目录

  body
}
