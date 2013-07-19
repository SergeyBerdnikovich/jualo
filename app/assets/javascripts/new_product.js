//$(document).ready(function(){

function add_image(image_id, image_address){
	html = ""
	html += '<div class="image_block" id="image_'+image_id+'">'
	html += '<table width="100%" height="100%" align="center" valign="center">'
   	html += '<tr><td><center class="nohover">'
	html += '<img src="'+image_address+'"><input type="hidden" name="image_ids[]" value="'+image_id+'"></center>'
	html += '<i class="icon-remove-circle" onclick=\'$("#image_'+image_id+'").remove()\'></i>'
 	html += '</td></tr>'
   	html += '</table>'
	html += '</div>'
	$('#images').append(html)

}

$('#choose_image').change(function() { 
    if ($('#choose_image').val().length > 10){
    $("#submit_image").click()
	}
})

function upload_image(){

	$("#choose_image").click()

};
	
	





	$("#ad_category_id").change(function(){
		ad_category_id = $("#ad_category_id").val()

		if (subcategories[ad_category_id] != undefined ){
			html = "";

			html += '<label class="title" for="ad_ad_type_id">Sub Categories</label>'
			html += '<div class="">'
			html += '<select id="ad_ad_subcategory_id" name="ad[subcategory_id]"><option value="">Please Select</option>'
			$.each(subcategories[ad_category_id], function(index,value){
				html += '<option value="'+value[0]+'">'+value[1]+'</option>'
			})
			html += '</div>'

			$("#subcategory").html(html)
			$("#subcategory").show()
		}else{
			$("#subcategory").html('')
			$("#subcategory").hide()
		}

		if (options[ad_category_id] != undefined ){
			html = "";

			//html += '<label class="title" >Additional information<p></label>'
//			html += '<div class="">'
			 
			$.each(options[ad_category_id], function(index,value){
				html += '<label style="display:block" class="title" for="ad_ad_options_id'+index+'">'+index+'</label><br>'
				html += '<select id="ad_ad_options_id'+index+'" name="ad[options['+index+']]"><option value="">'+index+'</option>'
				$.each(value, function(index,value){
					html += '<option value="'+value['id']+'">'+value['value']+'</option>'
				})
				html += '</select><p>'
			})
//			html += '</div>'

			$("#options").html(html)
			$("#options").show()
		}else{
			$("#options").html("")
			$("#options").hide()
		}


	})

$("#ad_state_id").change(function(){
		state_id = $("#ad_state_id").val()

		if (cities[state_id] != undefined ){
			html = "";

			html += '<label class="title" for="city_id">City</label>'
			html += '<div class="">'
			html += '<select id="city_id" name="ad[city_id]"><option value="">Please Select</option>'
			$.each(cities[state_id], function(index,value){

				html += '<option value="'+value['id']+'">'+value['name']+'</option>'
			})
			html += '</div>'

			$("#cities").html(html)
			$("#cities").show()
		}else{
			$("#cities").html("")
			$("#cities").hide()
		}

})

//})

