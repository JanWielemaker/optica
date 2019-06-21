DEST=	/einstein/jan/src/optica
PLBASE= /einstein/jan/src/pl
PLRT=	$(PLBASE)/runtime
PLBIN=	$(PLBASE)/bin
SP=	/einstein/sp

DIRS=	bin icons icons/16x16 log stress stress/dtd
OPA=	stress.opa
ICONS=  $(shell find icons \( -name \*.xpm -o -name \*.crs -o -name \*.lbl -o -name \*.bm \))
DTD=	HTML4.dcl HTML4.soc HTMLspec.ent stress.dtd \
	HTML4.dtd HTMLlat1.ent HTMLsym.ent
STRESS= monalisa.xpm  stress.sgml
DLL=	libpl.dll xml2pl.dll pl2xpce.dll socket.dll xpce.dll \
	plterm.dll sp130.dll
TESTS=	whatif2 normal2
TESTF=	$(shell for d in $(TESTS); do /bin/ls $$d/*.tst; done)

ADIRS=	$(addprefix $(DEST)/, $(DIRS)) \
	$(addprefix $(DEST)/, $(TESTS))

FILES=	$(ICONS) \
	$(OPA) \
	README.txt \
	swipl \
	$(addprefix stress/dtd/, $(DTD)) \
	$(addprefix stress/, $(STRESS)) \
	$(TESTF)

all:	dirs files $(WINFILES) win-install

dirs:	
	@for d in $(ADIRS); do mkdir -p $$d; done

files:	$(addprefix $(DEST)/, $(FILES)) \
	$(addprefix $(DEST)/bin/, $(DLL))

win-install:
	xpce -f build.pl -- optica.exe
	cp optica.exe /staff/jan/einstein/src/optica/bin/optica.exe

clean:
	rm -f `find . -name '*~'`
	rm -f optica.exe

distclean: clean
	rm -rf $(DEST)

$(DEST)/%:	%
	cp -p $< $@

$(DEST)/swipl:
	echo "." > $@

$(DEST)/README.txt:	README.txt
	unix2dos -c $< $@

$(DEST)/bin/xpce.dll:	$(PLRT)/xpce.dll
	cp -p $< $@
$(DEST)/bin/libpl.dll:	$(PLRT)/libpl.dll
	cp -p $< $@
$(DEST)/bin/plterm.dll:	$(PLBIN)/plterm.dll
	cp -p $< $@
$(DEST)/bin/socket.dll:	$(PLBIN)/socket.dll
	cp -p $< $@
$(DEST)/bin/pl2xpce.dll: $(PLBIN)/pl2xpce.dll
	cp -p $< $@
$(DEST)/bin/sp130.dll: $(SP)/bin/sp130.dll
	cp -p $< $@
$(DEST)/bin/xml2pl.dll: $(PLBIN)/xml2pl.dll
	cp -p $< $@


