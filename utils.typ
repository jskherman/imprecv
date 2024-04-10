#let str_to_date(date-iso) = {
  if lower(date-iso) == "present" {
    return "Present"
  } else {
    let date = datetime(
      year: int(date-iso.slice(0, 4)), month: int(date-iso.slice(5, 7)), day: int(date-iso.slice(8, 10)),
    )
    return date.display("[month repr:short]") + " " + date.display("[year repr:full]")
  }
}
