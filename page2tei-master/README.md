# page2tei

## I

- Export des Transkribus-Dokuments als PAGE nach "trans-out"
    - Derzeit manuell, langfristiges Ziel: GitHub-Action
    - ohne weiteres Unterverzeichnis speichern, also drei Objekte: metadata.xml, mets.xml und page-folder

## II

- Transformation der mets-Datei mit page2tei-0.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der mets-Datei mit letter-tags-1.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der mets-Datei mit letter-tags-2.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der mets-Datei mit letter-tags-3.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der mets-Datei mit letter-tags-4.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der mets-Datei mit replace_seite-esc-lb-continued.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der mets-Datei mit split-files.xsl (Ausgabedatei: ${pd}/editions/Untitled.xml)
    - Muss manuell an Jahrgang, involvierte Personen etc. angepasst werden

## III

- Transformation der neuen XML-Dateien mit strip-letter.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der neuen XML-Dateien mit p-correction1.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der neuen XML-Dateien mit p-correction2.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der neuen XML-Dateien mit de-escape.xsl (Ausgabedatei: ${currentFileURL})

- Transformation der neuen xml-Dateien mit back-element-hinzufügen-Transformation


## Contributors (page2tei)
- @tboenig
- @peterstadler
- @tillgrallert

## Adaptions (and everything else)
- @laurauntner
- @mepherl
