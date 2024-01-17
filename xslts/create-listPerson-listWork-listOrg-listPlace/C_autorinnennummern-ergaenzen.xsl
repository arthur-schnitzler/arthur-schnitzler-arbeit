<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:key name="persons" match="tei:person" use="@n"/>
    
    <!-- Dieses XSLT, auf die liste aller distincten refs angewendet, ergänzt 
    noch die autor:innennummern der erwähnten werde-->
    <xsl:template match="tei:body">
        <xsl:copy-of select="tei:listPlace"/>
        <xsl:copy-of select="tei:listOrg"/>
        <xsl:copy-of select="tei:list"/>
        <xsl:variable name="autorinnennummern-alle" as="node()">
            <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="tei:list/tei:item/@n">
                    <xsl:variable name="nummer" select="."/>
                    <xsl:variable name="eintrag"
                        select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/tei/work/', $nummer))"
                        as="xs:string"/>
                    <xsl:choose>
                        <xsl:when test="doc-available($eintrag)">
                            <xsl:for-each
                                select="document($eintrag)/*:bibl/*:author/@*[name() = 'key' or name() = 'ref']">
                                <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="n">
                                        <xsl:choose>
                                            <xsl:when test="starts-with(., 'person__')">
                                                <xsl:value-of
                                                  select="substring-after(., 'person__')"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:element>
        </xsl:variable>
        <xsl:variable name="autorinnennummern-distinkt" as="node()">
            <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="$autorinnennummern-alle//tei:person[@n][not(@n = preceding-sibling::tei:person/@n)]"/>
            </xsl:element>
        </xsl:variable>
        <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="distinct-values(($autorinnennummern-distinkt//tei:person, key('persons', tei:listPerson/tei:person/@n))/@n)">
                <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="n">
                        <xsl:choose>
                            <xsl:when test="starts-with(., 'person__')">
                                <xsl:value-of
                                    select="substring-after(., 'person__')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:element>
                
            </xsl:for-each>
            
            
            
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
