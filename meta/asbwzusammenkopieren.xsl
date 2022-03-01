<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:tei="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="tei">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:copy>
                <xsl:apply-templates mode="rootcopy"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="node()" mode="rootcopy">
        <xsl:copy>
            <xsl:variable name="folderURI" select="resolve-uri('.',base-uri())"/>
            <xsl:for-each select="collection(concat($folderURI, '/editions/?select=L0*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>
            <xsl:for-each select="collection(concat($folderURI, '/editions/?select=mmL*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>
            
           <!-- <xsl:for-each select="collection(concat($folderURI, '?select=L041*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>
            <xsl:for-each select="collection(concat($folderURI, '?select=E0*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>
            <xsl:for-each select="collection(concat($folderURI, '?select=L042*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>
            <xsl:for-each select="collection(concat($folderURI, '?select=D041*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>
            <xsl:for-each select="collection(concat($folderURI, '?select=T03*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>
            <xsl:for-each select="collection(concat($folderURI, '?select=I041*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>
            <xsl:for-each select="collection(concat($folderURI, '?select=J041*.xml;recurse=yes'))/node()">
                <xsl:apply-templates mode="copy" select="."/>
            </xsl:for-each>-->
        </xsl:copy>    
    </xsl:template>
    
    
    
    <!-- Deep copy template -->
    <xsl:template match="node()|@*" mode="copy">
        <xsl:copy>
            <xsl:apply-templates mode="copy" select="@*"/>
            <xsl:apply-templates mode="copy"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Handle default matching -->

    
   <!-- <xsl:template match="TEI">
        <xsl:choose>
            <xsl:when test="text[@type='diary']">
                <xsl:copy-of select="text/body/p[1]/date/@when"/>
            </xsl:when>
            <xsl:otherwise>
            <xsl:choose>
            <xsl:when test="text[@type='manuscript']">
                <xsl:copy-of select="fileDesc/sourceDesc/listWit/witness[1]/msDesc/origDate/@when"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="teiHeader/fileDesc/sourceDesc/correspDesc/dateSender/date/@when"/>
            </xsl:otherwise>
        </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    
    </xsl:template>-->
    
    <xsl:template match="/*">
        <xsl:element name="TEI">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="noNamespaceSchemaLocation"
                        namespace="http://www.w3.org/2001/XMLSchema-instance">your-value</xsl:attribute>--&gt;
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
