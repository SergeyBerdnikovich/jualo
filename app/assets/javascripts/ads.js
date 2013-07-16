  $(window).load(function(){
    
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

  });