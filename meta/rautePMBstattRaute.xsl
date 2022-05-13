<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@ref">
        <xsl:attribute name="ref">
        <xsl:for-each select="tokenize(.,' ')">
            <xsl:choose>
                <xsl:when test="starts-with(.,'#pmb')">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="replace(., '#', '#pmb')"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="not(position()=last())">
                <xsl:text> </xsl:text>
            </xsl:if>
        </xsl:for-each>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@scribe">
        <xsl:attribute name="scribe">
            <xsl:choose>
                <xsl:when test="starts-with(.,'#pmb')">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="replace(., '#', '#pmb')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="tei:handNote/@corresp">
        <xsl:attribute name="corresp">
            <xsl:choose>
                <xsl:when test="starts-with(.,'#pmb')">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="replace(., '#', '#pmb')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>
    
</xsl:stylesheet>