<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="tei:place/@n">
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/tei/place/', .))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>place</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:org/@n">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/tei/org/', $nummer))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>org</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:item/@n">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/tei/work/', $nummer))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>bibl</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="tei:item"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:item[@n]">
        <xsl:apply-templates select="@n"/>
    </xsl:template>
    <xsl:template match="tei:listPlace/tei:place[@n]">
        <xsl:apply-templates select="@n"/>
    </xsl:template>
    <xsl:template match="tei:listOrg/tei:org[@n]">
        <xsl:apply-templates select="@n"/>
    </xsl:template>
    <xsl:template match="tei:listPerson/tei:person[@n]">
        <xsl:call-template name="authorNr">
            <xsl:with-param name="nummer" select="@n" />
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="authorNr">
        <xsl:param name="nummer" select="."/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/tei/person/', $nummer))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="$nummer='2121'">
                <person xml:id="person__2121">
                    <persName>
                        <forename>Arthur</forename>
                        <surname>Schnitzler</surname>
                    </persName>
                    <birth>
                        <date when-iso="1862-05-15">15.05.1862</date>
                        <settlement key="50">
                            <placeName type="pref">Wien</placeName>
                            <location>
                                <geo>48,2066 16,37341</geo>
                            </location>
                        </settlement>
                    </birth>
                    <death>
                        <date when-iso="1931-10-21">21.10.1931</date>
                        <settlement key="50">
                            <placeName type="pref">Wien</placeName>
                            <location>
                                <geo>48,2066 16,37341</geo>
                            </location>
                        </settlement>
                    </death>
                    <sex value="male"/>
                    <occupation key="90">Schriftsteller/Schriftstellerin</occupation>
                    <occupation key="97">Mediziner/Medizinerin</occupation>
                    <idno type="URL" subtype="gnd">https://d-nb.info/gnd/118609807</idno>
                    <idno type="URL" subtype="schnitzler-bahr">
                        https://schnitzler-bahr.acdh.oeaw.ac.at/pmb2121.html
                    </idno>
                    <idno type="URL" subtype="pmb">https://pmb.acdh.oeaw.ac.at/entity/2121/</idno>
                    <idno type="URL" subtype="schnitzler-briefe">
                        https://schnitzler-briefe.acdh.oeaw.ac.at/pmb2121.html
                    </idno>
                    <idno type="URL" subtype="schnitzler-tagebuch">
                        https://schnitzler-tagebuch.acdh.oeaw.ac.at/entity/pmb2121
                    </idno>
                    <idno type="URL" subtype="fackel">https://fackel.oeaw.ac.at/?p=fackelp38500</idno>
                    <idno type="URL" subtype="dritte-walpurgisnacht">
                        https://kraus1933.ace.oeaw.ac.at/Gesamt.xml?template=register_personen.html&amp;letter=S#DWpers0212
                    </idno>
                    <idno type="URL" subtype="oebl">https://doi.org/10.1553/0x00284416</idno>
                    <idno type="URL" subtype="wikidata">http://www.wikidata.org/entity/Q44331</idno>
                    <idno type="URL" subtype="wikipedia">https://de.wikipedia.org/wiki/Arthur_Schnitzler</idno>
                    <idno type="URL" subtype="schnitzler-kino">
                        https://schnitzler-kino.acdh.oeaw.ac.at/pmb2121.html
                    </idno>
                    <idno type="URL" subtype="schnitzler-interviews">
                        https://schnitzler-interviews.acdh.oeaw.ac.at/pmb2121.html
                    </idno>
                </person>
            </xsl:when>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>person</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
