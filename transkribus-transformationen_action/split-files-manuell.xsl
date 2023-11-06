<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output name="xml" method="xml" indent="yes" omit-xml-declaration="yes"/>
    <!-- directory of new files -->
    <xsl:param name="dir">../editions</xsl:param>
    <xsl:param name="sender-in_pmb" as="xs:string">pmb11485</xsl:param>
    <xsl:param name="sender-in_name" as="xs:string">Goldmann, Paul</xsl:param>
    <xsl:param name="empfaenger-in_pmb" as="xs:string">pmb2121</xsl:param>
    <xsl:param name="empfaenger-in_name" as="xs:string">Schnitzler, Arthur</xsl:param>
    <xsl:param name="titel" as="xs:string">Paul Goldmann an Arthur Schnitzler</xsl:param>
    <xsl:param name="archiv-land" as="xs:string">D</xsl:param>
    <xsl:param name="archiv-stadt" as="xs:string">Marbach am Neckar</xsl:param>
    <xsl:param name="archiv-institution" as="xs:string">Deutsches Literaturarchiv</xsl:param>
    <xsl:param name="signatur" as="xs:string">A:Schnitzler, HS.NZ85.1.3174</xsl:param>

    <!--<xsl:param name="sender-in_pmb" as="xs:string">pmb2167</xsl:param>
    <xsl:param name="sender-in_name" as="xs:string">Salten, Felix</xsl:param>
    <xsl:param name="empfaenger-in_pmb" as="xs:string">pmb2121</xsl:param>
    <xsl:param name="empfaenger-in_name" as="xs:string">Schnitzler, Arthur</xsl:param>
    <xsl:param name="titel" as="xs:string">Felix Salten an Arthur Schnitzler</xsl:param>
    <xsl:param name="archiv-land" as="xs:string">GB</xsl:param>
    <xsl:param name="archiv-stadt" as="xs:string">Cambridge</xsl:param>
    <xsl:param name="archiv-institution" as="xs:string">University Library</xsl:param>
    <xsl:param name="signatur" as="xs:string">Schnitzler, B&#160;89, B&#160;1</xsl:param>-->



    <!--<xsl:param name="exporter">MAM</xsl:param>-->
    <xsl:param name="exporter">LU</xsl:param>
    <!-- hier Kürzel, LU oder MAM -->
    <!-- output xml file for each letter tag with file name according to number of xml files in output directory (+1) -->
    <xsl:template match="tei:div">
        <xsl:variable name="letzte-nummer" as="xs:integer">
            <xsl:for-each select="uri-collection(concat($dir, '/?select=L0*.xml;recurse=yes'))">
                <xsl:sort select="."/>
                <xsl:if test="position() = last()">
                    <xsl:value-of
                        select="number(substring-before(substring-after(., '/L'), '.xml'))"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="heute" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
        <xsl:for-each-group select="tei:page"
            group-starting-with="*[starts-with(@type, 'letter-begin')]">
            <xsl:variable name="nummer" select="$letzte-nummer + position()" as="xs:integer"/>
            <xsl:result-document href="../editions/L0{$nummer}.xml">
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.tei-c.org/ns/1.0 ../meta/asbwschema.xsd"
                    xml:id="{concat('L0',$nummer)}"
                    xml:base="https://id.acdh.oeaw.ac.at/schnitzler/schnitzler-briefe/editions">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <title level="s">Arthur Schnitzler: Briefwechsel mit Autorinnen und
                                    Autoren</title>
                                <title level="a">
                                    <xsl:value-of select="concat($titel, ', XXXX')"/>
                                </title>
                                <author ref="{concat('#', $sender-in_pmb)}">
                                    <xsl:value-of select="$sender-in_name"/>
                                </author>
                                <editor>
                                    <name>Müller, Martin Anton</name>
                                    <name>Untner, Laura</name>
                                </editor>
                                <funder>
                                    <name>FWF - Der Wissenschaftsfonds</name>
                                    <address>
                                        <street>Sensengasse 1</street>
                                        <postCode>1090 Wien</postCode>
                                        <placeName>
                                            <country>A</country>
                                            <settlement>Wien</settlement>
                                        </placeName>
                                    </address>
                                </funder>
                            </titleStmt>
                            <editionStmt>
                                <edition>ASBW</edition>
                                <respStmt>
                                    <resp>Transkription und Kommentierung</resp>
                                    <name>Müller, Martin Anton</name>
                                    <name>Untner, Laura</name>
                                </respStmt>
                            </editionStmt>
                            <publicationStmt>
                                <publisher>Austrian Centre for Digital Humanities and Cultural
                                    Heritage</publisher>
                                <pubPlace>Vienna</pubPlace>
                                <date when="2023">2023</date>
                                <availability>
                                    <licence
                                        target="https://creativecommons.org/licenses/by/4.0/deed.de">
                                        <p>
                                            <xsl:text>Sie dürfen: Teilen — das Material in jedwedem Format oder
                                            Medium vervielfältigen und weiterverbreiten Bearbeiten —
                                            das Material remixen, verändern und darauf aufbauen und
                                            zwar für beliebige Zwecke, sogar kommerziell.</xsl:text>
                                        </p>
                                        <p>
                                            <xsl:text>Der Lizenzgeber kann diese Freiheiten nicht widerrufen
                                            solange Sie sich an die Lizenzbedingungen halten. Unter
                                            folgenden Bedingungen:</xsl:text>
                                        </p>
                                        <p>
                                            <xsl:text>Namensnennung — Sie müssen angemessene Urheber- und
                                            Rechteangaben machen, einen Link zur Lizenz beifügen und
                                            angeben, ob Änderungen vorgenommen wurden. Diese Angaben
                                            dürfen in jeder angemessenen Art und Weise gemacht
                                            werden, allerdings nicht so, dass der Eindruck entsteht,
                                            der Lizenzgeber unterstütze gerade Sie oder Ihre Nutzung
                                            besonders. Keine weiteren Einschränkungen — Sie dürfen
                                            keine zusätzlichen Klauseln oder technische Verfahren
                                            einsetzen, die anderen rechtlich irgendetwas untersagen,
                                            was die Lizenz erlaubt.</xsl:text>
                                        </p>
                                        <p>
                                            <xsl:text>Hinweise:</xsl:text>
                                        </p>
                                        <p>
                                            <xsl:text>Sie müssen sich nicht an diese Lizenz halten hinsichtlich
                                            solcher Teile des Materials, die gemeinfrei sind, oder
                                            soweit Ihre Nutzungshandlungen durch Ausnahmen und
                                            Schranken des Urheberrechts gedeckt sind. Es werden
                                            keine Garantien gegeben und auch keine Gewähr geleistet.
                                            Die Lizenz verschafft Ihnen möglicherweise nicht alle
                                            Erlaubnisse, die Sie für die jeweilige Nutzung brauchen.
                                            Es können beispielsweise andere Rechte wie
                                            Persönlichkeits- und Datenschutzrechte zu beachten sein,
                                            die Ihre Nutzung des Materials entsprechend
                                            beschränken.</xsl:text>
                                        </p>
                                    </licence>
                                </availability>
                                <idno type="handle">XXXX</idno>
                            </publicationStmt>
                            <seriesStmt>
                                <p>Machine-Readable Transcriptions of the Correspondences of Arthur
                                    Schnitzler</p>
                            </seriesStmt>
                            <sourceDesc>
                                <listWit>
                                    <witness n="1">
                                        <objectType corresp="xbrief"/>
                                        <msDesc>
                                            <msIdentifier>
                                                <country>
                                                  <xsl:value-of select="$archiv-land"/>
                                                </country>
                                                <settlement>
                                                  <xsl:value-of select="$archiv-stadt"/>
                                                </settlement>
                                                <repository>
                                                  <xsl:value-of select="$archiv-institution"/>
                                                </repository>
                                                <idno>
                                                  <xsl:value-of select="$signatur"/>
                                                </idno>
                                            </msIdentifier>
                                            <physDesc>
                                                <objectDesc>

                                                  <supportDesc>
                                                  <extent>
                                                  <measure unit="seite" quantity=""/>
                                                  <measure unit="blatt" quantity=""/>
                                                  </extent>
                                                  </supportDesc>

                                                </objectDesc>
                                                <handDesc>
                                                  <handNote medium="" style="deutsche-kurrent"/>
                                                </handDesc>
                                                <!--<additions>
                                                    <incident type="archival">
                                                        <desc>Xmit Bleistift von unbekannter Hand nummeriert: »<quote>x</quote>«</desc>
                                                    </incident>
                                                </additions>-->
                                            </physDesc>
                                        </msDesc>
                                    </witness>
                                </listWit>
                            </sourceDesc>
                        </fileDesc>
                        <profileDesc>
                            <langUsage>
                                <language ident="de-AT">German</language>
                            </langUsage>
                            <correspDesc>
                                <correspAction type="sent">
                                    <persName ref="{concat('#', $sender-in_pmb)}">
                                        <xsl:value-of select="$sender-in_name"/>
                                    </persName>
                                    <date when="" n="01">XXXX</date>
                                    <!--<placeName ref="#50" evidence="conjecture">Wien</placeName>-->
                                    <placeName ref="#168" evidence="conjecture">Berlin</placeName>
                                </correspAction>
                                <correspAction type="received">
                                    <persName ref="{concat('#', $empfaenger-in_pmb)}">
                                        <xsl:value-of select="$empfaenger-in_name"/>
                                    </persName>
                                    <placeName ref="#50" evidence="conjecture">Wien</placeName>
                                </correspAction>
                            </correspDesc>
                        </profileDesc>
                        <revisionDesc status="proposed">
                            <change who="{$exporter}" when="{$heute}">Export aus
                                Transkribus</change>
                        </revisionDesc>
                    </teiHeader>
                    <text>
                        <body>
                            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'writingSession'"/>
                                </xsl:attribute>
                                <xsl:attribute name="n">
                                    <xsl:value-of select="'1'"/>
                                </xsl:attribute>
                                <xsl:copy-of select="current-group()"/>
                            </xsl:element>
                        </body>
                    </text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>
