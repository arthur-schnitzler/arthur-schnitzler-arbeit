<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:output indent="yes"
        method="xml"
        encoding="utf-8"
        omit-xml-declaration="false"/>
    <xsl:param name="correspPartner" select="document('listPerson.xml')"/>
    <xsl:key name="partner-name" match="tei:person" use="@xml:id"/>
    
    
 <!-- Diese Datei schreibt eine alte Liste mit den Entsprechungen um, so
 dass die neue listeDerBriefwechsel entsteht, vom Typ:
  <relation>
        <partner type="sub" id="#11054">Buschbeck Erhard</partner>
        <partner type="relatedTo" id="#10815">Bahr Hermann</partner>
    </relation>
 -->
    
    <xsl:template match="list">
     <xsl:element name="list">
         <xsl:for-each select="writer">
            <xsl:element name="relation"> 
                <xsl:element name="partner">
                    <xsl:attribute name="type">
                        <xsl:text>sub</xsl:text>
                    </xsl:attribute>
                 <xsl:attribute name="id">
                     <xsl:value-of select="concat('#', sender)"/>
                 </xsl:attribute>
                 <xsl:value-of select="normalize-space(key('partner-name', concat('pmb', sender), $correspPartner)/tei:persName)"/>
             </xsl:element>
                <xsl:element name="partner">
                    <xsl:attribute name="type">
                        <xsl:text>relatedTo</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="id">
                        <xsl:value-of select="concat('#', belongsTo)"/>
                    </xsl:attribute>
                    <xsl:value-of select="normalize-space(key('partner-name', concat('pmb', belongsTo), $correspPartner)/tei:persName)"/>
                </xsl:element>
            </xsl:element>
         </xsl:for-each>
     </xsl:element>
    </xsl:template>
</xsl:stylesheet>