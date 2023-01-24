<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:opf="http://www.idpf.org/2007/opf" version="3.0" exclude-result-prefixes="tei xhtml opf">

    <xsl:output method="xml" omit-xml-declaration="yes"/>

    <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>

    <xsl:template match="opf:package">
        <xsl:element name="package" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="version">
                <xsl:text>2.0</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="unique-identifier">
                <xsl:text>bookid</xsl:text>
            </xsl:attribute>
        </xsl:element>
        <xsl:copy-of select="opf:metadata"/>
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
            <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                <xsl:attribute name="id">
                    <xsl:text>coverimage</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:text>images/cover.png</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="media-type">
                    <xsl:text>image/png</xsl:text>
                </xsl:attribute>
            </xsl:element>
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
            <xsl:for-each select="collection(concat($folderURI, '/?select=L0*.xml;recurse=yes'))">
                <!-- XXXX values anpassen, sobald xhtml-Modell steht -->
                <xsl:sort select="//tei:correspAction[@type = 'sent']/tei:date/@when"
                    order="ascending"/>
                <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="id">
                        <xsl:value-of select="tei:TEI/@xml:id"/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat('texts/', tei:TEI/@xml:id, '.xhtml')"/>
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
            <xsl:for-each select="collection(concat($folderURI, '/?select=L0*.xml;recurse=yes'))">
                <!-- XXXX values anpassen, sobald xhtml-Modell steht -->
                <xsl:sort select="//tei:correspAction[@type = 'sent']/tei:date/@when"
                    order="ascending"/>
                <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="idref">
                        <xsl:value-of select="tei:TEI/@xml:id"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
