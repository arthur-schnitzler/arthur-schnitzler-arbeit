<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="tei:listPerson">
        <xsl:element name="listPerson">
            <xsl:copy-of select="child::tei:person"/>
            <xsl:for-each
                select="distinct-values(parent::tei:note/tei:list/tei:author/replace(@key, 'person__', ''))">
                <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="n">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:list/tei:author"/>
</xsl:stylesheet>
