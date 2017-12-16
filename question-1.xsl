<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:output method="xml"/>

<xsl:template match="/regularite-tgv">

<fo:root>
    <fo:layout-master-set>

        <fo:simple-page-master master-name="A4"
                            page-height="29.7cm"
                            page-width="21cm"
                            margin-top="1cm"
                            margin-bottom="1cm" 
                            margin-left="1cm"
                            margin-right="1cm">

            <fo:region-body background-color="#EEE"/>
        </fo:simple-page-master>


    </fo:layout-master-set>


    <fo:page-sequence master-reference="A4">
        <fo:flow flow-name="xsl-region-body">
        <xsl:apply-templates select="axe"/>
        </fo:flow>
    </fo:page-sequence>
</fo:root>

</xsl:template>

<xsl:template match="axe">
    <fo:block
        text-indent="2em"
        font-size="1.2em"
        font-weight="bold"
        padding="2em">
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
                <fo:block padding="0.5em" text-indent="4em">
                    De <xsl:value-of select="@nom"/> à <xsl:value-of select="../@nom"/>
                </fo:block>
            </fo:table-cell>
          </fo:table-row>
	  <fo:table-row keep-with-previous="always">
          <xsl:for-each select="mesure[position()=1]/@*[name()!='commentaire']">
	      <fo:table-cell    border="1px solid black"
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

	        <fo:table-row>
                <xsl:for-each select="@*[name()!='commentaire']">
	            <fo:table-cell border="1px solid black" font-size="0.8em">
	                <fo:block>
                            <xsl:value-of select="."/>
	                </fo:block>
	            </fo:table-cell>
                </xsl:for-each>
	        </fo:table-row>

                <xsl:if test="@commentaire!=''">
	        <fo:table-row keep-with-previous="always">
	            <fo:table-cell number-columns-spanned="7" font-size="0.7em" border="1px solid black">
	                <fo:block>
                            '-> <xsl:value-of select="@commentaire"/>
	                </fo:block>
	            </fo:table-cell>
	        </fo:table-row>
                </xsl:if>

            </xsl:for-each>
	</fo:table-body>
	</fo:table>
   </fo:table-cell>
   <fo:table-cell><fo:block/></fo:table-cell>
  </fo:table-row>
 </fo:table-body>
</fo:table>
    <fo:block break-after="page"/>
    </fo:block>
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
