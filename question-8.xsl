<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:output method="xml"/>

<xsl:param name="today"/>

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
                            background-color="#FFF"/>
            <fo:region-before extent="1.5cm"/>
            <fo:region-after extent="1cm"/>
        </fo:simple-page-master>

    </fo:layout-master-set>

    <fo:page-sequence master-reference="firstPage">

        <fo:static-content flow-name="xsl-region-after" font-size="100%">
            <fo:retrieve-marker retrieve-class-name="surFooter" retrieve-position="first-starting-within-page"/>
            <fo:block text-align="center">
                <xsl:value-of select="$today"/>
            </fo:block>
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
            
            <fo:block>
                <!-- surFooter for the other first page -->
                <fo:marker marker-class-name="surFooter">
                    <fo:block text-align="center" 
                            space-after="5cm">
                        Cliquez sur les titres pour accéder à la page
                    </fo:block>
                </fo:marker>
            </fo:block>

            <fo:block space-after="1cm">
                <fo:external-graphic src="url(LogoECL.png)" content-width="12cm"/>
            </fo:block>
            <fo:block   font-size="3em"
                        padding-bottom="1em"
                        border-bottom="0.5pt solid black">
                Régularité mensuelle du TGV 
            </fo:block>
            <fo:block   font-size="2em"
                        space-before="2em">
                BE XSL-FO
            </fo:block>
		<xsl:call-template name="genTOC"/>
        </fo:flow>
    </fo:page-sequence>

    <fo:page-sequence master-reference="middlePage" initial-page-number="1">

        <!-- header -->
        <fo:static-content flow-name="xsl-region-before" font-size="90%">
            <!-- main header on every page -->
            <fo:block   border-bottom="0.5pt solid black"
                        text-align-last="justify">
                Régularité mensuelle du TGV 
                <fo:leader leader-pattern="space"/><fo:page-number/>
            </fo:block>
            <!-- sub header -->
            <fo:retrieve-marker retrieve-class-name="subHeader" retrieve-position="first-starting-within-page"/>
        </fo:static-content>

        <!-- footer -->
        <fo:static-content flow-name="xsl-region-after" font-size="90%">
            <!-- special footer -->
            <fo:retrieve-marker retrieve-class-name="footer" retrieve-position="first-starting-within-page"/>
            <!-- common footer on every page -->
            <fo:block>Date d'impression : 
                <xsl:value-of select="$today"/>
            </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">

            <xsl:apply-templates select="axe"/>
        </fo:flow>
    </fo:page-sequence>
</fo:root>

</xsl:template>

<!-- Building Table of Contents -->
<xsl:template name="genTOC">
  <fo:block break-before='page'>
    <fo:block font-size="16pt" font-weight="bold" space-after="2em">
	TABLE DES MATIÈRES
    </fo:block>
    <xsl:for-each select="//axe">
      <fo:block text-align-last="justify" space-after="1em">
        <fo:basic-link internal-destination="{generate-id(.)}">
          <xsl:text> Axe </xsl:text>
          <xsl:value-of select="@nom"/> 
          <xsl:text>  </xsl:text>
          <fo:leader leader-pattern="dots" leader-pattern-width="0.2cm"/>
          <fo:page-number-citation ref-id="{generate-id(.)}" />
        </fo:basic-link>
      </fo:block>
    </xsl:for-each>
  </fo:block>
</xsl:template>

<!-- Building table layout -->
<xsl:template match="axe">
            <fo:block id="{generate-id(.)}">
                <!-- sub header for the not-first pages -->
                <fo:marker marker-class-name="subHeader">
                    <fo:block space-before="0.3em">
        		Axe <xsl:value-of select="@nom"/>
		    </fo:block>
                </fo:marker>
            </fo:block>
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
    <fo:block break-after="page" margin-left="0.5cm" margin-top="2cm">
	<xsl:call-template name="svgdisp"/>
    </fo:block>
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
            De <xsl:value-of select="../@nom"/> à <xsl:value-of select="@nom"/>
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

<!-- Building SVG -->
<xsl:template name="svgdisp">

    <fo:block      padding="1em"
                   space-before="5cm"
                   text-align="center"
                   color="#880000">
            Retards du <xsl:value-of select="../@nom"/> - <xsl:value-of select="@nom"/>
    </fo:block>

<xsl:variable name="globWidth" select="1200"/>
<xsl:variable name="globHeight" select="700"/>

<xsl:variable name="maxsatisf">
  <xsl:for-each select="mesure">
    <xsl:sort select="@retards" data-type="number"/>
    <xsl:if test="position()=last()">
        <xsl:value-of select="@retards"/>
    </xsl:if>
  </xsl:for-each>
</xsl:variable>

<fo:instream-foreign-object content-width="18.4cm">
<svg id="graphic" width="{$globWidth}" height="{$globHeight}" 
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">
<g>

    <xsl:variable name="init-x" select="30"/>
    <xsl:variable name="init-y" select="30"/>
    <xsl:variable name="width"  select="$globWidth - 4*$init-x"/>
    <xsl:variable name="height" select="$globHeight - 4*$init-y"/>
    <xsl:variable name="min-value" select="0"/>
    <xsl:variable name="step-value" select="10"/>
    <xsl:variable name="step-number" select="10"/>
    <xsl:variable name="baseline"  select="$height + $init-y"/>

      <!-- the diagram's box -->
      <rect x="{ $init-x }" y="{ $init-y }"
                width="{ $width }" height="{ $height }"
                fill="#fff" stroke="#000" stroke-width="1px"/>

    <!-- Build the X axis -->
    <xsl:variable name="nbMes" select="count(mesure)"/>
    <xsl:for-each select="mesure">
   	<xsl:sort select="@annee"/>
  	<xsl:sort select="@mois"/>

      	<xsl:variable name="xpos" select="$init-x + position()*$width div $nbMes"/>
 	<text x="{$xpos}" y="{$baseline + 15}"
            transform="rotate(-45 {$xpos} {$baseline + 15})"
            font-size="10px" text-anchor="end">
       	    <xsl:value-of select="@mois"/>-<xsl:value-of select="@annee"/>
	</text>

      	<rect x="{$xpos - 10}" y="{$baseline}" width="1" height="6" stroke="#000" fill="none"/>
    </xsl:for-each>

    <!-- Build the Y axis -->
    <xsl:for-each select="(//node())[5 >= position()]">
    <xsl:variable name="ypos" select="$height+$init-y - position()*$height div 5"/>
    <text x="{$init-x - 5}" y="{$ypos + 3}"
        font-size="15px" text-anchor="end">
        <xsl:value-of select="substring((position()*2*$maxsatisf) div 10,1,4)"/>
    </text>

    <rect x="{$init-x}" y="{$ypos}" width="{$width}" height="1px" stroke="#888" fill="none"/>
    </xsl:for-each>
    <text x="{$init-x - 5}" y="{$baseline}"
        font-size="15px" text-anchor="end">
        0
    </text>

    <!-- Plot the line -->
    <polyline id="plotsvg" style="fill:none; stroke:black;stroke-width:1px; background-color:white">
        <xsl:attribute name="points">
            <xsl:for-each select="mesure">
   	        <xsl:sort select="@annee"/>
  	        <xsl:sort select="@mois"/>
                
                <xsl:if test="@retards!=''">
                <xsl:value-of select="$init-x -10 + position()*$width div $nbMes"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$height+$init-y - @retards*$height*(10 div ($maxsatisf)) div 10"/>
                <xsl:text> </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:attribute>
    </polyline>

</g>
</svg>
</fo:instream-foreign-object>
</xsl:template>

</xsl:stylesheet>
