class SpamReport < ActiveRecord::Base
  attr_accessible :ad_id, :email, :ip, :message, :name
end
