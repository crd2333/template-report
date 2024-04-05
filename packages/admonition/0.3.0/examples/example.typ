#import "../lib.typ": *

#note(caption: [Self_defined Title], footer: [This is a footer.])[admonitions implemented by showybox, making the box more flexible.]

#info(caption: "Change size and info", caption_size: 20pt, size: 14pt,
  [Caption and content size can be changed.],
  [Currently supported types are:\
    *note, abstract, info, tip, success, question, warning, failure, bug, danger, example, quote.*
  ]
)

#abstract(caption: "Abstract", footer: [This is a footer.])[test]

#note(icon: emoji.face.cry)[command for note but use emoji icon]

#info(caption: "Info",
  [test],
  footer: [This is a footer.],
)

#tip(caption: "Tip",
  [test],
  footer: [This is a footer.],
)

#success(
  [test],
  footer: [This is a footer.],
)

#question(
  [This block is breakable.],
  footer: [This is a footer.],
)

#warning(
  [test],
  footer: [This is a footer.],
)

#failure(
  [test],
  footer: [This is a footer.],
)

#bug(
  [test],
  footer: [This is a footer.],
)

#danger(
  [test],
  footer: [This is a footer.],
)

#example(
  [test],
  footer: [This is a footer.],
)

#example2(
  [test],
  footer: [This is a footer.],
)

#quote(
  [test],
  footer: [This is a footer.],
)
