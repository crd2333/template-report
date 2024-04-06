#import "lib.typ": *

#set heading(numbering: "1.")
#show: thmrules

= First level heading
#theorem(footer: [The showybox allowes you add footer for boxes, useful when giving some explanation.])[#lorem(20)] <thm1>

= Another first level heading

#theorem(title: "This is a title", lorem(20)) <thm2>

== Second level heading
#definition[The counter will be reset after the first level of heading changes (counting within one chapter).]

#theorem(title: [#text(fill: green, "This is another title")])[Now the counter increases by 1 for type `Theorem`.]

#corollary([One body.], footer: [As well as footer!])[Another body!]

#lemma[#lorem(20)]

#proof[By default the `Proof` will not count itself.\ And the `Proof` box will have a square at the right bottom corner.]

@thm1 (Use the label name to refer)

@thm2
