#import "lib.typ": *
#show: thmrules.with(qed-symbol: $square$)

#set page(width: 16cm, height: auto, margin: 1.5cm)
#set heading(numbering: "1.1.")

= Prime numbers

= First level heading
#theorem(footer: [The showybox allowes you add footer for boxes, useful when giving some explanation.])[#lorem(10)] <thm1>

= Another first level heading

#theorem(lorem(10)) <thm2>

== Second level heading
#definition[The counter will be reset after the first level of heading changes, i.e. counting within one chapter(can be changed)).]

#theorem(title: [#text(fill: green, "This is another title")])[Now the counter increases by 1 for type `Theorem`.]

#corollary(title: [a title], [Another body!], footer: [As well as footer!])[Corollary counter based on theorem(can be changed).]

#lemma[#lorem(10)]

#proof[By default the `Proof` will not count itself.\ And the `Proof` box will have a square at the right bottom corner.]

#example()[By default the `example` will not count itself.]

@thm1[self-defined name]

@thm2
