/*
  typst-admonitions is a typst package that provides admonitions for typst. The icons are redrawed based on those in [material](https://squidfunk.github.io/mkdocs-material/reference/admonitions/). And it's easy to modify and add new icons.

  author: crd2333

  version: 0.1
  add iconbox
  add admonitions(note, abstract, info, tip, success, question, warning, failure, bug, danger, example, example2, quote)

  version: 0.2
  add font style and size for caption and body
*/

#let iconbox(
  body,
  caption: "iconbox",
  icon: emoji.info,    // a symbol or an image
  iconsize: 18pt,      // iconsize for symbol
  blockcolor: gray,    // background color for caption
  breakable: true,     // whether the box can be broken
  stroke: 1pt + black, // stroke size and color
  inset: 8pt,          // inset of the block
  radius: 4pt,         // radius of the block corners
  font: (:),           // font of caption and body
  caption_size: 13pt,  // size of the caption
  size: 10.5pt,        // size of content
  indent: true,        // whether indent is needed
  ..args
) = {
  set block(breakable: breakable)
  // caption, placed in the first block
  let title = if font != (:) {
      text(font: font, size: caption_size, weight: "bold", baseline: -0.4em, ligatures: false)[#caption]
    } else {
      text(size: caption_size, weight: "bold", baseline: -0.4em, ligatures: false)[#caption]
    }
  let caption = box(height: iconsize)[
    #if type(icon) == "symbol" {
        move(dy: 0.2em, text(iconsize, icon))
    } else {
      image(icon, fit: "contain")
    }
  ] + " " + title

  let body = if font != (:) {
    text(font: font, size: size)[#body]
  } else {
    text(size: size)[#body]
  }

  // the caption block
  let cap_block = block(
    fill: blockcolor,
    width: 100%,
    inset: inset,
    radius: (
      top-left: radius,
      top-right: radius,
    ),
    stroke: (
      bottom: none,
      rest: stroke,
    ),
    ..args
  )[#caption]

  // the second block
  let block = block(
      inset: inset,
      radius: (
        bottom-left: radius,
        bottom-right: radius,
      ),
      stroke: (
        top: none,
        rest: stroke,
      ),
    )[
      #pad(x: -inset, y: -10pt)[#cap_block] // caption block
      #parbreak()
      #if indent {h(2em)}
      #body
    ]

  block // negative padding to avoid extra space due to move
  // v(0.5em) // indent for the text below, can be delelted if not required
}

#let note(body, caption: none, icon: "svg/note.svg", blockcolor: rgb(236, 243, 255), stroke: rgb(68, 138, 255), ..args) = {
  caption = if caption == none {"Note"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let abstract(body, caption: none, icon: "svg/abstract.svg", blockcolor: rgb(229, 247, 255), stroke: rgb(0, 176, 255), ..args) = {
  caption = if caption == none {"Abstract"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let info(body, caption: none, icon: "svg/info.svg", blockcolor: rgb(229, 248, 251), stroke: rgb(0, 184, 212), ..args) = {
  caption = if caption == none {"Info"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let tip(body, caption: none, icon: "svg/tip.svg", blockcolor: rgb(229, 248, 246), stroke: rgb(0, 191, 165), ..args) = {
  caption = if caption == none {"Tip"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let success(body, caption: none, icon: "svg/success.svg", blockcolor: rgb(229, 249, 237), stroke: rgb(0, 200, 83), ..args) = {
  caption = if caption == none {"Success"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let question(body, caption: none, icon: "svg/question.svg", blockcolor: rgb(239, 252, 231), stroke: rgb(100, 221, 23), ..args) = {
  caption = if caption == none {"Question"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let warning(body, caption: none, icon: "svg/warning.svg", blockcolor: rgb(255, 244, 229), stroke: rgb(255, 145, 0), ..args) = {
  caption = if caption == none {"Warning"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let failure(body, caption: none, icon: "svg/failure.svg", blockcolor: rgb(255, 237, 237), stroke: rgb(255, 82, 82), ..args) = {
  caption = if caption == none {"Failure"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let bug(body, caption: none, icon: "svg/bug.svg", blockcolor: rgb(254, 229, 238), stroke: rgb(245, 0, 87), ..args) = {
  caption = if caption == none {"Bug"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let danger(body, caption: none, icon: "svg/danger.svg", blockcolor: rgb(255, 231, 236), stroke: rgb(255, 23, 68), ..args) = {
  caption = if caption == none {"Danger"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let example(body, caption: none, icon: "svg/example2.svg", blockcolor: rgb(242, 237, 255), stroke: rgb(124, 77, 255), ..args) = {
  caption = if caption == none {"Example"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let example2(body, caption: none, icon: "svg/example1.svg", blockcolor: rgb(242, 237, 255), stroke: rgb(124, 77, 255), ..args) = {
  caption = if caption == none {"Example"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}

#let quote(body, caption: none, icon: "svg/quote.svg", blockcolor: rgb(245, 245, 245), stroke: rgb(158, 158, 158), ..args) = {
  caption = if caption == none {"Quote"} else {caption}
  iconbox(caption: caption, icon: icon, blockcolor: blockcolor, stroke: stroke, ..args)[#body]
}
