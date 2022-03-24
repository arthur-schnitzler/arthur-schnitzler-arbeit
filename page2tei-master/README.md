# page2tei

1. Export der Transkribus-Dokumente als PAGEs
2. Transformation der mets.xml-Dateien

Developer's note:

_## How to use
Apply page2tei-0.xsl to the METS File:

```
java -jar saxon9he.jar -xsl:page2tei-0.xsl -s:mets.xml -o:[your tei file].xml
```

## Contributors
- @tboenig
- @peterstadler
- @tillgrallert_
