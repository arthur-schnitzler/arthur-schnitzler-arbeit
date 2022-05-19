# page2tei

1. Export des Transkribus-Dokuments als PAGE
2. Transformation der mets-Datei mit page2tei-0.xsl
3. Transformation der xml-Datei mit remove-seite.xsl
4. `&lt;` ersetzen mit `<`
5. `&gt;` ersetzen mit `>`
6. `&#47;` ersetzen mit `/`
7. Transformation der xml-Datei mit n2letters.xsl
8. ggf. Adaption von split-files.xsl (Jahr, Personen etc.)
9. Transformation der xml-Datei mit split-files.xsl
10. neue xml-Dokumente formatieren

## Contributors
- @tboenig
- @peterstadler
- @tillgrallert

## Adaptions
- @laurauntner
- @mepherl
