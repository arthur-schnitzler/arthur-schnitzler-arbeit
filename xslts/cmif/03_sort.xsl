<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="tei:profileDesc">
        <xsl:element name="profileDesc" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="tei:correspDesc">
                <xsl:sort select="@ana" data-type="text" order="ascending"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    <!-- Das gibt doppelte refs raus -->
    <xsl:template match="tei:ref[@type = 'belongsToCorrespondence' and @target = preceding-sibling::tei:ref/@target]"/>
       
</xsl:stylesheet>
