<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" version="3.0">

    <xsl:output name="xml" method="xml" indent="yes" omit-xml-declaration="yes"/>

    <!-- directory of new files -->
    <xsl:param name="dir">../editions</xsl:param>

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
        <xsl:for-each select="tei:page[starts-with(@type, 'letter-begin')]">
            <xsl:variable name="nummer" select="$letzte-nummer + position()" as="xs:integer"/>
            <xsl:result-document href="../splitted-files/Y0{$nummer}.xml">
                <TEI xmlns="http://www.tei-c.org/ns/1.0"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.tei-c.org/ns/1.0 ../meta/asbwschema.xsd"
                    xml:id="L0XXXX"
                    xml:base="https://id.acdh.oeaw.ac.at/schnitzler/schnitzler-briefe/editions">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <title level="s">Arthur Schnitzler: Briefwechsel mit Autorinnen und
                                    Autoren</title>
                                <title level="a">Paul Goldmann an Arthur Schnitzler, XXXX</title>
                                <author ref="#pmb11485">Goldmann, Paul</author>
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
                                <idno type="asbw">L0XXXX</idno>
                            </editionStmt>
                            <publicationStmt>
                                <publisher>Austrian Centre for Digital Humanities and Cultural
                                    Heritage</publisher>
                                <pubPlace>Vienna</pubPlace>
                                <date when="2023">2023</date>
                                <availability>
                                    <licence
                                        target="https://creativecommons.org/licenses/by/4.0/deed.de">
                                        <p>Sie dürfen: Teilen — das Material in jedwedem Format oder
                                            Medium vervielfältigen und weiterverbreiten Bearbeiten —
                                            das Material remixen, verändern und darauf aufbauen und
                                            zwar für beliebige Zwecke, sogar kommerziell.</p>
                                        <p>Der Lizenzgeber kann diese Freiheiten nicht widerrufen
                                            solange Sie sich an die Lizenzbedingungen halten. Unter
                                            folgenden Bedingungen:</p>
                                        <p>Namensnennung — Sie müssen angemessene Urheber- und
                                            Rechteangaben machen, einen Link zur Lizenz beifügen und
                                            angeben, ob Änderungen vorgenommen wurden. Diese Angaben
                                            dürfen in jeder angemessenen Art und Weise gemacht
                                            werden, allerdings nicht so, dass der Eindruck entsteht,
                                            der Lizenzgeber unterstütze gerade Sie oder Ihre Nutzung
                                            besonders. Keine weiteren Einschränkungen — Sie dürfen
                                            keine zusätzlichen Klauseln oder technische Verfahren
                                            einsetzen, die anderen rechtlich irgendetwas untersagen,
                                            was die Lizenz erlaubt.</p>
                                        <p>Hinweise:</p>
                                        <p>Sie müssen sich nicht an diese Lizenz halten hinsichtlich
                                            solcher Teile des Materials, die gemeinfrei sind, oder
                                            soweit Ihre Nutzungshandlungen durch Ausnahmen und
                                            Schranken des Urheberrechts gedeckt sind. Es werden
                                            keine Garantien gegeben und auch keine Gewähr geleistet.
                                            Die Lizenz verschafft Ihnen möglicherweise nicht alle
                                            Erlaubnisse, die Sie für die jeweilige Nutzung brauchen.
                                            Es können beispielsweise andere Rechte wie
                                            Persönlichkeits- und Datenschutzrechte zu beachten sein,
                                            die Ihre Nutzung des Materials entsprechend
                                            beschränken.</p>
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
                                        <objectType corresp=""/>
                                        <msDesc>
                                            <msIdentifier>
                                                <country>D</country>
                                                <settlement>Marbach am Neckar</settlement>
                                                <repository>Deutsches Literaturarchiv</repository>
                                                <idno>A:Schnitzler, HS.NZ85.1.3175</idno>
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
                                    <persName ref="#pmb11485">Goldmann, Paul</persName>
                                    <date when="" n="01">XXXX</date>
                                    <placeName ref="#pmb168">Berlin</placeName>
                                </correspAction>
                                <correspAction type="received">
                                    <persName ref="#pmb2121">Schnitzler, Arthur</persName>
                                    <placeName ref="#pmb50">Wien</placeName>
                                </correspAction>
                            </correspDesc>
                        </profileDesc>
                        <revisionDesc status="proposed">
                            <change who="KSK" when="{$heute}">Export aus Transkribus</change>
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
                                <xsl:copy-of select="."/>
                                <xsl:if test="@type != 'letter-begin-end'">
                                    <xsl:for-each
                                        select="following-sibling::tei:page[not(contains(@type, 'begin'))]">
                                        <xsl:copy-of select="."/>
                                    </xsl:for-each>
                                </xsl:if>
                            </xsl:element>
                        </body>
                    </text>
                </TEI>
                <!--<TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.tei-c.org/ns/1.0 ../meta/asbwschema.xsd"
                    xml:id="L0XXXX"
                    xml:base="https://id.acdh.oeaw.ac.at/schnitzler/schnitzler-briefe/editions">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <title level="s">Arthur Schnitzler: Briefwechsel mit Autorinnen und
                                    Autoren</title>
                                <title level="a">Arthur Schnitzler an Felix Salten, XXXX</title>
                                <author ref="#pmb2121">Schnitzler, Arthur</author>
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
                                <idno type="asbw">L0XXXX</idno>
                            </editionStmt>
                            <publicationStmt>
                                <publisher>Austrian Centre for Digital Humanities and Cultural
                                    Heritage</publisher>
                                <pubPlace>Vienna</pubPlace>
                                <date when="2023">2023</date>
                                <availability>
                                    <licence
                                        target="https://creativecommons.org/licenses/by/4.0/deed.de">
                                        <p>Sie dürfen: Teilen — das Material in jedwedem Format oder
                                            Medium vervielfältigen und weiterverbreiten Bearbeiten —
                                            das Material remixen, verändern und darauf aufbauen und
                                            zwar für beliebige Zwecke, sogar kommerziell.</p>
                                        <p>Der Lizenzgeber kann diese Freiheiten nicht widerrufen
                                            solange Sie sich an die Lizenzbedingungen halten. Unter
                                            folgenden Bedingungen:</p>
                                        <p>Namensnennung — Sie müssen angemessene Urheber- und
                                            Rechteangaben machen, einen Link zur Lizenz beifügen und
                                            angeben, ob Änderungen vorgenommen wurden. Diese Angaben
                                            dürfen in jeder angemessenen Art und Weise gemacht
                                            werden, allerdings nicht so, dass der Eindruck entsteht,
                                            der Lizenzgeber unterstütze gerade Sie oder Ihre Nutzung
                                            besonders. Keine weiteren Einschränkungen — Sie dürfen
                                            keine zusätzlichen Klauseln oder technische Verfahren
                                            einsetzen, die anderen rechtlich irgendetwas untersagen,
                                            was die Lizenz erlaubt.</p>
                                        <p>Hinweise:</p>
                                        <p>Sie müssen sich nicht an diese Lizenz halten hinsichtlich
                                            solcher Teile des Materials, die gemeinfrei sind, oder
                                            soweit Ihre Nutzungshandlungen durch Ausnahmen und
                                            Schranken des Urheberrechts gedeckt sind. Es werden
                                            keine Garantien gegeben und auch keine Gewähr geleistet.
                                            Die Lizenz verschafft Ihnen möglicherweise nicht alle
                                            Erlaubnisse, die Sie für die jeweilige Nutzung brauchen.
                                            Es können beispielsweise andere Rechte wie
                                            Persönlichkeits- und Datenschutzrechte zu beachten sein,
                                            die Ihre Nutzung des Materials entsprechend
                                            beschränken.</p>
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
                                        <objectType corresp=""/>
                                        <msDesc>
                                            <msIdentifier>
                                                <country>D</country>
                                                <settlement>Marbach am Neckar</settlement>
                                                <repository>Deutsches Literaturarchiv</repository>
                                                <idno>A:Schnitzler, HS.NZ85.1.3166</idno>
                                            </msIdentifier>
                                            <physDesc>
                                                <objectDesc>
                                                  <supportDesc>
                                                  <extent>
                                                  <measure unit="blatt" quantity=""/>
                                                  <measure unit="seite" quantity=""/>
                                                  </extent>
                                                  </supportDesc>
                                                </objectDesc>
                                                <handDesc>
                                                  <handNote medium="" style="deutsche-kurrent"/>
                                                </handDesc>
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
                                    <persName ref="#pmb2121">Schnitzler, Arthur</persName>
                                    <date when="" n="01">XXXX</date>
                                    <placeName ref="#50">Wien</placeName>
                                </correspAction>
                                <correspAction type="received">
                                    <persName ref="#pmb2167">Salten, Felix</persName>
                                    <placeName ref="#50">Wien</placeName>
                                </correspAction>
                            </correspDesc>
                        </profileDesc>
                        <revisionDesc status="proposed">
                            <change who="MAM" when="{$heute}">Export aus Transkribus</change>
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
                                <xsl:copy-of select="."/>
                                <xsl:if test="@type != 'letter-begin-end'">
                                    <xsl:for-each
                                        select="following-sibling::tei:page[not(contains(@type, 'begin'))]">
                                        <xsl:copy-of select="."/>
                                    </xsl:for-each>
                                </xsl:if>
                            </xsl:element>
                        </body>
                    </text>
                </TEI>-->
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
