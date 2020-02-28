// Screen media query
var onSmallScreen = window.matchMedia("(max-width: 992px)")

// Initialize popup
$(document).ready(function() {
  $('.image-link').magnificPopup({type:'image'});
});

$('.popup-image-link').magnificPopup({
  type: 'image'
  // other options
});

// Transition effect for navbar 
$(document).ready(function() {
    
    if (!onSmallScreen.matches) {
        if($(this).scrollTop() > 10) {
            $('.navbar').addClass('navbar-solid');
        }
        
        $(window).scroll(function() {
            if($(this).scrollTop() > 10) { 
                $('.navbar').addClass('navbar-solid');
             } else {
                $('.navbar').removeClass('navbar-solid');
             }
        });
    }
});

// Click event for the header button
$("#header-button").click(function() {
    var element = document.getElementById("problem-info-section")
    element.scrollIntoView({behavior: "smooth", inline: "nearest"});
});
