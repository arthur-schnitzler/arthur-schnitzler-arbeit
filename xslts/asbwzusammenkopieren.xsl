<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                version="3.0"
                exclude-result-prefixes="tei">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="node()">
        <xsl:copy>
            <xsl:variable name="folderURI" select="resolve-uri('.',base-uri())"/>
            <xsl:for-each select="collection(concat($folderURI, '/editions/?select=L0*.xml;recurse=yes'))">
                <!--<xsl:if test="tei:TEI/tei:teiHeader[1]/tei:profileDesc[1]/tei:correspDesc[1]/tei:correspContext[1]/tei:ref[@type='belongsToCorrespondence' and @target='correspondence_2167'][1]">-->
                <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:copy-of select="tei:TEI/@*"/>
                    <xsl:copy-of select="tei:TEI/tei:teiHeader"/>
                    <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:copy-of select="tei:TEI/tei:text/tei:body"/>
                    </xsl:element>
                </xsl:element>
                <!--</xsl:if>-->
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    
    
   
</xsl:stylesheet>
