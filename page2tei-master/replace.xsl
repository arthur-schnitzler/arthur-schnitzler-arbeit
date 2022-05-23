<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:ckbk="http://www.oreilly.com/xsltckbk" exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="@* | * | processing-instruction() | comment()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="replace-xmlns">
        <xsl:variable name="s1" select="' xmlns='''"/>
        <xsl:value-of select="replace($s1, ' xmlns=''', '')"/>
    </xsl:template>

</xsl:stylesheet>
