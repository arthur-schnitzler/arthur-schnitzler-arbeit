<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <!-- ein Telegramm kommt am gleichen Tag an, also correspDesc ergänzen-->
    
    <xsl:template match="tei:correspAction[@type='received' and not(tei:date) and ancestor::tei:TEI/descendant::tei:objectDesc/tei:desc/@type='telegramm']">
        <xsl:element name="correspAction">
            <xsl:attribute name="type">
                <xsl:text>received</xsl:text>
            </xsl:attribute>
            <xsl:copy-of select="tei:*"/>
            <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="evidence">
                    <xsl:text>conjecture</xsl:text>
                </xsl:attribute>
                <xsl:variable name="correspvorher" select="preceding-sibling::tei:correspAction[@type='sent'][1]/tei:date[1]" as="node()"/>
                <xsl:copy-of select="$correspvorher/@*[not(name()='n')]"/>
                <xsl:value-of select="$correspvorher"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    
</xsl:stylesheet>
