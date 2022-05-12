# epub schnitzler-briefe

Arbeitsverzeichnis für das Erstellen von E-Books von schnitzler-briefe

Workflow: 
1) TEI-Dokumente zu XHTML transformieren
2) im Terminal ins epub-Verzeichnis gehen und folgenden Befehl eingeben:

```
zip -rX out/schnitzler-briefe.epub mimetype META-INF/ OEBPS/ -x "*.DS_Store" -x "README.md" -x "out" -x "xslt"
```

Work in progress – not ready for use yet!

Validation with EPUB-Checker (https://www.pagina.gmbh/produkte/epub-checker/)

