// preloader
$(window).load(function(){
    $('.preloader').fadeOut(1000); // set duration in brackets    
});

$(function() {
    new WOW().init();
    $('.templatemo-nav').singlePageNav({
    	offset: 70
    });

    /* Hide mobile menu after clicking on a link
    -----------------------------------------------*/
    $('.navbar-collapse a').click(function(){
        $(".navbar-collapse").collapse('hide');
    });
    $('#enter').click(function(){
    //alert('login');
        var options={};
        //$('#myLoginFull').modal(options);
        $('#myLogin').modal(options);

    })
    /* Auth */
    function authProvider(p_name) {
        var link=window.location.protocol + "//" + window.location.host + "/"+"users/auth/"+p_name;
        console.log(link);
        window.location.href=link;
    }
})