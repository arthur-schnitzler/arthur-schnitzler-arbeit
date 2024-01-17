<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Match the root element to start the transformation -->
    <xsl:template match="/">
        <!-- Output CSV header -->
        <xsl:text>id,name,duplicate&#10;</xsl:text>
        <!-- Apply transformation to each row element -->
        <xsl:apply-templates select="//row"/>
    </xsl:template>
    
    <!-- Match each row element and output CSV lines -->
    <xsl:template match="row">
        <!-- Extract values from the XML elements -->
        <xsl:variable name="id" select="id"/>
        <xsl:variable name="name" select="name"/>
        <xsl:variable name="duplicate" select="duplicate"/>
        
        <!-- Output CSV line -->
        <xsl:value-of select="concat($id, ',', $name, ',', $duplicate)"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
