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
 var okay = true;
     $.ajax({
  url: window.location.pathname +"/verify_captcha?captcha=" + $("#captcha").val() + "&captcha_id=" + $("#captcha_id").val() ,
  dataType: "json",
   async:false,
  cache: false
}).success(function( data ) {
  alert(data['result']);
  if (data['result'] == false){
 alert("Wrong captcha, please try again")
      return okay = false;

  } else {
//$("#contact_form").submit();
    return okay = true;
}
});

return okay ;
})


  });
