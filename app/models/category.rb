class Category < ActiveRecord::Base
  attr_accessible :name, :parent, :id
  has_many :ads
  has_many :options

  extend FriendlyId
  friendly_id :name, use: :slugged
end
