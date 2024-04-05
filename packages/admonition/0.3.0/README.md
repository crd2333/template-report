# typst-admonition

[This package](https://github.com/crd2333/typst-admonition) is admonitions in [typst](https://github.com/typst/typst).

The icons are repainted from [material](https://squidfunk.github.io/mkdocs-material/reference/admonitions/). And it's easy to modify and add new icons.

After version 0.3.0, the package is nearly rewritten by [showybox](https://github.com/Pablo-Gonzalez-Calderon/showybox-package).

![example](examples/example1.png)
![example](examples/example2.png)

## Usage
```typst
#import "/path/to/typst-admonition/lib.typ": *

#info(caption: "This is a caption",
  [Caption and content size can be changed.],
  [Currently supported types are:\
    *note, abstract, info, tip, success, question, warning, failure, bug, danger, example, quote.*
  ]
)
```

For more information, see `examples/example.typ`.