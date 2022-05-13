<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="tei:TEI">
        <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*" copy-namespaces="false"/>
            <xsl:copy-of select="*" copy-namespaces="false"/>
            <xsl:element name="back" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:for-each
                        select="distinct-values(descendant::*[(@type = 'person' or name() = 'persName' or name() = 'author') and not(ancestor::tei:back)]/@ref/tokenize(., '#'))">
                        <xsl:if test="normalize-space(.) != ''">
                            <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="."/>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:for-each select="distinct-values(descendant::tei:handShift/@scribe)">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="replace(.,'#','')"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                    <xsl:for-each select="distinct-values(descendant::tei:handNote/@corresp)">
                        <xsl:if test="not(.='schreibkraft')">
                            <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="replace(.,'#','')"/>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:element>
                <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:for-each
                        select="distinct-values(descendant::tei:rs[@type = 'work' and not(ancestor::tei:back)]/@ref/tokenize(., '#'))">
                        <xsl:if test="normalize-space(.) != ''">
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="."/>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:element>
                <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:for-each
                        select="distinct-values(descendant::tei:*[(@type = 'place' or name() = 'placeName') and not(ancestor::tei:back)]/@ref/tokenize(., '#'))">
                        <xsl:if test="normalize-space(.) != ''">
                            <xsl:element name="place" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="."/>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:element>
                <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:for-each
                        select="distinct-values(descendant::tei:*[(@type = 'org' or name() = 'orgName') and not(ancestor::tei:back)]/@ref/tokenize(., '#'))">
                        <xsl:if test="normalize-space(.) != ''">
                            <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="."/>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    
    
</xsl:stylesheet>
