<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="3.0"
    exclude-result-prefixes="tei xhtml">

    <xsl:output method="xhtml" omit-xml-declaration="yes" doctype-public="yes"/>
    
    <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>
    
    <xsl:template match="tei:TEI">
        <xsl:for-each select="collection(concat($folderURI, '/?select=L0*.xml;recurse=yes'))">
            <xsl:sort select="//tei:correspAction[@type = 'sent']/tei:date/@when"
                order="ascending"/>
            <!--    copy of brief-titel 
    
            copy of brief-text (wie in asbw-gesamt) 
    
            copy of brief-kommentar (wie in asbw-gesamt) -->
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
