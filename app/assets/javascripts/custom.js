// preloader
$(window).load(function(){
    $('.preloader').fadeOut(1000); // set duration in brackets
    if (window.location.hash == "#_=_") {
        window.location.hash = "";
    }
    $("#sign_in_user").on("ajax:success", function(e, data, status, xhr) {
        $('#success-block').removeClass('hidden').delay( 1500 ).fadeIn( 400 );
        window.location.href=data.url_to
    }).on("ajax:error", function(e, xhr, status, error) {
        $('#error-block').removeClass('hidden')
        $('#error-block-mes').html(error)
    });
    $('#user_password, #password_confirmation').on('focus',function (){
        $('#error-block').addClass('hidden')
    })

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
    /* tabs */
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        console.log('showing tab ' + e.target); // Active Tab
        console.log('e= ', e); // Active Tab
        var tab_str=String(e.target);
        if (tab_str.search(/register/) >0 ) {
            $('.login-title').html('Site register');
        }else {
            $('.login-title').html('Site login');
        };

        //console.log('showing tab ' + e.relatedTarget); // Previous Tab
    })
    $('#license-btn').click(function(){
        $('a[href="#register-block"]').tab('show');
        $('#license-check').prop('checked', true);
    })
    //-------------Login/Register-------------

})