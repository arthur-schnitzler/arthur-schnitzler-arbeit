<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:foo="whatever works"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="no" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/html_title_navigation.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:import href="partials/view-pagination.xsl"/>
    <xsl:import href="partials/view-type.xsl"/>
    <xsl:import href="partials/annotation-options.xsl"/>
    <xsl:import href="partials/edition-md.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="descendant::tei:titleStmt/tei:title[@level='a'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>           
                <meta name="Date of publication" class="staticSearch_date">
                    <xsl:choose>
                        <xsl:when test="//tei:origin/tei:origDate/@notBefore">
                            <xsl:attribute name="content">
                                <xsl:value-of select="//tei:origin/tei:origDate/@notBefore"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="//tei:origin/tei:origDate/@when-iso">
                            <xsl:attribute name="content">
                                <xsl:value-of select="//tei:origin/tei:origDate/@when-iso"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="content">
                                <xsl:value-of select="//tei:origin/tei:origDate"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>                    
                </meta>
                <meta name="docImage" class="staticSearch_docImage">
                    <xsl:attribute name="content">
                        <!--<xsl:variable name="iiif-ext" select="'.jp2/full/,200/0/default.jpg'"/> -->
                        <xsl:variable name="iiif-ext" select="'.jpg?format=iiif&amp;param=/full/,200/0/default.jpg'"/> 
                        <xsl:variable name="iiif-domain" select="'https://iiif.acdh-dev.oeaw.ac.at/iiif/images/schnitzler-briefe/'"/>
                        <xsl:variable name="facs_id" select="concat(@type, '_img_', generate-id())"/>
                        <xsl:variable name="facs_item" select="descendant::tei:pb[1]/@facs"/>                        
                        <xsl:value-of select="concat($iiif-domain, $facs_item, $iiif-ext)"/>
                    </xsl:attribute>
                </meta>
                <meta name="docTitle" class="staticSearch_docTitle">
                    <xsl:attribute name="content">
                        <xsl:value-of select="//tei:titleStmt/tei:title[@level='a']"/>
                    </xsl:attribute>
                </meta>
                <xsl:if test="descendant::tei:back/tei:listPlace/tei:place">
                    <xsl:for-each select="descendant::tei:back/tei:listPlace/tei:place">
                        <meta name="Places"
                            class="staticSearch_feat"
                            content="{if (./tei:settlement) then (./tei:settlement/tei:placeName) else (./tei:placeName)}">
                        </meta>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="descendant::tei:back/tei:listPerson/tei:person">
                    <xsl:for-each select="descendant::tei:back/tei:listPerson/tei:person">
                        <meta name="Persons"
                            class="staticSearch_feat"
                            content="{concat(./tei:persName/tei:surname, ', ', ./tei:persName/tei:forename)}">
                        </meta>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="descendant::tei:back/tei:listOrg/tei:org">
                    <xsl:for-each select="descendant::tei:back/tei:listOrg/tei:org">
                        <meta name="Organizations"
                            class="staticSearch_feat"
                            content="{./tei:orgName}">
                        </meta>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="descendant::tei:back/tei:listBibl[not(parent::tei:person)]/tei:bibl">
                    <xsl:for-each select="descendant::tei:back/tei:listBibl[not(parent::tei:person)]/tei:bibl">
                        <meta name="Literature"
                            class="staticSearch_feat"
                            content="{./tei:title[1]}">
                        </meta>
                    </xsl:for-each>
                </xsl:if>
                <style>
                    .transcript {
                        padding: 1em 0;
                    }
                    /*.text-re::before {
                        content: '';
                        background-color: #ccc;
                        right: .05em;
                        width: 10px;
                        height: 100%;
                        position:absolute;
                        border-top: 10px solid ccc;
                    }*/
                    .card-body {
                        padding: 4em 1em;
                    }
                    .container-fluid {
                        max-width: 100%;
                    }
                    .sticky-navbar {
                        position: relative !important;
                    }
                </style>
                <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/3.1.0/openseadragon.min.js"></script>-->
                <script src="https://unpkg.com/de-micro-editor@0.2.2/dist/de-editor.min.js"></script>
                <!--<script src="js/dist/de-editor.min.js"></script>-->
            </head>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">  
                        <div class="card">
                            <div class="card-body" style="padding: .5em 0 0 0 !important;">
                                <xsl:call-template name="header-nav"/>
                                
                                <!--   adding arche metadata for each edition   -->
                                <xsl:call-template name="edition-md">
                                    <xsl:with-param name="doc_title" select="$doc_title"/>
                                </xsl:call-template>
                                
                                <!--   adding annotation view and options   -->
                                <xsl:call-template name="annotation-options"/>
                                
                            </div>
                            
                            <!--   add edition text and facsimile   -->
                             <xsl:for-each select="descendant::tei:body//tei:div">                                             
                                 <xsl:call-template name="view-type-img"/>
    
                             </xsl:for-each>
                            
                        </div><!-- .card -->
                        <xsl:for-each select="//tei:back">
                            <div class="tei-back">
                                
                                <xsl:apply-templates/>
                                
                            </div>
                        </xsl:for-each>
                    </div><!-- .container-fluid -->
                    <xsl:call-template name="html_footer"/>
                </div><!-- .site -->
                <script type="text/javascript" src="js/run.js"></script>
            </body>
        </html>
    </xsl:template>
                    
    <!--<xsl:template match="tei:lb">
        <br/>        
    </xsl:template>-->
    <xsl:template match="tei:lg">
        <span style="display:block;margin: 1em 0;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:l">
        <xsl:apply-templates/><br />
    </xsl:template>
    <xsl:template match="tei:unclear">
        <span class="abbr fade" alt="unclear">
            <xsl:apply-templates/>
        </span> 
    </xsl:template>
    <xsl:template match="tei:space">
        <span class="space">
            <xsl:value-of select="string-join((for $i in 1 to @quantity return '&#x00A0;'),'')"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:del">
        <span class="del fade"><xsl:apply-templates/></span>      
    </xsl:template> 
    <xsl:template match="tei:gap">
        <xsl:choose>
            <xsl:when test="@reason='deleted'">
                <span class="del gap">
                    <xsl:attribute name="alt">
                        <xsl:value-of select="data(@reason)"/>
                    </xsl:attribute>
                    <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
                </span>                
            </xsl:when>
            <xsl:when test="@reason='illegible'">
                <span class="gap">
                    <xsl:attribute name="alt">
                        <xsl:value-of select="data(@reason)"/>
                    </xsl:attribute>
                    <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
                </span>
            </xsl:when>
        </xsl:choose> 
    </xsl:template>
     
    <xsl:template match="tei:rs[@type='person']">
        <xsl:choose>
            <xsl:when test="count(tokenize(@ref, ' ')) > 1">
                <span class="persons">
                    <xsl:apply-templates/>
                    <xsl:for-each select="tokenize(@ref, ' ')">
                        <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                            <xsl:value-of select="position()"/>
                        </sup>
                        <xsl:if test="position() != last()">
                            <sup>/</sup>
                        </xsl:if>
                    </xsl:for-each>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="persons entity" data-bs-toggle="modal" data-bs-target="{@ref}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:rs[@type='work']">
        <xsl:choose>
            <xsl:when test="count(tokenize(@ref, ' ')) > 1">
                <span class="works">
                    <xsl:apply-templates/>
                    <xsl:for-each select="tokenize(@ref, ' ')">
                        <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                            <xsl:value-of select="position()"/>
                        </sup>
                        <xsl:if test="position() != last()">
                            <sup>/</sup>
                        </xsl:if>
                    </xsl:for-each>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="work entity" data-bs-toggle="modal" data-bs-target="{@ref}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type='org']">
        <xsl:choose>
            <xsl:when test="count(tokenize(@ref, ' ')) > 1">
                <span class="orgs">
                    <xsl:apply-templates/>
                    <xsl:for-each select="tokenize(@ref, ' ')">
                        <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                            <xsl:value-of select="position()"/>
                        </sup>
                        <xsl:if test="position() != last()">
                            <sup>/</sup>
                        </xsl:if>
                    </xsl:for-each>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="org entity" data-bs-toggle="modal" data-bs-target="{@ref}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:rs[@type='place']">
        <xsl:choose>
            <xsl:when test="count(tokenize(@ref, ' ')) > 1">
                <span class="places">
                    <xsl:apply-templates/>
                    <xsl:for-each select="tokenize(@ref, ' ')">
                        <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                            <xsl:value-of select="position()"/>
                        </sup>
                        <xsl:if test="position() != last()">
                            <sup>/</sup>
                        </xsl:if>
                    </xsl:for-each>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="place entity" data-bs-toggle="modal" data-bs-target="{@ref}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:listPerson">
        <xsl:for-each select="./tei:person">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{concat(./tei:persName/tei:surname, ', ', ./tei:persName/tei:forename)}" aria-hidden="true">
                 <div class="modal-dialog modal-dialog-centered">
                     <div class="modal-content">
                         <div class="modal-header">
                             <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="concat(./tei:persName/tei:surname, ', ', ./tei:persName/tei:forename)"/></h1>
                             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                         </div>
                         <div class="modal-body">
                             <table>
                                 <tbody>
                                     <tr>
                                         <th>
                                             Birth
                                         </th>
                                         <td>
                                             <xsl:value-of select="./tei:birth/tei:date/@when-iso"/>
                                         </td>
                                     </tr>
                                     <tr>
                                         <th>
                                             Death
                                         </th>
                                         <td>
                                             <xsl:value-of select="./tei:death/tei:date/@when-iso"/>
                                         </td>
                                     </tr>
                                     <tr>
                                         <th>
                                             GND
                                         </th>
                                         <td>
                                             <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                 <xsl:value-of select="./tei:idno[@type='GND']"/>
                                             </a>
                                         </td>
                                     </tr>
                                     <tr>
                                         <th>
                                             Read more
                                         </th>
                                         <td>
                                             <a href="{concat(@xml:id, '.html')}">
                                                 Detail Page
                                             </a>
                                         </td>
                                     </tr>
                                 </tbody>
                             </table>
                         </div>
                         <div class="modal-footer">
                             <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                         </div>
                     </div>
                 </div>
             </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:listPlace">
        <xsl:for-each select="./tei:place">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{if(./tei:settlement) then(./tei:settlement/tei:placeName) else (./tei:placeName)}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="if(./tei:settlement) then(./tei:settlement/tei:placeName) else (./tei:placeName)"/></h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tbody>
                                    <tr>
                                        <th>
                                            Country
                                        </th>
                                        <td>
                                            <xsl:value-of select="./tei:country"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Geonames ID
                                        </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                                                <xsl:value-of select="tokenize(./tei:idno[@type='GEONAMES'], '/')[4]"/>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Read more
                                        </th>
                                        <td>
                                            <a href="{concat(@xml:id, '.html')}">
                                                Detail Page
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:listOrg">
        <xsl:for-each select="./tei:org">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{./tei:orgName}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="./tei:orgName"/></h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tbody>
                                    <tr>
                                        <th>
                                            Wikidata ID
                                        </th>
                                        <td>
                                            <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Read more
                                        </th>
                                        <td>
                                            <a href="{concat(@xml:id, '.html')}">
                                                Detail Page
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    <!--<xsl:template match="tei:listBibl">
        <xsl:for-each select="./tei:bibl">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{./tei:title}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="./tei:title"/></h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tbody>
                                    
                                    <tr>
                                        <th>
                                            Author(s)
                                        </th>
                                        <td>
                                            <ul>
                                                <xsl:for-each select="./tei:author">
                                                    <li>
                                                        <a href="{@xml:id}.html">
                                                            <xsl:value-of select="./tei:persName"/>
                                                        </a>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Date
                                        </th>
                                        <td>
                                            <xsl:value-of select="./tei:date/@when"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Wikidata ID
                                        </th>
                                        <td>
                                            <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Read more
                                        </th>
                                        <td>
                                            <a href="{concat(@xml:id, '.html')}">
                                                Detail Page
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>-->
    
    
    <!--<xsl:template match="tei:lb">
        <br/>
        <xsl:if test="ancestor::tei:p">
            <a>
                <xsl:variable name="para" as="xs:int">
                    <xsl:number level="any" from="tei:body" count="tei:p"/>
                </xsl:variable>
                <xsl:variable name="lines" as="xs:int">
                    <xsl:number level="any" from="tei:body"/>
                </xsl:variable>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text><xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                    <xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="($lines mod 5) = 0">
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersVisible linenumbers</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-lbnr">
                            <xsl:value-of select="$lines"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersTransparent linenumbers</xsl:text>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="format-number($lines, '0000')"/>
            </a>  
        </xsl:if>
    </xsl:template>-->
    
    <!--<xsl:template match="tei:l">
        <br/>
        <xsl:if test="parent::tei:lg">
            <a>
                <xsl:variable name="para" as="xs:int">
                    <xsl:number level="any" from="tei:body" count="tei:lg"/>
                </xsl:variable>
                <xsl:variable name="lines" as="xs:int">
                    <xsl:number level="multiple" from="tei:body"/>
                </xsl:variable>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text><xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__lg</xsl:text><xsl:value-of select="$para"/><xsl:text>__vl</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                    <xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__lg</xsl:text><xsl:value-of select="$para"/><xsl:text>__vl</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__lg</xsl:text><xsl:value-of select="$para"/><xsl:text>__vl</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="($lines mod 5) = 0">
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersVisible linenumbers verseline</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-lbnr">
                            <xsl:value-of select="$lines"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersTransparent linenumbers verseline</xsl:text>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="concat('(vl) ', format-number($lines, '0000'))"/>
            </a>
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>-->
    <xsl:template match="tei:c[@rendition = '#langesS']|tei:c[@rendition = '#langesS2']" mode="lemma-k">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#langesS']|tei:c[@rendition = '#langesS2']" mode="lemma-t">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#langesS']">
        <xsl:text>ſ</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#langesS2']">
        <xsl:text>ſſ</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#kaufmannsund']" mode="lemma-k">
        <xsl:text>&amp;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#kaufmannsund']" mode="lemma-t">
        <xsl:text>&amp;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#kaufmannsund']">
        <xsl:text>&amp;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#tilde']">~</xsl:template>
    <xsl:template match="tei:c[@rendition = '#tilde']" mode="lemma-k">~</xsl:template>
    <xsl:template match="tei:c[@rendition = '#tilde']" mode="lemma-t">~</xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-auf']">
        <xsl:text>{</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-auf']" mode="lemma-k">
        <xsl:text>{</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-zu']" mode="lemma-k">
        <xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="tei:space[@unit = 'chars' and @quantity = '1']" mode="lemma-k">
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-auf']" mode="lemma-t">
        <xsl:text>{</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-zu']" mode="lemma-t">
        <xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="tei:space[@unit = 'chars' and @quantity = '1']" mode="lemma-t">
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="tei:space[@unit = 'chars' and @quantity = '1']">
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:function name="foo:spaci-space">
        <xsl:param name="anzahl"/>
        <xsl:param name="gesamt"/>  <br/>
        <xsl:if test="$anzahl &lt; $gesamt">
            <xsl:value-of select="foo:spaci-space($anzahl, $gesamt)"/>
        </xsl:if>
    </xsl:function>
    <xsl:template match="tei:space[@unit = 'line']">
        <xsl:value-of select="foo:spaci-space(@quantity, @quantity)"/>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-zu']">
        <xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#gemination-m']" mode="lemma-k">
        <span class="gemination">mm</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#gemination-m']" mode="lemma-t">
        <span class="gemination">mm</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#gemination-m']">
        <span class="gemination">m̅</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#gemination-n']" mode="lemma-k">
        <span class="gemination">nn</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#gemination-n']" mode="lemma-t">
        <span class="gemination">nn</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#gemination-n']">
        <span class="gemination">n̅</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#prozent']" mode="lemma-k">
        <xsl:text>%</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#prozent']" mode="lemma-t">
        <xsl:text>%</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#prozent']">
        <xsl:text>%</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#dots']" mode="lemma-k">
        <xsl:value-of select="foo:dots(@n)"/>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#dots']" mode="lemma-t">
        <xsl:value-of select="foo:dots(@n)"/>
    </xsl:template>
    
    <xsl:template match="tei:c[@rendition = '#dots']">
        <xsl:value-of select="foo:dots(@n)"/>
    </xsl:template>
    
        <xsl:template match="tei:ref[not(@type = 'schnitzlerDiary') and not(@type = 'toLetter')]">
        <xsl:choose>
            <xsl:when test="@target[ends-with(., '.xml')]">
                <xsl:element name="a">
                    <xsl:attribute name="class">reference-black</xsl:attribute>
                    <xsl:attribute name="href"> show.html?ref=<xsl:value-of
                            select="tokenize(./@target, '/')[4]"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:ref[@type = 'schnitzlerDiary']">
        <xsl:if test="not(@subtype = 'date-only')">
            <xsl:choose>
                <xsl:when test="@subtype = 'See'">
                    <xsl:text>Siehe </xsl:text>
                </xsl:when>
                <xsl:when test="@subtype = 'Cf'">
                    <xsl:text>Vgl. </xsl:text>
                </xsl:when>
                <xsl:when test="@subtype = 'see'">
                    <xsl:text>siehe </xsl:text>
                </xsl:when>
                <xsl:when test="@subtype = 'cf'">
                    <xsl:text>vgl. </xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:text>A. S.: Tagebuch, </xsl:text>
        </xsl:if>
        <a>
            <xsl:attribute name="class">reference-black</xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of
                    select="concat('https://schnitzler-tagebuch.acdh.oeaw.ac.at/entry__', @target, '.html')"
                />
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="substring(@target, 9, 1) = '0'">
                    <xsl:value-of select="substring(@target, 10, 1)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(@target, 9, 2)"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>. </xsl:text>
            <xsl:choose>
                <xsl:when test="substring(@target, 6, 1) = '0'">
                    <xsl:value-of select="substring(@target, 7, 1)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(@target, 6, 2)"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="substring(@target, 1, 4)"/>
        </a>
    </xsl:template>
    <xsl:template match="tei:ref[@type = 'toLetter']">
        <xsl:choose>
            <xsl:when test="@subtype = 'date-only'">
                <a>
                    <xsl:attribute name="class">reference-black</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of
                            select="concat('https://schnitzler-briefe.acdh.oeaw.ac.at/pages/show.html?document=', @target)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="tei:date/text()"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@subtype = 'See'">
                        <xsl:text>Siehe </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'Cf'">
                        <xsl:text>Vgl. </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'see'">
                        <xsl:text>siehe </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'cf'">
                        <xsl:text>vgl. </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <a>
                    <xsl:attribute name="class">reference-black</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of
                            select="concat('https://schnitzler-briefe.acdh.oeaw.ac.at/pages/show.html?document=', @target)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="tei:title/text()"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Ergänzungen für neues physDesc -->
    <xsl:template match="tei:incident/tei:desc/tei:stamp">
        <xsl:text>Stempel </xsl:text>
        <xsl:value-of select="@n"/>
        <xsl:text>:</xsl:text>
        <br/>
        <xsl:if test="tei:placeName"> Ort: <xsl:apply-templates select="./tei:placeName"/>
            <br/>
        </xsl:if>
        <xsl:if test="tei:date"> Datum: <xsl:apply-templates select="./tei:date"/>
            <br/>
        </xsl:if>
        <xsl:if test="tei:time"> Zeit: <xsl:apply-templates select="./tei:time"/>
            <br/>
        </xsl:if>
        <xsl:if test="tei:addSpan"> Vorgang: <xsl:apply-templates select="./tei:addSpan"/>
            <br/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:incident">
        <tr>
            <xsl:apply-templates select="tei:desc"/>
        </tr>
    </xsl:template>
    <xsl:template match="tei:additions">
        <xsl:apply-templates select="tei:incident[@type = 'supplement']"/>
        <xsl:apply-templates select="tei:incident[@type = 'postal']"/>
        <xsl:apply-templates select="tei:incident[@type = 'receiver']"/>
        <xsl:apply-templates select="tei:incident[@type = 'archival']"/>
        <xsl:apply-templates select="tei:incident[@type = 'additional-information']"/>
        <xsl:apply-templates select="tei:incident[@type = 'editorial']"/>
    </xsl:template>
    <xsl:template match="tei:incident[@type = 'supplement']/tei:desc">
        <tr>
            <xsl:variable name="poschitzion"
                select="count(parent::tei:incident/preceding-sibling::tei:incident[@type = 'supplement'])"/>
            <xsl:choose>
                <xsl:when test="$poschitzion &gt; 0">
                    <td/>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and not(parent::tei:incident/following-sibling::tei:incident[@type = 'supplement'])">
                    <th>Beilage</th>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and parent::tei:incident/following-sibling::tei:incident[@type = 'supplement']">
                    <th>Beilagen</th>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
            </xsl:choose>
        </tr>
    </xsl:template>
    <xsl:template match="tei:desc[parent::tei:incident[@type = 'postal']]">
        <xsl:variable name="poschitzion"
            select="count(parent::tei:incident/preceding-sibling::tei:incident[@type = 'postal'])"/>
        <xsl:choose>
            <xsl:when test="$poschitzion &gt; 0">
                <tr>
                    <th/>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when
                test="$poschitzion = 0 and not(parent::tei:incident/following-sibling::tei:incident[@type = 'postal'])">
                <tr>
                    <th>
                        <xsl:text>Versand</xsl:text>
                    </th>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when
                test="$poschitzion = 0 and parent::tei:incident/following-sibling::tei:incident[@type = 'postal']">
                <tr>
                    <th>
                        <xsl:text>Versand</xsl:text>
                    </th>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </tr>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:incident[@type = 'receiver']/tei:desc">
        <tr>
            <xsl:variable name="receiver"
                select="substring-before(ancestor::tei:teiHeader//tei:correspDesc/tei:correspAction[@type = 'received']/tei:persName[1], ',')"/>
            <xsl:variable name="poschitzion"
                select="count(parent::tei:incident/preceding-sibling::tei:incident[@type = 'receiver'])"/>
            <xsl:choose>
                <xsl:when test="$poschitzion &gt; 0">
                    <td/>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and parent::tei:incident/following-sibling::tei:incident[@type = 'receiver']">
                    <th>
                        <xsl:value-of select="$receiver"/>
                    </th>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <th>
                        <xsl:value-of select="$receiver"/>
                    </th>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
    </xsl:template>
    <xsl:template match="tei:desc[parent::tei:incident[@type = 'archival']]">
        <tr>
            <xsl:variable name="poschitzion"
                select="count(parent::tei:incident/preceding-sibling::tei:incident[@type = 'archival'])"/>
            <xsl:choose>
                <xsl:when test="$poschitzion &gt; 0">
                    <td/>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and not(parent::tei:incident/following-sibling::tei:incident[@type = 'archival'])">
                    <th>
                        <xsl:text>Ordnung</xsl:text>
                    </th>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and parent::tei:incident/following-sibling::tei:incident[@type = 'archival']">
                    <th>
                        <xsl:text>Ordnung</xsl:text>
                    </th>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
            </xsl:choose>
        </tr>
    </xsl:template>
    <xsl:template match="tei:desc[parent::tei:incident[@type = 'additional-information']]">
        <tr>
            <xsl:variable name="poschitzion"
                select="count(parent::tei:incident/preceding-sibling::tei:incident[@type = 'additional-information'])"/>
            <xsl:choose>
                <xsl:when test="$poschitzion &gt; 0">
                    <td/>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and not(parent::tei:incident/following-sibling::tei:incident[@type = 'additional-information'])">
                    <th>
                        <xsl:text>Zusatz</xsl:text>
                    </th>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and parent::tei:incident/following-sibling::tei:incident[@type = 'additional-information']">
                    <th>
                        <xsl:text>Zusatz</xsl:text>
                    </th>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
            </xsl:choose>
        </tr>
    </xsl:template>
    <xsl:template match="tei:desc[parent::tei:incident[@type = 'editorial']]">
        <tr>
            <xsl:variable name="poschitzion"
                select="count(parent::tei:incident/preceding-sibling::tei:incident[@type = 'editorial'])"/>
            <xsl:choose>
                <xsl:when test="$poschitzion &gt; 0">
                    <td/>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and not(parent::tei:incident/following-sibling::tei:incident[@type = 'editorial'])">
                    <th>Editorischer Hinweis</th>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
                <xsl:when
                    test="$poschitzion = 0 and parent::tei:incident/following-sibling::tei:incident[@type = 'editorial']">
                    <th>Editorischer Hinweise</th>
                    <td>
                        <xsl:value-of select="$poschitzion + 1"/>
                        <xsl:text>) </xsl:text>
                        <xsl:apply-templates/>
                    </td>
                </xsl:when>
            </xsl:choose>
        </tr>
    </xsl:template>
    <xsl:template match="tei:typeDesc">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:typeDesc/tei:p">
        <tr>
            <xsl:choose>
                <xsl:when test="not(preceding-sibling::tei:p)">
                    <th>Typografie</th>
                </xsl:when>
                <xsl:otherwise>
                    <th/>
                </xsl:otherwise>
            </xsl:choose>
            <td>
                <xsl:apply-templates/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="tei:handDesc">
        <xsl:choose>
            <!-- Nur eine Handschrift, diese demnach vom Autor/der Autorin: -->
            <xsl:when test="not(child::tei:handNote[2]) and not(tei:handNote/@corresp)">
                <tr>
                    <th>Handschrift</th>
                    <td>
                        <xsl:value-of select="foo:handNote(tei:handNote)"/>
                    </td>
                </tr>
            </xsl:when>
            <!-- Nur eine Handschrift, diese nicht vom Autor/der Autorin: -->
            <xsl:when test="not(child::tei:handNote[2]) and (tei:handNote/@corresp)">
                <xsl:choose>
                    <xsl:when test="handNote/@corresp = 'schreibkraft'">
                        <tr>
                            <th>Handschrift einer Schreibkraft</th>
                            <td>
                                <xsl:value-of select="foo:handNote(tei:handNote)"/>
                            </td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="sender"
                            select="ancestor::tei:teiHeader[1]/tei:profileDesc[1]/tei:correspDesc[1]/tei:correspAction[@type = 'sent']/tei:persName[@ref = tei:handNote/@corresp]"/>
                        <tr>
                            <th>Handschrift <xsl:value-of select="$sender"/>
                            </th>
                            <td>
                                <xsl:value-of select="foo:handNote(tei:handNote)"/>
                            </td>
                        </tr>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="handDesc-v" select="current()"/>
                <xsl:variable name="sender"
                    select="ancestor::tei:teiHeader[1]/tei:profileDesc[1]/tei:correspDesc[1]/tei:correspAction[@type = 'sent']"
                    as="node()"/>
                <xsl:for-each select="distinct-values(tei:handNote/@corresp)">
                    <xsl:variable name="corespi" select="."/>
                    <xsl:variable name="corespi-name" select="$sender/tei:persName[@ref = $corespi]"/>
                    <xsl:choose>
                        <xsl:when test="count($handDesc-v/tei:handNote[@corresp = $corespi]) = 1">
                            <tr>
                                <th>Handschrift <xsl:value-of
                                        select="foo:vorname-vor-nachname($corespi-name)"/>
                                </th>
                                <td>
                                    <xsl:value-of
                                        select="foo:handNote($handDesc-v/tei:handNote[@corresp = $corespi])"
                                    />
                                </td>
                            </tr>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each select="$handDesc-v/tei:handNote[@corresp = $corespi]">
                                <tr>
                                    <xsl:choose>
                                        <xsl:when test="position() = 1">
                                            <th>Handschrift <xsl:value-of
                                                  select="foo:vorname-vor-nachname($corespi-name)"/>
                                            </th>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <th/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <td>
                                        <xsl:variable name="poschitzon" select="position()"/>
                                        <xsl:value-of select="$poschitzon"/>
                                        <xsl:text>) </xsl:text>
                                        <xsl:value-of select="foo:handNote(current())"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:function name="foo:handNote">
        <xsl:param name="entry" as="node()"/>
        <xsl:choose>
            <xsl:when test="$entry/@medium = 'bleistift'">
                <xsl:text>Bleistift</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@medium = 'roter_buntstift'">
                <xsl:text>roter Buntstift</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@medium = 'blauer_buntstift'">
                <xsl:text>blauer Buntstift</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@medium = 'gruener_buntstift'">
                <xsl:text>grüner Buntstift</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@medium = 'schwarze_tinte'">
                <xsl:text>schwarze Tinte</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@medium = 'blaue_tinte'">
                <xsl:text>blaue Tinte</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@medium = 'gruene_tinte'">
                <xsl:text>grüne Tinte</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@medium = 'rote_tinte'">
                <xsl:text>rote Tinte</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@medium = 'anderes'">
                <xsl:text>anderes Schreibmittel</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="not($entry/@style = 'nicht_anzuwenden')">
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="$entry/@style = 'deutsche-kurrent'">
                <xsl:text>deutsche Kurrentschrift</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@style = 'lateinische-kurrent'">
                <xsl:text>lateinische Kurrentschrift</xsl:text>
            </xsl:when>
            <xsl:when test="$entry/@style = 'gabelsberger'">
                <xsl:text>Gabelsberger Kurzschrift</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="string-length(normalize-space($entry/.)) &gt; 1">
            <xsl:text> (</xsl:text>
            <xsl:apply-templates select="($entry/.)"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:function>
    <xsl:template match="tei:objectDesc/tei:desc[@type = '_blaetter']">
        <xsl:choose>
            <xsl:when test="parent::tei:objectDesc/tei:desc/@type = 'karte'">
                <xsl:choose>
                    <xsl:when test="@n = '1'">
                        <xsl:value-of select="concat(@n, ' Karte')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(@n, ' Karten')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@n = '1'">
                        <xsl:value-of select="concat(@n, ' Blatt')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(@n, ' Blätter')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="string-length(.) &gt; 1">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = '_seiten']">
        <xsl:text>, </xsl:text>
        <xsl:choose>
            <xsl:when test="@n = '1'">
                <xsl:value-of select="concat(@n, ' Seite')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(@n, ' Seiten')"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="string-length(.) &gt; 1">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:if
            test="preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'entwurf' or @type = 'reproduktion'] or following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'entwurf' or @type = 'reproduktion']">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc">
        <xsl:apply-templates
            select="tei:desc[@type = 'karte' or @type = 'bild' or @type = 'kartenbrief' or @type = 'brief' or @type = 'telegramm' or @type = 'widmung' or @type = 'anderes']"/>
        <xsl:apply-templates select="tei:desc[@type = '_blaetter']"/>
        <xsl:apply-templates select="tei:desc[@type = '_seiten']"/>
        <xsl:apply-templates select="tei:desc[@type = 'umschlag']"/>
        <xsl:apply-templates select="tei:desc[@type = 'reproduktion']"/>
        <xsl:apply-templates select="tei:desc[@type = 'entwurf']"/>
        <xsl:apply-templates select="tei:desc[@type = 'fragment']"/>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'karte']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:when test="@subtype = 'bildpostkarte'">
                <xsl:text>Bildpostkarte</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'postkarte'">
                <xsl:text>Postkarte</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'briefkarte'">
                <xsl:text>Briefkarte</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'visitenkarte'">
                <xsl:text>Visitenkarte</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Karte</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type = '_blaetter' or @type = '_seiten']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type = '_blaetter' or @type = '_seiten'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'reproduktion']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:when test="@subtype = 'fotokopie'">
                <xsl:text>Fotokopie</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'fotografische_vervielfaeltigung'">
                <xsl:text>Fotografische Vervielfältigung</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'ms_abschrift'">
                <xsl:text>maschinelle Abschrift</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'hs_abschrift'">
                <xsl:text>handschriftliche Abschrift</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'durchschlag'">
                <xsl:text>maschineller Durchschlag</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Reproduktion</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type='_blaetter' or @type='_seiten']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type='_blaetter' or @type='_seiten'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'widmung']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:when test="@subtype = 'widmung_vorsatzblatt'">
                <xsl:text>Widmung am Vorsatzblatt</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'widmung_titelblatt'">
                <xsl:text>Widmung am Titelblatt</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'widmung_vortitel'">
                <xsl:text>Widmung am Vortitel</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'widmung_schmutztitel'">
                <xsl:text>Widmung am Schmutztitel</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'widmung_umschlag'">
                <xsl:text>Widmung am Umschlag</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Widmung</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'brief']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Brief</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type = '_blaetter']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type = '_blaetter'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'bild']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:when test="@subtype = 'fotografie'">
                <xsl:text>Fotografie</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Bild</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type='_blaetter' or @type='_seiten']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type='_blaetter' or @type='_seiten'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'kartenbrief']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Kartenbrief</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type='_blaetter' or @type='_seiten']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type='_blaetter' or @type='_seiten'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'umschlag']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Umschlag</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'telegramm']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Telegramm</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'anderes']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>XXXXAnderes</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf' or @type = '_blaetter' or @type = '_seiten']) or (preceding-sibling::tei:desc[@type = 'umschlag' or @type = 'fragment' or @type = 'reproduktion' or @type = 'entwurf'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'entwurf']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Entwurf</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if
            test="(following-sibling::tei:desc[@type = 'fragment']) or (preceding-sibling::tei:desc[@type = 'fragment'])">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[@type = 'fragment']">
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 1">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Fragment</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:objectDesc/tei:desc[not(@type)]">
        <xsl:text>XXXX desc-Fehler</xsl:text>
    </xsl:template>
    
     <xsl:template match="tei:date[@*]">
    <!-- <abbr><xsl:attribute name="title"><xsl:value-of select="data(./@*)"/></xsl:attribute>-->
    <xsl:apply-templates/>
    <!--</abbr>-->
  </xsl:template>
  <xsl:template match="tei:term">
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:supplied">
    <xsl:text>[</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]</xsl:text>
  </xsl:template>
  <xsl:template match="tei:hi">
    <xsl:choose>
      <xsl:when test="@rend = 'subscript'">
        <span class="subscript">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:when test="@rend = 'superscript'">
        <span class="superscript">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:when test="@rend = 'italics'">
        <span class="italics">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:when test="@rend = 'underline'">
        <xsl:choose>
          <xsl:when test="@n = '1'">
            <span class="underline">
              <xsl:apply-templates/>
            </span></xsl:when>
          <xsl:when test="@n = '2'">
            <span class="doubleUnderline">
              <xsl:apply-templates/>
            </span></xsl:when>
          <xsl:otherwise>
            <span class="tripleUnderline">
              <xsl:apply-templates/>
            </span></xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@rend = 'pre-print'"><span class="pre-print">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:when test="@rend = 'bold'"><strong>
          <xsl:apply-templates/>
        </strong></xsl:when>
      <xsl:when test="@rend = 'stamp'">
        <span class="stamp">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:when test="@rend = 'small_caps'">
        <span class="small_caps">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:when test="@rend = 'capitals'">
        <span class="uppercase">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:when test="@rend = 'spaced_out'">
        <span class="spaced_out">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:when test="@rend = 'latintype'"><span class="latintype">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:when test="@rend = 'antiqua'">
        <span class="antiqua">
          <xsl:apply-templates/>
        </span></xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:attribute name="class">
            <xsl:value-of select="@rend"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--    footnotes -->
  <xsl:template match="tei:note">
    <xsl:element name="a">
      <xsl:attribute name="name">
        <xsl:text>fna_</xsl:text>
        <xsl:number level="any" format="1" count="tei:note"/>
      </xsl:attribute>
      <xsl:attribute name="href">
        <xsl:text>#fn</xsl:text>
        <xsl:number level="any" format="1" count="tei:note"/>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:attribute>
      <sup>
        <xsl:number level="any" format="1" count="tei:note[./tei:p]"/>
      </sup>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:div">
    <xsl:choose>
      <xsl:when test="@type = 'regest'">
        <div>
          <xsl:attribute name="class">
            <text>regest</text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <!-- transcript -->
      <xsl:when test="@type = 'transcript'">
        <div>
          <xsl:attribute name="class">
            <text>transcript</text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <!-- Anlagen/Beilagen  -->
      <xsl:when test="@xml:id">
        <xsl:element name="div">
          <xsl:attribute name="id">
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- resp -->
  <xsl:template match="tei:respStmt/tei:resp">
    <xsl:apply-templates/>  </xsl:template>
  <xsl:template match="tei:respStmt/tei:name">
    <xsl:for-each select=".">
      <li>
        <xsl:apply-templates/>
      </li>
    </xsl:for-each>
  </xsl:template>
  <!-- reference strings   -->
  <xsl:template match="tei:title[@ref]">
    <xsl:element name="a">
      <xsl:attribute name="class">reference</xsl:attribute>
      <xsl:attribute name="data-type">listtitle.xml</xsl:attribute>
      <xsl:attribute name="data-key">
        <xsl:value-of select="substring-after(data(@ref), '#')"/>
        <xsl:value-of select="@key"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:origPlace[@ref]">
    <xsl:element name="a">
      <xsl:attribute name="class">reference</xsl:attribute>
      <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
      <xsl:attribute name="data-key">
        <xsl:value-of select="substring-after(data(@ref), '#')"/>
        <xsl:value-of select="@key"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:author[@ref]">
    <xsl:element name="a">
      <xsl:attribute name="class">reference</xsl:attribute>
      <xsl:attribute name="data-type">listperson.xml</xsl:attribute>
      <xsl:attribute name="data-key">
        <xsl:value-of select="substring-after(data(@ref), '#')"/>
        <xsl:value-of select="@key"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <!--<xsl:template match="tei:rs[@ref or @key]"><xsl:element name="a"><xsl:attribute name="class">reference</xsl:attribute><xsl:attribute name="data-type"><xsl:value-of select="concat('list', data(@type), '.xml')"/></xsl:attribute><xsl:attribute name="data-key"><xsl:value-of select="substring-after(data(@ref), '#')"/><xsl:value-of select="@key"/></xsl:attribute><xsl:apply-templates/></xsl:element></xsl:template>-->
  <!--<xsl:template match="tei:rs[(@ref or @key) and not(descendant::tei:rs) and not(ancestor::tei:rs)]">
    <xsl:element name="a">
      <xsl:attribute name="class">reference</xsl:attribute>
      <xsl:attribute name="data-type">
        <xsl:value-of select="concat('list', data(@type), '.xml')"/>
      </xsl:attribute>
      <xsl:if test="count(tokenize(data(@ref), '\s+')) = 1">
        <xsl:attribute name="data-key">
          <xsl:value-of select="substring-after(data(@ref), '#')"/>
          <xsl:value-of select="@key"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="count(tokenize(data(@ref), '\s+')) gt 1">
        <xsl:attribute name="data-keys">
          <xsl:value-of select="data(@ref)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>-->
  <!--<xsl:template match="tei:rs[(@ref or @key) and descendant::tei:rs and not(ancestor::tei:rs)]">
    <xsl:variable name="unteres-element">
      <xsl:for-each select="descendant::tei:rs">
        <xsl:variable name="type" select="@type"/>
        <xsl:for-each select="tokenize(@ref, ' ')">
          <xsl:value-of select="$type"/>
          <xsl:text>:</xsl:text>
          <xsl:value-of select="substring-after(., '#')"/>
          <xsl:if test="not(position() = last())">
            <xsl:text> </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="current">
      <xsl:variable name="type" select="@type"/>
      <xsl:for-each select="tokenize(@ref, ' ')">
        <xsl:value-of select="$type"/>
        <xsl:text>:</xsl:text>
        <xsl:value-of select="substring-after(., '#')"/>
        <xsl:if test="not(position() = last())">
          <xsl:text> </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="data-keys" select="concat($current, ' ', $unteres-element)"/>
    <xsl:element name="a">
      <xsl:attribute name="class">reference</xsl:attribute>
      <xsl:choose>
        <xsl:when test="count(tokenize($data-keys, '\s+')) = 1">
          <xsl:attribute name="data-key">
            <xsl:value-of select="substring-after(data(@ref), '#')"/>
            <xsl:value-of select="@key"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="data-keys">
            <xsl:value-of select="$data-keys"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>-->
  <xsl:template match="tei:rs[(@ref or @key) and ancestor::tei:rs]">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:persName[@key]">
    <xsl:element name="a">
      <xsl:attribute name="class">reference</xsl:attribute>
      <xsl:attribute name="data-type">listperson.xml</xsl:attribute>
      <xsl:attribute name="data-key">
        <xsl:value-of select="@key"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:placeName[@key]">
    <xsl:element name="a">
      <xsl:attribute name="class">reference</xsl:attribute>
      <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
      <xsl:attribute name="data-key">
        <xsl:value-of select="@key"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:region[@key] | tei:country[@key]">
    <xsl:element name="a">
      <xsl:attribute name="class">reference</xsl:attribute>
      <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
      <xsl:attribute name="data-key">
        <xsl:value-of select="@key"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <!-- Tabellen -->
  <xsl:template match="tei:table">
    <xsl:element name="table">
      <xsl:if test="@xml:id">
        <xsl:attribute name="id">
          <xsl:value-of select="data(@xml:id)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:text>table editionText</xsl:text>
      </xsl:attribute>
      <xsl:element name="tbody">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:row">
    <xsl:element name="tr">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:cell">
    <xsl:element name="td">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <!-- Überschriften -->
  <xsl:template match="tei:head">
    <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
      <a>
        <xsl:attribute name="name">
          <xsl:value-of select="@xml:id"/>
        </xsl:attribute>
        <xsl:text> </xsl:text>
      </a>
    </xsl:if>
    <a>
      <xsl:attribute name="name">
        <xsl:text>hd</xsl:text>
        <xsl:number level="any"/>
      </xsl:attribute>
      <xsl:text> </xsl:text>
    </a>
    <h3>
      <div>
        <xsl:apply-templates/>
      </div>
    </h3>
  </xsl:template>
  <!--  Quotes / Zitate -->
  <xsl:template match="tei:q">
    <xsl:element name="i">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:quote">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Zeilenumbürche   -->
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>
  <!-- Durchstreichungen -->
  <xsl:template match="tei:origDate[@notBefore and @notAfter]">
    <xsl:variable name="dates">
      <xsl:value-of select="./@*" separator="-"/>
    </xsl:variable>
    <abbr title="{$dates}">
      <xsl:value-of select="."/>
    </abbr>
  </xsl:template>
  <xsl:template match="tei:extent">
    <xsl:apply-templates select="./tei:measure"/>
    <xsl:apply-templates select="./tei:dimensions"/>
  </xsl:template>
  <xsl:template match="tei:measure">
    <xsl:variable name="x">
      <xsl:value-of select="./@type"/>
    </xsl:variable>
    <xsl:variable name="y">
      <xsl:value-of select="./@quantity"/>
    </xsl:variable>
    <abbr title="type: {$x}, quantity: {$y}">Measure</abbr>: <xsl:value-of select="./text()"/>
    <br/>
  </xsl:template>
  <xsl:template match="tei:dimensions">
    <xsl:variable name="x">
      <xsl:value-of select="./@type"/>
    </xsl:variable>
    <xsl:variable name="y">
      <xsl:value-of select="./@unit"/>
    </xsl:variable>
    <abbr title="type: {$x}">Dimensions:</abbr> h: <xsl:value-of select="./tei:height/text()"/>
    <xsl:value-of select="$y"/>, w: <xsl:value-of select="./tei:width/text()"/>
    <xsl:value-of select="$y"/>
    <br/>
  </xsl:template>
  <xsl:template match="tei:layoutDesc">
    <xsl:for-each select="tei:layout">
      <div>
        <xsl:value-of select="./@columns"/> Column(s) à <xsl:value-of
          select="./@ruledLines | ./@writtenLines"/> ruled/written lines: <xsl:apply-templates/>
      </div>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="tei:locus">
    <xsl:variable name="folio-from-id">
      <xsl:value-of select="./@from"/>
    </xsl:variable>
    <xsl:variable name="folio-to-id">
      <xsl:value-of select="./@to"/>
    </xsl:variable>
    <xsl:variable name="url-from-facs">
      <xsl:value-of select="./ancestor::tei:TEI//tei:graphic[@n = $folio-from-id]/@url"/>
    </xsl:variable>
    <xsl:variable name="url-to-facs">
      <xsl:value-of select="./ancestor::tei:TEI//tei:graphic[@n = $folio-to-id]/@url"/>
    </xsl:variable>
    <a href="{$url-from-facs}">
      <xsl:value-of select="$folio-from-id"/>
    </a>-<a href="{$url-to-facs}">
      <xsl:value-of select="./@to"/>
    </a>
  </xsl:template>
  <xsl:template match="tei:handDesc">
    <xsl:for-each select="./tei:handNote">
      <div>
        <xsl:apply-templates/>
      </div>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="tei:title">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:title[ancestor::tei:fileDesc[1]/tei:titleStmt[1] and @level = 'a']">
    <div id="titleForNavigation">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:scriptDesc">
    <xsl:for-each select="./tei:scriptNote">
      <div> Type: <xsl:value-of select="./@script"/>
        <xsl:apply-templates/>
      </div>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="tei:bindingDesc">
    <xsl:for-each select="./tei:binding">
      <div> Date: <xsl:value-of select="./@notBefore"/>-<xsl:value-of select="./@notAfter"/>
        <xsl:apply-templates/>
      </div>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="tei:list">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  <xsl:template match="tei:item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <xsl:template match="descendant::tei:teiHeader/descendant::tei:sourceDesc/tei:listBibl">
    <xsl:for-each select=".//tei:bibl">
      <li>
        <xsl:apply-templates/>
      </li>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="tei:ptr">
    <xsl:variable name="x">
      <xsl:value-of select="./@target"/>
    </xsl:variable>
    <a href="{$x}" class="fas fa-link"/>
  </xsl:template>
  <xsl:template match="tei:msPart">
    <xsl:variable name="x">
      <xsl:number count="." level="any"/>
    </xsl:variable>
    <div class="card-header" id="mspart_{$x}">
      <div class="card-header">
        <h4 align="center">
          <xsl:value-of select="./tei:msIdentifier"/>
          <xsl:value-of select="./tei:head"/>
        </h4>
      </div>
      <div class="card-body">
        <xsl:apply-templates select=".//tei:msContents"/>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="tei:msContents">
    <xsl:for-each select=".//tei:msItem">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="tei:msItem">
    <xsl:variable name="x">
      <xsl:number level="any" count="tei:msItem"/>
    </xsl:variable>
    <h5 id="msitem_{$x}"> Manuscript Item Nr: <xsl:value-of select="$x"/>
    </h5>
    <table class="table table-condensed table-bordered">
      <thead>
        <tr>
          <th width="20%">Key</th>
          <th>Value</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>locus</th>
          <td>
            <xsl:apply-templates select="./tei:locus"/>
          </td>
        </tr>
        <xsl:if test="./tei:note">
          <tr>
            <th>notes</th>
            <td>
              <xsl:apply-templates select="./tei:note"/>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="./tei:author">
          <tr>
            <th>author</th>
            <td>
              <xsl:apply-templates select="./tei:author"/>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="./tei:title">
          <tr>
            <th>title</th>
            <td>
              <xsl:apply-templates select="./tei:title"/>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="./tei:incipit">
          <tr>
            <th>incipit</th>
            <td>
              <xsl:apply-templates select="./tei:incipit"/>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="./tei:explicit">
          <tr>
            <th>explicit</th>
            <td>
              <xsl:apply-templates select="./tei:explicit"/>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="./tei:finalRubric">
          <tr>
            <th>finalRubric</th>
            <td>
              <xsl:apply-templates select="./tei:finalRubric"/>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="./tei:bibl">
          <tr>
            <th>Bibliography</th>
            <td>
              <xsl:apply-templates select="./tei:bibl"/>
            </td>
          </tr>
        </xsl:if>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="tei:gi">
    <code>
      <xsl:apply-templates/>
    </code>
  </xsl:template>
  <xsl:function name="foo:dots">
    <xsl:param name="anzahl"/> . <xsl:if test="$anzahl &gt; 1">
      <xsl:value-of select="foo:dots($anzahl - 1)"/>
    </xsl:if>
  </xsl:function>
  <xsl:function name="foo:gaps">
    <xsl:param name="anzahl"/>
    <xsl:text>×</xsl:text>
    <xsl:if test="$anzahl &gt; 1">
      <xsl:value-of select="foo:gaps($anzahl - 1)"/>
    </xsl:if>
  </xsl:function>
  <xsl:template match="tei:gap[@unit = 'chars' and @reason = 'illegible']">
    <span class="illegible">
      <xsl:value-of select="foo:gaps(@quantity)"/>
    </span>
  </xsl:template>
  <xsl:template match="tei:gap[@unit = 'lines' and @reason = 'illegible']">
    <div class="illegible">
      <xsl:text> [</xsl:text>
      <xsl:value-of select="@quantity"/>
      <xsl:text> Zeilen unleserlich] </xsl:text>
    </div>
  </xsl:template>
  <xsl:template match="tei:gap[@reason = 'outOfScope']">
    <span class="outOfScope">[…]</span>
  </xsl:template>
  <xsl:template match="tei:p[child::tei:space[@dim] and not(child::*[2]) and empty(text())]">
    <br/>
  </xsl:template>
  <xsl:template match="tei:p[parent::tei:quote]">
    <xsl:apply-templates/>
    <xsl:if test="not(position() = last())">
      <xsl:text> / </xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:function name="foo:verticalSpace">
    <xsl:param name="anzahl"/>
    <br/>
    <xsl:if test="$anzahl &gt; 1">
      <xsl:value-of select="foo:verticalSpace($anzahl - 1)"/>
    </xsl:if>
  </xsl:function>
  <xsl:template match="tei:space[@dim = 'vertical' and not(@unit)]">
    <xsl:element name="div">
      <xsl:attribute name="style">
        <xsl:value-of select="concat('padding-bottom:', @quantity, 'em;')"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="tei:space[@unit = 'chars' and not(@quantity = 1)]">
    <xsl:variable name="weite" select="0.5 * @quantity"/>
    <xsl:element name="span">
      <xsl:attribute name="style">
        <xsl:value-of select="concat('display:inline-block; width: ', $weite, 'em; ')"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tei:opener">
    <div class="opener">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:add[@place and not(parent::tei:subst)]">
    <span class="steuerzeichen">↓</span>
    <span class="add">
      <xsl:apply-templates/>
    </span>
    <span class="steuerzeichen">↓</span>
  </xsl:template>
  <!-- Streichung -->
  <xsl:template match="tei:del[not(parent::tei:subst)]">
    <span class="del">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:del[parent::tei:subst]">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Substi -->
  <xsl:template match="tei:subst">
    <span class="steuerzeichen">↑</span>
    <span class="superscript">
      <xsl:apply-templates select="tei:del"/>
    </span>
    <span class="subst-add">
      <xsl:apply-templates select="tei:add"/>
    </span>
    <span class="steuerzeichen">↓</span>
  </xsl:template>
  <!-- Wechsel der Schreiber <handShift -->
  <xsl:template match="tei:handShift[not(@scribe)]">
    <xsl:choose>
      <xsl:when test="@medium = 'typewriter'">
        <xsl:text>[ms.:] </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[hs.:] </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:handShift[@scribe]">
    <xsl:variable name="scribe">
      <xsl:choose>
        <xsl:when test="contains(@scribe, 'pmb')">
          <xsl:value-of select="replace(@scribe, 'pmb', '')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@scribe"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="//tei:correspAction//tei:persName[replace(@ref, 'pmb', '') = $scribe]">
        <xsl:text>[hs. </xsl:text>
        <xsl:value-of
          select="foo:vorname-vor-nachname(//tei:correspAction//tei:persName[replace(@ref, 'pmb', '') = $scribe])"/>
        <xsl:text>:] </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[Schreiberwechsel:] </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:function name="foo:vorname-vor-nachname">
    <xsl:param name="autorname"/>
    <xsl:choose>
      <xsl:when test="contains($autorname, ', ')">
        <xsl:value-of select="substring-after($autorname, ', ')"/>
        <xsl:text> </xsl:text>
        <xsl:text> </xsl:text>
        <xsl:value-of select="substring-before($autorname, ', ')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$autorname"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:template match="tei:salute[parent::tei:opener]">
    <p>
      <div class="editionText salute">
        <xsl:apply-templates/>
      </div>
    </p>
  </xsl:template>
  <xsl:template match="tei:signed">
    <div class="signed editionText">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template
    match="tei:p[ancestor::tei:body and not(ancestor::tei:note) and not(ancestor::tei:footNote) and not(ancestor::tei:caption) and not(parent::tei:bibl) and not(parent::tei:quote) and not(child::tei:space[@dim])] | tei:dateline | tei:closer">
    <xsl:choose>
      <xsl:when test="child::tei:seg">
        <div class="editionText">
          <span class="seg-left">
            <xsl:apply-templates select="tei:seg[@rend = 'left']"/>
          </span>
          <xsl:text> </xsl:text>
          <span class="seg-right">
            <xsl:apply-templates select="tei:seg[@rend = 'right']"/>
          </span>
        </div>
      </xsl:when>
      <xsl:when test="@rend = 'right'">
        <div align="right" class="editionText">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="@rend = 'left'">
        <div align="left" class="editionText">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="@rend = 'center'">
        <div align="center" class="editionText">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="@rend = 'inline'">
        <div class="inline editionText">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      
      <xsl:otherwise>
        <div class="editionText">
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template
    match="tei:p[not(parent::tei:quote) and (ancestor::tei:note or ancestor::tei:footNote or ancestor::tei:caption or parent::tei:bibl)]">
    <xsl:choose>
      <xsl:when test="@rend = 'right'">
        <div align="right">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="@rend = 'left'">
        <div align="left">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="@rend = 'center'">
        <div align="center">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="@rend = 'inline'">
        <div style="inline">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div>
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:div[not(@type = 'address')]">
    <div class="div">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:div[@type = 'address']">
    <div class="address-div">
      <xsl:apply-templates/>
    </div>
    <br/>
  </xsl:template>
  <xsl:template match="tei:address">
    <div class="column">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:addrLine">
    <div class="addrLine">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:damage">
    <span class="damage-critical">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:unclear">
    <span class="unsicher">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:lg[@type = 'poem' and not(descendant::lg[@type = 'stanza'])]">
    <div class="poem editionText">
      <ul>
        <xsl:apply-templates/>
      </ul>
    </div>
  </xsl:template>
  <xsl:template match="tei:lg[@type = 'poem' and descendant::lg[@type = 'stanza']]">
    <div class="poem editionText">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:lg[@type = 'stanza']">
    <ul>
      <xsl:apply-templates/>
    </ul>
    <xsl:if test="not(position() = last())">
      <br/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:l">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <xsl:template match="tei:back"/>
</xsl:stylesheet>
