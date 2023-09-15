# Typst CV Template

<p align="center">
  <a href="LICENSE">
    <img alt="Apache-2 License" src="https://img.shields.io/badge/license-Apache%202-brightgreen"/>
  </a>
</p>

A no-frills curriculum vitae (CV) template for [Typst](https://github.com/typst/typst) that uses a YAML file for data input in order to version control CV data easily.

This is based on the [popular template on Reddit](https://web.archive.org/https://old.reddit.com/r/jobs/comments/7y8k6p/im_an_exrecruiter_for_some_of_the_top_companies/) by [u/SheetsGiggles](https://web.archive.org/https://old.reddit.com/user/SheetsGiggles) and the recommendations of the [r/EngineeringResumes wiki](https://web.archive.org/https://old.reddit.com/r/EngineeringResumes/comments/m2cc65/new_and_improved_wiki).

## Demo

See [**example CV**](example.pdf) and [@jskherman's CV](https://go.jskherman.com/cv):

<div align="center">
  <img src="https://github.com/jskherman/cv.typ/assets/68434444/12cff1a4-76d7-4ce0-97f1-16cd26d61c25" alt="Sample CV Page 1" style="float: left; width: 49%; height: auto;">
  <img src="https://github.com/jskherman/cv.typ/assets/68434444/52bc078b-35f3-46ba-9561-2d2b4d0f8eb0" alt="Sample CV Page 2" style="float: left; width: 49%; height: auto;">
</div>

## Usage

`cv.typ` is intended to be used by importing the `cv.typ` file from a "content"
file (see [`example.typ`](example.typ) as an example). In this content file,
call the functions which apply document styles, show CV components, and load CV
data from a YAML file (see [`example.yml`](example.yml) as an example). Inside
the content file you can modify several style variables and even override
existing function implementations to your own needs and preferences.

### With [Typst CLI](https://github.com/typst/typst) (Recommended)

The recommended usage with Typst CLI is by adding this `cv.typ` repository as a [git
submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules). This way, upstream changes can be
pulled easily.

```
<your-cv-repo>/
├── cv.typ/ // git submodule 
|   └── cv.typ
├── <your-cv-content>.typ // #import "cv.typ/cv.typ": *
└── <your-cv-data>.yml
```

1. Add [jskherman/cv.typ](https://github.com/jskherman/cv.typ) as git submodule.
into your CV's repo.

  ```
  git submodule add https://github.com/jskherman/cv.typ
  ```

2. Copy and rename `example.typ` and `example.yml` to your CV's repo root directory. Use these files
   as template/starting point for your CV.

3. Run the following to command to automatically recompile your CV file on changes.

  ```bash
  typst watch <your-cv-content>.typ
  ```

### With [typst.app](https://typst.app)

1. Upload the [`cv.typ`](cv.typ), [`utils.typ`](utils.typ), [`example.typ`](example.typ). and
   [`example.yml`](example.yml) files to your Typst project. You may rename `example.typ` and
   `example.yml`.
2. Use `example.typ` and `example.yml` (or whatever the names after you rename it) as a
   template/starting point for your CV.
