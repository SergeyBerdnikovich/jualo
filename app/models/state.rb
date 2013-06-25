class State < ActiveRecord::Base
  attr_accessible :name
  has_many :cities
  has_many :ads

  extend FriendlyId
  friendly_id :name, use: :slugged

end
