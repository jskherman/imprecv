#import "cv.typ"

#let user-data = yaml("example.yml")

#let options = (
  font: (body: "Linux Libertine", heading: "Linux Libertine", size: 10pt), heading-smallcaps: false, line-spacing: 6pt, show-address: true, // bool: show address in header
  show-number: true, // bool: show phone number in header
)

// you could override default style by reapplying style rules here
#let set-style(doc) = {
  // set list(spacing: 10pt)
  // set par(leading: 10pt, justify: false)
  doc
}

#let init(doc) = {
  doc = cv.set-style(options, doc)
  doc = set-style(doc)

  doc
}

// you could override each section format by redeclaring section function here
// #let work = [
//   [== Work Experience]
// ]

// ========================================================================== //
//                             cv-content                                     //
// ========================================================================== //

#show: doc => init(doc)

#cv.header(user-data.personal, options)

#cv.work(user-data.work)
#cv.education(user-data.education)
#cv.affiliations(user-data.affiliations)
#cv.projects(user-data.projects)
#cv.awards(user-data.awards)
#cv.certificates(user-data.certificates)
#cv.publications(user-data.publications)
#cv.skills(
  user-data.skills, user-data.at("languages", default: none), user-data.at("interests", default: none),
)
#cv.references(user-data.references)

#cv.footer()
