# epub schnitzler-briefe

Arbeitsverzeichnis für das Erstellen von E-Books von schnitzler-briefe

Workflow: 
1) TEI-Dokumente (editions) mit epub-all.xsl zu XHTML transformieren (transformation not finished yet!)
2) OEBPS/content.opf mit create-content.xsl transformieren
3) OEBPS/texts/inhalt.xhtml mit create-inhalt.xsl transformieren
4) OEBPS/texts/inhaltsverzeichnis.ncx mit create-inhaltsverzeichnis.xsl transformieren
5) im Terminal ins epub-Verzeichnis gehen und folgenden Befehl eingeben:

```
zip -rX out/schnitzler-briefe.epub mimetype META-INF/ OEBPS/ -x "*.DS_Store" -x "README.md" -x "out" -x "xslt"
```

Work in progress – not ready for use yet!

Validation with EPUB-Checker (https://www.pagina.gmbh/produkte/epub-checker/)

