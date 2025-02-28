#import "fonts.typ": *
#import "utils.typ": *
#import "covers.typ": show_cover
#import "figures.typ": *
#import "math.typ": *

#let project(
  title: "Title1",
  title_2: "Title2",
  title_3: "Title3",
  authors: ("authors1", "authors2"),
  date: datetime.today(),
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
  if type(authors) == array {authors = authors.join(", ")} // 多作者（array）时，分隔为字符串
  if type(date) == datetime {date = (date.year(), date.month(), date.day())} // 日期处理为 array
  let infos = (
    title: title,
    title_2: title_2,
    title_3: title_3,
    authors: authors,
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
  set document(title: title, author: authors)
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

  // 导入规则
  set-page-properties(margin-left: 2cm) // drafting, set to same as page's margin x
  show: process_figure_and_equation.with(unnumbered-label: "-")
  show: checklist.with(fill: luma(95%), stroke: blue, radius: .2em)
  show: shorthand // 导入 math shorthand
  show: show-theorion.with()
  show: zebraw-init.with(
    background-color: (luma(240), luma(250)),
    highlight-color: yellow.lighten(90%),
    comment-color: blue.lighten(90%),
    extend: false,
  )
  show: zebraw
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
  show emph: text.with(font: 字体.楷体) // 中文斜体显示为楷体
  set par(first-line-indent: (amount: 2em, all: true))
  // 设置 bullet list 和 enum 的 marker，相比默认更像 markdown，另外刻意调大了一点（适合老年人
  set list(marker: ([●], [○], [■], [□], [►]), tight: false, spacing: .8em)
  set enum(numbering: numbly("{1}.", "{2:a}.", "{3:i}."), full: true, tight: false, spacing: .8em)
  // 将 list and enum 用 block 撑开 (for math.equation and figures)
  show: align_list_enum
  // show: align-list-marker-with-baseline
  // show: align-enum-marker-with-baseline
  // 设置 figure (for long table or code) breakable
  show figure: set block(breakable: true)

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
  show heading: it => it + v(6pt)

  // 行内代码，灰色背景
  show raw.where(block: false): box.with(fill: colors.gray, inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt)
  // 行内代码与文字之间的自动空格
  show raw.where(block: false): it => h(0.25em, weak: true) + it + h(0.25em, weak: true)
  show raw: set text(font: (字体.meslo-mono, 字体.思源宋体)) // 代码中文字体
  show raw.where(block: true): set text(size: 字号.小四 - 3pt)  // 代码块字体小一点
  show raw: it => {
    show regex("pin\d"): it => pin(eval(it.text.slice(3))) // pinit package for raw
    it
  }
  // show: comment_color.with(color: green)

  show_cover(infos: infos) // 封面
  if show_toc {toc(toc_break: toc_break, depth: toc_depth)} // 目录

  body
}
