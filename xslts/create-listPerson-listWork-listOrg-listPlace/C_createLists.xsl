<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="tei:place/@n">
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/entities/tei/place/', .))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>place</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:org/@n">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/entities/tei/org/', $nummer))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>org</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:item/@n">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/entities/tei/work/', $nummer))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>bibl</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:list">
        <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="tei:item"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:item[@n]">
        <xsl:apply-templates select="@n"/>
    </xsl:template>
    <xsl:template match="tei:listPlace/tei:place[@n]">
        <xsl:apply-templates select="@n"/>
    </xsl:template>
    <xsl:template match="tei:listOrg/tei:org[@n]">
        <xsl:apply-templates select="@n"/>
    </xsl:template>
    <xsl:template match="tei:listPerson/tei:person[@n]">
        <xsl:apply-templates select="@n"/>
    </xsl:template>
    <xsl:template match="tei:listPerson/tei:person/@n">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/entities/tei/person/', $nummer))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>person</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
