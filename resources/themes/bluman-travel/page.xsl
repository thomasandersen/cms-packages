    <xsl:stylesheet
        exclude-result-prefixes="#all"
        version="2.0" xmlns="http://www.w3.org/1999/xhtml"
        xmlns:util="enonic:utilities"
        xmlns:portal="http://www.enonic.com/cms/xslt/portal"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:import href="../../libraries/utilities/standard-variables.xsl"/>
    <xsl:import href="../../libraries/utilities/region.xsl"/>
    <xsl:import href="../../libraries/utilities/head.xsl"/>
    <xsl:import href="../../libraries/utilities/error-handler.xsl"/>
    <xsl:import href="../../libraries/utilities/accessibility.xsl"/>
    <xsl:import href="../../libraries/utilities/google.xsl"/>
    <xsl:import href="../../libraries/widgets/breadcrumbs.xsl"/>
    <xsl:import href="../../libraries/widgets/menu.xsl"/>
    <xsl:import href="mobile.xsl"/>
    <xsl:import href="pc.xsl"/>
    <xsl:import href="widgets/spot-slideshow.xsl"/>

     <xsl:output
        method="html"
        doctype-public="XSLT-compat"
        omit-xml-declaration="yes"
        encoding="UTF-8"
        indent="yes" />

    <!-- page type -->
    <!-- For multiple layouts on one site. Various layouts can be configured in theme.xml, each with a different 'name' attribute on the 'layout' element. -->
    <xsl:param name="layout" select="'default'" as="xs:string"/>
    <xsl:param name="body-class" select="''" as="xs:string"/>

    <!-- regions -->
    <xsl:param name="north"><type>region</type></xsl:param>
    <xsl:param name="west"><type>region</type></xsl:param>
    <xsl:param name="center"><type>region</type></xsl:param>
    <xsl:param name="south"><type>region</type></xsl:param>
    <xsl:param name="east"><type>region</type></xsl:param>
    <xsl:param name="background"><type>region</type></xsl:param>

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$device-class = 'mobile'">
                <xsl:call-template name="mobile"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="pc"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="pc">
        <!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
        <!--[if lt IE 7]> <html class="no-js ie6 oldie" dir="ltr" lang="{$language}" xml:lang="{$language}" > <![endif]-->
        <!--[if IE 7]>    <html class="no-js ie7 oldie" dir="ltr" lang="{$language}" xml:lang="{$language}" > <![endif]-->
        <!--[if IE 8]>    <html class="no-js ie8 oldie" dir="ltr" lang="{$language}" xml:lang="{$language}" > <![endif]-->
        <!--[if gt IE 8]><!--> <html class="no-js" dir="ltr" lang="{$language}" xml:lang="{$language}" > <!--<![endif]-->
        <head>
            <title>
                <xsl:value-of select="util:menuitem-name($current-resource)"/>
                <xsl:value-of select="concat(' - ', $site-name)"/>
            </title>
            <link rel="shortcut icon" type="image/x-icon" href="{portal:createResourceUrl(concat($theme-public, '/images/favicon.ico'))}"/>
            <xsl:call-template name="head.meta-common"/>
            <xsl:call-template name="head.css-common"/>
            <xsl:call-template name="region.css">
                <xsl:with-param name="layout" select="$layout"/>
            </xsl:call-template>
            <xsl:call-template name="head.script-common"/>
        </head>

        <body>
            <xsl:if test="not($body-class='')">
                <xsl:attribute name="class"><xsl:value-of select="$body-class"/></xsl:attribute>
            </xsl:if>
            <xsl:call-template name="pc.body" />
        </body>
    </html>
    </xsl:template>

    <xsl:template name="mobile">
        <html lang="{$language}" xml:lang="{$language}">
            <head>
                <title>
                    <xsl:value-of select="util:menuitem-name($current-resource)"/>
                </title>
                <link rel="apple-touch-icon" href="{portal:createResourceUrl(concat($theme-public, '/images-mobile/apple-touch-icon.png'))}"/>
                <xsl:call-template name="head.script-common" />
                <xsl:call-template name="mobile.scripts" />
                <xsl:call-template name="head.css-common"/>

                <meta content="minimum-scale=1.0, width=device-width, user-scalable=yes" name="viewport" />
                <meta name="apple-mobile-web-app-capable" content="yes" />
            </head>
            <body>
                <xsl:if test="not($body-class='')">
                    <xsl:attribute name="class"><xsl:value-of select="$body-class"/></xsl:attribute>
                </xsl:if>
                <xsl:call-template name="mobile.body" />
            </body>
        </html>
    </xsl:template>



</xsl:stylesheet>