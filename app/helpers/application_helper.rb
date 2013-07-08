module ApplicationHelper

	def current_url(overwrite={})
		url = params
		url.delete("action")
		url.delete("controller")
		url.delete("id")
		url_for :only_path => false, :params => url.merge(overwrite)
	end

	def stripe_unallowed_tags(text)
		text.scan(/(?:<)\w{1,100}/).each do |tag|
			unless tag[1] =~ /br|p|li|ul/    # the list in regular expression of allowed tag. Just list separated by |
				text.gsub!(/<#{tag[1]}[^>]*>/,"")
				text.gsub!(/<\/#{tag[1]}>/,"")
			end
		end
		text.gsub!(/<\/div>/,"") #we have divs layout, lost closing div tag could ruin it for us

		text

	end
end
