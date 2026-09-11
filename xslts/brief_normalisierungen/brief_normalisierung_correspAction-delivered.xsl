<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xml" indent="no" encoding="UTF-8"/>
    <!-- Identity template: copy everything by default -->
    <xsl:mode on-no-match="shallow-copy"/>

    <!--
        Ergänzt correspAction[@type="delivered"] in allen correspDesc, deren TEI
        einen Poststempel mit der Anmerkung "bestellt"/"Bestellt" trägt und die
        noch kein correspAction[@type="delivered"] haben – entspricht:

        //TEI[descendant::physDesc/additions/descendant::stamp/addSpan[.='bestellt' or .='Bestellt']]
            /descendant::correspDesc[not(correspAction/@type='delivered')]

        Zustelldatum und -ort stammen aus genau diesem Stempel. Eingefügt wird
        nach der letzten Beförderungsstation – dem letzten correspAction, das
        weder "received" noch "delivered" ist (also nach ggf. mehreren
        "transmitted", sonst nach "sent") – und vor "received".

        date: hat der Stempel kein @when, wird kein date eingefügt (Rohtext
        wird nicht geraten). Sonst wird die Anzeige aus @when neu gebildet
        (Editionskonvention: Tag.&#160;Monat.&#160;Jahr, ohne führende Nullen),
        der Stempel-Rohtext (der oft nicht normierte Formen wie "7./7. 91"
        enthält) wird dafür nicht verwendet.

        placeName: Text wird aus dem Stempel übernommen; darin enthaltene
        <unclear> werden aufgelöst (nur ihr Text bleibt), <supplied> wird als
        [eckige Klammern] ausgegeben.
    -->
    <xsl:template match="tei:correspDesc
        [not(tei:correspAction/@type = 'delivered')]
        [ancestor::tei:TEI/descendant::tei:physDesc/tei:additions/descendant::tei:stamp
            /tei:addSpan[. = 'bestellt' or . = 'Bestellt']]">

        <xsl:variable name="stempel" as="element(tei:stamp)?"
            select="(ancestor::tei:TEI/descendant::tei:physDesc/tei:additions
                /descendant::tei:stamp[tei:addSpan[. = 'bestellt' or . = 'Bestellt']])[1]"/>

        <xsl:variable name="anker"
            select="tei:correspAction[not(@type = ('received', 'delivered'))][last()]"/>

        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each select="node()">
                <xsl:apply-templates select="."/>
                <xsl:if test=". is $anker">
                    <xsl:text>&#10;            </xsl:text>
                    <xsl:call-template name="neues-delivered">
                        <xsl:with-param name="stempel" select="$stempel"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="neues-delivered">
        <xsl:param name="stempel" as="element(tei:stamp)?"/>
        <xsl:variable name="wenn" select="string($stempel/tei:date[1]/@when)"/>
        <xsl:element name="correspAction" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">delivered</xsl:attribute>
            <xsl:if test="matches($wenn, '^\d{4}-\d{2}-\d{2}$')">
                <xsl:text>&#10;               </xsl:text>
                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="when" select="$wenn"/>
                    <xsl:value-of select="concat(
                        xs:integer(substring($wenn, 9, 2)), '.', '&#160;',
                        xs:integer(substring($wenn, 6, 2)), '.', '&#160;',
                        substring($wenn, 1, 4))"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="$stempel/tei:placeName">
                <xsl:variable name="ort-roh">
                    <xsl:apply-templates select="$stempel/tei:placeName[1]/node()" mode="stempel-text"/>
                </xsl:variable>
                <xsl:text>&#10;               </xsl:text>
                <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:if test="$stempel/tei:placeName[1]/@ref">
                        <xsl:attribute name="ref" select="$stempel/tei:placeName[1]/@ref"/>
                    </xsl:if>
                    <xsl:value-of select="normalize-space($ort-roh)"/>
                </xsl:element>
            </xsl:if>
            <xsl:text>&#10;            </xsl:text>
        </xsl:element>
    </xsl:template>

    <!-- Mixed-Content des Stempel-Ortsnamens zu Klartext auflösen:
         unclear wird ignoriert (nur Text bleibt), supplied wird [eckig]. -->
    <xsl:template match="tei:supplied" mode="stempel-text">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates mode="stempel-text"/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    <xsl:template match="tei:unclear" mode="stempel-text">
        <xsl:apply-templates mode="stempel-text"/>
    </xsl:template>
    <xsl:template match="text()" mode="stempel-text">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="*" mode="stempel-text">
        <xsl:apply-templates mode="stempel-text"/>
    </xsl:template>
</xsl:stylesheet>
