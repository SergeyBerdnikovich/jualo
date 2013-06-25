class Variant < ActiveRecord::Base
  attr_accessible :option_id, :value
  belongs_to :option
  has_and_belongs_to_many  :ads
end
