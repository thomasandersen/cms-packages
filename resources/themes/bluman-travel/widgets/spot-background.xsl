<xsl:stylesheet version="2.0"
                exclude-result-prefixes="#all"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:portal="http://www.enonic.com/cms/xslt/portal"
                xmlns:util="enonic:utilities"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../../libraries/utilities/standard-variables.xsl"/>

    <xsl:template match="/">
        <div id="spot-background" role="">
            <script  type="text/javascript">
                $(document).ready(function(){
                    var images=new Array();
                    var imageId;
                    var imageUrl;
                    <!--Shuffle function for array that holds slideshow images-->
                    Array.prototype.shuffle = function() {
                        var s = [];
                        while (this.length) s.push(this.splice(Math.random() * this.length, 1)[0]);
                        while (s.length) this.push(s.pop());
                        return this;
                    }

                <xsl:if test="/result/travelinfo-background-images/contents/relatedcontents/content[@contenttype='Image']">
                        <xsl:for-each select="/result/travelinfo-background-images/contents/relatedcontents/content[@contenttype='Image'] ">
                            imageUrl = "<xsl:value-of select="portal:createImageUrl(current()/@key, 'scalewidth(1200)','','jpg','50')" />";
                            imageId = imageUrl.substring(imageUrl.lastIndexOf('=')+1);
                            $('#footer').append('<figcaption class="photo-info transparent" id="tempId">"<xsl:value-of select="display-name" />"<xsl:if test="not(contentdata/photographer/@name='')"> by <xsl:value-of select="contentdata/photographer/@name" /></xsl:if></figcaption>');
                            $('#tempId').attr("id",imageId);
                            images[<xsl:value-of select="position()-1"/>] = imageUrl;
                        </xsl:for-each>
                        runSlideshow(images.shuffle());

                    </xsl:if>
                    <xsl:if test="/result/background-images/contents/relatedcontents/content[@contenttype='Image']">
                        <xsl:choose>
                            <xsl:when test="/result/context/resource/type='Spot'">
                                <xsl:variable name="resourceKey" select="/result/context/resource/@key" />
                                <xsl:for-each select="/result/background-images/contents/content[@contenttype='Spot' and @key = $resourceKey]" >
                                    <xsl:for-each select="relatedcontentkeys/relatedcontentkey[@contenttype='Image']">
                                         <xsl:choose>
                                            <xsl:when test="$device-class = 'mobile'">
                                                imageUrl = "<xsl:value-of select="portal:createImageUrl(current()/@key, 'scaleblock(320, 480)','','jpg','50')" />";
                                            </xsl:when>
                                            <xsl:otherwise>
                                                imageUrl = "<xsl:value-of select="portal:createImageUrl(current()/@key, 'scalewidth(1200)','','jpg','50')" />";
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        imageId = imageUrl.substring(imageUrl.lastIndexOf('=')+1);
                                       <xsl:for-each select="/result/background-images/contents/relatedcontents/content[@contenttype='Image' and @key = current()/@key]">
                                            $('#footer').append('<figcaption class="photo-info transparent" rel="tempId">"<xsl:value-of select="display-name" />"<xsl:if test="not(contentdata/photographer/@name='')"> by <xsl:value-of select="contentdata/photographer/@name" /></xsl:if></figcaption>');
                                            $('figcaption[rel="tempId"]').attr("id",imageId);
                                        </xsl:for-each>
                                        images[<xsl:value-of select="position()-1"/>] = imageUrl;
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each select="/result/background-images/contents/relatedcontents/content[@contenttype='Image'] ">
                                     <xsl:choose>
                                        <xsl:when test="$device-class = 'mobile'">
                                            imageUrl = "<xsl:value-of select="portal:createImageUrl(current()/@key, 'scaleblock(320, 800)','','jpg','50')" />";
                                        </xsl:when>
                                        <xsl:otherwise>
                                            imageUrl = "<xsl:value-of select="portal:createImageUrl(current()/@key, 'scalewidth(1200)','','jpg','50')" />";
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    imageId = imageUrl.substring(imageUrl.lastIndexOf('=')+1);
                                    $('#footer').append('<figcaption class="photo-info transparent" rel="tempId">"<xsl:value-of select="display-name" />" <xsl:if test="not(contentdata/photographer/@name='')"> by <xsl:value-of select="contentdata/photographer/@name" /></xsl:if></figcaption>');
                                    $('figcaption[rel="tempId"]').attr("id",imageId);
                                    images[<xsl:value-of select="position()-1"/>] = imageUrl;
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                        runSlideshow(images.shuffle());
                    </xsl:if>
                });
            </script>
        </div>

    </xsl:template>
</xsl:stylesheet>