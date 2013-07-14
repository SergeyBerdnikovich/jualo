  $(window).load(function(){
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