// typst 读取字体的规则是从前往后，如果找不到对应就往后找
// 下面是我觉得还算好看的字体，不过基本只使用了宋体和黑体，英文统一用 Arial，中文分宋体、黑体和楷体
#let 字体 = (
  宋体: ("Arial", "Noto Serif CJK SC"),
  黑体: ("Arial", "Noto Sans CJK SC"),
  思源宋体: "Noto Serif CJK SC",
  思源黑体: "Noto Sans CJK SC",
  楷体: ("Arial", "LXGW WenKai"),
  ntl: "Microsoft New Tai Lue",
  meslo: "MesloLGS NF",
  tnr: "Times New Roman",
);

#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  八号: 5pt
);
