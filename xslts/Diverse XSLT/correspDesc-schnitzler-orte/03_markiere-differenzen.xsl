<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="persName"/>
 
 <xsl:template match="placeName[@ref = following-sibling::idno]">
     <xsl:element name="treffer" namespace=""/>
 </xsl:template>
 
 
</xsl:stylesheet>
