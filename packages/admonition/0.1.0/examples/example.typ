#import "../lib.typ": *

#note()[test]
#abstract()[test]
#info()[test]
#tip()[test]
#success()[test]
#question()[test]
#warning()[test]
#failure()[test]
#bug()[test]
#danger()[test]
#example()[test]
#example2()[test]
#quote()[test]

#note(icon: "../svg/info.svg")[command for note but use info icon]

#note(icon: emoji.face.cry)[command for note but use emoji icon]

#info(caption: "This is a caption")[
  Cpation can be self defined if determined, otherwise it will be the same as the type.

  Currently supported types are:\
  note, abstract, info, tip, success, question, warning, failure, bug, danger, example, quote.
]