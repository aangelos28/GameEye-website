/*
 * Show/hide navbar dropdown elements on mobile
 */
$('.nav-dropdown-button').click(function() {
    let button = $(this);
    let dropdownDiv = button.next();
    dropdownDiv.toggleClass("mobile-show")
})
