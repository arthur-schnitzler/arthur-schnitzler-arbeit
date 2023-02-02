<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="3.0"
    exclude-result-prefixes="tei xhtml">

    <xsl:output method="xhtml"/>

    <xsl:mode on-no-match="shallow-skip"/>

    <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>

    <xsl:template match="/">
        <xsl:element name="html" namespace="http://www.w3.org/1999/xhtml">
            <xsl:element name="head" namespace="http://www.w3.org/1999/xhtml">
                <xsl:element name="title" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:text>Inhaltsverzeichnis</xsl:text>
                </xsl:element>
            </xsl:element>
            <xsl:element name="body" namespace="http://www.w3.org/1999/xhtml">
                <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:text>Inhalt</xsl:text>
                </xsl:element>
                <xsl:element name="ol" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="class">
                        <xsl:text>toc-list</xsl:text>
                    </xsl:attribute>
                    <xsl:for-each
                        select="collection(concat($folderURI, '/?select=L0*.xhtml;recurse=yes'))">
                        <xsl:sort select="//xhtml:meta[@name = 'date']/@content" order="ascending"/>
                        <xsl:sort select="//xhtml:meta[@name = 'n']/@content" order="ascending"/>
                        <xsl:element name="li" namespace="http://www.w3.org/1999/xhtml">
                            <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
                                <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
                                    <xsl:attribute name="class">
                                        <xsl:text>title</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="//xhtml:title/text()"/>
                                </xsl:element>
                                <!-- XXXX Seitenzahl -->
                                <!--<xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
                            <xsl:attribute name="class">
                                <xsl:text>page</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select=""/>
                        </xsl:element>-->
                            </xsl:element>
                        </xsl:element>
                        <xsl:text>&#10;</xsl:text>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
