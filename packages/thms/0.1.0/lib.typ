#import "@preview/showybox:2.0.1": showybox

#let reset-counters-box(it, level: 1, extra-kinds: (), return-orig-heading: true) = {
  if it.level <= level {
    for kind in ("Theorem", "Definition", "Lemma", "Corollary", "Proof") {
      counter(kind).update(0)
    }
  }
  if return-orig-heading {
    it
  }
}

#let thm-base(
  type: "Theorem",
  color: blue,
  ..args) = {
  let heading_num = context counter(heading).get().at(0)
  let thm_counter = counter(type)
  let thm_num = {
    thm_counter.step()
    heading_num + "." + thm_counter.display()
  }
  return figure(
    showybox(
      frame: (
        title-color: color.lighten(10%),
        body-color: color.lighten(90%),
        footer-color: color.lighten(70%),
        border-color: color,
        radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt)
      ),
      title: type+" "+thm_num,
      ..args
    ),
    supplement: type,
    kind: type,
  )
}

#let theorem(body, ..args) = thm-base(type: "Theorem", color: blue, body, ..args)
#let definition(body, ..args) = thm-base(type: "Definition", color: orange, body, ..args)
#let lemma(body, ..args) = thm-base(type: "Lemma", color: purple, body, ..args)
#let corollary(body, ..args) = thm-base(type: "Corollary", color: green, body, ..args)
#let proof(body, ..args) = {
  body = body + h(1fr) + box(scale(160%, origin: bottom + right, sym.square.stroked))
  return thm-base(type: "Proof", color: gray.darken(30%), body, ..args)
}