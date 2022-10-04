<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="places"
        select="document('/Users/oldfiche/Documents/git/schnitzler-orte/editions/schnitzler_places.xml')"/>
    <xsl:key name="place-lookup" match="tei:event" use="@when"/>
 
 <xsl:template match="correspAction">
     <xsl:element name="correspAction" namespace="">
         <xsl:attribute name="type">
             <xsl:value-of select="@type"/>
         </xsl:attribute>
         <xsl:copy-of select="*" copy-namespaces="no"/>
         <xsl:copy-of select="key('place-lookup', date/@when, $places)//tei:idno[@type='pmb']" copy-namespaces="no"/>
     </xsl:element>
 </xsl:template>
</xsl:stylesheet>
