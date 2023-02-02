# epub of all schnitzler-briefe

Working directory for the creation of an epub for all correspondences in schnitzler-briefe.

Workflow: 

1) run in schnitzler briefe-static:
```
sh fetch-data.py
```

and 

```
ant
```

2) copy generated html files to /OEBPS/texts

3) rename the suffixes of the generated html files to .xhtml

4) transform the copied xhtml files (but not inhalt.xhtml, inhaltsverzeichnix.ncx, rechte.xhtml and title.xhtml) with /xslt/static-to-epub.xsl

5) transform the copied (and just transformed) xhtml files (but not inhalt.xhtml, inhaltsverzeichnix.ncx, rechte.xhtml and title.xhtml) with /xslt/editions-postprocessing.xsl

6) check the xhtml files for faulty tables and correct them manually with this XPath:

```
//tbody[tr[1]/count(td) != tr[2]/count(td)]
```

7) remove from the xhtml files:

```
xmlns:_="urn:acdh" xmlns:foo="whatever works"
```

8) validate the xhtml files just to be sure

9) transform /OEBPS/content.opf with /xslt/create-content.xsl

10) transform /OEBPS/texts/inhalt.xhtml with /xslt/create-inhalt.xsl

11) transform /OEBPS/texts/inhaltsverzeichnis.ncx with /xslt/create-inhaltsverzeichnis.xsl

12) run in arthur-schnitzler-arbeit/epub/epub-all:

```
zip -rX out/schnitzler-briefe.epub mimetype META-INF/ OEBPS/ -x "*.DS_Store" -x "README.md" -x "out" -x "xslt"
```

13) validate the generated epub (in /out) with an epub-checker (i. e. https://github.com/w3c/epubcheck, https://www.pagina.gmbh/produkte/epub-checker/ or https://www.ebookit.com/tools/bp/Bo/eBookIt/epub-validator)
