################################################################
#
#
################################################################

DOC2TEX=$$HOME/src/xpce/bin/doc2tex
LATEX=latex
RM=rm
DOC=optica

doc:		$(DOC).tex
		$(LATEX) $(DOC).tex

$(DOC).dvi:	$(DOC).tex
		$(LATEX) $(DOC).tex

$(DOC).tex:	$(DOC).doc
		$(DOC2TEX) $(DOC).doc > $@

$(DOC).html:	$(DOC).tex
		latex2html $(DOC)
		mv $(DOC)/$(DOC).html $@
		rm -r $(DOC)

clean:
		rm -f *~ *% 

distclean:	clean

		

