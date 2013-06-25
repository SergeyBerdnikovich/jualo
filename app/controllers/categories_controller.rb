class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json

  def export_categories
    @response = ActiveSupport::JSON.decode(params[:data])
    @response.each{|catalog|
      if Category.where("id = ?", catalog["id"]).size == 0
        Category.new(:id => catalog["id"], :parent => catalog["parent"], :name => catalog["name"]).save
      else
       @cat =  Category.find(catalog["id"])
       @cat.update_attributes(:parent => catalog["parent"], :name => catalog["name"])
        @cat.save
      end

    }
  end

  def export_products
    @response = ActiveSupport::JSON.decode(params[:data])
#(id SERIAL, name VARCHAR(255), short_des VARCHAR(500) , des TEXT, images TEXT, category_id INT, address VARCHAR(5000), phone VARCHAR(255), price VARCHAR(255) , used TINYINT, username VARCHAR(255), exported TINYINT, PRIMARY KEY (id))")
    @response.each{|ad|

      @user = User.where("name = ?", ad["username"])
      if @user.size == 0
        @user = User.new(:name => ad["username"], :phone => ad["phone"])
        @user.save(:validate => false)
      else
        @user = @user.first
      end

      address = ad["address"].split(/,/)

      sate_name =  address[1].strip
      city_name =  address[0].strip

      @state = State.where("name = ?", sate_name)
      if State.where("name = ?", sate_name).size == 0
        @state = State.new(:name => sate_name)
        @state.save(:validate => false)
      else
        @state = @state.first
      end

      @city = City.where("name = ?", city_name)
      if @city.size == 0
        @city = City.new(:name => city_name, :state_id => @state.id)
        @city.save(:validate => false)
      else
       @city =  @city.first
      end

      @ad = Ad.where("id = ?", ad["id"])
      if @ad.size == 0
        @ad = Ad.new(:id => ad["id"],
  :category_id => ad["category_id"],
  :ad_type_id => 0,
  :ad_condition_id => 0 ,
  :price => ad["price"],
  :image_id => nil )
        @ad.city = @city
        @ad.state = @state
        @ad.user = @user
        @ad.save(:validate => false)


      @details = Detail.new(:name => ad["name"], :ad_id => @ad.id, :description => ad["des"])
      @details.save(:validate => false)

    ad["images"].split(/,/).each{|img|

      @image = Image.new(:title => ad['name'], :ad_id => @ad.id, :url => img, :need_download => true)
      @image.save(:validate => false)
      if @ad.image_id == nil
        @ad.image_id = @image.id
        @ad.save(:validate => false)
      end
    }

      end



    }

  end


  def home

    @states = State.all

    @new = Ad.where('image_id > 1').order("created_at DESC").limit(9)

    @categories = Category.where('parent = 1')

  end

  def index
    redirect_to root_path and return true
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])    
    @catalogs = Category.where("parent = ?", @category.id)
    begin
    @parent_cat = Category.find(@category.parent)
    rescue
     @parent_cat = Category.find(1)
    end

    
    if params[:filter]
      filters = ""
      params[:filter].each do |filter|
        filters += " AND " if filters != ""
        filters += " id IN (SELECT ad_id AS id FROM ads_variants WHERE variant_id = #{filter[1]})"
      end
      @ads = @category.ads.where(filters).order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    else 
      @ads = @category.ads.order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end

  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
