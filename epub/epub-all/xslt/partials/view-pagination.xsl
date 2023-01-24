<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsl tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget tei-facsimile.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with call-templates in html:body.</p>
            <p>The template "view-pagination" creates a pagintion based on items position.</p> 
            <p>Bootstrap is required.</p>
        </desc>    
    </doc>
    
    <xsl:template name="view-pagination">
        <xsl:variable 
            name="vseq" 
            select="//tei:pb"
            as="item()*"/>
        
        <div class="text-center pagination">
            <ul class="pagination-menu nav nav-tabs">
                <xsl:for-each select="$vseq">
                    <!--  var to create container ids to insert facsimiles to one individual container each   -->
                    <xsl:variable name="facs_item" select="tokenize(@facs, '/')[5]"/>
                    <xsl:choose>
                        <xsl:when test="position() = [1,2,3,4,5,6,7,8,9]">
                            <li class="nav-item">
                                <edition-pagination 
                                    opt="edition-pagination"
                                    pos="{position()}" 
                                    facs="{$facs_item}" 
                                    data-type="{@type}">
                                </edition-pagination>                                                 
                            </li>
                        </xsl:when>
                        <xsl:when test="position() = 10">
                            <li class="nav-item dropdown">
                                <a
                                    title="more"
                                    href="#"
                                    data-toggle="dropdown"
                                    data-tab="paginate"
                                    class="nav-link dropdown-toggle"
                                    style="border-radius:30px;"
                                    >more <span class="caret"></span>
                                </a>
                                <ul class="pagination-menu dropdown-menu" role="menu">
                                    <xsl:for-each select="$vseq">
                                        <xsl:variable name="facs_item" select="tokenize(@facs, '/')[5]"/> 
                                        <xsl:choose>
                                            <xsl:when test="position() > 9">
                                                <li class="nav-item dropdown-submenu"
                                                    style="display:inline-block;">
                                                    <edition-pagination 
                                                        opt="edition-pagination"
                                                        pos="{position()}" 
                                                        facs="{$facs_item}" 
                                                        data-type="{@type}">
                                                    </edition-pagination>
                                                </li>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:for-each>                                                                                                                
                                </ul>                                
                            </li>
                        </xsl:when>
                        <xsl:otherwise>
                            <!--<li class="nav-item" style="display:none;">
                                <a
                                    title="{position()}"
                                    class="nav-link btn btn-round btn-backlink"
                                    data-toggle="tab"
                                    href="#diplomatic-paginate-{position()}"
                                    ><xsl:value-of select="position()"/> 
                                </a>                                                    
                            </li>-->
                        </xsl:otherwise>
                    </xsl:choose>                                                                                                        
                </xsl:for-each>                                                                                                
            </ul>            
        </div>
        
    </xsl:template> 
</xsl:stylesheet>