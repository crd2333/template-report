#import "@preview/quick-maths:0.1.0": shorthands

// 以类似格式添加符号缩写
#let shorthand = shorthands.with(
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
  ($=<$, $<=$),               // =< becomes '≤'
  ($<=$, math.arrow.l.double) // Replaces '≤'
)
// $<=$ 似乎需要某一边有东西才能正常工作，原因未知

// 以类似格式添加文本缩写
#let le = $=<$
#let ge = $>=$
