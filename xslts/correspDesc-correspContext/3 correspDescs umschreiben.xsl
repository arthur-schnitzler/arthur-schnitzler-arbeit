<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="correspList" select="document('correspList.xml')"/>
    <xsl:key name="corresp-lookup" match="tei:correspDesc" use="@date"/>
    <xsl:template match="tei:correspDesc">
        <xsl:variable name="date">
            <xsl:choose>
                <xsl:when test="tei:correspAction[@type = 'sent']/tei:date/@when">
                    <xsl:value-of select="tei:correspAction[@type = 'sent']/tei:date/@when"/>
                </xsl:when>
                <xsl:when test="tei:correspAction[@type = 'sent']/tei:date/@notBefore">
                    <xsl:value-of select="tei:correspAction[@type = 'sent']/tei:date/@notBefore"/>
                </xsl:when>
                <xsl:when test="tei:correspAction[@type = 'sent']/tei:date/@notAfter">
                    <xsl:value-of select="tei:correspAction[@type = 'sent']/tei:date/@notAfter"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="date_n">
            <xsl:choose>
                <xsl:when test="string-length(tei:correspAction[@type = 'sent']/tei:date/@n) = 1">
                    <xsl:value-of
                        select="concat($date, '_0', tei:correspAction[@type = 'sent']/tei:date/@n)"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="concat($date, '_', tei:correspAction[@type = 'sent']/tei:date/@n)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="correspDesc" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="tei:correspAction" copy-namespaces="yes"/>
            <xsl:element name="correspContext" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:variable name="writer-ref"
                    select="key('corresp-lookup', $date_n, $correspList)/tei:correspContext" as="node()"/>
                <xsl:copy-of select="$writer-ref/tei:ref"/>
                <!-- Dieser Abschnitt setzt den Verweis auf den vorhergehenden Brief innerhalb aller Briefe-->
                <xsl:variable name="prevCollectionLetter" as="node()?"
                    select="key('corresp-lookup', $date_n, $correspList)/preceding-sibling::*[1]"/>
                <xsl:if test="not(empty($prevCollectionLetter))">
                    <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="subtype">
                            <xsl:text>previous_letter</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="type">
                            <xsl:text>withinCollection</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:value-of select="$prevCollectionLetter/@xml:id"/>
                        </xsl:attribute>
                        <xsl:for-each select="$prevCollectionLetter/tei:correspAction[@type = 'sent']/tei:persName">
                            <xsl:value-of select="substring-before(., ',')"/>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text> an </xsl:text>
                        <xsl:for-each
                            select="$prevCollectionLetter/tei:correspAction[@type = 'received']/tei:persName">
                            <xsl:value-of select="substring-before(., ',')"/>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="$prevCollectionLetter/tei:correspAction[@type = 'sent']/tei:date"/>
                    </xsl:element>
                </xsl:if>
                <!-- Dieser Abschnitt setzt den Verweis auf den folgenden Brief innerhalb aller Briefe-->
                <xsl:variable name="followCollectionLetter" as="node()?"
                    select="key('corresp-lookup', $date_n, $correspList)/following-sibling::*[1]"/>
                <xsl:if test="not(empty($followCollectionLetter))">
                    <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="subtype">
                            <xsl:text>next_letter</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="type">
                            <xsl:text>withinCollection</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:value-of select="$followCollectionLetter/@xml:id"/>
                        </xsl:attribute>
                        <xsl:for-each select="$followCollectionLetter/tei:correspAction[@type = 'sent']/tei:persName">
                            <xsl:value-of select="substring-before(., ',')"/>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text> an </xsl:text>
                        <xsl:for-each
                            select="$followCollectionLetter/tei:correspAction[@type = 'received']/tei:persName">
                            <xsl:value-of select="substring-before(., ',')"/>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="$followCollectionLetter/tei:correspAction[@type = 'sent']/tei:date"/>
                    </xsl:element>
                </xsl:if>
                <xsl:for-each select="$writer-ref/tei:ref[@type = 'belongsToCorrespondence']/@target">
                    <xsl:variable name="current-ref" select="normalize-space(.)"/>
                    <xsl:variable name="prevCD" as="node()?"
                        select="key('corresp-lookup', $date_n, $correspList)/preceding-sibling::tei:correspDesc[descendant::tei:ref[@type = 'belongsToCorrespondence' and @target = $current-ref]][1]"/>
                    <xsl:if test="not(empty($prevCD))">
                        <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="subtype">
                                <xsl:text>previous_letter</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="type">
                                <xsl:text>withinCorrespondence</xsl:text>
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
                    <xsl:variable name="nextCD" as="node()?"
                        select="key('corresp-lookup', $date_n, $correspList)/following-sibling::tei:correspDesc[descendant::tei:ref[@type = 'belongsToCorrespondence' and @target = $current-ref]][1]"/>
                        <xsl:if test="not(empty($nextCD))">
                        <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="subtype">
                                <xsl:text>next_letter</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="type">
                                <xsl:text>withinCorrespondence</xsl:text>
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
                </xsl:for-each>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:ab[parent::tei:refsDecl]">
        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:text>References to Arthur Schnitzler’s diary online consist of the relevant dates only, 
            e.g. @type="schnitzler-tagebuch" @target="1891-05-15". The complete URI is: 
            'https://schnitzler-tagebuch.acdh.oeaw.ac.at/v/editions/entry__1891-05-15'
        </xsl:text>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
