master.pdf: master.dvi
	dvipdfmx master.dvi

master.dvi: master.tex body.tex
	platex master.tex; pbibtex master; platex master; platex master

body.tex: body_tmp.md crossref.yaml
	pandoc body_tmp.md --mathml --listings --filter pandoc-crossref -M "crossrefYaml=crossref.yaml" -o body.tex;
	sed -ie 's/\begin{figure}/\begin{figure}[H]/g' body.tex;

body_tmp.md: body.md
	sed -e 's/\[\[/\\cite{/g' body.md | sed -e 's/\]\]/}/g' > body_tmp.md;

clean:
	rm master.pdf master.log master.dvi master.out master.aux master.blg master.bbl body.texe body.tex body_tmp.md;