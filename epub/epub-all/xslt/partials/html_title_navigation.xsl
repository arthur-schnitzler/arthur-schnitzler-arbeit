<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xsl tei xs" version="2.0">
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget add_header-navigation-custom-title.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied in html:body.</p>
            <p>The template "add_header-navigation-custom-title" creates a custom header without
                using tei:title but includes prev and next urls.</p>
        </desc>
    </doc>
    <xsl:template name="header-nav">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@level = 'a'][1]/text()"/>
        </xsl:variable>
        <xsl:variable name="prev">
            <xsl:value-of
                select="concat(descendant::tei:correspDesc/tei:correspContext/tei:ref[@type = 'withinCollection' and @subtype = 'previous_letter'][1]/@target, '.html')"
            />
        </xsl:variable>
        <xsl:variable name="next">
            <xsl:value-of
                select="concat(descendant::tei:correspDesc/tei:correspContext/tei:ref[@type = 'withinCollection' and @subtype = 'next_letter'][1]/@target, '.html')"
            />
        </xsl:variable>
        <div class="row hide-reading" id="title-nav">
            <div class="col-md-2">
                <xsl:if test="not(starts-with($prev, '.html'))">
                    <h1>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="$prev"/>
                            </xsl:attribute>
                            <svg class="arrow svg-inline--fa fa-chevron-left fa-w-10"
                                title="previous" aria-labelledby="svg-inline--fa-title-1"
                                data-prefix="fas" data-icon="chevron-left" role="img"
                                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"
                                data-fa-i2svg="">
                                <title id="svg-inline--fa-title-1">previous</title>
                                <path fill="currentColor"
                                    d="M34.52 239.03L228.87 44.69c9.37-9.37 24.57-9.37 33.94 0l22.67 22.67c9.36 9.36 9.37 24.52.04 33.9L131.49 256l154.02 154.75c9.34 9.38 9.32 24.54-.04 33.9l-22.67 22.67c-9.37 9.37-24.57 9.37-33.94 0L34.52 272.97c-9.37-9.37-9.37-24.57 0-33.94z"
                                />
                            </svg>
                            <!-- <i class="fas fa-chevron-left" title="previous"></i> -->
                        </a>
                    </h1>
                </xsl:if>
            </div>
            <div class="col-md-8">
                <h3 style="text-align:center;">
                    <h2 align="center">
                        <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title[@level = 'a']">
                            <xsl:apply-templates/>
                            <br/>
                        </xsl:for-each>
                    </h2>
                </h3>
            </div>
            <div class="col-md-2" style="text-align:right;">
                <xsl:if test="not(starts-with($next, '.html'))">
                    <h1 style="text-align:right;">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="$next"/>
                            </xsl:attribute>
                            <svg class="arrow svg-inline-\-fa fa-chevron-right fa-w-10" title="next"
                                aria-labelledby="svg-inline-\-fa-title-2" data-prefix="fas"
                                data-icon="chevron-right" role="img"
                                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"
                                data-fa-i2svg="">
                                <title id="svg-inline-\-fa-title-2">next</title>
                                <path fill="currentColor"
                                    d="M285.476 272.971L91.132 467.314c-9.373 9.373-24.569 9.373-33.941 0l-22.667-22.667c-9.357-9.357-9.375-24.522-.04-33.901L188.505 256 34.484 101.255c-9.335-9.379-9.317-24.544.04-33.901l22.667-22.667c9.373-9.373 24.569-9.373 33.941 0L285.475 239.03c9.373 9.372 9.373 24.568.001 33.941z"
                                />
                            </svg>
                        </a>
                    </h1>
                </xsl:if>
            </div>
        </div>
        <!-- .row -->
        <!-- .card-header -->
    </xsl:template>
</xsl:stylesheet>
