# page2tei

## manuell I
1. Export des Transkribus-Dokuments als PAGE

## Transformation I: "trans2tei-1"
1. Transformation der mets-Datei mit page2tei-0.xsl

## Transformation II: "trans2tei-2"
1. Transformation der xml-Datei mit remove-seite.xsl

## manuell II
1. ggf. Adaption von split-files.xsl (Jahr, Personen etc.)

## Transformation III: "trans2tei-3"
1. Transformation der xml-Datei mit split-files.xsl
2. Transformation der neuen xml-Dateien mit replace.xsl

## manuell III
1. neue xml-Dokumente formatieren

## Contributors
- @tboenig
- @peterstadler
- @tillgrallert

## Adaptions
- @laurauntner
- @mepherl
