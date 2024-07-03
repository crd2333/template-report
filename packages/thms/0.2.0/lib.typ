// the 0.1.0 version is not efficient like ctheorem, so implement the thms by showybox based on [ctheorem](https://github.com/sahasatvik/typst-theorems/)

#import "@preview/showybox:2.0.1": showybox

// Store theorem environment numbering
#let thmcounters = state("thm",
  (
    "counters": ("heading": ()),
    "latest": ()
  )
)

#let thmenv(identifier, base, base_level, fmt) = {

  let global_numbering = numbering

  return (
    ..args,
    body,
    title: none,
    number: auto,
    numbering: "1.1",
    refnumbering: auto,
    supplement: identifier,
    base: base,
    base_level: base_level
  ) => {
    let name = none
    if args != none and args.pos().len() > 0 {
      name = args.pos().first()
    }
    if refnumbering == auto {
      refnumbering = numbering
    }
    let result = none
    if number == auto and numbering == none {
      number = none
    }
    if number == auto and numbering != none {
      result = locate(loc => {
        return thmcounters.update(thmpair => {
          let counters = thmpair.at("counters")
          // Manually update heading counter
          counters.at("heading") = counter(heading).at(loc)
          if not identifier in counters.keys() {
            counters.insert(identifier, (0, ))
          }

          let tc = counters.at(identifier)
          if base != none {
            let bc = counters.at(base)

            // Pad or chop the base count
            if base_level != none {
              if bc.len() < base_level {
                bc = bc + (0,) * (base_level - bc.len())
              } else if bc.len() > base_level{
                bc = bc.slice(0, base_level)
              }
            }

            // Reset counter if the base counter has updated
            if tc.slice(0, -1) == bc {
              counters.at(identifier) = (..bc, tc.last() + 1)
            } else {
              counters.at(identifier) = (..bc, 1)
            }
          } else {
            // If we have no base counter, just count one level
            counters.at(identifier) = (tc.last() + 1,)
            let latest = counters.at(identifier)
          }

          let latest = counters.at(identifier)
          return (
            "counters": counters,
            "latest": latest
          )
        })
      })

      number = thmcounters.display(x => {
        return global_numbering(numbering, ..x.at("latest"))
      })
    }

    return figure(
      result +  // hacky!
      fmt(number, title, body, ..args) +
      [#metadata(identifier) <meta:thmenvcounter>],
      kind: "thmenv",
      outlined: false,
      caption: name,
      supplement: supplement,
      numbering: refnumbering,
    )
  }
}


#let thmbox(
  identifier,
  head,
  fill: blue,
  ..blockargs,
  supplement: auto,
  padding: (top: 0.5em, bottom: 0.5em),
  separator: [#h(0.1em):#h(0.2em)],
  bodyfmt: x => x,
  base: "heading",
  base_level: none,
) = {
  if supplement == auto {
    supplement = head
  }
  let boxfmt(number, title, body, ..blockargs_individual) = {
    if title != none {
      title = ": " + title
    }
    body = bodyfmt(body)
    pad(
      ..padding,
      showybox(
        title-style: (
          weight: "bold",
          boxed-style: (
            anchor: (x: left, y: horizon),
            radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
          )
        ),
        frame: (
          title-color: fill.lighten(10%),
          body-color: fill.lighten(90%),
          footer-color: fill.lighten(70%),
          border-color: fill,
          radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt)
        ),
        sep: (
          dash: "dashed",
        ),
        title: [#head #number#title],
        [#body],
        ..blockargs_individual,
        ..blockargs.named()
      ),
    )
  }
  return thmenv(
    identifier,
    base,
    base_level,
    boxfmt
  ).with(
    supplement: supplement,
  )
}


#let thmplain = thmbox.with(
  padding: (top: 0em, bottom: 0em),
  breakable: true,
)

// Track whether the qed symbol has already been placed in a proof
#let thm-qed-done = state("thm-qed-done", false)

// Show the qed symbol, update state
#let thm-qed-show = {
  thm-qed-done.update("thm-qed-symbol")
  thm-qed-done.display()
}

// If placed in a block equation/enum/list, place a qed symbol to its right
#let qedhere = metadata("thm-qedhere")

// Checks if content x contains the qedhere tag
#let thm-has-qedhere(x) = {
  if x == "thm-qedhere" {
    return true
  }

  if type(x) == content {
    for (f, c) in x.fields() {
      if thm-has-qedhere(c) {
        return true
      }
    }
  }

  if type(x) == array {
    for c in x {
      if thm-has-qedhere(c) {
        return true
      }
    }
  }

  return false
}


// bodyfmt for proofs
#let proof-bodyfmt(body) = {
  thm-qed-done.update(false)
  body
  locate(loc => {
    if thm-qed-done.at(loc) == false {
      h(1fr)
      thm-qed-show
    }
  })
}

#let thmrules(qed-symbol: $qed$, doc) = {

  show figure.where(kind: "thmenv"): it => it.body

  show ref: it => {
    if it.element == none {
      return it
    }
    if it.element.func() != figure {
      return it
    }
    if it.element.kind != "thmenv" {
      return it
    }

    let supplement = it.element.supplement
    if it.citation.supplement != none {
      supplement = it.citation.supplement
    }

    let loc = it.element.location()
    let thms = query(selector(<meta:thmenvcounter>).after(loc), loc)
    let number = thmcounters.at(thms.first().location()).at("latest")
    return link(
      it.target,
      [#supplement~#numbering(it.element.numbering, ..number)]
    )
  }

  show math.equation.where(block: true): eq => {
    if thm-has-qedhere(eq) and thm-qed-done.at(eq.location()) == false {
      grid(
        columns: (1fr, auto, 1fr),
        [], eq, align(right + horizon)[#thm-qed-show]
      )
    } else {
      eq
    }
  }

  show enum.item: it => {
    show metadata.where(value: "thm-qedhere"): {
      h(1fr)
      thm-qed-show
    }
    it
  }

  show list.item: it => {
    show metadata.where(value: "thm-qedhere"): {
      h(1fr)
      thm-qed-show
    }
    it
  }

  show "thm-qed-symbol": qed-symbol

  doc
}

#let theorem = thmbox("theorem", "Theorem", fill: blue, base_level: 1)

#let corollary = thmplain("corollary", "Corollary", fill: orange, base: "theorem")

#let definition = thmbox("definition", "Definition", fill: green, base_level: 1)

#let lemma = thmbox("lemma", "Lemma", fill: purple, base_level: 1)

#let example = thmplain("example", "Example", fill: rgb(51, 198, 221)).with(numbering: none)

#let proof = thmplain("proof", "Proof", fill: gray.darken(30%), bodyfmt: proof-bodyfmt,
).with(numbering: none)