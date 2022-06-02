<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name="opening-p" select="'&lt;p&gt;'"/>
    <xsl:variable name="regex-p" select="'^(?!&lt;/p&gt;)'"/>
    <xsl:variable name="match-p" select="concat('&lt;p&gt;', '^(?!&lt;/p&gt;)', '&lt;p&gt;')"/>

    <xsl:template match="//tei:seite/text()">
        <xsl:choose>
            <xsl:when test=".[contains(., $match-p)]">
                <xsl:element name="test"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- &lt;p&gt;(.*?)&lt;/p&gt; -> zeigt alles zwischen zwei p-Tags
    
    ^(?!\&lt\;\/p\&gt\;) -> alles außer closing p tag -->

    <!-- Funktioniert noch nicht. Zusammenfassung, was ich machen will: alle p Tags schließen für wohlgeformte Dokumente (ergo: wenn opening p Tag auf einen opening p Tag folgt, aber dazwischen kein closing p Tag ist, muss ich einen closing p Tag einfügen) -->

</xsl:stylesheet>
