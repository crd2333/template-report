#import "@preview/t4t:0.3.2": is
#import "@preview/tablex:0.0.6": tablex, hlinex
#import "@preview/tablem:0.1.0": tablem
#import "@preview/codelst:2.0.0": sourcecode, codelst-lno, code-frame
#import "@preview/lovelace:0.2.0": algorithm, pseudocode-raw
#import "@preview/truthfy:0.3.0": truth-table, truth-table-empty

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

// 使用 figure3 函数替代原生 figure 函数以支持将 codelst 作为代码块来识别。
#let figure3(body, kind: auto, ..args) = figure(
  kind:
    if (kind != auto) {
      kind
    } else if (is.elem(image, body) or is.elem(raw, body)) {
      auto
    } else { // 让其默认为 code(raw)
      raw
    },
  body,
  ..args,
)

// 代码块，使用 codelst + i-figure 实现
#let code(caption: "", body, ..args) = figure3(
  sourcecode(
    ..args,
  )[#body],
  caption: caption,
)

#let algo(caption: "", body) = algorithm(
  caption: caption,
  pseudocode-raw(
    indentation-guide-stroke: .4pt + aqua,
    body
  )
)