<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" version="3.0" exclude-result-prefixes="xhtml">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="//xhtml:div//xhtml:a/@name">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="//xhtml:p[child::xhtml:div[@class='editionText salute']]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="//@data-bs-target">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="//@data-bs-toggle">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="//@align">
        <xsl:attribute name="id">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    
</xsl:stylesheet>
