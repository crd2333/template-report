#import "./lib.typ": setup-emoji, noto, github

#show: setup-emoji.with(font: noto)

// list all the emojis
#let github_list = github.keys().zip(github.values())

#grid(
  columns: 3,
  gutter: 2pt,
  ..github_list.map(it => it.first() + ": " + it.last())
)
