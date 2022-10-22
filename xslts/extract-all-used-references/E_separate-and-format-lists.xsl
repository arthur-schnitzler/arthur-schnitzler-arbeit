<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
  <xsl:template match="tei:listPlace">
      <xsl:result-document  href="listplace.xml">
          <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
              <xsl:for-each select="tei:place">
                  <xsl:choose>
                      <xsl:when test="@xml:id">
                          <xsl:element name="place" namespace="http://www.tei-c.org/ns/1.0">
                              <xsl:attribute name="xml:id">
                                  <xsl:value-of select="replace(@xml:id, 'place__', 'pmb')"/>
                              </xsl:attribute>
                              <xsl:copy-of select="child::*"></xsl:copy-of>
                          </xsl:element>
                      </xsl:when>
                      <xsl:otherwise>
                          <xsl:element name="place" namespace="http://www.tei-c.org/ns/1.0">
                              <xsl:attribute name="xml:id">
                                  <xsl:value-of select="replace(descendant::tei:place/@xml:id, 'place__', 'pmb')"/>
                              </xsl:attribute>
                              <xsl:copy-of select="descendant::tei:place[@xml:id]/child::*"/>
                          </xsl:element>
                      </xsl:otherwise>
                  </xsl:choose>
              </xsl:for-each>
          </xsl:element>
      </xsl:result-document>
      
  </xsl:template>
    
    <xsl:template match="tei:listPerson">
        <xsl:result-document  href="listperson.xml">
            <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="tei:person">
                    <xsl:choose>
                        <xsl:when test="@xml:id">
                            <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="replace(@xml:id, 'person__', 'pmb')"/>
                                </xsl:attribute>
                                <xsl:copy-of select="child::*"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="replace(descendant::tei:person/@xml:id, 'person__', 'pmb')"/>
                                </xsl:attribute>
                                <xsl:copy-of select="descendant::tei:person[@xml:id]/child::*"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:element>
        </xsl:result-document>
        
    </xsl:template>
   
    <xsl:template match="tei:listOrg">
        <xsl:result-document  href="listorg.xml">
            <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="tei:org">
                    <xsl:choose>
                        <xsl:when test="@xml:id">
                            <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="replace(@xml:id, 'org__', 'pmb')"/>
                                </xsl:attribute>
                                <xsl:copy-of select="child::*"></xsl:copy-of>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="replace(descendant::tei:org/@xml:id, 'org__', 'pmb')"/>
                                </xsl:attribute>
                                <xsl:copy-of select="descendant::tei:org[@xml:id]/child::*"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <xsl:result-document  href="listwork.xml">
            <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="tei:item">
                    <xsl:choose>
                        <xsl:when test="@xml:id">
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="replace(@xml:id, 'work__', 'pmb')"/>
                                </xsl:attribute>
                                <xsl:copy-of select="child::*"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="replace(descendant::tei:bibl/@xml:id, 'work__', 'pmb')"/>
                                </xsl:attribute>
                                <xsl:copy-of select="descendant::tei:bibl[@xml:id]/child::*"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>
