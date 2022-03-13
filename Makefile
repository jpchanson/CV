LTXBin :=pdflatex
LTXFlags := -file-line-error
DOC := JanHansonCV.tex
SECTIONS := Sections/*.tex
RESOURCES := Resources/*.*

all: build
	make build
	make clean

build: $(DOC) $(Resources)
	$(LTXBin) $(LTXFlags) $(DOC)

.PHONY: clean
clean:
	rm *.aux *.log *.out

