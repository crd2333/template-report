// 导入本地包
#import "fonts.typ":*
#import "packages/admonition/0.3.0/lib.typ": *

// 导入 preview 包
// 树、图文包裹、图标、真值表
#import "@preview/syntree:0.2.1": syntree, tree
#import "@preview/treet:0.1.1": tree-list
#import "@preview/wrap-it:0.1.1": wrap-content, wrap-top-bottom
#import "@preview/fontawesome:0.5.0": *
#import "@preview/cheq:0.2.2": checklist
#import "@preview/pinit:0.2.2": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/drafting:0.2.2": *
#import "@preview/theorion:0.3.2": *
#import cosmos.fancy: * // theorion 的样式

// 假段落，deprecated
#let fake_par = context{let b=par(box()); b; v(-measure(b+b).height)}

// 中文缩进
#let indent = h(2em)
#let unindent = h(-2em)
#let noindent(body) = {
  set par(first-line-indent: 0em)
  body
}
#let tab = indent     // alias
#let untab = unindent
#let notab(body) = noindent(body)

// list, enum 的修复，来自 @OrangeX4(https://github.com/OrangeX4) 的解决方案
// 解决编号与基线不对齐的问题，同时也恢复了 block width 和 list, enum 的间隔问题
// Align the list marker with the baseline of the first line of the list item.
#let align-list-marker-with-baseline(body) = {
  show list.item: it => {
    let current-marker = {
      set text(fill: text.fill)
      if type(list.marker) == array {
        list.marker.at(0)
      } else {
        list.marker
      }
    }
    context {
      let hanging-indent = measure(current-marker).width + .6em + .3pt
      set terms(hanging-indent: hanging-indent)
      if type(list.marker) == array {
        terms.item(
          current-marker,
          {
            // set the value of list.marker in a loop
            set list(marker: list.marker.slice(1) + (list.marker.at(0),))
            it.body
          },
        )
      } else {
        terms.item(current-marker, it.body)
      }
    }
  }
  body
}
// Align the enum marker with the baseline of the first line of the enum item. It will only work when the enum item has a number like `1.`.
#let align-enum-marker-with-baseline(body) = {
  show enum.item: it => {
    if not it.has("number") or it.number == none or enum.full == true {
      // If the enum item does not have a number, or the number is none, or the enum is full
      return it
    }
    let weight-map = (
      thin: 100,
      extralight: 200,
      light: 300,
      regular: 400,
      medium: 500,
      semibold: 600,
      bold: 700,
      extrabold: 800,
      black: 900,
    )
    let current-marker = {
      set text(
        fill: text.fill,
        weight: if type(text.weight) == int {
          text.weight - 300
        } else {
          weight-map.at(text.weight) - 300
        },
      )
      numbering(enum.numbering, it.number) + h(-.1em)
    }
    let hanging-indent = measure(current-marker).width + .6em + .3pt
    set terms(hanging-indent: hanging-indent)
    terms.item(current-marker, it.body)
  }
  body
}

// 封装 tree-list，使其无缩进、视为整体且支持根节点；选用这个字体使线段连续
#let tree-list = (root: "", breakable: false, body) => {
  let root = if root != "" {[#root\ ]}
  block(breakable: breakable)[
    #noindent()[
      #root
      #tree-list(
        marker-font: "MesloLGS NF",
        marker: [├──#h(0.3em)], // modify as you like
        indent: [│#h(1.5em)],
        last-marker: [└──#h(0.3em)],
        empty-indent: h(2.2em),
        body
      )
    ]
  ]
}

#let date_format(
  date: (2023, 5, 14),
  lang: "en",
  size: "四号",
  font: 字体.宋体,
) = {
  if type(size) != length {size = 字号.at(size)}
  set text(font: font, size: size);
  if lang == "zh" {
    [#date.at(0)年#date.at(1)月#date.at(2)日]
  } else {   // 美式日期格式，月日年
    [#date.at(1).#date.at(2).#date.at(0)]
  }
}

// 目录
#let toc(
  depth: 4,
  indent: 2em,
  toc_break: true
) = {
  set par(first-line-indent: 0pt)
  set text(font: (字体.ntl, 字体.思源黑体), size: 字号.小四)
  outline(
    indent: indent,
    depth: depth
  )
  if toc_break {pagebreak()}
}

#let colors = (
  gray: luma(240),
  blue: rgb(29, 144, 208),
  green: rgb(102, 174, 62),
  red: rgb(237, 32, 84),
  yellow: rgb(255, 201, 23),
  purple: rgb(158, 84, 159),
)

// 双下划线
#let double-line(body) = style(styles => {
  let size = measure(body, styles)
  stack(
    body,
    v(1pt),
    line(length: size.width),
    v(2pt),
    line(length: size.width),
  )
})

// 一条水平横线
#let hline() = {
  line(length: 100%)
}

// 快捷 grid
#let grid2(alignment: center, body1, body2, ..args) = align(alignment, grid(
  columns: 2,
  grid.cell(align: center+horizon)[#body1],
  grid.cell(align: center+horizon)[#body2],
  ..args
))
#let grid3(alignment: center, body1, body2, body3, ..args) = align(alignment, grid(
  columns: 3,
  grid.cell(align: center+horizon)[#body1],
  grid.cell(align: center+horizon)[#body2],
  grid.cell(align: center+horizon)[#body3],
  ..args
))

// 快捷文字着色，实现了红色蓝色，黑色则为粗体，两个 * 即可
#let redt(body) = text(fill: colors.red, body) // red-text
#let bluet(body) = text(fill: colors.blue, body) // blue-text

// pinit 的公式高亮指针
#let pinit-highlight-equation-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), highlight-pins, point-pin, body) = {
  pinit-highlight(..highlight-pins, dy: -0.6em, fill: rgb(..fill.components().slice(0, -1), 40))
  pinit-point-from(
    fill: fill, pin-dx: -0.6em, pin-dy: if pos == bottom { 0.8em } else { -0.6em }, body-dx: 0pt, body-dy: if pos == bottom { -1.7em } else { -1.6em }, offset-dx: -0.6em, offset-dy: if pos == bottom { 0.8em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      }
    )
  )
}

// align center math.equation and figure(image, table) in list and enum
#let align_list_enum(doc) = {
  show list: it => {
    show math.equation.where(block: true): eq => {
      block(width: 100%, inset: 0pt, align(center, eq))
    }
    show figure.where(kind: "image"): it => {
      block(width: 100%, inset: 0pt, align(center, it))
    }
    show figure.where(kind: "table"): it => {
      block(width: 100%, inset: 0pt, align(center, it))
    }
    it
  }
  show enum: it => {
    show math.equation.where(block: true): eq => {
      block(width: 100%, inset: 0pt, align(center, eq))
    }
    show figure.where(kind: "image"): it => {
      block(width: 100%, inset: 0pt, align(center, it))
    }
    show figure.where(kind: "table"): it => {
      block(width: 100%, inset: 0pt, align(center, it))
    }
    it
  }
  doc
}

// 更改注释颜色（如果需要打印等用途，灰色可能难以辨认）
#let comment_color(color: green, doc) = {
  show raw: body => {
    show text: it => if text.fill == rgb("#8A8A8A") { text(fill: color, it) } else { it }
    body
  }
  doc
}
