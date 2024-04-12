//
// internal
//

#let _str-to-date(date-iso) = {
  if lower(date-iso) == "present" {
    return "Present"
  } else {
    let date = datetime(
      year: int(date-iso.slice(0, 4)), month: int(date-iso.slice(5, 7)), day: int(date-iso.slice(8, 10)),
    )
    return date.display("[month repr:short]") + " " + date.display("[year repr:full]")
  }
}

#let _line-one(left, right: none, url: none) = {
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

#let _line-two(left, right-start: none, right-end: none) = {
  if right-start != none {
    [#text(style: "italic", left) #h(1fr) #right-start #sym.dash.en #right-end]
  } else {
    [#text(style: "italic", left) #h(1fr) #right-end]
  }
}

#let _dot-list(title, elements, url: none) = {
  if url != none {
    [- *#link(url, title)*: #elements.join(", ")]
  } else {
    [- *#title*: #elements.join(", ")]
  }
}

#let _address-line(personal, opts) = {
  if opts.show-address {
    let address-line = ()

    for key in ("city", "region", "country") {
      let value = personal.location.at(key, default: none)
      if value != none and value != "" {
        address-line.push([#personal.location.at(key, default: none)])
      }
    }

    [#address-line.join(", ") #personal.location.postalCode]

    v(-0.5em)
  }
}

#let _contact-line(personal, opts) = block(
  width: 100%, {
    // remove empty elements from profiles
    let profiles = array(
      (
        box(link("mailto:" + personal.email)), if opts.show-number { box(link("tel:" + personal.phone)) } else { none }, if personal.at("url", default: none) != none { box(link(personal.url, { personal.url.split("//").at(1) })) },
      ).filter(it => it != none),
    )

    if personal.profiles.len() > 0 {
      for profile in personal.profiles {
        profiles.push(box(link(profile.url, { profile.url.split("//").at(1) })))
      }
    }

    set text(font: opts.font.body, weight: "medium", size: opts.font.size * 1)
    pad(x: 0em, {
      profiles.join([#sym.space.en #sym.diamond.filled #sym.space.en])
    })
  },
)

//
// external
//

#let set-style(opts, doc) = {
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

    if opts.heading-smallcaps {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }

    v(0.1em)
  })

  // section heading case
  show heading.where(level: 2): it => block(width: 100%, {
    set align(left)
    set text(font: opts.font.heading, size: 1em, weight: "bold")

    if opts.heading-smallcaps {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }

    v(-0.5em)
    line(length: 100%, stroke: 1pt + black)
  })

  doc
}

#let header(personal, opts) = {
  align(center, {
    [= #personal.name]

    _address-line(personal, opts)
    _contact-line(personal, opts)
  })
}

#let work(works, breakable: true) = {
  block({
    [== Work Experience]

    for work in works {
      let company = work.organization
      let url = work.at("url", default: none)
      let location = work.location

      _line-one(company, right: location, url: url)

      let index = 0
      for pos in work.positions {
        let start = pos.at("startDate", default: none)
        if start != none {
          start = _str-to-date(start)
        }
        let end = _str-to-date(pos.endDate)

        if index != 0 { v(0.5em) }

        block(above: 0.5em, {
          _line-two(pos.position, right-start: start, right-end: end)
        })

        for hi in pos.highlights {
          [- #eval(hi, mode: "markup")]
        }

        index = index + 1
      }
    }
  })
}

#let education(edus, breakable: true) = {
  block({
    [== Education]

    for edu in edus {
      let start = edu.at("startDate", default: none)
      if start != none {
        start = _str-to-date(start)
      }
      let end = _str-to-date(edu.endDate)

      let left = [#edu.studyType in #edu.area]
      let url = edu.at("url", default: none)

      block(width: 100%, breakable: breakable, {
        // line 1: institution and location
        _line-one(edu.institution, right: edu.location, url: edu.url)
        linebreak()
        // line 2: degree and date
        _line-two(left, right-start: start, right-end: end)
        let honors = edu.at("honors", default: ())
        _dot-list("Honors", honors)

        let courses = edu.at("courses", default: ())
        _dot-list("Courses", courses)

        if edu.at("highlights", default: none) != none {
          for hi in edu.highlights {
            [- #eval(hi, mode: "markup")]
          }
        }
      })
    }
  })
}

#let affiliations(affiliations, breakable: true) = {
  block({
    [== Leadership & Activities]

    for af in affiliations {
      let url = af.at("url", default: none)
      let start = af.at("startDate", default: none)
      if start != none {
        start = _str-to-date(start)
      }
      let end = _str-to-date(af.endDate)

      block(width: 100%, breakable: breakable, {
        // line 1: organization and location
        _line-one(af.organization, right: af.location, url: af.url)

        linebreak()
        // line 2: position and date
        _line-two(af.position, right-start: start, right-end: end)

        if af.at("highlights", default: none) != none {
          for hi in af.highlights {
            [- #eval(hi, mode: "markup")]
          }
        }
      })
    }
  })
}

#let projects(projects, breakable: true) = {
  block({
    [== Projects]

    for proj in projects {
      let url = proj.at("url", default: none)
      let start = proj.at("startDate", default: none)
      if start != none {
        start = _str-to-date(start)
      }
      let end = _str-to-date(proj.endDate)

      block(width: 100%, breakable: breakable, {
        // line 1: project name
        _line-one(proj.name, url: url)

        linebreak()
        // line 2: organization and date
        _line-two(proj.affiliation, right-start: start, right-end: end)

        for hi in proj.highlights {
          [- #eval(hi, mode: "markup")]
        }
      })
    }
  })
}

#let awards(awards, breakable: true) = {
  block({
    [== Honors & Awards]
    for award in awards {
      let url = award.at("url", default: none)
      let date = _str-to-date(award.date)

      block(width: 100%, breakable: breakable, {
        // line 1: award title and location
        _line-one(award.title, right: award.location, url: url)

        linebreak()
        // line 2: issuer and date
        _line-two(award.issuer, right-end: date)

        if award.at("highlights", default: none) != none {
          for hi in award.highlights {
            [- #eval(hi, mode: "markup")]
          }
        }
      })
    }
  })
}

#let certificates(certs, breakable: true) = {
  block({
    [== Licenses & Certifications]

    for cert in certs {
      let url = cert.at("url", default: none)
      let date = _str-to-date(cert.date)

      block(width: 100%, breakable: breakable, {
        // line 1: certificate name
        _line-one(cert.name, url: cert.url)

        linebreak()
        // line 2: issuer and date
        _line-two(cert.issuer, right-end: date)
      })
    }
  })
}

#let publications(pubs, breakable: true) = {
  block({
    [== Research & Publications]

    for pub in pubs {
      let url = pub.at("url", default: none)
      let date = _str-to-date(pub.releaseDate)

      block(width: 100%, breakable: breakable, {
        // line 1: publication title
        _line-one(pub.name, url: url)

        linebreak()
        // line 2: publisher and date
        [Published on #_line-two(pub.publisher, right-end: date)]
      })
    }
  })
}

#let skills(skill-groups, langs, interests, breakable: true) = {
  block(breakable: breakable, {
    [== Skills, Languages & Interests]

    for skill-group in skill-groups {
      _dot-list(skill-group.category, skill-group.skills)
    }

    if langs != none {
      let langs-join = ()
      for lang in langs {
        langs-join.push([#lang.language (#lang.fluency)])
      }
      _dot-list("Languages", langs-join)
    }

    if interests != none {
      _dot-list("Interests", interests)
    }
  })
}

#let references(refs, breakable: true) = {
  block({
    [== References]

    for ref in refs {
      _dot-list(ref.name, ("\"" + ref.reference + "\"",), url: ref.url)
    }
  })
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
