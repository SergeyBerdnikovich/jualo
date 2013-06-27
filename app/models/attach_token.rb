class AttachToken < ActiveRecord::Base
  attr_accessible :ad_id, :token

  belongs_to :ad
end