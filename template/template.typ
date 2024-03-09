#import "fonts.typ": *
#import "utils.typ": *
#import "covers.typ": *
#import "figures.typ": *

// 导入第三方包
#import "@preview/lovelace:0.2.0": *
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
  body
) = {
  // 信息处理和打包
  if type(author) != "string" {author = author.join(", ")} // 多作者（array）时，分隔为字符串
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

  // 导入第三方包中的 show 规则
  show figure: i-figured.show-figure
  show heading: i-figured.reset-counters
  show math.equation: i-figured.show-equation
  show: setup-emoji
  show: setup-lovelace // 注意这一行必须在 i-figure 后，否则会被覆盖而出 bug

  set document(title: title, author: author)
  set page(
    paper: "a4",
    numbering: "1",
    header:
      if header {
        locate(
        loc => if (counter(page).at(loc).first()==1) {none}
        else {align(right, [*#title*])}
        )
      } else {none},
    footer:
      if footer {
        locate(loc => {
          let page_number = counter(page).at(loc).first()
          let total_pages = counter(page).final(loc).last()
          align(center)[Page #page_number of #total_pages]
        })
      } else {none},
    margin: (x: 2cm, y: 1.5cm),
  )

  // 设置字体与语言
  set text(font: 字体.宋体, size: 字号.小四, lang: lang)
  set par(first-line-indent: 2em)

  // 中文斜体显示为楷体
  show emph: text.with(font: 字体.楷体)

  // 设置标题
  show heading.where(level: 1): it => {
    set align(center)
    set text(weight: "bold", font: 字体.宋体, size: 18pt)
    set block(spacing: 1em)
    it
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", font: 字体.宋体, size: 17pt)
    it
  }
  show heading.where(level: 3): it => {
    set text(weight: "bold", font: 字体.宋体, size: 16pt)
    it
  }

  show heading: it => { // 标题后用假段落添加缩进
    set block(above: 1.5em, below: 1em)
    it
  } + _empty_par()

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

  if show_toc {toc(lang: lang)}

  body
}
