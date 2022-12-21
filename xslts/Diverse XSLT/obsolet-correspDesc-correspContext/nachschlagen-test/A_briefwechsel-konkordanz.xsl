<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <!-- Diese Transformation holt aus einer Liste mit Briefwechseln jene heraus, die als abhängig zu einem anderen zu betrachten sind, 
        zB. Gertrud Rung gehört zu Georg Brandes -->
    <xsl:template match="list">
        <xsl:element name="list">
            <xsl:apply-templates select="item[subitem]"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="item[not(subitem)] | subitem[position() = 1]"/>
    <xsl:template match="subitem[not(position() = 1)]">
        <xsl:element name="writer">
            <xsl:element name="writer-pmb">
                <xsl:value-of select="."/>
            </xsl:element>
            <xsl:element name="belongsTo">
                <xsl:value-of select="parent::item/subitem[1]"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
