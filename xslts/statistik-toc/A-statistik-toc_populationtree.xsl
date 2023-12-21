<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.0">
    <xsl:output method="text" indent="false"/>
    <xsl:mode on-no-match="shallow-skip"/>
    <!-- diese datei soll, angewandt auf statistik_toc_XXXX.xml-Dateien,
       mehrere csv-Dateien schreiben, mit denen sich Grafiken bauen lassen
   -->
    <!--<xsl:template match="/">
        <xsl:variable name="filename"
            select="concat('statistik_1_', descendant::tei:correspContext[not(tei:ref[@type = 'belongsToCorrespondence'][2])][1]/tei:ref[@type = 'belongsToCorrespondence'][1]/@target)"/>
        <xsl:result-document href="../../../schnitzler-briefe-statistik/statistik1/{$filename}.csv">
            <xsl:apply-templates select="tei:TEI"/>
        </xsl:result-document>
    </xsl:template>-->
    <xsl:template match="tei:body/tei:list">
        <xsl:variable name="startYear" select="1888"/>
        <xsl:variable name="endYear" select="1901"/>
        <xsl:variable name="correspAction-gesamt" as="node()" select="."/>
        <xsl:variable name="correspAction-schnitzler" as="node()">
            <xsl:element name="profileDesc" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of
                    select="descendant::tei:correspDesc[tei:correspAction[@type = 'sent']/tei:persName/@ref = '#pmb2121']"
                />
            </xsl:element>
        </xsl:variable>
        <xsl:variable name="correspAction-notschnitzler" as="node()">
            <xsl:element name="profileDesc" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of
                    select="descendant::tei:correspDesc[tei:correspAction[last()]/tei:persName/@ref = '#pmb2121']"
                />
            </xsl:element>
        </xsl:variable>
        <xsl:text>year,"von Schnitzler","an Schnitzler"&#10;</xsl:text>
        <xsl:for-each select="($startYear to $endYear)">
            <xsl:variable name="currentYear" select="."/>
            <!-- Zählen der tei:date[@when] für das aktuelle Jahr -->
            <xsl:variable name="countAllDates"
                select="count($correspAction-gesamt/descendant::tei:correspDesc/tei:correspAction[1]/tei:date[number(tokenize(@*[contains(., '-')][1], '-')[1]) = $currentYear]/number(tokenize(@*[contains(., '-')][1], '-')[1]))"
                as="xs:integer"/>
            <xsl:variable name="countSchnitzlerDates"
                select="count($correspAction-schnitzler/descendant::tei:correspDesc/tei:correspAction[1]/tei:date[number(tokenize(@*[contains(., '-')][1], '-')[1]) = $currentYear]/number(tokenize(@*[contains(., '-')][1], '-')[1]))"
                as="xs:integer"/>
            <xsl:variable name="countNotSchnitzlerDates"
                select="count($correspAction-notschnitzler/descendant::tei:correspDesc/tei:correspAction[1]/tei:date[number(tokenize(@*[contains(., '-')][1], '-')[1]) = $currentYear]/number(tokenize(@*[contains(., '-')][1], '-')[1]))"
                as="xs:integer"/>
            <!-- Ausgabe der Anzahl von tei:date[@when] für das aktuelle Jahr -->
            <xsl:value-of
                select="concat($currentYear, ',-', $countSchnitzlerDates, ',', $countNotSchnitzlerDates)"/>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
        <xsl:variable name="startYear" select="1902"/>
        <xsl:variable name="endYear" select="1931"/>
        <xsl:for-each select="($startYear to $endYear)">
            <xsl:variable name="currentYear" select="."/>
            <!-- Zählen der tei:date[@when] für das aktuelle Jahr -->
            <xsl:variable name="countAllDates"
                select="count($correspAction-gesamt/descendant::tei:correspDesc/tei:correspAction[1]/tei:date[number(tokenize(@*[contains(., '-')][1], '-')[1]) = $currentYear]/number(tokenize(@*[contains(., '-')][1], '-')[1]))"
                as="xs:integer"/>
            <xsl:variable name="countSchnitzlerDates"
                select="count($correspAction-schnitzler/descendant::tei:correspDesc/tei:correspAction[1]/tei:date[number(tokenize(@*[contains(., '-')][1], '-')[1]) = $currentYear]/number(tokenize(@*[contains(., '-')][1], '-')[1]))"
                as="xs:integer"/>
            <xsl:variable name="countNotSchnitzlerDates"
                select="count($correspAction-notschnitzler/descendant::tei:correspDesc/tei:correspAction[1]/tei:date[number(tokenize(@*[contains(., '-')][1], '-')[1]) = $currentYear]/number(tokenize(@*[contains(., '-')][1], '-')[1]))"
                as="xs:integer"/>
            <!-- Ausgabe der Anzahl von tei:date[@when] für das aktuelle Jahr -->
            <xsl:value-of
                select="concat($currentYear, ',-', $countSchnitzlerDates, ',', $countNotSchnitzlerDates)"/>
            <xsl:if test="not($currentYear = $endYear)">
                <xsl:text>&#10;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
