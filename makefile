.PHONY: watch compile

ifeq ($(OS),Windows_NT)
    # Windows
    watch:
		@PowerShell -Command "typst watch template/template.typ --root ."

    compile:
		@PowerShell -Command "typst compile template/template.typ"
else
    # WSL or Unix-like system
    watch:
		@bash -c "typst watch template/template.typ --root ."

    compile:
		@bash -c "typst compile template/template.typ"
endif
