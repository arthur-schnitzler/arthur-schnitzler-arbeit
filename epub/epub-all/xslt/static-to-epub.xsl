<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" version="3.0" exclude-result-prefixes="xhtml">

    <xsl:mode on-no-match="shallow-skip"/>

    <xsl:output method="xhtml"/>

    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:element name="html" namespace="http://www.w3.org/1999/xhtml">
            <xsl:element name="head" namespace="http://www.w3.org/1999/xhtml">
                <xsl:element name="title" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:copy-of select="//xhtml:title[parent::xhtml:head]/text()"/>
                </xsl:element>
                <xsl:element name="meta" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="name">
                        <xsl:text>date</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="content">
                        <xsl:value-of select="//xhtml:meta[@name = 'Date of publication']/@content"
                        />
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="meta" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="name">
                        <xsl:text>n</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="content">
                        <xsl:value-of select="//xhtml:meta[@name = 'Date of publication']/@n"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="meta" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="name">
                        <xsl:text>id</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="content">
                        <xsl:value-of
                            select="//xhtml:tr[child::xhtml:th[contains(., 'Download')]]//xhtml:li[1]/xhtml:a/substring-before(substring-after(@href, 'briefe/'), '?')"
                        />
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="body" namespace="http://www.w3.org/1999/xhtml">
                <xsl:element name="h2" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:copy-of select="//xhtml:div[@class = 'col-md-8']/xhtml:h3/xhtml:h2/text()"/>
                    <xsl:element name="br" namespace="http://www.w3.org/1999/xhtml"/>
                </xsl:element>
                <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:copy-of select="//xhtml:div[@class = 'div'][1]"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
