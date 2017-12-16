<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:output method="xml"/>

<xsl:template match="/regularite-tgv">

<fo:root>
    <fo:layout-master-set>
        <fo:simple-page-master master-name="firstPage"
                            page-height="29.7cm"
                            page-width="21cm"
                            margin="2cm">
            <fo:region-body margin-top="5cm"
                            region-name="first-body"
                            margin-bottom="6cm"/>
            <fo:region-before extent="4cm"/>
            <fo:region-after extent="7cm"/>
        </fo:simple-page-master>

    </fo:layout-master-set>

    <fo:page-sequence master-reference="firstPage">


        <fo:flow flow-name="first-body" text-align="center">
            <fo:block>
                <xsl:for-each select="axe">
                    <fo:block   font-size="2em"
                                padding="0.3em"
                                background-color="#CCC"
                                space-after="1em">
                        <xsl:value-of select="@nom"/>
                    </fo:block>
                </xsl:for-each>
            
            </fo:block>
        </fo:flow>
    </fo:page-sequence>

</fo:root>

</xsl:template>


</xsl:stylesheet>
