<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:strip-space elements="*"/>
    <!-- Dieses XSLT überprüft, ob manche Daten plus Nummer doppelt sind -->
    
    <xsl:template match="tei:correspDesc">
        <xsl:variable name="datum" select="@date"/>
        <xsl:choose>
            <xsl:when test="preceding-sibling::tei:correspDesc/@date =$datum">
                <xsl:element name="doppelter-tag" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:value-of select="$datum"/>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
