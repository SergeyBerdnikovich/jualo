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
         $('.name_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
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
         $('.email_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
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
         $('.phone_number_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
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
         $('.subject_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
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
         $('.message_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
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
         $('.captcha_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>Wrong Captcha</div>");
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



  // ad new

  $("#new_ad").submit(function(){
    var product_title_ok = false;
    var product_type_ok = false;
    var catergory_ok = false;
    var subcategory_ok = false;
    var state_ok = false;
    var city_ok = false;
    var description_ok = false;
    var price_ok = false;
    var user_name_ok = false;
    var user_email_ok = false;
    var user_phone_ok = false;
    var user_blackberry_pin_ok = false;
    var captcha_ok = false;

    $.ajax({ url: "/ads/verify_for_emptiness?field=Product+title&obj=" + $("#new_ad #ad_detail_attributes_name").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('#product_title_div .modal_alert').remove();
       if (result != true){
         $('#product_title_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
       } else {
        product_title_ok = true;
       }
     });

     var ad_ad_type_id = $("#new_ad #ad_ad_type_id").val();
     $('#product_type_div .modal_alert').remove();
     if (ad_ad_type_id == '') {
       $('#product_type_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ "Please Select Product Type" +"</div>");
     } else {
       product_type_ok = true;
     }

     var ad_category_id = $("#new_ad #ad_category_id").val();
     $('#category_div .modal_alert').remove();
     if (ad_category_id == '') {
       $('#category_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ "Please Select Category" +"</div>");
     } else {
       catergory_ok = true;
     }

     var ad_subcategory_id = $("#new_ad #ad_ad_subcategory_id").val();
     $('#subcategory .modal_alert').remove();
     if (ad_subcategory_id == '') {
       $('#subcategory').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ "Please Select Subcategory" +"</div>");
     } else {
       subcategory_ok = true;
     }

     var ad_state_id = $("#new_ad #ad_state_id").val();
     $('#state_div .modal_alert').remove();
     if (ad_state_id == '') {
       $('#state_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ "Please Select State" +"</div>");
     } else {
       state_ok = true;
     }

     var city_id = $("#new_ad #city_id").val();
     $('#cities .modal_alert').remove();
     if (city_id == '') {
       $('#cities').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ "Please Select Sity" +"</div>");
     } else {
       city_ok = true;
     }

     $.ajax({ url: "/ads/verify_for_emptiness?field= Desciption&obj=" + $("#new_ad #ad_detail_attributes_description").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('#description_div .modal_alert').remove();
       if (result != true){
         $('#description_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
       } else {
        description_ok = true;
       }
     });

     $.ajax({ url: "/ads/verify_for_emptiness?field= Price&obj=" + $("#new_ad #ad_price").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('.harga .modal_alert').remove();
       if (result != true){
         $('.harga').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
       } else {
        price_ok = true;
       }
     });

     $.ajax({ url: "/ads/verify_for_emptiness?field=User+name&obj=" + $("#new_ad #user_name").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('#in_name .modal_alert').remove();
       if (result != true){
         $('#in_name').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
       } else {
         user_name_ok = true;
       }
     });

     $.ajax({ url: "/ads/verify_for_emptiness?field=User+email&obj=" + $("#new_ad #user_email").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('#in_email .modal_alert').remove();
       if (result != true){
         $('#in_email').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
       } else {
        user_email_ok = true;
       }
     });

     $.ajax({ url: "/ads/verify_for_emptiness?field=User+phone&obj=" + $("#new_ad #user_phone").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('#in_phone_number .modal_alert').remove();
       if (result != true){
         $('#in_phone_number').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
       } else {
         user_phone_ok = true;
       }
     });

     $.ajax({ url: "/ads/verify_for_emptiness?field=User+blackberry+pin&obj=" + $("#new_ad #user_blackberry_pin").val(),
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       var result = data['result'];
       $('#in_blackberry_pin .modal_alert').remove();
       if (result != true){
         $('#in_blackberry_pin').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>"+ result +"</div>");
       } else {
         user_blackberry_pin_ok = true;
       }
     });

     $.ajax({ url: "/ads/verify_captcha?captcha=" + $("#captcha").val() + "&captcha_id=" + $("#captcha_id").val() ,
                  dataType: "json",
                  async: false,
                  cache: false
     }).success(function( data ) {
       $('#new_ad_captch_div .modal_alert').remove();
       if (data['result'] == false){
         $('#new_ad_captch_div').prepend("<div class='modal_alert' style='color: #337DAB;padding: 5px;border: 2px solid #FF3E47;margin:2px 0;background-color: #FFD2D3;'>Wrong Captcha</div>");
       } else {
         captcha_ok = true;
       }
     });

     if (product_title_ok == true && product_type_ok == true && catergory_ok == true && subcategory_ok == true && state_ok == true && city_ok == true && description_ok == true && price_ok == true && user_name_ok == true && user_email_ok == true && user_phone_ok == true && user_blackberry_pin_ok == true && captcha_ok == true) {
       return true;
     } else {
       return false;
     }
  });
});
