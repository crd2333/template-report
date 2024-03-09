#let todo_counter = counter("todos")

#let todo(content, inline: false, fill: white, note: "", numbers: none, border_radius: 4pt, border_stroke: 1pt, inline_width:100%, line_stroke: black + 0.1em, underline_content: false) = {
    locate(loc => {
        let heading_counter = counter(heading).at(loc)
        let todo_count = todo_counter.at(loc)
        let note_counter = (..heading_counter, ..todo_count)
        let count_display = if numbers != none { [#numbering(numbers, ..note_counter)] }
        if inline {
            assert(note.len() == 0, message: "inline notes cannot have separate note text")
            [#box(rect(width:inline_width, fill:fill, radius:border_radius, stroke:border_stroke, [#count_display #content])) <todos>]
        } else {
        let content = if underline_content {underline(stroke:line_stroke, evade: false, content)}else{content}
            [#box(rect(fill:fill, radius:border_radius, stroke:border_stroke, [#count_display #note])) <todos> #content]
        }
        todo_counter.step()
    })
}

#let missing_figure(content, width: 100%, fill: gray, stroke: none, prefix: [*Missing Figure*:]) = {
    rect(width: width, fill: fill, stroke: stroke, [#prefix #content])
}

#let list_of_todos(title: "List of Todos", outlined: true, numbers: none) = {
    heading(title, numbering: none, outlined: outlined)

    locate(loc => {
        let todos = query(<todos>, loc)

        for todo in todos {
            let location = todo.location()
            let todo_counter = todo_counter.at(location)
            let heading_counter = counter(heading).at(location)
            let note_counter = (..heading_counter, ..todo_counter)
            let counter_display = if numbers != none { numbering(numbers, ..note_counter) }
            let page = counter(page).at(location)
            let body = todo.body.body.children.last()
            let body_func = body.func()
            let text_slug = if body_func == text {
                let text = body.at("text")
                text.slice(0, calc.min(90,text.len()))
            } else {
                body.children.first()
            }
            [
                #link(todo.location())[
                    #box(width: 1em, height:1em, fill: todo.body.fill, stroke: todo.body.stroke)
                    #counter_display #text_slug
                ]
                #box(width: 1fr, repeat[.])
                #link(todo.location(), [
                    #numbering("1", ..page)
                ]) \
            ]
        }
    })
}
