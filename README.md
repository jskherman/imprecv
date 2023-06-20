# Typst CV Template

## Description

A no-frills CV template for [typst.app](https://typst.app) that uses a YAML file for data input.

This is based on the [popular template on reddit](https://web.archive.org/https://old.reddit.com/r/jobs/comments/7y8k6p/im_an_exrecruiter_for_some_of_the_top_companies/) by [u/SheetsGiggles](https://web.archive.org/https://old.reddit.com/user/SheetsGiggles) and the recommendations of the [r/EngineeringResumes wiki](https://web.archive.org/https://old.reddit.com/r/EngineeringResumes/comments/m2cc65/new_and_improved_wiki).

## Demo

See [**sample CV**](cv.pdf) and [@jskherman's CV](https://go.jskherman.com/cv):

![Sample CV](cv.png)

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

[MIT](LICENSE)
