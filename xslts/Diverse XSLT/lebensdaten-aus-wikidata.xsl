<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output method="xml" indent="yes"/>
    
    <!-- ACHTUNG, AUFPASSEN: nicht berücksichtigt ist der Fall, dass in der PMB ein vierstelliges
    Todesdatum steht, in wikidata keines. Ergebnis ist ein Eintrag mit der PMB-Nummer, aber ohne
    Datum. Das muss man das nächste Mal filtern!-->
    
    <!-- Geburtsdaten -->
<!--<xsl:template match="tei:person[tei:idno/@subtype='wikidata']/tei:birth[not(tei:date) or string-length(tei:date)=4]">
    <xsl:value-of select="parent::tei:person/@xml:id"/><xsl:text>,</xsl:text>
    <xsl:variable name="wikidata-entry" select="parent::tei:person/tei:idno[@subtype='wikidata'][1]" as="xs:string"/>
        <xsl:variable name="wikidata-entity">
            <xsl:choose>
                <xsl:when test="starts-with($wikidata-entry, 'Q')">
                    <xsl:value-of select="normalize-space($wikidata-entry)"/>
                </xsl:when>
                <xsl:when test="starts-with($wikidata-entry, 'https://www.wikidata.org/entity/')">
                    <xsl:value-of
                        select="normalize-space(substring-after($wikidata-entry, 'https://www.wikidata.org/entity/'))"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="normalize-space(concat('Q', tokenize($wikidata-entry, 'Q')[last()]))"
                    />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="get-string" as="xs:string">
            <xsl:value-of
                select="concat('https://www.wikidata.org/w/api.php?action=wbgetentities&amp;format=xml&amp;ids=', $wikidata-entity,'')"
            />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="document($get-string)/descendant::property[@id='P569']/claim[1]/mainsnak[1]/datavalue[1]/value[1]/@time">
                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:variable name="datumZeit" select="document($get-string)/descendant::property[@id='P569']/claim[1]/mainsnak[1]/datavalue[1]/value[1]/@time"/>
                <xsl:variable name="datum">
                        <xsl:choose>
                            <xsl:when test="contains($datumZeit, 'T') and contains($datumZeit, '-00-00')">
                                <xsl:value-of select="substring-before($datumZeit, '-00-00T')"/>
                            </xsl:when>
                            <xsl:when test="contains($datumZeit, 'T')">
                                <xsl:value-of select="substring-before($datumZeit, 'T')"/>
                            </xsl:when>
                            <xsl:when test="contains($datumZeit, '-00-00')">
                                <xsl:value-of select="substring-before($datumZeit, '-00-00')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$datumZeit"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:variable>
                    <xsl:choose>
                    <xsl:when test="starts-with($datum, '+')">
                        <xsl:value-of select="substring($datum,2)"/>
                    </xsl:when>
                        <xsl:when test="starts-with($datum, '-')">
                            <xsl:value-of select="concat(substring($datumZeit,2), '&lt;0001-01-01&gt;')"/>
                        </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$datum"/>
                    </xsl:otherwise>
                </xsl:choose>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    <xsl:text>
</xsl:text>
</xsl:template>    -->
    
    <!-- TOD -->
   <!-- <xsl:template match="tei:person[tei:idno/@subtype='wikidata']/tei:death[not(tei:date) or string-length(tei:date)=4]">
        <xsl:value-of select="parent::tei:person/@xml:id"/><xsl:text>,</xsl:text>
        <xsl:variable name="wikidata-entry" select="parent::tei:person/tei:idno[@subtype='wikidata'][1]" as="xs:string"/>
        <xsl:variable name="wikidata-entity">
            <xsl:choose>
                <xsl:when test="starts-with($wikidata-entry, 'Q')">
                    <xsl:value-of select="normalize-space($wikidata-entry)"/>
                </xsl:when>
                <xsl:when test="starts-with($wikidata-entry, 'https://www.wikidata.org/entity/')">
                    <xsl:value-of
                        select="normalize-space(substring-after($wikidata-entry, 'https://www.wikidata.org/entity/'))"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="normalize-space(concat('Q', tokenize($wikidata-entry, 'Q')[last()]))"
                    />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="get-string" as="xs:string">
            <xsl:value-of
                select="concat('https://www.wikidata.org/w/api.php?action=wbgetentities&amp;format=xml&amp;ids=', $wikidata-entity,'')"
            />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="document($get-string)/descendant::property[@id='P570']/claim[1]/mainsnak[1]/datavalue[1]/value[1]/@time">
                    <xsl:variable name="datumZeit" select="document($get-string)/descendant::property[@id='P569']/claim[1]/mainsnak[1]/datavalue[1]/value[1]/@time"/>
                    <xsl:variable name="datum">
                        <xsl:choose>
                            <xsl:when test="contains($datumZeit, 'T') and contains($datumZeit, '-00-00')">
                                <xsl:value-of select="substring-before($datumZeit, '-00-00T')"/>
                            </xsl:when>
                            <xsl:when test="contains($datumZeit, 'T')">
                                <xsl:value-of select="substring-before($datumZeit, 'T')"/>
                            </xsl:when>
                            <xsl:when test="contains($datumZeit, '-00-00')">
                                <xsl:value-of select="substring-before($datumZeit, '-00-00')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$datumZeit"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="starts-with($datum, '+')">
                            <xsl:value-of select="substring($datum,2)"/>
                        </xsl:when>
                        <xsl:when test="starts-with($datum, '-')">
                            <xsl:value-of select="concat(substring($datumZeit,2), '&lt;0001-01-01&gt;')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$datum"/>
                        </xsl:otherwise>
                    </xsl:choose>
            </xsl:when>
        </xsl:choose>
        <xsl:text>
</xsl:text>
    </xsl:template>-->
    
    <!-- gender -->
    <xsl:template match="tei:person[tei:idno/@subtype='wikidata' and tei:sex[@value='not-set'] or not(tei:sex)]">
        <xsl:value-of select="@xml:id"/><xsl:text>,</xsl:text>
        <xsl:variable name="wikidata-entry" select="tei:idno[@subtype='wikidata'][1]" as="xs:string"/>
        <xsl:variable name="wikidata-entity">
            <xsl:choose>
                <xsl:when test="starts-with($wikidata-entry, 'Q')">
                    <xsl:value-of select="normalize-space($wikidata-entry)"/>
                </xsl:when>
                <xsl:when test="starts-with($wikidata-entry, 'https://www.wikidata.org/entity/')">
                    <xsl:value-of
                        select="normalize-space(substring-after($wikidata-entry, 'https://www.wikidata.org/entity/'))"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="normalize-space(concat('Q', tokenize($wikidata-entry, 'Q')[last()]))"
                    />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="get-string" as="xs:string">
            <xsl:value-of
                select="concat('https://www.wikidata.org/w/api.php?action=wbgetentities&amp;format=xml&amp;ids=', $wikidata-entity,'')"
            />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="document($get-string)/descendant::property[@id='P21']/claim/mainsnak/datavalue/value/@id">
                <xsl:variable name="gender" select="document($get-string)/descendant::property[@id='P21']/claim/mainsnak/datavalue/value/@id"/>
                <xsl:choose>
                    <xsl:when test="$gender='Q6581097'">
                        <xsl:text>male</xsl:text>
                    </xsl:when>
                    <xsl:when test="$gender='Q6581072'">
                        <xsl:text>female</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$gender"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
        <xsl:text>
</xsl:text>
    </xsl:template>
    

    
</xsl:stylesheet>