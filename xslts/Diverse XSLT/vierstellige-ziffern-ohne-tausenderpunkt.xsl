<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs math" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="true"/>
    <!-- Match text nodes that contain four-digit numbers with a dot -->
    <xsl:template match="tei:note//text()[not(ancestor::tei:quote)]">
        <xsl:analyze-string select="." regex="(?:^|\D)(\d{{1}}\.\d{{3}})(?:\D|$)">
            <!-- If the text matches, wrap the match in a <check> element -->
            <xsl:matching-substring>
                    <xsl:value-of select="concat(substring-before(., '.'), substring-after(., '.'))"/>
            </xsl:matching-substring>
            <!-- Non-matching parts of the text are output unchanged -->
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
</xsl:stylesheet>
