#import "@preview/t4t:0.3.2": is
#import "@preview/tablex:0.0.6": tablex, hlinex, vlinex, colspanx, rowspanx, cellx
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

// 使用 figure2 函数替代原生 figure 函数以支持将 tablex 作为表格来识别。
#let figure2(body, kind: auto, ..args) = figure(
  kind:
    if (kind != auto) {
      kind
    } else if (is.elem(image, body) or is.elem(raw, body)) {
      auto
    } else { // 让其默认为 table
      table
    },
  body,
  ..args,
)

// 普通表，使用 tablex 实现
#let tbl(caption: "", alignment: center + horizon, ..args) = figure2(
  tablex(
    align: alignment,
    ..args,
  ),
  caption: caption,
)
// 三线表，包含居中，使用 tablex 实现
#let tlt(caption: "", alignment: center + horizon, ..args) = figure2(
  tablex(
    auto-lines: false,
    align: alignment,
    hlinex(y: 0),
    hlinex(y: 1),
    ..args,
    hlinex(),
  ),
  caption: caption,
)

// 类 markdown 表格，使用 tablem 实现
#let tblm(caption: "", ..args) = figure2(
  tablem(
    ..args,
  ),
  caption: caption,
)

// 真值表，使用 truthfy 实现
#let truth-tbl(caption: "", ..args) = figure2(
  caption: caption,
  truth-table(..args)
)
#let truth-tbl-empty(caption: "", ..args) = figure2(
  caption: caption,
  truth-table-empty(..args)
)

// 算法框，使用 lovelace 实现
#let algo(caption: "", body) = {
  // 去除当以 "[]" 形式传参时 body "[]"，方法比较笨，轻喷
  if "children" in body.fields() {
    body = body.children
    body.remove(0)
    body.remove(body.len() - 1)
    body = body.at(0)
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