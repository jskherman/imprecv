#import "cv.typ": *

#let uservars = (
    headingfont: "Linux Libertine", // Set font for headings
    bodyfont: "Linux Libertine",   // Set font for body
    fontsize: 10pt, // 10pt, 11pt, 12pt
    linespacing: 6pt,
    showAddress: true, // true/false Show address in contact info
    showNumber: true,  // true/false Show phone number in contact info
)

#let customrules(doc) = {
    // Add custom document style rules here

}

#let cvinit(doc) = {
    doc = setrules(uservars, doc)
    doc = showrules(uservars, doc)

    doc
}

// Each section function can also be overridden by re-declaring it here
// #let cveducation = []

// Content
#show: doc => cvinit(doc)

#cvheading
#cveducation
#cvwork
#cvaffiliations
#cvprojects
#cvawards
#cvcertificates
#cvpublications
#cvskills
#cvreferences
