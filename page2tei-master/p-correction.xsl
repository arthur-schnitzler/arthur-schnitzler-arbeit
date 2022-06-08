<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>

    <!--    <xsl:variable name="opening-p" select="'&lt;p&gt;'"/>
    <xsl:variable name="regex-p" select="'^(?!&lt;/p&gt;)'"/>
    <xsl:variable name="match-p" select="concat('&lt;p&gt;', '^(?!&lt;/p&gt;)', '&lt;p&gt;')"/>

    <xsl:template match="//tei:seite/text()">
        <xsl:choose>
            <xsl:when test=".[contains(., $match-p)]">
                <xsl:element name="test"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-\- &lt;p&gt;(.*?)&lt;/p&gt; -> zeigt alles zwischen zwei p-Tags
    
    ^(?!\&lt\;\/p\&gt\;) -> alles außer closing p tag -\->

    <!-\- Funktioniert noch nicht. Zusammenfassung, was ich machen will: alle p Tags schließen für wohlgeformte Dokumente (ergo: wenn opening p Tag auf einen opening p Tag folgt, aber dazwischen kein closing p Tag ist, muss ich einen closing p Tag einfügen) -\->

//div[contains(., concat('&lt;p&gt;', '^(?!&lt;/p&gt;)', '&lt;p&gt;'))]

&lt;p&gt; ANYTHING &lt;p&gt;

match = (?=&lt;p&gt;)(.*)(?=&lt;p&gt;) -> substring-before(substring-after(., '&lt;p&gt;'), '&lt;p&gt;')

if (.*) contains ?!&lt;/p&gt;




//substring-before(substring-after(., '&lt;p&gt;'), '&lt;p&gt;') -> for-each test if what's inbetween contains closing tag-->

    <xsl:variable name="between-open-p"
        select="//substring-before(substring-after(., '&lt;p&gt;'), '&lt;p&gt;')"/>
    <xsl:variable name="closed-p" select="'&lt;/p&gt;'"/>

    <!--<xsl:template match="//tei:div">
    <xsl:for-each select="$between-open-p">
        <xsl:choose>
            <xsl:when test="contains(., $closed-p)">
                <xsl:copy-of select="."/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="substring-before(., '&lt;p&gt;')"/>
                <xsl:text>&lt;/p&gt;</xsl:text>
                <xsl:copy-of select="substring-after(., '&lt;p&gt;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
</xsl:template>-->

    <!--<xsl:template
        match="//tei:letter[contains(., substring-before(substring-after(., '&lt;p&gt;'), '&lt;p&gt;'))]">
        <xsl:for-each select=".">
            <xsl:choose>
                <xsl:when test="contains(., '&lt;/p&gt;')">
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="substring-before(., '&lt;p&gt;')"/>
                    <xsl:text>&lt;/p&gt;</xsl:text>
                    <xsl:copy-of select="substring-after(., '&lt;p&gt;')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>-->

    <!--(?=&lt;p&gt;)(.*)(?=&lt;p&gt;) -> das dazwischen darf nicht closing-p Tag sein-->

    <xsl:param name="between-two-opening-p-tags">
        <xsl:text>(?=&lt;p&gt;)(.*)(?=&lt;p&gt;)</xsl:text>
    </xsl:param>
    
    <xsl:variable name="match-between" select="//*/text()[matches(., $between-two-opening-p-tags)]"/>

    <xsl:template match="$match-between">
        <xsl:for-each select=".">
            <xsl:choose>
                <xsl:when test="contains(., '&lt;/p&gt;')">
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="substring-before(., '&lt;p&gt;')"/>
                    <xsl:text>TEST<!--&lt;/p&gt;--></xsl:text>
                    <xsl:copy-of select="substring-after(., '&lt;p&gt;')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
