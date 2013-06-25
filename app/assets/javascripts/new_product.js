//$(document).ready(function(){


	$("#ad_category_id").change(function(){
		ad_category_id = $("#ad_category_id").val()

		if (subcategories[ad_category_id] != undefined ){
			html = "";

			html += '<label class="control-label" for="ad_ad_type_id">Sub Categories</label>'
			html += '<div class="controls">'
			html += '<select id="ad_ad_subcategory_id" name="ad[subcategory_id]"><option value="">Please Select</option>'
			$.each(subcategories[ad_category_id], function(index,value){
				html += '<option value="'+value[0]+'">'+value[1]+'</option>'
			})
			html += '</div>'

			$("#subcategory").html(html)
			$("#subcategory").show()
		}else{
			$("#subcategory").hide()
		}

		if (options[ad_category_id] != undefined ){
			html = "";

			html += '<label class="control-label" >Additional information<p></label>'
			html += '<div class="controls">'
			 
			$.each(options[ad_category_id], function(index,value){
				html += '<label style="display:block" for="ad_ad_options_id'+index+'">'+index+'</label>'
				html += '<select id="ad_ad_options_id'+index+'" name="ad[options['+index+']]"><option value="">'+index+'</option>'
				$.each(value, function(index,value){
					html += '<option value="'+value['id']+'">'+value['value']+'</option>'
				})
				html += '</select><p>'
			})
			html += '</div>'

			$("#options").html(html)
			$("#options").show()
		}else{
			$("#options").hide()
		}


	})

$("#ad_state_id").change(function(){
		state_id = $("#ad_state_id").val()

		if (cities[state_id] != undefined ){
			html = "";

			html += '<label class="control-label" for="city_id">City</label>'
			html += '<div class="controls">'
			html += '<select id="city_id" name="ad[city_id]"><option value="">Please Select</option>'
			$.each(cities[state_id], function(index,value){

				html += '<option value="'+value['id']+'">'+value['name']+'</option>'
			})
			html += '</div>'

			$("#cities").html(html)
			$("#cities").show()
		}else{
			$("#cities").hide()
		}

})


//})

