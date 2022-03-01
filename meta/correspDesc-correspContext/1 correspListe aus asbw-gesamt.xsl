<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    version="3.0">
    
    <xsl:output indent="yes"
        method="xml"
        encoding="utf-8"
        omit-xml-declaration="false"/>
    <xsl:param name="correspPartner" select="document('listeDerBriefwechsel.xml')"/>
    <xsl:key name="corresp-lookup" match="correspondence" use="sub-person/@id"/>
    
    
 <!-- Diese Datei zieht alle correspDescs aus asbw-gesamt. sie fügt beim
element correspDesc zwei Attribute hinzu: date mit isodatum und person mit
der liste aller Korrespondenzpartner*innen Schnitzlers. 
Zusätzlich wird ein neues correspContext-Element angelegt, das bei den
zugehörigen Briefwechseln die zugehörigen Nummern angibt (also Anna Bahr-Mildenburg zu Bahr). Hier 
entstehen Duplikate! -->
    
    <xsl:template match="root">
        <xsl:element name="root" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="descendant::correspDesc">
                <xsl:variable name="date-n">
                   <xsl:choose>
                       <xsl:when test="correspAction[1]/date/@when">
                           <xsl:value-of select="correspAction[1]/date/@when"/>
                       </xsl:when>
                       <xsl:when test="correspAction[1]/date/@notBefore">
                           <xsl:value-of select="correspAction[1]/date/@notBefore"/>
                       </xsl:when>
                       <xsl:when test="correspAction[1]/date/@notAfter">
                           <xsl:value-of select="correspAction[1]/date/@notAfter"/>
                       </xsl:when>
                   </xsl:choose> 
                    <xsl:choose>
                        <xsl:when test="string-length(correspAction[@type = 'sent']/date/@n) = 1">
                            <xsl:value-of
                                select="concat('_0', correspAction[@type = 'sent']/date/@n)"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('_', correspAction[@type = 'sent']/date/@n)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="partner" as="node()">
                    <xsl:choose>
                        <xsl:when test="correspAction[@type='sent']/persName/@ref='#2121' or correspAction[@type='sent']/persName/@ref='#2173'">
                            <xsl:copy-of select="correspAction[@type='received']"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="correspAction[@type='sent']"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:element name="correspDesc" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="ancestor::TEI/@id"/>
                    </xsl:attribute>
                    <xsl:attribute name="date">
                        <xsl:value-of select="$date-n"/>
                    </xsl:attribute>
                    <xsl:for-each select="correspAction">
                        <xsl:element name="correspAction" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:value-of select="@type"/>
                        </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:for-each>
                    <xsl:element name="correspContext" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:for-each select="$partner/persName">
                            <xsl:if test="not(key('corresp-lookup', @ref, $correspPartner)/writer/@id = 'null')"><!-- Das filtert die paar Fälle, die wir (noch) nicht aufnehmen -->
                            <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:text>belongsToCorrespondence</xsl:text>
                                </xsl:attribute>
                                    <xsl:choose>
                                        <xsl:when test="string-length(key('corresp-lookup', @ref, $correspPartner)/writer) &gt; 1">
                                            <xsl:attribute name="target">
                                            <xsl:value-of select="key('corresp-lookup', @ref, $correspPartner)/writer/@id"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="key('corresp-lookup', @ref, $correspPartner)/writer"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="target">
                                            <xsl:value-of select="@ref"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="."/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                            </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="persName">
        <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="ref">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="placeName">
        <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="ref">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
        <xsl:template match="date">
            <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:if test="@when">
                        <xsl:attribute name="when">
                            <xsl:value-of select="@when"/>
                        </xsl:attribute>
                </xsl:if>
                <xsl:if test="@notBefore">
                    <xsl:attribute name="notBefore">
                        <xsl:value-of select="@notBefore"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@notAfter">
                    <xsl:attribute name="notAfter">
                        <xsl:value-of select="@notAfter"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@notBefore">
                    <xsl:attribute name="notBefore">
                        <xsl:value-of select="@notBefore"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@from">
                    <xsl:attribute name="from">
                        <xsl:value-of select="@from"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@notBefore">
                    <xsl:attribute name="notBefore">
                        <xsl:value-of select="@notBefore"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@to">
                    <xsl:attribute name="to">
                        <xsl:value-of select="@to"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:template>
        
</xsl:stylesheet>