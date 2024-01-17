<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template name="teiheader" as="node()">
        <xsl:param name="listenname"/>
        <xsl:element name="teiHeader" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="fileDesc" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="titleStmt" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="level">
                            <xsl:text>s</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Arthur Schnitzler: Briefwechsel mit Autorinnen und
                        Autoren</xsl:text>
                    </xsl:element>
                    <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="level">
                            <xsl:text>a</xsl:text>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="$listenname = 'listPerson'">
                                <xsl:text>Verzeichnis der vorkommenden Personen</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listPlace'">
                                <xsl:text>Verzeichnis der vorkommenden Orte</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listOrg'">
                                <xsl:text>Verzeichnis der vorkommenden Institutionen</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listBibl'">
                                <xsl:text>Verzeichnis der vorkommenden Werke</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:element>
                    <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>providing the content</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Martin Anton Müller</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Gerd-Hermann Susen</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Laura Untner</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>PMB (Personen der Moderne Basis)</xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>converted to XML encoding</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Martin Anton Müller</xsl:text>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="publicationStmt" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="publisher" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:text>Austrian Centre for Digital Humanities and Cultural Heritage (ACDH-CH)</xsl:text>
                    </xsl:element>
                    <xsl:element name="pubPlace" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:text>Vienna, Austria</xsl:text>
                    </xsl:element>
                    <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:value-of select="fn:current-date()"/>
                    </xsl:element>
                    <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>URI</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of
                            select="concat('https://id.acdh.oeaw.ac.at/arthur-schnitzler-briefe/v1/indices/', $listenname)"
                        />
                    </xsl:element>
                    <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>handle</xsl:text>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="$listenname = 'listPerson'">
                                <xsl:text>https://hdl.handle.net/21.11115/0000-000E-753F-9</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listPlace'">
                                <xsl:text>https://hdl.handle.net/21.11115/0000-000E-753E-A</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listOrg'">
                                <xsl:text>https://hdl.handle.net/21.11115/0000-000E-753D-B</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listBibl'">
                                <xsl:text>https://hdl.handle.net/21.11115/0000-000E-7542-4</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="sourceDesc" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:text>Entitäten für die Edition der beruflichen Korrespondenz Schnitzlers</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="tei:listPlace">
        <xsl:variable name="listenname" select="name()" as="xs:string"/>
        <xsl:result-document href="listplace.xml">
            <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:call-template name="teiheader">
                    <xsl:with-param name="listenname" select="$listenname"/>
                </xsl:call-template>
                <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:for-each select="*:place">
                                <xsl:choose>
                                    <xsl:when test="@xml:id">
                                        <xsl:element name="place"
                                            namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of
                                                  select="replace(@xml:id, 'place__', 'pmb')"/>
                                            </xsl:attribute>
                                            <xsl:copy-of select="child::*"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="place"
                                            namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of
                                                  select="replace(descendant::*:place/@xml:id, 'place__', 'pmb')"
                                                />
                                            </xsl:attribute>
                                            <xsl:copy-of
                                                select="descendant::*:place[@xml:id]/child::*"/>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="tei:listPerson">
        <xsl:variable name="listenname" select="name()" as="xs:string"/>
        <xsl:result-document href="listperson.xml">
            <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:call-template name="teiheader">
                    <xsl:with-param name="listenname" select="$listenname"/>
                </xsl:call-template>
                <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:for-each select="tei:person">
                                <xsl:choose>
                                    <xsl:when test="@xml:id">
                                        <xsl:element name="person"
                                            namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of
                                                  select="replace(@xml:id, 'person__', 'pmb')"/>
                                            </xsl:attribute>
                                            <xsl:copy-of select="child::*"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="person"
                                            namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of
                                                  select="replace(descendant::tei:person/@xml:id, 'person__', 'pmb')"
                                                />
                                            </xsl:attribute>
                                            <xsl:copy-of
                                                select="descendant::tei:person[@xml:id]/child::*"/>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="tei:listOrg">
        <xsl:variable name="listenname" select="name()" as="xs:string"/>
        <xsl:result-document href="listorg.xml">
            <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:call-template name="teiheader">
                    <xsl:with-param name="listenname" select="$listenname"/>
                </xsl:call-template>
                <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:for-each select="tei:org">
                                <xsl:choose>
                                    <xsl:when test="@xml:id">
                                        <xsl:element name="org"
                                            namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of
                                                  select="replace(@xml:id, 'org__', 'pmb')"/>
                                            </xsl:attribute>
                                            <xsl:copy-of select="child::*"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="org"
                                            namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of
                                                  select="replace(descendant::tei:org/@xml:id, 'org__', 'pmb')"
                                                />
                                            </xsl:attribute>
                                            <xsl:copy-of
                                                select="descendant::tei:org[@xml:id]/child::*"/>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="tei:listBibl">
        <xsl:variable name="listenname" select="name()" as="xs:string"/>
        <xsl:result-document href="listwork.xml">
            <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:call-template name="teiheader">
                    <xsl:with-param name="listenname" select="$listenname"/>
                </xsl:call-template>
                <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:for-each select="tei:bibl">
                                <xsl:choose>
                                    <xsl:when test="@xml:id">
                                        <xsl:element name="bibl"
                                            namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of
                                                  select="replace(@xml:id, 'work__', 'pmb')"/>
                                            </xsl:attribute>
                                            <xsl:copy-of select="child::*"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="bibl"
                                            namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of
                                                  select="replace(descendant::tei:bibl/@xml:id, 'work__', 'pmb')"
                                                />
                                            </xsl:attribute>
                                            <xsl:copy-of
                                                select="descendant::tei:bibl[@xml:id]/child::*"/>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
