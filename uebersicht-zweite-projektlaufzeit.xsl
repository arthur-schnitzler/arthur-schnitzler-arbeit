<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" expand-text="yes">

    <xsl:mode on-no-match="shallow-skip"/>

    <xsl:variable name="editions" select="collection('editions/?select=*.xml')"/>

    <xsl:template match="*:report">
        <xsl:element name="report">

            <xsl:text>&#xa;</xsl:text>
            <xsl:text>Martin, diese Dokumente solltest du noch durchsehen:</xsl:text>
            <xsl:text>&#xa;</xsl:text>

            <xsl:for-each select="$editions">
                <xsl:if test="number(substring-after(//tei:TEI/@xml:id, 'L0')) > 2579">
                    <xsl:choose>
                        <xsl:when
                            test="boolean(//tei:revisionDesc/tei:change[@who = 'MAM'][contains(., 'Durchsicht')])"/>
                        <xsl:otherwise>
                            <xsl:value-of select="tei:TEI/@xml:id"/>
                            <xsl:text>&#xa;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>

            <xsl:text>&#xa;</xsl:text>
            <xsl:text>Laura, diese Dokumente solltest du noch durchsehen:</xsl:text>
            <xsl:text>&#xa;</xsl:text>

            <xsl:for-each select="$editions">
                <xsl:if test="number(substring-after(//tei:TEI/@xml:id, 'L0')) > 2579">
                    <xsl:choose>
                        <xsl:when
                            test="boolean(//tei:revisionDesc/tei:change[@who = 'MAM'][contains(., 'Durchsicht')]) and not(boolean(//tei:revisionDesc/tei:change[@who = 'LU'][contains(., 'Durchsicht')]))">
                            <xsl:value-of select="tei:TEI/@xml:id"/>
                            <xsl:text>&#xa;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>

            <xsl:text>&#xa;</xsl:text>
            <xsl:text>Laura, diese Dokumente sind bereits candidates und warten auf ihr approval:</xsl:text>
            <xsl:text>&#xa;</xsl:text>

            <xsl:for-each select="$editions">
                <xsl:if test="number(substring-after(//tei:TEI/@xml:id, 'L0')) > 2579">
                    <xsl:choose>
                        <xsl:when test="boolean(//tei:revisionDesc[@status = 'candidate'])">
                            <xsl:value-of select="tei:TEI/@xml:id"/>
                            <xsl:text>&#xa;</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>

            <xsl:text>&#xa;</xsl:text>
            <xsl:text>In der zweiten Projektlaufzeit sind Stand </xsl:text>
            <xsl:value-of select="current-dateTime()"/>
            <xsl:text> bereits </xsl:text>
            <xsl:value-of
                select="count($editions[number(substring-after(//tei:TEI/@xml:id, 'L0')) > 2579]//tei:revisionDesc[@status = 'approved'])"/>
            <xsl:text> Dokumente bzw. </xsl:text>
            <xsl:value-of
                select="sum($editions[number(substring-after(//tei:TEI/@xml:id, 'L0')) > 2579]//tei:revisionDesc[@status = 'approved']/../../count(//tei:pb))"/>
            <xsl:text> Seiten fertiggestellt worden.</xsl:text>
            <xsl:text>&#xa;</xsl:text>

        </xsl:element>


    </xsl:template>

</xsl:stylesheet>
