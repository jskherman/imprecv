#import "cv.typ"

#let user-data = yaml("example.yml")

#let cv-options = (
  font: (
    body: "Linux Libertine",
    heading: "Linux Libertine",
    size: 10pt,
  ),
  heading-smallcaps: false,
  line-spacing: 6pt,
  show-address: true, // bool: show address in header
  show-number: true, // bool: show phone number in header
)

// you could override default style by re-applying style rules here
#let set_style(doc) = {
  // set list(spacing: 10pt)
  // set par(leading: 10pt, justify: false)
  doc
}

#let init(doc) = {
  doc = cv.set_style(cv-options, doc)
  doc = set_style(doc)

  doc
}

// you could override each section format by re-declaring section function here
// #let work = [
//   [== Work Experience]
// ]

// ========================================================================== //
//                             cv-content                                     //
// ========================================================================== //

#show: doc => init(doc)

#cv.header(user-data, cv-options)
#cv.work(user-data)
#cv.education(user-data)
#cv.affiliations(user-data)
#cv.projects(user-data)
#cv.awards(user-data)
#cv.certificates(user-data)
#cv.publications(user-data)
#cv.skills(user-data)
#cv.references(user-data)
#cv.footer()
