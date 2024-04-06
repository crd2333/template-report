/*
Theorems boxes implemented by showybox, providing a beautiful way to display theorems, definitions, lemmas, corollaries, and proofs.
The boxes will be counted like x.y, where x is the first level heading number and y is the box number of the type.

Author: crd233
*/

#import "@preview/showybox:2.0.1": showybox

#let thmrules(doc) = {
  let types = ("Theorem", "Definition", "Lemma", "Corollary", "Proof")
  // update all counters when first level heading is updated
  show heading: it => {
    if it.level <= 1 {
      for kind in types {
        counter(kind).update(1)
      }
    }
    it
  }
  // use the label name to refer
  show ref: it => {
    if (it.element != none and it.element.has("kind") and it.element.kind in types) {
      return link(it.target, [#str(it.element.at("label"))])
    } else {it}
  }
  doc
}

#let thm-base(
  type: "thm-base",
  color: blue,
  title: "",
  count: true,
  body,
  ..args) = {
  let heading_num = context counter(heading).get().at(0)
  let thm_counter = counter(type)
  if title != "" and count {
    title = type + " " + heading_num + "." + thm_counter.display() + ": " + title
  } else if count {
    title = type + " " + heading_num + "." + thm_counter.display()
  } else {
    title = type
  }

  return figure(
    showybox(
      title-style: (
        weight: "bold",
        boxed-style: (
          anchor: (x: left, y: horizon),
          radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
        )
      ),
      frame: (
        title-color: color.lighten(10%),
        body-color: color.lighten(90%),
        footer-color: color.lighten(70%),
        border-color: color,
        radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt)
      ),
      sep: (
        dash: "dashed",
      ),
      title: title,
      [#thm_counter.step() #body],
      ..args
    ),
    supplement: type,
    kind: type
  )
}

#let theorem(..args) = thm-base(type: "Theorem", color: blue, ..args)
#let definition(..args) = thm-base(type: "Definition", color: orange, ..args)
#let lemma(..args) = thm-base(type: "Lemma", color: purple, ..args)
#let corollary(..args) = thm-base(type: "Corollary", color: green, ..args)
#let proof(body, ..args) = {
  body = body + h(1fr) + box(scale(160%, origin: bottom + right, sym.square.stroked))
  return thm-base(type: "Proof", color: gray.darken(30%), count: false, body, ..args)
}
