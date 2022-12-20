<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:template match="root">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Arthur Schnitzler – Briefwechsel mit Autorinnen und Autoren
                            CMIF</title>
                        <editor>Martin Anton Müller<email>martin.anton.mueller@oeaw.ac.at</email>
                        </editor>
                    </titleStmt>
                    <publicationStmt>
                        <publisher>
                            <ref target="https://schnitzler-briefe.acdh.oeaw.ac.at/">Martin Anton
                                Müller</ref>
                        </publisher>
                        <idno type="url"
                            >https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-cmif/main/2023_asbw-cmif.xml</idno>
                        <availability>
                            <licence target="https://creativecommons.org/licenses/by/null/"
                                >CC0</licence>
                        </availability>
                        <xsl:element name="date">
                            <xsl:attribute name="when">
                                <xsl:value-of select="fn:current-date()"/>
                            </xsl:attribute>
                        </xsl:element>
                    </publicationStmt>
                    <sourceDesc>
                        <bibl type="online" xml:id="asbw_0a380dfe-61d4-4b9e-8641-01eba8e50760"
                            >Arthur Schnitzler – Briefwechsel mit Autorinnen und Autoren. Digitale
                            Edition herausgegeben von Martin Anton Müller, Gerd-Hermann Susen und
                            Laura Untner, 2018–[2024] <ref
                                target="https://schnitzler-briefe.acdh.oeaw.ac.at/"
                                >https://schnitzler-briefe.acdh.oeaw.ac.at/</ref>
                        </bibl>
                    </sourceDesc>
                </fileDesc>
                <xsl:element name="profileDesc" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>
                    <xsl:for-each
                        select="collection(concat($folderURI, '/editions/?select=L0*.xml;recurse=yes'))[descendant::tei:correspAction]/node()">
                        
                        <xsl:if test="not(@xml:id='' or not(@xml:id) or empty(@xml:id))">
                        <xsl:element name="correspDesc" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="@xml:id"/>
                            </xsl:attribute>
                            <xsl:copy-of select="descendant::tei:correspDesc/tei:correspAction" copy-namespaces="no"
                            />
                        </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:element>
            </teiHeader>
            <text>
                <body>
                    <p/>
                </body>
            </text>
        </TEI>
    </xsl:template>
</xsl:stylesheet>
