<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:util="enonic:utilities"
                xmlns:portal="http://www.enonic.com/cms/xslt/portal"
                xmlns:math="http://exslt.org/math"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../../../libraries/utilities/standard-variables.xsl"/>
    <xsl:include href="../../../libraries/utilities/utilities.xsl"/>
    <xsl:include href="../../../libraries/utilities/frame.xsl"/>

    <xsl:output indent="yes" media-type="text/html" method="xhtml" omit-xml-declaration="yes"/>

    <xsl:template match="/">
            <div id="spots-nearby" class="spots-nearby-container" role="navigation">
                <div id="spots-info" class="spots-info">
                    <p>
                        You<xsl:choose><xsl:when test="/result/context/querystring/parameter[@name='locationKey']"> searched for spots in </xsl:when><xsl:otherwise> browsed to </xsl:otherwise></xsl:choose>
                        <xsl:variable name="locationKey" select="/result/context/querystring/parameter[@name='locationKey']" />
                        <xsl:choose>
                            <xsl:when test="$locationKey and not(/result/context/resource/path/resource[@key=$locationKey]/display-name='')">
                                <span class="capitalize">
                                    <xsl:value-of select="/result/context/resource/path/resource[@key=$locationKey]/display-name" />
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="capitalize"><xsl:value-of select="/result/context/resource/display-name" /></span>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="/result/context/querystring/parameter[@name='spottags']">
                            <xsl:variable name="spottags" select="/result/context/querystring/parameter[@name='spottags']" />
                            <xsl:text> related to </xsl:text>
                            <xsl:for-each select="/result/tags/contents/content">
                                <xsl:if test="contains($spottags, @key)">
                                    <span><xsl:value-of select="display-name" /><xsl:text> </xsl:text></span>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                    </p>
                </div>
                <nav class="spots-nearby">
                    <xsl:if test="(/result/context/resource/@type='menuitem' and count(/result/spots-nearby/contents/content)>0) or (/result/context/resource/@type='content' and count(/result/spots-nearby/contents/content)>1)">
                        <p>Spots nearby :</p>
                    </xsl:if>
                    <ul id="sdt_menu" class="sdt_menu">
                        <xsl:apply-templates select="/result/spots-nearby/contents/content" mode="spots-nearby"/>
                     </ul>
                </nav>
            </div>
    </xsl:template>
    <xsl:template match="content" mode="spots-nearby">
            <xsl:if test="not(current()/@key = /result/context/resource/@key)">
                <xsl:variable name="activeClass"><xsl:if test="/result/context/resource/@key=current()/@key"><xsl:text>spot-nearby-active</xsl:text></xsl:if></xsl:variable>
                <li class="spot-nearby" style="background: url({portal:createImageUrl(contentdata/image[1]/image/@key, 'scalewidth(170)')})">
                    <xsl:variable name="spottags" select="/result/context/querystring/parameter[@name='spottags']" />
                    <xsl:variable name="locationKey" select="/result/context/querystring/parameter[@name='locationKey']" />
                    <xsl:variable name="spotUrl">
                        <xsl:value-of select="portal:createContentUrl(@key,('locationKey', $locationKey))" />
                        <xsl:if test="$locationKey and string-length($spottags)>0">
                            <xsl:text>&amp;spottags=</xsl:text><xsl:value-of select="$spottags" />
                        </xsl:if>
                    </xsl:variable>
                    <a href="{$spotUrl}">
                        <span class="sdt_active"></span>
                        <span class="sdt_wrap">
                            <span class="sdt_link {$activeClass}"><xsl:value-of select="display-name" /></span>
                            <span class="sdt_descr {$activeClass}"><xsl:value-of select="location/site/contentlocation/@menuitemname" /> </span>
                        </span>
                    </a>
                </li>
            </xsl:if>
    </xsl:template>
</xsl:stylesheet>
