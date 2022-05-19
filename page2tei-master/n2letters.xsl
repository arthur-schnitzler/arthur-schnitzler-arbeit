<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="@* | * | processing-instruction() | comment()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="letter">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="position()"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
