  $(window).load(function(){

$("#phone_number").click(function(){

  $('#secret').html(numb)

$('#see_complete_no').hide()

})

    $(function () {
    $('#myTab a:last').tab('show');
  })

    setTimeout(function(){{ $(".ad-image").addClass("center_me"); $('.ad-thumb-list li a img').addClass("center_me") }},50)
      var galleries = $('.ad-gallery').adGallery({
         display_next_and_prev: false,
         loader_image: 'http://jualo.com:3000/assets/loader.gif',
           display_back_and_forward: false
      });
    $('#toggle-slideshow').click(
      function() {
        galleries[0].slideshow.toggle();
        return false;
      }
    );

    $('#captcha_img').click(function(){

     $.ajax({
  url: window.location.pathname +"/get_new_captcha/",
  dataType: "json",
  cache: false
}).done(function( data ) {
    $('#captcha_img').html(data[0]);
     $('#captcha_id').val(data[1]);
});


    })

$("#contact_form").submit(function(){
  var name_ok = false
  var email_ok = false
  var phone_number_ok = false
  var subject_ok = false
  var message_ok = false
  var captcha_ok = false

     $.ajax({ url: window.location.pathname +"/verify_name?name=" + $("#contact_form #nama").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('.name_div .modal_alert').remove();
       if (result != true){
         $('.name_div').prepend("<div class='modal_alert' style='color: red;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;'>"+ result +"</div>");
       } else {
       return name_ok = true;
       }
     });
     $.ajax({ url: window.location.pathname +"/verify_email?email=" + $("#contact_form #email").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('.email_div .modal_alert').remove();
       if (result != true){
         $('.email_div').prepend("<div class='modal_alert' style='color: red;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;'>"+ result +"</div>");
       } else {
       return email_ok = true;
       }
     });
     $.ajax({ url: window.location.pathname +"/verify_phone_number?phone_number=" + $("#contact_form #phone_number").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('.phone_number_div .modal_alert').remove();
       if (result != true){
         $('.phone_number_div').prepend("<div class='modal_alert' style='color: red;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;'>"+ result +"</div>");
       } else {
       return phone_number_ok = true;
       }
     });
     $.ajax({ url: window.location.pathname +"/verify_subject?subject=" + $("#contact_form #subyek").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('.subject_div .modal_alert').remove();
       if (result != true){
         $('.subject_div').prepend("<div class='modal_alert' style='color: red;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;'>"+ result +"</div>");
       } else {
       return subject_ok = true;
       }
     });
     $.ajax({ url: window.location.pathname +"/verify_message?message=" + $("#contact_form #pesan").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('.message_div .modal_alert').remove();
       if (result != true){
         $('.message_div').prepend("<div class='modal_alert' style='color: red;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;'>"+ result +"</div>");
       } else {
       return message_ok = true;
       }
     });
     $.ajax({ url: window.location.pathname +"/verify_captcha?captcha=" + $("#captcha").val() + "&captcha_id=" + $("#captcha_id").val() ,
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       $('.captcha_div .modal_alert').remove();
       if (data['result'] == false){
         $('.captcha_div').prepend("<div class='modal_alert' style='color: red;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;'>Wrong Captcha</div>");
       } else {
       return captcha_ok = true;
       }
     });

     if (name_ok == true && email_ok == true && phone_number_ok == true && subject_ok == true && message_ok == true && captcha_ok == true) {
       return true;
     } else {
       return false;
     }
 });


  });
