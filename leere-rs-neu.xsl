<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="true"/>
    <!-- Definiere eine Funktion, um die XML-Daten aus der URL zu laden -->
    <xsl:variable name="source-uri"
        select="'https://raw.githubusercontent.com/arthur-schnitzler/arthur-schnitzler-arbeit/34610d1d1adbbaed0b40ef3f0d5005f2d6f63da4/editions/'"/>
    <!-- Verwende die Funktion unparsed-text(), um den Inhalt der URL als XML zu laden -->
    <!-- Template für das erste tei:rs-Element -->
    <xsl:template match="tei:rs[not(ancestor::tei:back) and normalize-space(.) = '']">
        <xsl:variable name="ref" select="@ref"/>
        <xsl:variable name="subtype" select="@subtype"/>
        <xsl:variable name="type" select="@type"/>
        <xsl:variable name="ID" select="ancestor::tei:TEI/@xml:id"/>
        <xsl:variable name="doc" select="doc(concat($source-uri, $ID, '.xml'))"/>
        <xsl:choose>
            <xsl:when test="$subtype">
                <xsl:choose>
                    <xsl:when
                        test="$doc/descendant::tei:rs[@type = $type and @subtype = $subtype and @ref = $ref][2]">
                        <xsl:copy-of select="."/>
                        <xsl:comment>
                            <xsl:text>XXXXY</xsl:text>
                            <xsl:for-each select="$doc/descendant::tei:rs[@type = $type and @subtype = $subtype and @ref = $ref]">
                                <xsl:value-of select="position()"/><xsl:text>)</xsl:text><xsl:value-of select="."/><xsl:text>(</xsl:text>
                            </xsl:for-each>
                        </xsl:comment>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of
                            select="$doc/descendant::tei:rs[@type = $type and @subtype = $subtype and @ref = $ref][1]"
                        />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$doc/descendant::tei:rs[@type = $type and @ref = $ref][2]">
                        <xsl:copy-of select="."/>
                        <xsl:comment>
                            <xsl:text>XXXX</xsl:text>
                            <xsl:for-each select="$doc/descendant::tei:rs[@type = $type and @ref = $ref]">
                                <xsl:value-of select="position()"/><xsl:text>)</xsl:text><xsl:value-of select="."/><xsl:text>(</xsl:text>
                            </xsl:for-each>
                        </xsl:comment>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of
                            select="$doc/descendant::tei:rs[@type = $type and @ref = $ref][1]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
