class StaticPage < ActiveRecord::Base
  attr_accessible :content, :locale_id, :name
end
