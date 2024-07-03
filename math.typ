#import "@preview/quick-maths:0.1.0": shorthands
#import "@preview/mitex:0.2.4": *

// 以类似格式添加符号缩写
#let shorthand = shorthands.with(
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
  ($=<$, $<=$),               // =< becomes '≤'
  ($<=$, math.arrow.l.double), // Replaces '≤'，似乎需要某一边有东西才能正常工作，原因未知
  ($~$, $med$),
)

// 以类似格式添加文本缩写
#let le = $<=$
#let ge = $>=$
#let infty = $infinity$
#let wave = $dash.wave$ // alternative to ~
// 带圈数字，在 sym 里没找到，Unicode 字符中的又太小，故自己实现，希望没 bug
#let czero  = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "0")]) // circle zero
#let cone   = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "1")])  // circle one
#let ctwo   = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "2")])
#let cthree = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "3")])
#let cfour  = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "4")])
#let cfive  = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "5")])
#let csix   = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "6")])
#let cseven = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "7")])
#let ceight = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "8")])
#let cnine  = box(baseline: 15%, circle(radius: 5pt)[#align(center + horizon, "9")])
