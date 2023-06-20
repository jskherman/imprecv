#import "utils.typ"

// Load CV Data from YAML
#let info = yaml("cv.typ.yml")

// Variables
#let headingfont = "Linux Libertine" // Set font for headings
#let bodyfont = "Linux Libertine"   // Set font for body
#let fontsize = 10pt // 10pt, 11pt, 12pt
#let linespacing = 6pt
#let showAddress = true // true/false Show address in contact info
#let showNumber = true  // true/false Show phone number in contact info

// Set Page Layout
#set page(
paper: "us-letter", // a4, us-letter
    numbering: "1 / 1",
    number-align: center, // left, center, right
    margin: 1.25cm, // 1.25cm, 1.87cm, 2.5cm
)

// Set Text settings
#set text(
    font: bodyfont,
    size: fontsize,
    hyphenate: false,
)

// Set Paragraph settings
#set par(
    leading: linespacing,
    justify: true,
)


// Uppercase Section Headings
#show heading.where(
    level: 2,
): it => block(width: 100%)[
    #set align(left)
    #set text(font: headingfont, size: 1em, weight: "bold")
    #upper(it.body)
    #v(-0.75em) #line(length: 100%, stroke: 1pt + black) // Draw a line
]

// Name Title
#show heading.where(
    level: 1,
): it => block(width: 100%)[
    #set text(font: headingfont, size: 1.5em, weight: "bold")
    #upper(it.body)
    #v(2pt)
]

// Address
#let addresstext = {
    if showAddress {
        block(width: 100%)[
            #info.personal.location.city, #info.personal.location.region, #info.personal.location.country #info.personal.location.postalCode
            #v(-4pt)
        ]
    } else {none}
}

// Contact Info
// Create a list of contact profiles
#let profiles = (
    box(link("mailto:" + info.personal.email)),
    if showNumber {box(link("tel:" + info.personal.phone))} else {none},
    box(link(info.personal.url)[#info.personal.url.split("//").at(1)]),
)

// Remove any none elements from the list
#if none in profiles {
    profiles.remove(profiles.position(it => it == none))
}

// Add any social profiles
#if info.personal.profiles.len() > 0 {
            for profile in info.personal.profiles {
                profiles.push(
                    box(link(profile.url)[#profile.url.split("//").at(1)])
                )
            }
        }

// Arrange the contact profiles with a diamond separator
#let contacttext = block(width: 100%)[
    // #set par(justify: false)
    #set text(font: bodyfont, weight: "medium", size: fontsize * 1)
    #pad(x: 0em)[
        #profiles.join([#sym.space.en #sym.diamond.filled #sym.space.en])
    ]
]

// Create layout of the title + contact info
#align(center)[
    = #info.personal.name
    #addresstext
    #contacttext
    // #v(0.5em)
]

// Education
== Education

#for edu in info.education [
    // Parse ISO date strings into datetime objects
    #let start = utils.strpdate(edu.startDate)
    #let end = utils.strpdate(edu.endDate)

    // Create a block layout for each education entry
    #block(width: 100%)[
        // Line 1: Institution and Location
        *#link(edu.url)[#edu.institution]* #h(1fr) *#edu.location* \ 
        // Line 2: Degree and Date Range
        #text(style: "italic")[#edu.studyType in #edu.area] #h(1fr)
        #utils.monthname(start.month()) #start.year() #sym.dash.en #utils.monthname(end.month()) #end.year() \
        // Bullet points
        - *Honors*: #edu.honors.join(", ")
        - *Courses*: #edu.courses.join(", ")
        // Highlights or Description
        #for hi in edu.highlights [
            - #eval("[" + hi + "]")
        ]
    ]
]

// Work Experience
== Work Experience

#for w in info.work [
    // Parse ISO date strings into datetime objects
    #let start = utils.strpdate(w.startDate)
    #let end = utils.strpdate(w.endDate)

    // Create a block layout for each education entry
    #block(width: 100%)[
        // Line 1: Institution and Location
        *#link(w.url)[#w.organization]* #h(1fr) *#w.location* \ 
        // Line 2: Degree and Date Range
        #text(style: "italic")[#w.position] #h(1fr)
        #utils.monthname(start.month()) #start.year() #sym.dash.en #utils.monthname(end.month()) #end.year() \
        // Highlights or Description
        #for hi in w.highlights [
            - #eval("[" + hi + "]")
        ]
    ]
]

// Leadership and Activities
== Leadership & Activities

#for org in info.affiliations [
    // Parse ISO date strings into datetime objects
    #let start = utils.strpdate(org.startDate)
    #let end = utils.strpdate(org.endDate)

    // Create a block layout for each education entry
    #block(width: 100%)[
        // Line 1: Institution and Location
        *#link(org.url)[#org.organization]* #h(1fr) *#org.location* \ 
        // Line 2: Degree and Date Range
        #text(style: "italic")[#org.position] #h(1fr)
        #utils.monthname(start.month()) #start.year() #sym.dash.en #utils.monthname(end.month()) #end.year() \
        // Highlights or Description
        #if org.highlights != none {
            for hi in org.highlights [
                - #eval("[" + hi + "]")
            ]
        } else {}
    ]
]

// Projects
== Projects

#for project in info.projects [
    // Parse ISO date strings into datetime objects
    #let start = utils.strpdate(project.startDate)
    #let end = utils.strpdate(project.endDate)

    // Create a block layout for each education entry
    #block(width: 100%)[
        // Line 1: Institution and Location
        *#link(project.url)[#project.name]* \ 
        // Line 2: Degree and Date Range
        #text(style: "italic")[#project.affiliation]  #h(1fr) #utils.monthname(start.month()) #start.year() #sym.dash.en #utils.monthname(end.month()) #end.year() \
        // Summary or Description
        #for hi in project.highlights [
            - #eval("[" + hi + "]")
        ]
    ]
]

// Honors and Awards
== Honors & Awards

#for award in info.awards [
    // Parse ISO date strings into datetime objects
    #let date = utils.strpdate(award.date)

    // Create a block layout for each education entry
    #block(width: 100%)[
        // Line 1: Institution and Location
        *#link(award.url)[#award.title]* #h(1fr) *#award.location*\ 
        // Line 2: Degree and Date Range
        Issued by #text(style: "italic")[#award.issuer]  #h(1fr) #utils.monthname(date.month()) #date.year() \
        // Summary or Description
        #if award.highlights != none {
            for hi in award.highlights [
                - #eval("[" + hi + "]")
            ]
        } else {}
    ]
]

// Certifications
== Licenses & Certifications

#for cert in info.certificates [
    // Parse ISO date strings into datetime objects
    #let date = utils.strpdate(cert.date)

    // Create a block layout for each education entry
    #block(width: 100%)[
        // Line 1: Institution and Location
        *#link(cert.url)[#cert.name]* \ 
        // Line 2: Degree and Date Range
        Issued by #text(style: "italic")[#cert.issuer]  #h(1fr) #utils.monthname(date.month()) #date.year() \
    ]
]

// Research & Publications
#if info.publications != none [
    == Research & Publications

    #for pub in info.publications [
        // Parse ISO date strings into datetime objects
        #let date = utils.strpdate(pub.releaseDate)

        // Create a block layout for each education entry
        #block(width: 100%)[
            // Line 1: Institution and Location
            *#link(pub.url)[#pub.name]* \ 
            // Line 2: Degree and Date Range
            Published on #text(style: "italic")[#pub.publisher]  #h(1fr) #utils.monthname(date.month()) #date.year() \
        ]
    ]
]


// Skills, Languages, and Interests
#let langs = ()
#for lang in info.languages {
    langs.push([#lang.language (#lang.fluency)])
}

== Skills, Languages, Interests

- *Languages*: #langs.join(", ")
#for group in info.skills [
    - *#group.category*: #group.skills.join(", ")
]
- *Interests*: #info.interests.join(", ")

// References
#if info.references != none [
    == References

    #for ref in info.references [
        - *#link(ref.url)[#ref.name]*: "#ref.reference"   
    ]
] else {}



// =====================================================================

// End Note
#place(
    bottom + right,
    block[
        #set text(size: 5pt, font: "Consolas")
        \*This document was last updated on #datetime.today().display("[year]-[month]-[day]") using #strike[LaTeX] #link("https://typst.app")[Typst].
    ]
)

// #place(
//     bottom + right,
//     dy: -71%,
//     dx: 4%,
//     rotate(
//         270deg,
//         origin: right + horizon,
//         block(width: 100%)[
//             #set align(left)
//             #set par(leading: 0.5em)
//             #set text(size: 6pt)

//             #super(sym.dagger) This document was last updated on #raw(datetime.today().display("[year]-[month]-[day]")) using #strike[LaTeX] #link("https://typst.app")[Typst].
//             // Template by Je Sian Keith Herman.
//         ]
//     )
// )