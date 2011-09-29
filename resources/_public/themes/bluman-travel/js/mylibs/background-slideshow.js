
var images = new Array();
var currentBackgroundImage = 0;
var toggle = true;
var first = true;
var imageUrl = "";
var backgroundSlideshow = 0;

function runSlideshow(imageArray){
    images = imageArray;
    slideshow();
}

function slideshow(){
    if (images.length == 0){
        /*alert("No images defined for slideshow, you must pass inn a javascript array of valid image-urls");*/
    }else{
        if (toggle){
            imageUrl = images[currentBackgroundImage];
            if (currentBackgroundImage==images.length-1){
                currentBackgroundImage = 0;
            }else{
                currentBackgroundImage++;
            }
            if(first){
                $('#background1').css("background-image",'url('+imageUrl+')');
                $('#background1').css({opacity:0}).animate({opacity:1},5000);
                toggle=false;
                first=false;
            }else{
                $('#background2').css("background-image",'url('+imageUrl+')');
                $('#background2').css({opacity:0}).animate({opacity:1},5000);
                toggle = false;
                first=true;
            }
            setTimeout(slideshow, 10000);
        }else{
            if (images.length>1){
                if (first){
                    $('#background2').css({opacity:1}).animate({opacity:0},5000);
                }else{
                    $('#background1').css({opacity:1}).animate({opacity:0},10000);
                }
                toggle = true;
                setTimeout(slideshow, 0);
            }
        }
    }
}