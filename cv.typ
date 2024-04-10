#import "utils.typ"

#let set_style(opts, doc) = {
  set list(spacing: opts.line-spacing)
  set par(leading: opts.line-spacing, justify: true)
  set text(font: opts.font.body, size: opts.font.size, hyphenate: false)
  set page(
    margin: 1.25cm, // 1.25cm, 1.87cm, 2.5cm
    number-align: center, // left, center, right
    numbering: "1 / 1", paper: "us-letter", // a4, us-letter
  )

  // name title case
  show heading.where(level: 1): it => block(width: 100%, {
    set text(font: opts.font.heading, size: 1.5em, weight: "bold")

    if (opts.at("heading-smallcaps", default: false)) {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }

    v(0.1em)
  })

  // section headings case
  show heading.where(level: 2): it => block(width: 100%, {
    set align(left)
    set text(font: opts.font.heading, size: 1em, weight: "bold")

    if (opts.at("heading-smallcaps", default: false)) {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }

    v(-0.5em)
    line(length: 100%, stroke: 1pt + black)
  })

  doc
}

#let line_one(left, right: none, url: none) = {
  if url != none {
    if right != none {
      [*#link(url, left)* #h(1fr) *#right*]
    } else {
      [*#link(url, left)* #h(1fr)]
    }
  } else {
    if right != none {
      [*#left* #h(1fr) *#right*]
    } else {
      [*#left* #h(1fr)]
    }
  }
}

#let line_two(left, right_start: none, right_end: none) = {
  if right_start != none {
    [#text(style: "italic", left) #h(1fr) #right_start #sym.dash.en #right_end]
  } else {
    [#text(style: "italic", left) #h(1fr) #right_end]
  }
}

#let dot_list(title, elements, url: none) = {
  if url != none {
    [- *#link(url, title)*: #elements.join(", ")]
  } else {
    [- *#title*: #elements.join(", ")]
  }
}

// address
#let address_text(info, opts) = {
  if opts.show-address {
    let address_line = ()
    let location = info.personal.at("location")

    for key in ("city", "region", "country") {
      let value = location.at(key, default: none)
      if value != none and value != "" {
        address_line.push([#location.at(key, default: none)])
      }
    }

    [#address_line.join(", ") #location.postalCode]

    v(-0.5em)
  }
}

#let contact_text(info, opts) = block(
  width: 100%, {
    let profiles = array(
      (
        box(link("mailto:" + info.personal.email)), if opts.show-number { box(link("tel:" + info.personal.phone)) } else { none }, if info.at("personal.url", default: none) != none { box(link(info.personal.url, { info.personal.url.split("//").at(1) })) },
      ).filter(it => it != none),
    ) // remove empty elements from profiles

    if info.personal.profiles.len() > 0 {
      for profile in info.personal.profiles {
        profiles.push(box(link(profile.url, { profile.url.split("//").at(1) })))
      }
    }

    set text(font: opts.font.body, weight: "medium", size: opts.font.size * 1)
    pad(x: 0em, {
      profiles.join([#sym.space.en #sym.diamond.filled #sym.space.en])
    })
  },
)

#let header(info, opts) = {
  align(center, {
    [= #info.personal.name]

    address_text(info, opts)
    contact_text(info, opts)
  })
}

#let work(info, isbreakable: true) = {
  if info.at("work", default: none) != none {
    block({
      [== Work Experience]

      for w in info.work {
        let company = w.organization
        let url = w.at("url", default: none)
        let location = w.location

        line_one(company, right: location, url: url)

        let index = 0
        for p in w.positions {
          let start = p.at("startDate", default: none)
          if start != none {
            start = utils.str_to_date(start)
          }
          let end = utils.str_to_date(p.endDate)

          if index != 0 { v(0.5em) }

          block(above: 0.5em, {
            line_two(p.position, right_start: start, right_end: end)
          })

          for hi in p.highlights {
            [- #eval(hi, mode: "markup")]
          }

          index = index + 1
        }
      }
    })
  }
}

#let education(info, isbreakable: true) = {
  if info.at("education", default: none) != none {
    block({
      [== Education]

      for edu in info.education {
        let start = edu.at("startDate", default: none)
        if start != none {
          start = utils.str_to_date(start)
        }
        let end = utils.str_to_date(edu.endDate)

        let left = [#edu.studyType in #edu.area]
        let url = edu.at("url", default: none)

        block(width: 100%, breakable: isbreakable, {
          // line 1: institution and location
          line_one(edu.institution, right: edu.location, url: edu.url)
          linebreak()
          // line 2: degree and date
          line_two(left, right_start: start, right_end: end)
          let honors = edu.at("honors", default: ())
          dot_list("Honors", honors)

          let courses = edu.at("courses", default: ())
          dot_list("Courses", courses)

          if edu.at("highlights", default: none) != none {
            for hi in edu.highlights {
              [- #eval(hi, mode: "markup")]
            }
          }
        })
      }
    })
  }
}

#let affiliations(info, isbreakable: true) = {
  if info.at("affiliations", default: none) != none {
    block({
      [== Leadership & Activities]

      for org in info.affiliations {
        let url = org.at("url", default: none)
        let start = org.at("startDate", default: none)
        if start != none {
          start = utils.str_to_date(start)
        }
        let end = utils.str_to_date(org.endDate)

        block(width: 100%, breakable: isbreakable, {
          // line 1: organization and location
          line_one(org.organization, right: org.location, url: org.url)

          linebreak()
          // line 2: position and date
          line_two(org.position, right_start: start, right_end: end)

          if org.at("highlights", default: none) != none {
            for hi in org.highlights {
              [- #eval(hi, mode: "markup")]
            }
          }
        })
      }
    })
  }
}

#let projects(info, isbreakable: true) = {
  if info.at("projects", default: none) != none {
    block({
      [== Projects]

      for project in info.projects {
        let url = project.at("url", default: none)
        let start = project.at("startDate", default: none)
        if start != none {
          start = utils.str_to_date(start)
        }
        let end = utils.str_to_date(project.endDate)

        block(width: 100%, breakable: isbreakable, {
          // line 1: project name
          line_one(project.name, url: url)

          linebreak()
          // line 2: organization and date
          line_two(project.affiliation, right_start: start, right_end: end)

          for hi in project.highlights {
            [- #eval(hi, mode: "markup")]
          }
        })
      }
    })
  }
}

#let awards(info, isbreakable: true) = {
  if info.at("awards", default: none) != none {
    block({
      [== Honors & Awards]
      for award in info.awards {
        let url = award.at("url", default: none)
        let date = utils.str_to_date(award.date)

        block(width: 100%, breakable: isbreakable, {
          // line 1: award title and location
          line_one(award.title, right: award.location, url: url)

          linebreak()
          // line 2: issuer and date
          line_two(award.issuer, right_end: date)

          if award.at("highlights", default: none) != none {
            for hi in award.highlights {
              [- #eval(hi, mode: "markup")]
            }
          }
        })
      }
    })
  }
}

#let certificates(info, isbreakable: true) = {
  if info.at("certificates", default: none) != none {
    block({
      [== Licenses & Certifications]

      for cert in info.certificates {
        let url = cert.at("url", default: none)
        let date = utils.str_to_date(cert.date)

        block(width: 100%, breakable: isbreakable, {
          // line 1: certificate name
          line_one(cert.name, url: cert.url)

          linebreak()
          // line 2: issuer and date
          line_two(cert.issuer, right_end: date)
        })
      }
    })
  }
}

#let publications(info, isbreakable: true) = {
  if info.at("publications", default: none) != none {
    block({
      [== Research & Publications]

      for pub in info.publications {
        let url = pub.at("url", default: none)
        let date = utils.str_to_date(pub.releaseDate)

        block(width: 100%, breakable: isbreakable, {
          // line 1: publication title
          line_one(pub.name, url: url)

          linebreak()
          // line 2: publisher and date
          [Published on #line_two(pub.publisher, right_end: date)]
        })
      }
    })
  }
}

#let skills(info, isbreakable: true) = {
  if (info.at("languages", default: none) != none) or (info.at("skills", default: none) != none) or (info.at("interests", default: none) != none) {
    block(breakable: isbreakable, {
      [== Skills, Languages, Interests]

      let langs = info.at("languages", default: none)
      let langs_join = ()
      for lang in langs {
        langs_join.push([#lang.language (#lang.fluency)])
      }

      dot_list("Languages", langs_join)

      let skills = info.at("skills", default: none)
      for skill-group in skills {
        dot_list(skill-group.category, skill-group.skills)
      }

      let interests = info.at("interests", default: none)
      dot_list("Interests", interests)
    })
  }
}

#let references(info, isbreakable: true) = {
  if info.at("references", default: none) != none {
    block({
      [== References]

      for ref in info.references {
        dot_list(ref.name, (ref.reference,), url: ref.url)
      }
    })
  }
}

#let footer() = {
  place(
    bottom + right, block(
      {
        text(
          size: 4pt, font: "Consolas", fill: silver, {
            [This document was last updated on #datetime.today().display("[year]-[month]-[day]") using #strike[LaTeX] #link("https://typst.app/docs")[Typst]]
          },
        )
      },
    ),
  )
}
