class City < ActiveRecord::Base
  attr_accessible :name, :state_id
  has_many :ads
  belongs_to :state
  extend FriendlyId
  friendly_id :name, use: :slugged
  
end
