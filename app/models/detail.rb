class Detail < ActiveRecord::Base
  attr_accessible :ad_id, :address, :description, :name
  belongs_to :ad
end
