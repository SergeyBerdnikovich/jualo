class Image < ActiveRecord::Base
	attr_accessible :ad_id, :title, :url, :need_download, :image
	has_attached_file :image,:whiny => true, :styles => { :medium => "300x300>", :thumb => "95x95>" }, :default_url => "/images/:style/missing.png"

	belongs_to :ad

	def self.downloads

		@images = Image.where("need_download = 1").limit(30)
		begin
			@images.each do |image|
				p image
				needretry = false
				begin
					image.image = open(image.url)
				rescue
					needretry = true
				end

				if needretry == true
					begin
						image.image = open(image.url)
					rescue
					end
				end

				image.url = ""
				image.need_download = false
				image.save

			end
		@images = Image.where("need_download = 1").limit(30)
		end while @images.size != 0
	end


end
