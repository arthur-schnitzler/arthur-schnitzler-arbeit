<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <!-- hier wird bei correspContext eingetragen, welche Briefe vorher und nachher kommen-->
    <xsl:template match="tei:correspContext">
        <xsl:element name="correspContext" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="*"/>
            <xsl:if test="ancestor::tei:correspDesc/preceding-sibling::tei:correspDesc[1]">
                <xsl:variable name="prevCD"
                    select="ancestor::tei:correspDesc/preceding-sibling::tei:correspDesc[1]"
                    as="node()"/>
                <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="subtype">
                        <xsl:text>previous_letter</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>withinCollection</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:value-of select="$prevCD/@xml:id"/>
                    </xsl:attribute>
                    <xsl:for-each select="$prevCD/tei:correspAction[@type = 'sent']/tei:persName">
                        <xsl:value-of select="substring-before(., ',')"/>
                        <xsl:if test="not(position() = last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text> an </xsl:text>
                    <xsl:for-each
                        select="$prevCD/tei:correspAction[@type = 'received']/tei:persName">
                        <xsl:value-of select="substring-before(., ',')"/>
                        <xsl:if test="not(position() = last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="$prevCD/tei:correspAction[@type = 'sent']/tei:date"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="ancestor::tei:correspDesc/following-sibling::tei:correspDesc[1]">
                <xsl:variable name="nextCD" as="node()"
                    select="ancestor::tei:correspDesc/following-sibling::tei:correspDesc[1]"/>
                <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="subtype">
                        <xsl:text>next_letter</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>withinCollection</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:value-of select="$nextCD/@xml:id"/>
                    </xsl:attribute>
                    <xsl:for-each select="$nextCD/tei:correspAction[@type = 'sent']/tei:persName">
                        <xsl:value-of select="substring-before(., ',')"/>
                        <xsl:if test="not(position() = last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text> an </xsl:text>
                    <xsl:for-each
                        select="$nextCD/tei:correspAction[@type = 'received']/tei:persName">
                        <xsl:value-of select="substring-before(., ',')"/>
                        <xsl:if test="not(position() = last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="$nextCD/tei:correspAction[@type = 'sent']/tei:date"/>
                </xsl:element>
            </xsl:if>
            <xsl:for-each select="tei:ref/@target">
                <xsl:variable name="currentTarget" select="."/>
                <xsl:if
                    test="ancestor::tei:correspDesc/preceding-sibling::tei:correspDesc[tei:correspContext/tei:ref[@type = 'belongsToCorrespondence' and @target = $currentTarget]][1]">
                    <xsl:variable name="prevCD" as="node()"
                        select="ancestor::tei:correspDesc/preceding-sibling::tei:correspDesc[tei:correspContext/tei:ref[@type = 'belongsToCorrespondence' and @target = $currentTarget]][1]"/>
                    <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="subtype">
                            <xsl:text>previous_letter</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="type">
                            <xsl:text>withinCorrespondence</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="source">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:value-of select="$prevCD/@xml:id"/>
                        </xsl:attribute>
                        <xsl:for-each
                            select="$prevCD/tei:correspAction[@type = 'sent']/tei:persName">
                            <xsl:value-of select="substring-before(., ',')"/>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text> an </xsl:text>
                        <xsl:for-each
                            select="$prevCD/tei:correspAction[@type = 'received']/tei:persName">
                            <xsl:value-of select="substring-before(., ',')"/>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="$prevCD/tei:correspAction[@type = 'sent']/tei:date"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if
                    test="ancestor::tei:correspDesc/following-sibling::tei:correspDesc[tei:correspContext/tei:ref[@type = 'belongsToCorrespondence' and @target = $currentTarget]][1]">
                    <xsl:variable name="nextCD" as="node()"
                        select="ancestor::tei:correspDesc/following-sibling::tei:correspDesc[tei:correspContext/tei:ref[@type = 'belongsToCorrespondence' and @target = $currentTarget]][1]"/>
                    <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="subtype">
                            <xsl:text>next_letter</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="type">
                            <xsl:text>withinCorrespondence</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="source">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:value-of select="$nextCD/@xml:id"/>
                        </xsl:attribute>
                        <xsl:for-each
                            select="$nextCD/tei:correspAction[@type = 'sent']/tei:persName">
                            <xsl:value-of select="substring-before(., ',')"/>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text> an </xsl:text>
                        <xsl:for-each
                            select="$nextCD/tei:correspAction[@type = 'received']/tei:persName">
                            <xsl:value-of select="substring-before(., ',')"/>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="$nextCD/tei:correspAction[@type = 'sent']/tei:date"/>
                    </xsl:element>
                </xsl:if>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
