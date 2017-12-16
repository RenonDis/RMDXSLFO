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

        <fo:simple-page-master master-name="middlePage"
                            page-height="29.7cm"
                            page-width="21cm"
                            margin="1cm">
            <fo:region-body margin-top="1.6cm"
                            margin-bottom="1.6cm"
                            background-color="#EEE"/>
            <fo:region-before extent="1.5cm"/>
            <fo:region-after extent="1.5cm"/>
        </fo:simple-page-master>

    </fo:layout-master-set>

    <fo:page-sequence master-reference="firstPage">

        <fo:static-content flow-name="xsl-region-after" font-size="100%">
            <fo:block   font-style="italic"
                        text-align-last="justify"
                        space-after="5cm">
                Auteur : Florentin Vallée
                <fo:leader leader-pattern="space"/>Professeur : Pr Daniel Muller
            </fo:block>
            <fo:block text-align="center">16/12/2017</fo:block>
        </fo:static-content>

        <fo:flow flow-name="first-body" text-align="center">
            <fo:block space-after="1cm">
                <fo:external-graphic src="url(LogoECL.png)" content-width="12cm"/>
            </fo:block>
            <fo:block   font-size="3em"
                        padding-bottom="1em"
                        border-bottom="0.5pt solid black">
                Statistiques des trains 
            </fo:block>
            <fo:block   font-size="2em"
                        space-before="2em">
                BE XSL-FO
            </fo:block>
        </fo:flow>
    </fo:page-sequence>

    <fo:page-sequence master-reference="middlePage">

        <fo:flow flow-name="xsl-region-body">
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
