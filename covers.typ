#import "fonts.typ":*
#import "utils.typ":*

#let _info_key(body) = {
  rect(width: 100%, inset: 2pt,
    stroke: none,
    text(
      font: 字体.宋体,
      size: 字号.三号,
      body
    )
  )
}

#let _info_value(body) = {
  rect(
    width: 120%,
    inset: 3pt,
    stroke: (
      bottom: 1pt + black
    ),
    text(
      font: 字体.宋体,
      size: 字号.三号,
      bottom-edge: "descender"
    )[#body]
  )
}

#let cover_normal(
  title: "Title",
  author: "author",
  date: (2023, 5, 14),
  lang: "en",
  show_name: true,
  ..args
) = {
  let author = if show_name {author} else {none};
  set page("a4", numbering: none, margin: (top: 10%));
  align(center)[
    #image("assets/校名.jpg", width: 60%)
    #v(4em)
    #image("assets/校徽.jpg", width: 70%)
    #set par(leading: 1.5em)
    #v(3.5em)
    #text(title, font: 字体.宋体, size: 字号.小一, weight: "bold")
    #v(1em)
    #text(author, font: 字体.宋体, size: 字号.三号)
    #v(0.5em)
    #date_format(date: date, lang: lang)
  ]
}

#let cover_report(
  title: "",
  title_2: "",
  author: "",
  class: "",
  grade: "",
  department: "",
  date: (2023, 04, 17),
  id: "",
  lang: "en",
  mailbox: "",
  major: "",
  mentor: "",
  type: 1,
  ..args
) = {
  date = date_format(date: date, lang: lang, size: 字号.三号)
  align(center + horizon)[
    #image("assets/校名.jpg", width: 40%)
    #image("assets/校徽.jpg", width: 60%)
    #text(title, font: 字体.宋体, size: 字号.小一, weight: "bold")
    #v(0.5em)
    #if (lang == "en") {
      let title = (_info_key("Project Name"), _info_value(title_2))
      let author = (_info_key("Student Name"), _info_value(author))
      let id = (_info_key("Student ID"), _info_value(id))
      let class = (_info_key("Class"), _info_value(class))
      let major = (_info_key("Major"), _info_value(major))
      let department = (_info_key("Department"), _info_value(department))
      let date = (_info_key("Date"), _info_value(date))
      let mailbox = (_info_key("Mailbox"), _info_value(mailbox))
      let mentor = (_info_key("Mentor"), _info_value(mentor))
      let info_show = if type == "1" {
        (title + author + id + class + department + date)
        } else if type == "2" {
          (title + author + department + major + mailbox + date)
        } else if type == "3" {
          (title + author + id + mailbox + mentor + date)
        }
      grid(
        columns: (160pt, 180pt),
        rows: (40pt, 40pt),
        gutter: 3pt,
        ..info_show
      )
    } else {
      let title = (_info_key("实验题目"), _info_value(title_2))
      let author = (_info_key("学生姓名"), _info_value(author))
      let id = (_info_key("学　　号"), _info_value(id))
      let class = (_info_key("班　　级"), _info_value(class))
      let major = (_info_key("专　　业"), _info_value(major))
      let department = (_info_key("所在学院"), _info_value(department))
      let date = (_info_key("提交日期"), _info_value(date))
      let mailbox = (_info_key("邮　　箱"), _info_value(mailbox))
      let mentor = (_info_key("指导教师"), _info_value(mentor))
      let info_show = if type == "1" {
        (title + author + id + class + department + date)
        } else if type == "2" {
          (title + author + department + major + mailbox + date)
        } else if type == "3" {
          (title + author + id + mailbox + mentor + date)
        }
      grid(
        columns: (120pt, 180pt),
        rows: (40pt, 40pt),
        gutter: 3pt,
        ..info_show
      )
    }
  ]
  pagebreak()
}

#let cover_anonymous_report(
  title: "",
  title_2: "",
  title_3: "",
  author: "",
  date: (2023, 5, 14),
  lang: "en",
  ..args
) = {
  align(center + horizon)[
    #image("assets/校名.jpg", width: 60%)
    #v(5em)
    #image("assets/校徽.jpg", width: 70%)
    #v(3em)
    #text(title, font: 字体.宋体, size: 字号.小一, weight: "bold")
    #v(1em)
    #text(title_2, font: 字体.宋体, size: 字号.小二 + 2pt)
    #v(0.5em)
    #text(title_3, font: 字体.宋体, size: 字号.小二,)
    #v(0.1em)
    #date_format(date: date, lang: lang)
  ]
  pagebreak()
}

#let show_cover(infos: (:)) = {
  // 如果 report_type 中含有数字，则提取并细化设置 report 类型，默认为 1
  let report_type = if infos.cover_style.match(regex("\d+")) != none {infos.cover_style.match(regex("\d+")).text} else {"1"}
  let cover_style = infos.cover_style.trim(report_type)
  if cover_style == "report" and infos.show_name { cover_report(type: report_type, ..infos) } // 实验报告
  else if cover_style == "report" { cover_anonymous_report(..infos) } // 匿名实验报告
  else { cover_normal(..infos) }
}