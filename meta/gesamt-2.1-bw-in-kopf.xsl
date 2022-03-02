<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:param name="personen" as="array(xs:string*)"
        select="['#12438', 
        ('#2147', '#2260'), 
        '#10762', 
        ('#10815', '#10818', '#10818', '#5490', '#10977', '#5489', '#29124', '#11054', '#18530', '#29126', '#11913', '#29122', '#29123', '#29121', '#5495', '#28344', '#29120', '#12968', '#27882', '#27886'), 
        ('#10863', '#13923', '#2668', '#10860'), 
        '#10912', 
        '#10955', 
        ('#14328', '#35015'), 
        ('#10992', '#4395', '#5558'), 
        '#11002', 
        '#11036', 
        ('#11061', '#11324'), 
        '#11098', 
        '#2416', 
        '#2281', 
        ('#11148', '#4358'), 
        ('#11230', '#15716', '#29150'), 
        ('#2450', '#42508'), 
        '#11527', 
        ('#11617', '#11617'), 
        ('#11740', '#16658', '#16670', '#3220', '#2292', '#18404', '#11737', '#24033', '#24239'), 
        '#11763', 
        ('#2563', '#28812', '#41355'), 
        ('#11988', '#2446', '#29184', '#5830', '#3004', '#12564', '#4498', '#13064'), 
        ('#12071', '#29182', '#11697', '#29183', '#5822', '#5819', '#12614', '#12826', '#2725'), 
        '#4986', 
        ('#12176', '#12173'), 
        '#12170', 
        '#12183', 
        '#12225', 
        '#9550', 
        '#12740', 
        '#26121', 
        '#13055', 
        '#13068', 
        '#3557', 
        '#13212',
        '#2167',
        '#12740', 
        '#11485',
        '#11216']"/>
    <!-- Listet die Briefwechsel auf. Mehrere Personen in einem Briefwechsel mit Klammer verbunden -->
    <!-- Brandes incl. Tochter und Rung-->
    <!-- Muss nicht alphabetisch geordnet sein, die Liste
    kann aus listeDerBriefwechsel transformiert werden-->
    <xsl:key name="sent-by" match="TEI"
        use="descendant::correspDesc/correspAction[@type = 'sent']/persName/@ref"/>
    <xsl:key name="received-by" match="TEI"
        use="descendant::correspDesc/correspAction[@type = 'received']/persName/@ref"/>
    <xsl:variable name="sent-by-arthur"
        select="key('sent-by', ('#2121', '#2173', '#12698', '#12692'))"/>
    <xsl:variable name="received-by-arthur"
        select="key('received-by', ('#2121', '#2173', '#12698', '#12692'))"/>
    <xsl:template match="/*">
        <xsl:variable name="root" select="."/>
        <xsl:copy>
            <xsl:for-each select="1 to array:size($personen)">
                <xsl:apply-templates
                    select="key('sent-by', $personen(.), $root) intersect $received-by-arthur | key('received-by', $personen(.), $root) intersect $sent-by-arthur">
                    <xsl:with-param name="correspondence" select="$personen(.)[1]"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="TEI">
        <xsl:param name="correspondence"/>
        <TEI bw="{$correspondence}">
            <xsl:apply-templates select="@* | node()"/>
        </TEI>
        <xsl:if test="starts-with(@xml:id, 'E')">
            <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.tei-c.org/ns/1.0 ../../XML/META/asbwschema.xsd"
                xml:id="xxxx">
                <xsl:attribute name="bw">
                    <xsl:value-of select="concat('A', substring(@xml:id, 2))"/>
                </xsl:attribute>
                <xsl:apply-templates select="@* | node()"/>
            </TEI>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
