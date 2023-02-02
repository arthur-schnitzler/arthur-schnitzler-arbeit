<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:_="urn:acdh" xmlns:foo="whatever works"
    version="3.0" exclude-result-prefixes="xhtml _ foo">

    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:output method="xhtml"/>

    <xsl:template match="//xhtml:div//xhtml:a/@name">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//xhtml:p[child::xhtml:div[@class = 'editionText salute']]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//@data-bs-target">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//@data-bs-toggle">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//xhtml:div/@class">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//@align">
        <xsl:attribute name="class">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="//xhtml:ul/xhtml:a">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//xhtml:ul/xhtml:ul">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//xhtml:ul/xhtml:br">
        <xsl:element name="li" namespace="http://www.w3.org/1999/xhtml">
            <xsl:text>&#10;&#10;</xsl:text>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//xhtml:span[@class = 'del']"/>

    <xsl:template match="//xhtml:span[@class = 'steuerzeichen']"/>

    <xsl:template match="//xhtml:span[@class = 'seg-right']/xhtml:div[@class = 'right']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//xhtml:span[@class = 'seg-left']/xhtml:div[@class = 'left']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//xhtml:span[@class = 'seg-right']">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:text>right</xsl:text>
            </xsl:attribute>
            <xsl:copy-of select="./*"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//xhtml:span[@class = 'seg-left']">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:text>left</xsl:text>
            </xsl:attribute>
            <xsl:copy-of select="./*"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//xhtml:div[parent::xhtml:span[@class = 'antiqua']]">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:text>footnote</xsl:text>
            </xsl:attribute>
            <xsl:copy-of select="./*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//xhtml:a/@href">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="//text()">
        <xsl:value-of select="replace(., 'ſ', 's')"/>
    </xsl:template>

</xsl:stylesheet>
