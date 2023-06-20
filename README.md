# Typst CV Template

## Description

A no-frills CV template for [typst.app](https://typst.app) that uses a YAML file for data input.

This is based on the [popular template on reddit](https://web.archive.org/https://old.reddit.com/r/jobs/comments/7y8k6p/im_an_exrecruiter_for_some_of_the_top_companies/) by [u/SheetsGiggles](https://web.archive.org/https://old.reddit.com/user/SheetsGiggles) and the recommendations of the [r/EngineeringResumes wiki](https://web.archive.org/https://old.reddit.com/r/EngineeringResumes/comments/m2cc65/new_and_improved_wiki).

## Demo

See [**sample CV**](cv.pdf) and [@jskherman's CV](https://go.jskherman.com/cv):

<!-- ![Sample CV Page 1](https://github.com/jskherman/cv.typ/assets/68434444/ff35d521-d48e-4c32-a6fe-d19ae390512c) -->
<!-- ![Sample CV Page 2](https://github.com/jskherman/cv.typ/assets/68434444/76840b60-4224-495d-a637-30b8ddfa91c3) -->

<div align="center">
  <img src="https://github.com/jskherman/cv.typ/assets/68434444/12cff1a4-76d7-4ce0-97f1-16cd26d61c25" alt="Sample CV Page 1" style="float: left; width: 49%; height: auto;">
  <img src="https://github.com/jskherman/cv.typ/assets/68434444/52bc078b-35f3-46ba-9561-2d2b4d0f8eb0" alt="Sample CV Page 2" style="float: left; width: 49%; height: auto;">
</div>

## Usage

### With [typst.app](https://typst.app)

1. Upload the [`cv.typ`](cv.typ), [`utils.typ`](utils.typ), and [`cv.typ.yml`](cv.typ.yml) files to your Typst project.
2. In your project, Start editing `cv.typ` for the layout and `cv.typ.yml` for the data.

### With [Typst CLI](https://github.com/typst/typst)

Fork and clone this repo, then run the command:
```bash
typst watch cv.typ
```

The default font is Linux Libertine, which you can customize in `cv.typ`. You can run `typst fonts` to see other fonts that can be used instead.

Other options such as the font size and paper size can also be customized by editing `cv.typ`.

## License

[Apache License 2.0](LICENSE)
