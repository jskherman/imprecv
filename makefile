.PHONY: watch compile

ifeq ($(OS),Windows_NT)
    # Windows
    watch:
		@PowerShell -Command "typst watch example.typ --root ."

    compile:
		@PowerShell -Command "typst compile example.typ"
else
    # WSL or Unix-like system
    watch:
		@bash -c "typst watch example.typ --root ."

    compile:
		@bash -c "typst compile example.typ"
endif
