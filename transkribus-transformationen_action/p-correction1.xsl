<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="tei:p[@facs]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:page">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:letter-begin|tei:letter-end"/>
    
    
    <xsl:template match="tei:pb">
        <xsl:text> </xsl:text>
        <xsl:copy-of select="."/>
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>
