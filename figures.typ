#import "@preview/i-figured:0.2.4"
#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge
#import "@preview/tablem:0.1.0": tablem
#import "@preview/lovelace:0.3.0": pseudocode-list, pseudocode, line-label
#import "@preview/truthfy:0.4.0": truth-table, truth-table-empty
#import "@preview/codly:1.0.0": *

// 通过这三个函数可以手动控制 i-figured 的计数器
#let reset_i-figure_image(num) = counter(figure.where(kind: i-figured._prefix + repr(image))).update(num)
#let reset_i-figure_table(num) = counter(figure.where(kind: i-figured._prefix + repr(table))).update(num)
#let reset_i-figure_raw(num) = counter(figure.where(kind: i-figured._prefix + repr(row))).update(num)

// 插入图片
#let fig(caption: "", ..args) = figure(
  image(..args),
  caption: caption,
)

// 正则捕捉自动设置数学环境，对表格等使用
#let automath_rule = it => {
  show regex("\d+(.\d+)*"): it => $it$
  it
}
// 普通表，包含居中
#let tbl(caption: "", alignment: center + horizon, automath: false, ..args) = {
  let fig = figure(
    table(
      align: alignment,
      ..args,
    ),
    caption: caption,
  )
  if automath {
    show table.cell: automath_rule
    fig
  } else {fig}
}
// 三线表，包含居中
#let tlt(caption: "", alignment: center + horizon, automath: false, ..args) = {
  let fig = figure(
    table(
      stroke: none,
      align: alignment,
      table.hline(y: 0),
      table.hline(y: 1),
      ..args,
      table.hline(),
    ),
    caption: caption,
  )
  if automath {
    show table.cell: automath_rule
    fig
  } else {fig}
}

// 类 markdown 表格，使用 tablem 包实现
#let tblm(caption: "", automath: false, ..args) = {
  let fig = figure(
    tablem(
      ..args,
    ),
    caption: caption,
  )
  if automath {
    show table.cell: automath_rule
    fig
  } else {fig}
}

// csv 表格，使用 csv decode 处理转为表格
#let csvtable(caption: "", alignment: center + horizon, automath: false, raw) = {
  let data = csv.decode(raw.text)
  let fig = figure(
    table(
      columns: data.at(0).len(),
      align: alignment,
      ..data.flatten()
    ),
    caption: caption
  )
  if automath {
    show table.cell: automath_rule
    fig
  } else {fig}
}

// 真值表，使用 truthfy 实现
#let truth-tbl(caption: "", ..args) = figure(
  caption: caption,
  truth-table(..args)
)
#let truth-tbl-empty(caption: "", ..args) = figure(
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

// 代码块，使用 codly + i-figure 实现
#let code(caption: "", body) = figure(
    // disable-codly()
    body
  ,
  caption: caption,
)

// icons for codly
#let codly_icon(codepoint) = {
  box(
    height: 1em,
    baseline: 0.1em,
    image(codepoint)
  )
  h(0.2em)
}
#let c_svg = codly_icon("assets/c.svg")
#let cpp_svg = codly_icon("assets/cpp.svg")
#let python_svg = codly_icon("assets/python.svg")
#let rust_svg = codly_icon("assets/rust.svg")
#let java_svg = codly_icon("assets/java.svg")
#let sql_svg = codly_icon("assets/sql.svg")
#let typst_svg = codly_icon("assets/typst.svg")
#let verilog_svg = codly_icon("assets/verilog.svg")

#let diagram(..args) = align(center, fletcher.diagram(
  node-stroke: 1pt,
  edge-stroke: 1pt,
  mark-scale: 70%,
  ..args
))
#let edge(..args, marks: "-|>") = fletcher.edge(..args, marks: marks)
