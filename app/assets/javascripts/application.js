// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require twitter/bootstrap
//= require_tree .



//for each element that is classed as 'pull-down', set its margin-top to the difference between its own height and the height of its parent
var map_image_id = 0;

function override_hide_image(id,not_necessary){
	map_image_id = id;
}

	$(window).resize(function(){

		$('.pullright').each(function() {
			$(this).css('margin-left', $(this).parent().width()-$(this).width())
		});


	})


	$(window).resize();

	var cursor_on_balloon = false
	var cursor_on_area = false

	$('area').mouseover(function(){
		cursor_on_area = true
		
		var position = $(this).attr('coords').split(',');
		var x = 0;
		var y = 0;
		var popup_arrow_up = false
		var	fix_x = 0
		var	fix_y = 0

		var title = $(this).attr("title")

		if (title.length > 15){ //defining state by "title" attribute. There is generally state:cities... format but 2 small cities specified with ":" thus making an exception
			var patt=/.*?(?=:)/g;
			var state=patt.exec(title)[0];
		}else{
			var state = title
		}


		$.each(position, function(index, value) {  //calculating image map average location
			if (isOdd(index)){
				y += parseInt(value)
			} else {
				x += parseInt(value)
			}
		}); 
		//it's not working well always and unable to decide when switch arrows
		// thus making knowing exceptions
		switch(state)
			{
			case "SUMBAR":
			popup_arrow_up = true
			fix_x = -68
			fix_y = 60			
    		break;

			case "RIAU":
			popup_arrow_up = false
			fix_x = -35
			fix_y = 10			
    		break;


			case "DKI: Jakarta":
			popup_arrow_up = false
			fix_x = -2
			fix_y = 0	
    		break;

    		case "BENGKULU":
			popup_arrow_up = true
			fix_x = -74
			fix_y = 58			
    		break;

    		case "SULBAR":
			popup_arrow_up = true
			fix_x = -74
			fix_y = 58			
    		break;


			case "DIY: Yogyakarta":
			popup_arrow_up = true
			fix_x = -72
			fix_y = 70			
    		break;

			case "SUMSEL":
			popup_arrow_up = false
			fix_x = 0
			fix_y = -10			
    		break;

    		case "NAD":
			popup_arrow_up = false
			fix_x = 0
			fix_y = -20			
    		break;

    		case "SUMUT":
			popup_arrow_up = false
			fix_x = 0
			fix_y = -25			
    		break;

    		case "SULUT":
			popup_arrow_up = false
			fix_x = -7
			fix_y = 0
    		break;


			case "KALBAR":
			popup_arrow_up = false
			fix_x = -15
			fix_y = -20			
    		break;

			case "MALUT":
			popup_arrow_up = true
			fix_x = -60
			fix_y = 60  			
    		break;


			default:
			  fix_x = 0
			  popup_arrow_up = false
			  fix_y =  0
			}


		var map_position = $('#area_image').offset()

		x = ((x / position.length) * 2) + map_position.left - 8 + fix_x
		y = ((y / position.length) * 1.9) + map_position.top - 43 + fix_y
		


		$('.popup').show()
		if (popup_arrow_up){
			$('.popup').attr("class",'popup popup_arrow_up')
			
		} else{
			$('.popup').attr("class",'popup popup_arrow_down')
		}

		$('.popup').css("left", x)
		$('.popup').css("top", y)
		var position = $('.popup').offset()

		$('#popup_text_val').html(state)
		$('.popup_text').css(position)
		$('.popup_text').show()



	})

	$('area').mouseleave(function(){
		cursor_on_area = false
		setTimeout(function(){
			if (cursor_on_area == false){
				if (cursor_on_balloon == false){
					$('.popup').hide()
					$('.popup_text').hide()
					hide_image(map_image_id,1)
				}
			}
		},100)
	})

	$('.popup, .popup_text *').mouseover(function(){
		cursor_on_balloon = true;
	})
	$('.popup, .popup_text *').mouseleave(function(){
		cursor_on_balloon = false;
		setTimeout(function(){
			if (cursor_on_area == false){
				if (cursor_on_balloon == false){
					$('.popup').hide()
					$('.popup_text').hide()
					hide_image(map_image_id,1)
				}
			}
		},100)

	})

	function isOdd(n)
	{
		return isNumber(n) && (n % 2 == 1);
	}
	function isNumber(n)
	{
		return n == parseFloat(n);
	}
