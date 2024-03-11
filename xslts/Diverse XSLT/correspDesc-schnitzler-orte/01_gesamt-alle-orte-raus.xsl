<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="root">
        <xsl:element name="profileDesc" namespace="">
            <xsl:apply-templates select="descendant::correspAction"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="correspAction[date/@when and persName[. ='Schnitzler, Arthur']]">
        <xsl:element name="correspAction" namespace="">
            <xsl:attribute name="type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:copy-of select="*" copy-namespaces="no"/>
        </xsl:element>
        
        
        
        
    </xsl:template>
    
    
</xsl:stylesheet>
