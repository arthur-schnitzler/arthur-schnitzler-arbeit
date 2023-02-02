<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:opf="http://www.idpf.org/2007/opf" xmlns:dc="http://purl.org/dc/elements/1.1/"
     version="3.0"
    exclude-result-prefixes="tei xhtml opf">

    <xsl:output method="xml" omit-xml-declaration="yes"/>

    <xsl:mode on-no-match="shallow-skip"/>

    <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>

    <xsl:template match="/">
        <xsl:element name="package" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="version">
                <xsl:text>2.0</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="unique-identifier">
                <xsl:text>asbw-epub</xsl:text>
            </xsl:attribute>
            <xsl:element name="metadata" namespace="http://www.idpf.org/2007/opf">
                <xsl:element name="identifier" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:attribute name="id">
                        <xsl:text>asbw-epub</xsl:text>
                    </xsl:attribute>
                    <xsl:text>asbw-epub</xsl:text>
                </xsl:element>
                <xsl:element name="title" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:text>Arthur Schnitzler: Briefwechsel mit Autorinnen und Autoren</xsl:text>
                </xsl:element>
                <xsl:element name="creator" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:text>Müller, Martin Anton</xsl:text>
                </xsl:element>
                <xsl:element name="creator" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:text>Susen, Gerd-Hermann</xsl:text>
                </xsl:element>
                <xsl:element name="creator" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:text>Untner, Laura</xsl:text>
                </xsl:element>
                <xsl:element name="publisher" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:text>Austrian Centre for Digital Humanities and Cultural Heritage at the Austrian Academy of Sciences</xsl:text>
                </xsl:element>
                <xsl:element name="language" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:text>German</xsl:text>
                </xsl:element>
                <xsl:element name="date" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:text>2023</xsl:text>
                </xsl:element>
                <xsl:element name="subject" namespace="http://purl.org/dc/elements/1.1/">
                    <xsl:text>Arthur Schnitzler’s literary correspondences</xsl:text>
                </xsl:element>
                <!--<xsl:element name="meta" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="name">
                        <xsl:text>cover</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="content">
                        <xsl:text>images/cover.svg</xsl:text>
                    </xsl:attribute>
                </xsl:element>-->
            </xsl:element>
            <xsl:element name="manifest" namespace="http://www.idpf.org/2007/opf">
                <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="id">
                        <xsl:text>inhaltsverzeichnis</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>texts/inhaltsverzeichnis.ncx</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="media-type">
                        <xsl:text>application/x-dtbncx+xml</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="id">
                        <xsl:text>titel</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>texts/titel.xhtml</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="media-type">
                        <xsl:text>application/xhtml+xml</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <!--<xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="id">
                        <xsl:text>coverimage</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>images/cover.svg</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="media-type">
                        <xsl:text>image/svg+xml</xsl:text>
                    </xsl:attribute>
                </xsl:element>-->
                <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="id">
                        <xsl:text>inhalt</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>texts/inhalt.xhtml</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="media-type">
                        <xsl:text>application/xhtml+xml</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:for-each
                    select="collection(concat($folderURI, '/texts/?select=L0*.xhtml;recurse=yes'))">
                    <xsl:sort select="//xhtml:meta[@name='date']/@content" order="ascending"/>
                    <xsl:sort select="//xhtml:meta[@name='n']/@content" order="ascending"/>
                    <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="id">
                            <xsl:value-of select="//xhtml:meta[@name='id']/@content"/>
                        </xsl:attribute>
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat('texts/', //xhtml:meta[@name='id']/@content, '.xhtml')"/>
                        </xsl:attribute>
                        <xsl:attribute name="media-type">
                            <xsl:text>application/xhtml+xml</xsl:text>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
                <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="id">
                        <xsl:text>rechte</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>texts/rechte.xhtml</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="media-type">
                        <xsl:text>application/xhtml+xml</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="id">
                        <xsl:text>css</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>styles/stylesheet.css</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="media-type">
                        <xsl:text>text/css</xsl:text>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="spine" namespace="http://www.idpf.org/2007/opf">
                <xsl:attribute name="toc">
                    <xsl:text>inhaltsverzeichnis</xsl:text>
                </xsl:attribute>
                <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="idref">
                        <xsl:text>coverimage</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="idref">
                        <xsl:text>titel</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="idref">
                        <xsl:text>rechte</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="idref">
                        <xsl:text>inhalt</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:for-each
                    select="collection(concat($folderURI, '/texts/?select=L0*.xhtml;recurse=yes'))">
                    <xsl:sort select="//xhtml:meta[@name='date']/@content" order="ascending"/>
                    <xsl:sort select="//xhtml:meta[@name='n']/@content" order="ascending"/>
                    <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="idref">
                            <xsl:value-of select="//xhtml:meta[@name='id']/@content"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
