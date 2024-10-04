LTXBin :=xelatex
LTXFlags := -file-line-error -halt-on-error
DOC := JanHansonCV.tex
SECTIONS := Sections/*.tex
RESOURCES := Resources/*.*
L_SEP=>======>
R_SEP=<======<

all: build
	make build
	make clean

build: $(DOC) $(Resources)
	$(LTXBin) $(LTXFlags) $(DOC)

.PHONY: clean
clean:
	rm -rf *.aux *.log *.out

# This target is experimental and may still need some tweaking so dont expect
# this to work as intended out of the box.
.phony: online
online:
	@if ( git describe --tags >/dev/null ); then\
		CV_VERSION="$$(git describe --tags | cut -d "/" -f2)";\
		CV_ARTIFACT="$$(basename ${DOC} .tex)_$${CV_VERSION}";\
		echo "${L_SEP} Archiving $${CV_ARTIFACT} ${R_SEP}";\
		tar -cvf "$${CV_ARTIFACT}.tar.gz" ${DOC} ${SECTIONS} ${RESOURCES} &&\
		echo "$${CV_ARTIFACT}.tar.gz Created";\
	else\
		echo "no appropriate tags found";\
	fi &&\
	echo "${L_SEP} Sending $${CV_ARTIFACT}.tar.gz to LatexOnline ${R_SEP}";\
	curl -X POST \
		 "https://latexonline.cc/data?target=${DOC}"\
		 -F upload=@$${CV_ARTIFACT}.tar.gz\
	     --output $${CV_ARTIFACT}.pdf ;\
#	@curl -X POST https://latexonline.cc/data?target=main.tex                  \
#		  -F upload=@test.tar.gz                                               \
#	      --output test
