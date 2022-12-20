<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    
    <xsl:mode on-no-match="shallow-copy" />
    <xsl:output indent="yes"
        method="xml"
        encoding="utf-8"
        omit-xml-declaration="false"/>
    
    <xsl:param name="alphabet" select="document('alphabet.xml')"/>
    <xsl:key name="letter-lookup" match="row" use="letter"/>
    
    <xsl:template match="base">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="object">
        <xsl:element name="group">
            <xsl:element name="object">
            <xsl:value-of select="text()"/>
            </xsl:element>
            <xsl:element name="preceding">
                <xsl:value-of select="key('letter-lookup', text(), $alphabet)/preceding-sibling::row[@attr='bahr'][1]"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>