<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:template match="tei:body//tei:anchor[@type='commentary']">
        <xsl:variable name="xmlid" select="ancestor::tei:TEI/@xml:id"/>
        <xsl:variable name="i">
            <xsl:number count="tei:anchor[@type='commentary']" from="tei:body" level="any" />
        </xsl:variable>
        <xsl:element name="anchor" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>commentary</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('K_',$xmlid,'_',$i)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:body//tei:note[@type='commentary']">
        <xsl:variable name="xmlid" select="ancestor::tei:TEI/@xml:id"/>
        <xsl:variable name="i">
            <xsl:number count="tei:note[@type='commentary']" from="tei:body" level="any" />
        </xsl:variable>
        <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>commentary</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('K_',$xmlid,'_',$i,'h')"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:body//tei:anchor[@type='textConst']">
        <xsl:variable name="xmlid" select="ancestor::tei:TEI/@xml:id"/>
        <xsl:variable name="i">
            <xsl:number count="tei:anchor[@type='textConst']" from="tei:body" level="any" />
        </xsl:variable>
        <xsl:element name="anchor" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>textConst</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('T_',$xmlid,'_',$i)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:body//tei:note[@type='textConst']">
        <xsl:variable name="xmlid" select="ancestor::tei:TEI/@xml:id"/>
        <xsl:variable name="i">
            <xsl:number count="tei:note[@type='textConst']" from="tei:body" level="any" />
        </xsl:variable>
        <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>textConst</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('T_',$xmlid,'_',$i,'h')"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
</xsl:stylesheet>
