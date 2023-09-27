<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
  
    <!-- Dubletten raus, vor allem, weil die erst im letzten Schritt eingefügten Autoren hier noch
    dazu kommen-->
    
    <xsl:template match="tei:*[starts-with(name(), 'list')]/tei:*[@xml:id= preceding-sibling::tei:*/@xml:id]"/>
    
</xsl:stylesheet>
