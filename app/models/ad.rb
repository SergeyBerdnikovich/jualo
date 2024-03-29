class Ad < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :ad_condition_id, :ad_type_id, :category_id, :city_id, :image_id, :price, :state_id, :user_id, :id, :slug, :variant_ids, :currency_id, :detail_attributes, :active
  belongs_to :category
  belongs_to :ad_type
  belongs_to :city
  belongs_to :state
  belongs_to :category
  belongs_to :user
  has_one :detail
  has_one :attach_token
  accepts_nested_attributes_for :detail
  has_many :images
  has_and_belongs_to_many  :variants
  has_many :options, through: :category

  self.per_page = 30

  attr_accessor :name



  friendly_id :name, use: :scoped, :scope => [:category, :city, :state]


  def name
    @name = nil
    @name = detail.name.strip.gsub(/[^\sA-Za-z0-9]/," ").gsub(/[ ]{2,99}/," ") if detail
    return id if @name.blank?
    if @name.length < 5
    	@name = id.to_s + "-" + @name
    end
    return @name
  end

  def image
  	@image = Image.where('id = ?',self.image_id).first
  	return @image
  end
end
