#import "fonts.typ": *
#import "utils.typ": *
#import "covers.typ": *
#import "figures.typ": *
#import "math.typ": *

// 导入第三方包
#import "@preview/lovelace:0.2.0": setup-lovelace
#import "@preview/i-figured:0.2.4"

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

  set document(title: title, author: author)
  set page(
    paper: "a4",
    numbering: "1",
    header:
      if header {
        locate(loc => {
          if (counter(page).at(loc).first() <= 2) {none}
          else {align(right, text(size: 10pt, weight: "bold", title))}
        })
      } else {none},
    footer:
      if footer {
        locate(loc => {
          set align(center)
          set text(10pt)
          if (counter(page).at(loc).first() <= 2) {none}
          else {"Page " + counter(page).display("1 of 1", both: true)}
        })
      } else {none},
    margin: (x: 2cm, y: 1.5cm),
  )

  // 设置字体与语言
  set text(font: 字体.宋体, size: 字号.小四, lang: lang)
  set par(first-line-indent: 2em)

  // 设置 bullet list 的 marker，相比默认更像 markdown，另外刻意调大了一点（适合老年人
  set list(marker: ([●], [○], [■], [□], [►]))

  // 中文斜体显示为楷体
  show emph: text.with(font: 字体.楷体)

  // 设置标题
  show heading.where(level: 1): it => {
    set block(spacing: 1em)
    align(center, text(weight: "bold", font: 字体.黑体, size: 18pt, it))
  }
  show heading.where(level: 2): it => {text(weight: "bold", font: 字体.黑体, size: 17pt, it)}
  show heading.where(level: 3): it => {text(weight: "bold", font: 字体.黑体, size: 16pt, it)}
  show heading.where(level: 4): it => {text(weight: "bold", font: 字体.黑体, size: 15pt, it)}
  show heading.where(level: 5): it => {text(weight: "bold", font: 字体.黑体, size: 14pt, it)}
  show heading: it => { // 标题后用假段落添加缩进
    set block(above: 1em, below: 1em)
    it
  } + fake_par
  set heading(numbering: (..nums) => { // 设置标题编号
    nums.pos().map(str).join(".") + " "
  })

  // 行内代码，灰色背景
  show raw.where(block: false): box.with(
    fill: colors.gray,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // codly 初始化
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

  // 代码中文字体
  show raw: set text(font: (字体.meslo-mono, 字体.思源宋体))
  // 对 typst 语言的注释进行特殊处理
  show raw.where(lang: "typst"): it => {
    show regex("//[\s\S]*"): it => {
      let e = it.text.slice(2).trim(at: start)
      "/" + sym.zws + "/"
      it.text.slice(2, it.text.len() - e.len())
      eval(e, mode: "markup")
    }
    it
  }
  set raw(syntaxes: "assets/Assembly.sublime-syntax") // 汇编代码的语法高亮

  // 行间公式、原始文本与文字之间的自动空格
  show raw.where(block: false): it => h(0.25em, weak: true) + it + h(0.25em, weak: true)
  show math.equation.where(block: false): it => h(0.25em, weak: true) + it + h(0.25em, weak: true)

  // 引用与链接字体蓝色显示
  show ref: it => {
    text(colors.blue)[#it]
  }
  show link: it => {
    text(colors.blue)[#it]
  }

  show_cover(infos: infos)

  if show_toc {toc(toc_break: toc_break, depth: toc_depth)}

  body
}
