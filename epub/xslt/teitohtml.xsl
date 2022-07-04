<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei html" version="2.0">

    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5" indent="yes"/>

    <xsl:template match="/*">

        <html:html>

            <html:head>

                <html:meta>

                    <html:title>
                        <xsl:value-of select="tei:titleStmt/tei:title[@level = 'a']/text()"/>
                        <xsl:text> </xsl:text>
                        <html:p>(<xsl:value-of
                                select="tei:correspDesc/tei:correspAction[@type = 'sent']/tei:placeName/text()"
                            />)</html:p>
                    </html:title>

                    <html:author>
                        <xsl:value-of select="tei:titleStmt/tei:author/text()"/>
                    </html:author>

                    <html:editor>
                        <xsl:if test="tei:titleStmt/tei:editor/tei:name[1]">
                            <xsl:value-of select="./text()"/>
                        </xsl:if>
                        <xsl:if test="tei:titleStmt/tei:editor/tei:name[2]">
                            <xsl:value-of select="./text()"/>
                        </xsl:if>
                        <xsl:if test="tei:titleStmt/tei:editor/tei:name[3]">
                            <xsl:value-of select="./text()"/>
                        </xsl:if>
                    </html:editor>

                    <html:edition>
                        <html:name>
                            <xsl:value-of select="tei:titleStmt/tei:title[@level = 's']/text()"/>
                        </html:name>
                    </html:edition>

                    <html:funder>
                        <html:name>
                            <xsl:value-of select="tei:funder/tei:name/text()"/>
                        </html:name>
                    </html:funder>

                    <html:publisher>
                        <html:name>
                            <xsl:value-of select="tei:publicationStmt/tei:publisher/text()"/>
                        </html:name>
                        <html:place>
                            <xsl:value-of select="tei:publicationStmt/tei:pubPlace/text()"/>
                        </html:place>
                        <html:date>
                            <xsl:value-of select="tei:publicationStmt/tei:date/text()"/>
                            <xsl:attribute name="when">
                                <xsl:value-of select="tei:publicationStmt/tei:date/@when"/>
                            </xsl:attribute>
                        </html:date>
                    </html:publisher>

                    <html:availability>
                        <html:licence target="https://creativecommons.org/licenses/by/4.0/deed.de">
                            <html:p>Sie dürfen: Teilen — das Material in jedwedem Format oder Medium
                                vervielfältigen und weiterverbreiten Bearbeiten — das Material
                                remixen, verändern und darauf aufbauen und zwar für beliebige
                                Zwecke, sogar kommerziell.</html:p>
                            <html:p>Der Lizenzgeber kann diese Freiheiten nicht widerrufen solange
                                Sie sich an die Lizenzbedingungen halten. Unter folgenden
                                Bedingungen:</html:p>
                            <html:p>Namensnennung — Sie müssen angemessene Urheber- und
                                Rechteangaben machen, einen Link zur Lizenz beifügen und angeben, ob
                                Änderungen vorgenommen wurden. Diese Angaben dürfen in jeder
                                angemessenen Art und Weise gemacht werden, allerdings nicht so, dass
                                der Eindruck entsteht, der Lizenzgeber unterstütze gerade Sie oder
                                Ihre Nutzung besonders. Keine weiteren Einschränkungen — Sie dürfen
                                keine zusätzlichen Klauseln oder technische Verfahren einsetzen, die
                                anderen rechtlich irgendetwas untersagen, was die Lizenz
                                erlaubt.</html:p>
                            <html:p>Hinweise:</html:p>
                            <html:p>Sie müssen sich nicht an diese Lizenz halten hinsichtlich
                                solcher Teile des Materials, die gemeinfrei sind, oder soweit Ihre
                                Nutzungshandlungen durch Ausnahmen und Schranken des Urheberrechts
                                gedeckt sind. Es werden keine Garantien gegeben und auch keine
                                Gewähr geleistet. Die Lizenz verschafft Ihnen möglicherweise nicht
                                alle Erlaubnisse, die Sie für die jeweilige Nutzung brauchen. Es
                                können beispielsweise andere Rechte wie Persönlichkeits- und
                                Datenschutzrechte zu beachten sein, die Ihre Nutzung des Materials
                                entsprechend beschränken.</html:p>
                        </html:licence>
                    </html:availability>

                    <html:idno>
                        <xsl:value-of select="tei:idno/text()"/>
                    </html:idno>

                    <!-- witness 1 bis 5 -->

                    <!-- listBibl -->

                    <html:language>
                        <xsl:value-of select="tei:langUsage/tei:language/text()"/>
                        <xsl:attribute name="ident">
                            <xsl:value-of select="tei:langUsage/tei:language/@ident"/>
                        </xsl:attribute>
                    </html:language>

                    <html:doc-type>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'anderes']">
                            <xsl:value-of select="'Anderes'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'bild']">
                            <xsl:value-of select="'Bild'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'brief']">
                            <xsl:value-of select="'Brief'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'entwurf']">
                            <xsl:value-of select="'Entwurf'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'fragment']">
                            <xsl:value-of select="'Fragment'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'karte']">
                            <xsl:value-of select="'Karte'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'kartenbrief']">
                            <xsl:value-of select="'Kartenbrief'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'reproduktion']">
                            <xsl:value-of select="'Reproduktion'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'telegramm']">
                            <xsl:value-of select="'Telegramm'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'umschlag']">
                            <xsl:value-of select="'Umschlag'"/>
                        </xsl:if>
                        <xsl:if test="tei:physDesc/tei:desc[@type = 'widmung']">
                            <xsl:value-of select="'Widmung'"/>
                        </xsl:if>
                    </html:doc-type>

                </html:meta>

            </html:head>

            <html:body>

                <xsl:if test="tei:body">
                    <xsl:if test="tei:div[@*]">

                        <xsl:if test="tei:dateline">
                            <html:p>
                                <xsl:value-of select="tei:dateline/text()"/>
                            </html:p>
                        </xsl:if>
                        <xsl:if test="tei:salute">
                            <html:p>
                                <xsl:value-of select="tei:salute/text()"/>
                            </html:p>
                        </xsl:if>
                        <xsl:if test="tei:addrLine">
                            <html:p>
                                <xsl:value-of select="tei:addrLine/text()"/>
                            </html:p>
                        </xsl:if>
                        <xsl:if test="tei:p">
                            <html:p>
                                <xsl:value-of select="tei:p/text()"/>
                            </html:p>
                        </xsl:if>
                        <xsl:if test="tei:closer">
                            <html:p>
                                <xsl:value-of select="tei:closer/text()"/>
                            </html:p>
                        </xsl:if>
                        <xsl:if test="tei:signed">
                            <html:p>
                                <xsl:value-of select="tei:signed/text()"/>
                            </html:p>
                        </xsl:if>

                    </xsl:if>
                </xsl:if>

            </html:body>

            <!-- Optionen für Listen, Tabellen, Gedichte etc. -->

        </html:html>

        <xsl:apply-templates/>
        
        <!-- funktioniert überhaupt nicht!! -->

    </xsl:template>

</xsl:stylesheet>
