<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:_="urn:acdh"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsl tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget tei-facsimile.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with call-templates in html:body.</p>
            <p>The template "view type" generates various view types e.g. reading, diplomatic,
                commentary.</p>
            <p>Select between a type with or without images.</p>
            <p>Bootstrap is required.</p>
        </desc>
    </doc>
    <xsl:function name="_:ano">
        <xsl:param name="node"/>
        <xsl:for-each-group select="$node" group-by="$node">
            <xsl:sequence
                select="concat('(', count(current-group()[current-grouping-key() = .]), ' ', current-grouping-key(), ')')"
            />
        </xsl:for-each-group>
    </xsl:function>
    <xsl:template name="view-type-img">
        <xsl:variable name="hand" select="'font-family: Times New Roman, serif; font-size: 22px;'"/>
        <xsl:variable name="typed" select="'font-family: Courier New, monospace; font-size: 18px;'"/>
        <xsl:variable name="printed" select="'font-family: Arial, serif; font-size: 18px;'"/>
        <div class="pagination-top">
            <xsl:call-template name="view-pagination"/>
        </div>
        <div class="tab-content">
            <xsl:choose>
                <xsl:when
                    test="descendant::tei:pb[1]/@facs and not(starts-with(descendant::tei:pb[1]/@facs, 'http') or starts-with(descendant::tei:pb[1]/@facs, 'www.')) and not(contains(descendant::tei:pb[1]/@facs, '.pdf'))">
                    <div class="pagination-tab tab-pane active" data-tab="paginate"  id="paginate-{position()}" tabindex="-1">
                        <window-resize opt="resizing" pos="{position()}"/>
                        <div id="container-resize-{position()}" class="transcript row">
                            <div id="text-resize-{position()}" class="text-re col-md-6">
                                <div class="card-body">
                                    <xsl:apply-templates select="//tei:text"/>
                                    <xsl:element name="ol">
                                        <xsl:attribute name="class">
                                            <xsl:text>list-for-footnotes</xsl:text>
                                        </xsl:attribute>
                                        <xsl:apply-templates select="descendant::tei:footNote"
                                            mode="footnote"/>
                                    </xsl:element>
                                </div>
                            </div>
                            <div id="img-resize-{position()}"
                                class="col-md-6 card-header osd-viewer"
                                style="padding: 1em;background-color: #dedede;">
                                <!--<hr/> -->
                                <xsl:variable name="osd_container_id"
                                    select="concat(@type, '_container_', position())"/>
                                <xsl:variable name="osd_container_id2"
                                    select="concat(@type, '_container2_', position())"/>
                                    <xsl:variable name="facsimiles">
                                        <xsl:value-of
                                            select="distinct-values(descendant::tei:pb[not(starts-with(@facs, 'http') or starts-with(@facs, 'www.') or @facs = '' or empty(@facs)) and not(preceding-sibling::tei:tp/@facs = @facs) or (not(@facs))]/@facs)"
                                        />
                                    </xsl:variable>
                                    <xsl:variable name="url-of-facsimile">
                                        <xsl:for-each select="tokenize($facsimiles, ' ')">
                                            <xsl:text>"https://iiif.acdh-dev.oeaw.ac.at/iiif/images/schnitzler-briefe/</xsl:text>
                                            <xsl:value-of select="."/>
                                            <xsl:text>.jp2/info.json"</xsl:text>
                                            <xsl:if test="not(position() = last())">
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    <div id="openseadragon-photo" style="height:800px;">
                                        <script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/3.0.0/openseadragon.min.js"/>
                                        <script type="text/javascript">
                                            var viewer = OpenSeadragon({
                                            id: "openseadragon-photo",
                                            protocol: "http://iiif.io/api/image",
                                            prefixUrl: "https://cdnjs.cloudflare.com/ajax/libs/openseadragon/3.0.0/images/",
                                            sequenceMode: true,
                                            showNavigationControl: true,
                                            showReferenceStrip: true,
                                            defaultZoomLevel: 0,
                                            fitHorizontally: true,
                                            tileSources:[<xsl:value-of select="$url-of-facsimile"/>
                                            ],
                                            // Initial rotation angle
                                            degrees: 0,
                                            // Show rotation buttons
                                            showRotationControl: true,
                                            // Enable touch rotation on tactile devices
                                            gestureSettingsTouch: {
                                            pinchRotate: true
                                            }
                                            });</script>
                                        <div class="image-rights">
                                            <xsl:text>Bildrechte © </xsl:text>
                                            <xsl:value-of
                                                select="//tei:fileDesc/tei:sourceDesc[1]/tei:listWit[1]/tei:witness[1]/tei:msDesc[1]/tei:msIdentifier[1]/tei:repository[1]"/>
                                            <xsl:text>, </xsl:text>
                                            <xsl:value-of
                                                select="//tei:fileDesc/tei:sourceDesc[1]/tei:listWit[1]/tei:witness[1]/tei:msDesc[1]/tei:msIdentifier[1]/tei:settlement[1]"
                                            />
                                        </div>
                                    </div>
                                
                            </div>
                        </div>
                    </div>
                </xsl:when>
                
                    <xsl:otherwise>
                        <div class="card-body-normalertext">
                            <xsl:apply-templates select="//tei:text"/>
                        </div>
                    </xsl:otherwise>
                
            </xsl:choose>
        </div>
        <div class="pagination-bottom">
            <xsl:call-template name="view-pagination"/>
        </div>
    </xsl:template>
</xsl:stylesheet>
