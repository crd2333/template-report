#import "@preview/tablem:0.1.0": tablem
#import "@preview/lovelace:0.2.0": algorithm, pseudocode-raw
#import "@preview/truthfy:0.3.0": truth-table, truth-table-empty
#import "@preview/codly:0.2.0": *

// 插入图片
// image 函数必须在外部调用后传入图片，否则相对位置会基于模板
#let fig(caption: "", image) = figure(
  image,
  caption: caption,
)

// 普通表，包含居中
#let tbl(caption: "", alignment: center+horizon, ..args) = {
  figure(
    table(
      align: alignment,
      ..args,
    ),
    caption: caption,
  )
}
// 三线表，包含居中
#let tlt(caption: "", alignment: center+horizon, ..args) = figure(
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

// 类 markdown 表格，使用 tablem 实现
#let tblm(caption: "", ..args) = figure(
  tablem(
    ..args,
  ),
  caption: caption,
)

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
#let algo(caption: "", body) = {
  // 去除当以 "[]" 形式传参时 body 中的 "[]"，方法比较笨，轻喷
  if "text" not in body.fields() {
    body = body.children
    body = body.at(1)
  }
  algorithm(
    caption: caption,
    pseudocode-raw(
      indentation-guide-stroke: .4pt + aqua,
      body
    )
  )
}

// 代码块，使用 codly + i-figure 实现
#let code(caption: "", body) = figure(
  body,
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