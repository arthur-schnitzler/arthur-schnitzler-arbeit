<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="text"/>
    <!-- Diese XSLT zählt alle Zeichen einschließlich Leerzeichen im edierten Text. Anpassungen
    sind vorgesehen für Sonderzeichen und Vordrucke. -->
    <xsl:template match="tei:TEI">
        <xsl:variable name="character-count"
            select="sum(tei:text/tei:body//text()[not(ancestor::tei:note) and not(ancestor::tei:back) and not(ancestor::tei:hi[@rend='pre-print'])]/string-length(normalize-space(.)))"/>
        <xsl:variable name="number-of-spaces"
            select="count(tei:text/tei:body/descendant::tei:space[not(ancestor::tei:note) and not(ancestor::tei:back) and not(ancestor::tei:hi[@rend='pre-print'])])"/>
        <xsl:variable name="dots"
            select="sum(descendant::tei:c[not(ancestor::tei:note) and not(ancestor::tei:back) and not(ancestor::tei:hi[@rend='pre-print'])]/@n)"/>
        <xsl:variable name="c-ohne-dots"
            select="count(tei:text/tei:body/descendant::tei:c[not(ancestor::tei:note) and not(ancestor::tei:back) and not(@n) and not(ancestor::tei:hi[@rend='pre-print'])])"/>
        <xsl:value-of select="sum($character-count + $number-of-spaces + $dots + $c-ohne-dots)"/>
    </xsl:template>
</xsl:stylesheet>
