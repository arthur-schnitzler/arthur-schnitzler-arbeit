<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" 
    xmlns:foo="whatever" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="tei:correspAction[@type='received' and tei:date[@evidence and @notAfter]/@notBefore=preceding-sibling::tei:correspAction/tei:date/@when and tei:placeName/@ref != preceding-sibling::tei:correspAction/tei:placeName/@ref]/tei:date[@evidence]">
        <xsl:element name="date">
            <xsl:copy-of select="@evidence"/>
            <xsl:attribute name="notBefore">
                <xsl:value-of select="xs:date(@notBefore) + xs:dayTimeDuration('P1D')"/>
            </xsl:attribute>
            <xsl:attribute name="notAfter">
                <xsl:value-of select="xs:date(@notAfter) + xs:dayTimeDuration('P1D')"/>
            </xsl:attribute>
            <xsl:text>[</xsl:text><xsl:value-of select="foo:formatdate(xs:date(@notBefore) + xs:dayTimeDuration('P1D'))"/><xsl:text> – </xsl:text><xsl:value-of select="foo:formatdate(xs:date(@notAfter) + xs:dayTimeDuration('P1D'))"/><xsl:text>?]</xsl:text>                                
        </xsl:element>
        
    </xsl:template>
  
  
    <xsl:function name="foo:formatdate">
        <xsl:param name="date-incoming" as="xs:date"/>
        <xsl:variable name="date" select="string($date-incoming)" as="xs:string"/>
        <xsl:variable name="tag" as="xs:string">
            <xsl:choose>
                <xsl:when test="starts-with(tokenize($date,'-')[3], '0')">
                    <xsl:value-of select="substring(tokenize($date,'-')[3], 2)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="tokenize($date,'-')[3]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="monat" as="xs:string">
            <xsl:choose>
                <xsl:when test="starts-with(tokenize($date,'-')[2], '0')">
                    <xsl:value-of select="substring(tokenize($date,'-')[2], 2)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="tokenize($date,'-')[2]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$tag"/><xsl:text>.&#160;</xsl:text><xsl:value-of select="$monat"/><xsl:text>.&#160;</xsl:text><xsl:value-of select="tokenize($date,'-')[1]"/>
    </xsl:function>
    
    
</xsl:stylesheet>
