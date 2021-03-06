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
            <fo:retrieve-marker retrieve-class-name="surFooter" retrieve-position="first-starting-within-page"/>
            <fo:block text-align="center">16/12/2017</fo:block>
        </fo:static-content>

        <fo:flow flow-name="first-body" text-align="center">
            <fo:block>
                <!-- surFooter for the first page -->
                <fo:marker marker-class-name="surFooter">
                    <fo:block   font-style="italic"
                                text-align-last="justify"
                                space-after="5cm">
                        Auteur : Florentin Vallée
                        <fo:leader leader-pattern="space"/>Professeur : Pr Daniel Muller
                    </fo:block>
                </fo:marker>
            </fo:block>
            
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
            <xsl:apply-templates select="axe"/>
        </fo:flow>
    </fo:page-sequence>
</fo:root>

</xsl:template>

<!-- Building table layout -->
<xsl:template match="axe">
    <fo:block
        text-indent="2em"
        font-size="1.2em"
        font-weight="bold"
        space-before="2em"
        padding="1em">
        Axe <xsl:value-of select="@nom"/>
    </fo:block>
    <xsl:for-each select=".//gare-arrivee">
    <fo:block font-size="0.7em">

    <fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="1cm"/>
        <fo:table-column column-width="from-parent(width)-2cm"/>
        <fo:table-column column-width="1cm"/>
        <fo:table-body>
            <fo:table-row>
                <fo:table-cell><fo:block/></fo:table-cell>
            <fo:table-cell>
                <xsl:call-template name="coreTable"/>
            </fo:table-cell>
                <fo:table-cell><fo:block/></fo:table-cell>
            </fo:table-row>
        </fo:table-body>
    </fo:table>
    <fo:block break-after="page"/>
    </fo:block>
    </xsl:for-each>
</xsl:template>


<!-- Building core table -->
<xsl:template name="coreTable">
<fo:table 
    table-layout="fixed"
    width="100%"
    text-align="center"
    space-before="1em">
<fo:table-header>
  <fo:table-row>
    <fo:table-cell number-columns-spanned="7"
                   border="none"
                   padding="1em"
                   color="#880000">
        <fo:block padding="0.5em">
            De <xsl:value-of select="@nom"/> à <xsl:value-of select="../@nom"/>
        </fo:block>
    </fo:table-cell>
  </fo:table-row>
  <fo:table-row>
  <xsl:for-each select="mesure[position()=1]/@*[name()!='commentaire']">
      <fo:table-cell    border="0.5pt solid black"
                        font-size="1em"
                        padding="0.3em"
                        background-color="#CCC">
          <fo:block>
              <xsl:value-of select="name()"/>
          </fo:block>
      </fo:table-cell>
  </xsl:for-each>
  </fo:table-row>
</fo:table-header>
<fo:table-body>
    <xsl:for-each select="mesure">
        <xsl:sort select="@annee"/>
        <xsl:sort select="@mois"/>

	<xsl:variable name="bgclr">
	    <xsl:choose>
	        <xsl:when test="position() mod 2">#FFF</xsl:when>
	        <xsl:otherwise>#A7BFDE</xsl:otherwise>
	    </xsl:choose>
	</xsl:variable>

        <fo:table-row   keep-with-next="always"
                        background-color="{$bgclr}">
        <xsl:for-each select="@*[name()!='commentaire']">
            <fo:table-cell border="0.5pt solid black" font-size="0.8em">
                <fo:block>
                    <xsl:value-of select="."/>
                </fo:block>
            </fo:table-cell>
        </xsl:for-each>
        </fo:table-row>

        <xsl:if test="@commentaire!=''">
        <fo:table-row background-color="{$bgclr}">
            <fo:table-cell 	number-columns-spanned="7" 
				font-size="0.7em" 
				border="0.5pt solid black">
                <fo:block page-break-inside="avoid">
                    '-> <xsl:value-of select="@commentaire"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
        </xsl:if>

    </xsl:for-each>
</fo:table-body>
</fo:table>
</xsl:template>

</xsl:stylesheet>
