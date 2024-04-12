.PHONY: watch compile

ifeq ($(OS),Windows_NT)
    # Windows
    watch:
		@PowerShell -Command "typst watch template/cv-template.typ --root ."

    compile:
		@PowerShell -Command "typst compile template/cv-template.typ --root ."
		@PowerShell -Command "typst compile template/cv-template.typ template/cv-template_{n}.png -f png --root ."
else
    # WSL or Unix-like system
    watch:
		@bash -c "typst watch template/cv-template.typ --root ."

    compile:
		@bash -c "typst compile template/cv-template.typ --root ."
		@bash -c "typst compile template/cv-template.typ template/cv-template_{n}.png -f png --root ."
endif
