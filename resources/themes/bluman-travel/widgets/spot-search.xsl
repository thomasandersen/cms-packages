<xsl:stylesheet version="2.0"
                exclude-result-prefixes="#all"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:portal="http://www.enonic.com/cms/xslt/portal"
                xmlns:util="enonic:utilities"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../../libraries/utilities/standard-variables.xsl"/>

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="/result/context/querystring/parameter[@name = 'ajaxsearch']">
                <input type="hidden" id="contentKey" value="{/result/random-spot/contents/content/@key}" />
                <input type="hidden" id="contentUrl" value="{portal:createContentUrl( /result/random-spot/contents/content/@key, '')}" />
            </xsl:when>
            <xsl:otherwise>
             <xsl:call-template name="spot-search" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="spot-search">
            <div id="bluman-form-container" role="search">
                <h1 class="visuallyhidden">Search for spots</h1>
                <form id="bluman-form" method="post" action="">
                    <fieldset>
                        <legend id="tagline">Find <span class="bluman">Blumans</span> favourite spots in:</legend>
                        <label for="locationKey" class="visuallyhidden">Select city</label>
                        <select id="locationKey" name="locationKey">
                            <option value="">Please select</option>
                            <xsl:for-each select="/result/spots/menuitems/menuitem">
                                <xsl:choose>
                                    <xsl:when test="display-name=/result/context/resource/display-name">
                                        <option style="color:#3B7FBF" selected="true" value="{@key}"><xsl:value-of select="display-name" /></option>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <option style="color:#3B7FBF" value="{@key}"><xsl:value-of select="display-name" /></option>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates select="menuitems/menuitem" mode="cities"/>
                            </xsl:for-each>
                        </select>
                    </fieldset>
                    <fieldset id="select-tags">
                        <legend>when he wants:</legend>
                        <xsl:for-each select="/result/tags/contents/content">
                           <input id="{@key}" type="checkbox" value="{@key}" />
                           <label for="{@key}"><xsl:value-of select="name" /></label>
                       </xsl:for-each>
                    </fieldset>
                    <span>
                        <input type="hidden" id="spottags" name="spottags" />
                    </span>
                </form>
                <a id="find-bluman-button" class="large blue awesome">Find Bluman</a>
                <div id="no-such-spots-message">Message goes here</div>
                <div id="appendRandomSpotHere" />
            </div>
            <xsl:call-template name="spot-search-scripts" />
    </xsl:template>

    <xsl:template match="menuitem" mode="cities">
        <xsl:choose>
            <xsl:when test="display-name=/result/context/resource/display-name">
                <option selected="true" value="{@key}"><xsl:value-of select="display-name" /></option>
            </xsl:when>
            <xsl:otherwise>
                <option value="{@key}"><xsl:value-of select="display-name" /></option>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="spot-search-scripts">

            <script  type="text/javascript">
              $(document).ready(function(){
                    $('#spot').selectBox();
                    /*Maintain a comma separated list of spottags used in datasource to filter random spot when form is submitted*/
                    $('#bluman-form-container :checkbox').click(function(){
                        $('#spottags').val('');
                        $('#bluman-form-container :checkbox:checked').each(function(){
                            if(!$('#spottags').val())
                                $('#spottags').val($('#spottags').val() + $(this).val());
                            else
                                $('#spottags').val($('#spottags').val() + ',' + $(this).val());
                        });
                    });

                    <xsl:variable name="windowKey" select="/result/context/window/@key"/>
                    <xsl:variable name="portletKey" select="/result/context/window/portlet/@key"/>
                    <xsl:variable name="portletUrl" select="portal:createWindowUrl($windowKey,(''))"/>
                    /*Submit ajax query to find random spot (contentKey) in selected city, we need this to get correct http url for spot*/
                    $("#find-bluman-button").click(function() {
                         if ($("#bluman-form #locationKey ").find("option:selected").val()!=''){
                            $.get("<xsl:value-of select="$portletUrl" />", {locationKey: $('#bluman-form #locationKey').find("option:selected").val(), spottags: $('#bluman-form #spottags').val(), ajaxsearch: "true"},
                               function(data){
                                    $('#appendRandomSpotHere').children('input').remove();
                                    $('#appendRandomSpotHere').append(data);
                                    if (!$('#contentKey').val()){
                                        jAlert('No spots found, try a new search!', 'No spots');
                                    }else{
                                        $('#bluman-form').attr('action', $('#contentUrl').val());
                                        $('#bluman-form').submit();
                                    }
                               }
                            );
                        }
                        else{
                            jAlert('No location selected!', 'Information');
                        }
                    });
                 });
            </script>
    </xsl:template>
</xsl:stylesheet>