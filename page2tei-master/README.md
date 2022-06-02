# page2tei

- Export des Transkribus-Dokuments als PAGE
    - Funktioniert
    - Derzeit manuell, langfristiges Ziel: GitHub-Action

- Transformation der mets-Datei mit page2tei-0.xsl
    - Funktioniert

- Transformation der mets-Datei mit letter-tags-1.xsl
    - Funktioniert

- Transformation der mets-Datei mit letter-tags-2.xsl
    - Funktioniert

- Transformation der mets-Datei mit letter-tags-3.xsl
    - Funktioniert

- Transformation der mets-Datei mit p-correction.xsl
    - Funktioniert noch nicht

- Transformation der mets-Datei mit replace_seite-esc-lb-continued.xsl
    - Funktioniert grundsätzlich, wurde aber noch nicht ausführlich getestet und wird evtl. noch erweitert

- Wohlgeformtheit überprüfen
    - Derzeit manuell, wird aber evtl. mit p-correction.xsl (halbwegs) überflüssig

- Transformation der mets-Datei mit split-files.xsl
    - Funktioniert noch nicht perfekt (Pfade müssen noch angepasst werden, beim Export wird derzeit noch das letzte Dokument überschrieben [position() +1?])
    - Muss manuell an Jahrgang, involvierte Personen etc. angepasst werden

- Transformation der neuen xml-Dateien mit back-element-hinzufügen-Transformation
    - Funktioniert (dient Formatierung und ID-Generierung)


## Contributors
- @tboenig
- @peterstadler
- @tillgrallert

## Adaptions
- @laurauntner
- @mepherl
