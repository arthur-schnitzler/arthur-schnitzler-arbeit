# page2tei

1. Export der Transkribus-Dokumente als PAGEs
2. Transformation der mets.xml-Dateien mit page2tei-0.xsl
3. Element `seite` auspacken (XML-Refaktorierung) [an automatisierter Lösung wird gearbeitet]
4. Falls mit Tags `paragraph-begin` und `paragraph-end` gearbeitet wurde: [an automatisierter Lösung wird aufgrund des neuen Workflows, der diese Tags ausschließt, nicht gearbeitet]
    1. `&lt;` ersetzen mit `<`
    2. `&gt;` ersetzen mit `>`
    3. `&#47;` ersetzen mit `/`

## Contributors
- @tboenig
- @peterstadler
- @tillgrallert

## Adaptions
- @laurauntner
- @mepherl
