class User < ActiveRecord::Base
  attr_accessible :name, :phone
  has_many :ads
end
