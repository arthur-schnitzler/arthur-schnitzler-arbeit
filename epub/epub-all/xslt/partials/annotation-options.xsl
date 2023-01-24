<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsl tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget annotation options.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with call-templates in html:body.</p>
            <p>Custom template to create interactive options for text annoations.</p>
        </desc>    
    </doc>
    
    <xsl:template name="annotation-options">
        <div class="row">
            <div class="col-md-12">
                <div class="navBarLetters text-center">                                            
                    <table class="table" style="margin-bottom:0;">
                        <tbody>           
                            <tr>         
                                <td style="width:5%;border: 1px dashed #dedede;">
                                    <full-size opt="edition-fullsize"></full-size> 
                                </td>
                                <td style="text-align:center;width:5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;"> 
                                    <image-switch opt="edition-switch"></image-switch>
                                </td>
                                <td style="text-align:left;width:10%;border: 1px dashed #dedede;border-right: 1px dashed #dedede;"> 
                                    <font-size opt="select-fontsize"></font-size> 
                                </td>
                                <td style="text-align:left;width:15%;border: 1px dashed #dedede;border-right: 1px dashed #dedede;">
                                    <font-family opt="select-font"></font-family> 
                                </td>
                                <td style="margin-bottom:-2em;text-align:center;width:15%;border-top: 1px dashed #dedede;border-right: 1px dashed #dedede;">   
                                    <annotation-slider opt="text-features"></annotation-slider> 
                                </td>
                                <td style="text-align:center;width:12.5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;">     
                                    <annotation-slider opt="deleted"></annotation-slider>  
                                </td>
                                <td style="text-align:center;width:12.5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;">   
                                    <annotation-slider opt="unclear"></annotation-slider>  
                                </td>
                                <td style="text-align:center;width:12.5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;">     
                                    <annotation-slider opt="underlined"></annotation-slider>      
                                </td>
                                <td style="text-align:center;width:12.5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;border-right: 1px dashed #dedede;">  
                                    <annotation-slider opt="whitespace"></annotation-slider>   
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 1px dashed #dedede;height:80px;"></td>
                                <td style="border: 1px dashed #dedede;"></td>
                                <td style="border: 1px dashed #dedede;"></td>
                                <td style="border: 1px dashed #dedede;"></td>
                                <td style="border-bottom: 1px dashed #dedede;border-right: 1px dashed #dedede;"></td>
                                <td style="text-align:center;width:12.5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;">
                                    <annotation-slider opt="persons"></annotation-slider>
                                </td>
                                <td style="text-align:center;width:12.5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;">
                                    <annotation-slider opt="places"></annotation-slider>
                                </td>
                                <td style="text-align:center;width:12.5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;">
                                    <annotation-slider opt="orgs"></annotation-slider>
                                </td>
                                <td style="text-align:center;width:12.5%;border-top: 1px dashed #dedede;border-bottom: 1px dashed #dedede;border-right: 1px dashed #dedede;">
                                    <annotation-slider opt="works"></annotation-slider>
                                </td>
                            </tr> 
                        </tbody>
                    </table>   
                </div>
            </div>
        </div>
        
    </xsl:template>
</xsl:stylesheet>