#import "@preview/fletcher:0.5.5" as fletcher: diagram, node, edge
#import "@preview/tablem:0.2.0": tablem
#import "@preview/lovelace:0.3.0": pseudocode-list, pseudocode, line-label
#import "@preview/truthfy:0.6.0": truth-table, truth-table-empty
#import "@preview/zebraw:0.4.3": *
#import "@preview/timeliney:0.2.0": timeline as timeliney, headerline, group, taskgroup, task, milestone
#import "packages/diagbox/0.1.0/lib.typ": *
#import "packages/admonition/0.3.0/lib.typ": *

// 一些图标
#let icon(path) = box(
  baseline: 0.125em,
  height: 1.0em,
  width: 1.25em,
  align(center + horizon, image(path))
)
#let faAngleRight = icon("assets/icons/fa-angle-right.svg")
#let faAward = icon("assets/icons/fa-award.svg")
#let faBuildingColumns = icon("assets/icons/fa-building-columns.svg")
#let faCode = icon("assets/icons/fa-code.svg")
#let faEnvelope = icon("assets/icons/fa-envelope.svg")
#let faGithub = icon("assets/icons/fa-github.svg")
#let faGraduationCap = icon("assets/icons/fa-graduation-cap.svg")
#let faLinux = icon("assets/icons/fa-linux.svg")
#let faPhone = icon("assets/icons/fa-phone.svg")
#let faWindows = icon("assets/icons/fa-windows.svg")
#let faWrench = icon("assets/icons/fa-wrench.svg")
#let faWork = icon("assets/icons/fa-work.svg")
#let falink = icon("assets/icons/fa-link.svg")
#let fajumplink = icon("assets/icons/fa-jumplink.svg")

// 简单取代 i-figured
#let process_figure_and_equation(unnumbered-label: "-", body) = {
  show heading.where(level:1):it => { // reset counters when new chapter starts
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)
    it
  }
  // show styles: `1-1` for image, code, table, and `(1-1)` for math
  show figure.where(kind: image): set figure(numbering: _ => [#counter(heading.where(level: 1)).display("1")-#counter(figure.where(kind: image)).display("1")])
  show figure.where(kind: table): set figure(numbering: _ => [#counter(heading.where(level: 1)).display("1")-#counter(figure.where(kind: table)).display("1")])
  show figure.where(kind: raw): set figure(numbering: _ => [#counter(heading.where(level: 1)).display("1")-#counter(figure.where(kind: raw)).display("1")])
  set math.equation(numbering: _ => [(#counter(heading.where(level: 1)).display("1")-#counter(math.equation).display("1"))])
  show math.equation.where(block: true): it => {
    if (it.has("label") and str(it.label) == unnumbered-label) {
      counter(math.equation).update(i => i - 1)
      math.equation(numbering: none, block: true, number-align: end+horizon, it.body) // unnumbered equation, and won't be counted, e.g. $ x + y $<->
    } else {
      it
    }
  }
  body
}

// 插入图片
#let fig(caption: "", ..args) = figure(
  kind: image,
  caption: caption,
  image(..args)
)
#let fign(..args) = figure(
  kind: image,
  supplement: none, // no caption and supplement
  caption: none,
  image(..args)
)

#let timeline(caption: "", ..args, body) = figure(
  kind: image,
  caption: caption,
  timeliney(..args, body)
)

// 正则捕捉自动设置数学环境，对表格等使用
#let automath_rule = it => {
  show regex("\d+(.\d+)*"): it => $it$
  it
}
// 普通表，包含居中
#let tbl(caption: "", alignment: center + horizon, automath: false, ..args) = {
  let fig = figure(
    kind: table,
    caption: caption,
    table(
      align: alignment,
      ..args,
    )
  )
  if automath {
    show table.cell: automath_rule
    fig
  } else {fig}
}
// 三线表，包含居中
#let tlt(caption: "", alignment: center + horizon, automath: false, ..args) = {
  let fig = figure(
    kind: table,
    caption: caption,
    table(
      stroke: none,
      align: alignment,
      table.hline(y: 0),
      table.hline(y: 1),
      ..args,
      table.hline(),
    )
  )
  if automath {
    show table.cell: automath_rule
    fig
  } else {fig}
}

// 类 markdown 表格，使用 tablem 包实现
#let tblm(caption: "", alignment: center + horizon, automath: false, ..args) = {
  let fig = figure(
    kind: table,
    caption: caption,
    tablem(
      align: alignment,
      ..args,
    )
  )
  if automath {
    show table.cell: automath_rule
    fig
  } else {fig}
}

// csv 表格，使用 csv 处理转为表格
#let csvtbl(caption: "", alignment: center + horizon, automath: false, columns: 0, raw) = {
  let data = csv(bytes(raw.text))
  let fig = figure(
    kind: table,
    caption: caption,
    table(
      columns: if columns == 0 {data.at(0).len()} else {columns},
      align: alignment,
      ..data.flatten()
    )
  )
  if automath {
    show table.cell: automath_rule
    fig
  } else {fig}
}

// 真值表，使用 truthfy 实现
#let truth-tbl(caption: "", ..args) = figure(
  kind: table,
  caption: caption,
  truth-table(..args)
)
#let truth-tbl-empty(caption: "", ..args) = figure(
  kind: table,
  caption: caption,
  truth-table-empty(..args)
)

// 算法框，使用 lovelace 实现
#let my-lovelace-defaults = (
  line-numbering: "1",
  booktabs: true,
  // stroke: none,
  hooks: 0.5em,
  indentation: 1em,
  booktabs-stroke: 2pt + black,
)
#let pseudocode-list = pseudocode-list.with(..my-lovelace-defaults)
#let algo(title: none, body) = {
  figure(
    kind: "algorithm",
    supplement: [Algorithm],
    pseudocode-list(
      booktabs: true,
      numbered-title: title + h(1fr),
      body
    )
  )
}
#let comment(body) = {
  h(1fr)
  text(size: .85em, fill: gray, sym.triangle.stroked.r + sym.space + body)
}
#let no-number = [- #hide([])] // empty line and no number

// 代码块，使用 zebraw 实现
#let code(
  caption: "",
  body,
  ..args
) = figure(
  kind: raw,
  caption: caption,
  zebraw(
    body,
    ..args
  )
)

#let diagram(caption: "", ..args) = figure(
  kind: image,
  caption: caption,
  fletcher.diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    mark-scale: 70%,
    ..args
  )
)
#let edge(..args, marks: "-|>") = fletcher.edge(..args, marks: marks)
