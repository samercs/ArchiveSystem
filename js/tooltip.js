$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
    $(".menu_btn").click(function () {
        $(".dropdownmenu").slideToggle("slow");
    });
    $(' .picker').datepicker({ format: 'dd/mm/yyyy' });
        /*$('.link').click(function(){
            $('.commenter').slideToggle("slow");
        });*/
        /*$('.up').click(function(){
            $('.collapse').slideToggle("slow");
        });*/

});