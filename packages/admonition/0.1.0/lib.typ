/*
  typst-admonitions is a typst package that provides admonitions for typst. The icons are repainted based on those in [material](https://squidfunk.github.io/mkdocs-material/reference/admonitions/). And it's easy to modify and add new icons.

  author: crd2333

  version: 0.1
  add iconbox
  add admonitions(note, abstract, info, tip, success, question, warning, failure, bug, danger, example, example2, quote)

  version: 0.2
  add font style and size for caption and body

  version: 0.3
  Nearly rewrite the code the implement admonitions by showybox, making it more flexible.
*/
#import "@preview/showybox:2.0.1": showybox

#let iconbox(
  icon: emoji.info,    // a symbol or an image
  caption: "iconbox",  // title of the box
  caption_size: 16pt,  // size of the caption
  size: 12pt,          // size of content
  breakable: true,     // whether the box can be broken across pages
  ..args
) = {
  let caption = box(height: caption_size,
    if type(icon) == "symbol" {
      pad(caption_size * 0.15, text(caption_size, icon))
    } else {
      image(icon, fit: "contain", width: caption_size)
    }
  ) + " " + box(height: caption_size * 0.8,
    text(size: caption_size, ligatures: false, caption)
  )
  let body = showybox(
    frame: (
      border-color: rgb(68, 138, 255),
      title-color: rgb(236, 243, 255),
      footer-color: rgb(236, 243, 255).lighten(50%),
      title-inset: 10pt,
    ),
    title-style: (
      color: black,
      weight: "bold",
      align: left
    ),
    shadow: (
      offset: 1pt,
    ),
    title: caption,
    breakable: breakable,
    sep: (
      dash: "densely-dashed"
    ),
    align: right,
    ..args,
  )
  if size != 0 {
    set text(size: size)
    body
  } else {
    body
  }
}

// Below are the predefined admonitions
#let note(
  caption: "Note",
  icon: "svg/note.svg",
  titlecolor: rgb(236, 243, 255),
  bordercolor: rgb(68, 138, 255),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let abstract(
  caption: "Abstract",
  icon: "svg/abstract.svg",
  titlecolor: rgb(229, 247, 255),
  bordercolor: rgb(0, 176, 255),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let info(
  caption: "Info",
  icon: "svg/info.svg",
  titlecolor: rgb(229, 248, 251),
  bordercolor: rgb(0, 184, 212),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let tip(
  caption: "Tip",
  icon: "svg/tip.svg",
  titlecolor: rgb(229, 248, 246),
  bordercolor: rgb(0, 191, 165),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let success(
  caption: "Success",
  icon: "svg/success.svg",
  titlecolor: rgb(229, 249, 237),
  bordercolor: rgb(0, 200, 83),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let question(
  caption: "Question",
  icon: "svg/question.svg",
  titlecolor: rgb(239, 252, 231),
  bordercolor: rgb(100, 221, 23),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let warning(
  caption: "Warning",
  icon: "svg/warning.svg",
  titlecolor: rgb(255, 244, 229),
  bordercolor: rgb(255, 145, 0),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let failure(
  caption: "Failure",
  icon: "svg/failure.svg",
  titlecolor: rgb(255, 237, 237),
  bordercolor: rgb(255, 82, 82),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let bug(
  caption: "Bug",
  icon: "svg/bug.svg",
  titlecolor: rgb(254, 229, 238),
  bordercolor: rgb(245, 0, 87),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let danger(
  caption: "Danger",
  icon: "svg/danger.svg",
  titlecolor: rgb(255, 231, 236),
  bordercolor: rgb(255, 23, 68),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let example(
  caption: "Example",
  icon: "svg/example2.svg",
  titlecolor: rgb(242, 237, 255),
  bordercolor: rgb(124, 77, 255),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let example2(
  caption: "Example",
  icon: "svg/example1.svg",
  titlecolor: rgb(242, 237, 255),
  bordercolor: rgb(124, 77, 255),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)

#let quote(
  caption: "Quote",
  icon: "svg/quote.svg",
  titlecolor: rgb(245, 245, 245),
  bordercolor: rgb(158, 158, 158),
  ..args
) = iconbox(
  frame: (
    title-color: titlecolor,
    border-color: bordercolor,
    footer-color: titlecolor.lighten(60%),
    title-inset: 6pt,
  ),
  caption: caption,
  icon: icon,
  ..args
)
