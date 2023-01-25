# epub schnitzler-briefe

Arbeitsverzeichnis für das Erstellen von E-Books von schnitzler-briefe

Workflow: 

1) run 
```
sh fetch-data.py
```

and 

```
ant
```

in schnitzler-briefe-static

2) copy generated xhtml files to OEBPS/texts

3) transform the copied xhtml files (but not inhalt.xhtml, inhaltsverzeichnix.ncx, rechte.xhtml and title.xhtml) with static-to-epub.xsl

4) transform OEBPS/content.opf with create-content.xsl

5) transform OEBPS/texts/inhalt.xhtml with create-inhalt.xsl

6) transform OEBPS/texts/inhaltsverzeichnis.ncx with create-inhaltsverzeichnis.xsl

7) run

```
zip -rX out/schnitzler-briefe.epub mimetype META-INF/ OEBPS/ -x "*.DS_Store" -x "README.md" -x "out" -x "xslt"
```

in arthur-schnitzler-arbeit/epub/epub-all

8) validate the generated epub (in /out) with an epub-checker (https://www.pagina.gmbh/produkte/epub-checker/)