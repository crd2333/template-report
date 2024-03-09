#import "fonts.typ":*

// 导入自定义包
// todo、emoji、两种 box
#import "../packages/todo/lib.typ": todo
#import "../packages/svg-emoji/lib.typ": setup-emoji, github
#import "../packages/admonition/lib.typ": *
#import "../packages/thms/thm-envs.typ": *

// 导入第三方包中的工具
// 可变长箭头、树、图文包裹、图标、真值表
#import "@preview/xarrow:0.3.0": xarrow, xarrowSquiggly, xarrowTwoHead
#import "@preview/syntree:0.2.0": syntree
#import "@preview/treet:0.1.0": *
#import "@preview/wrap-it:0.1.0": wrap-content, wrap-top-bottom
#import "@preview/fontawesome:0.1.0": *
#import "@preview/quick-maths:0.1.0": shorthands

#let _empty_par() = {
  v(-1em)
  box()
}

#let _empty_par_larger() = {
  _empty_par()
  _empty_par()
  _empty_par()
  _empty_par()
}

#let _empty_par_huge() = {
  _empty_par_larger()
  _empty_par_larger()
  _empty_par_larger()
  _empty_par_larger()
}

// 中文缩进
#let indent = h(2em)
#let tab = indent // alias

#let noindent(body) = {
  set par(first-line-indent: 0em)
  body
}

// 封装 tree-list，使其无缩进、视为整体且支持根节点；选用这个字体使线段连续
#let tree-list = (root: "", breakable: false, body) => {
  let root = if root != "" {[#root\ ]}
  block(breakable: breakable)[#noindent()[#root#tree-list(marker-font: "MesloLGS NF", body)]]
}

#let date_format(
  date: (2023, 5, 14),
  lang: "en",
  size: "四号",
  font_style: 字体.宋体,
) = {
  if type(size) != length {size = 字号.at(size)}
  set text(font: font_style, size: size);
  if lang == "zh" {
    [#date.at(0)年#date.at(1)月#date.at(2)日]
  } else {   // 美式日期格式，月日年
    [#date.at(1).#date.at(2).#date.at(0)]
  }
}

// 目录
#let toc(
  lang: "en"
) = {
  if lang == "en" {
    align(center)[
      #text(font: (字体.ntl, 字体.思源黑体), size: 字号.小二, "Catalog")
    ]
  } else if lang == "zh" {
    align(center)[
      #text(font: (字体.ntl, 字体.思源黑体), size: 字号.小二, "目录")
    ]
  }

  parbreak()
  set text(font: (字体.ntl, 字体.思源黑体), size: 字号.小四)
  set par(first-line-indent: 0pt)
  show outline: it => {
    set text(font: (字体.ntl, 字体.思源黑体), size: 字号.小四)
    it
    parbreak()
  }
  outline(
    title: none,
    indent: true,
  )
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

// 汉字伪粗体，from https://discord.com/channels/1054443721975922748/1054443722592497796/1175967383630921848
#let skew(angle, vscale: 1, body) = {
  let (a, b, c, d) = (1, vscale * calc.tan(angle), 0, vscale)
  let E = (a + d) / 2
  let F = (a - d) / 2
  let G = (b + c) / 2
  let H = (c - b) / 2
  let Q = calc.sqrt(E * E + H * H)
  let R = calc.sqrt(F * F + G * G)
  let sx = Q + R
  let sy = Q - R
  let a1 = calc.atan2(F, G)
  let a2 = calc.atan2(E, H)
  let theta = (a2 - a1) / 2
  let phi = (a2 + a1) / 2

  set rotate(origin: bottom + center)
  set scale(origin: bottom + center)

  rotate(phi, scale(x: sx * 100%, y: sy * 100%, rotate(theta, body)))
}
#let fake-italic(body) = box(skew(-12deg, body))
