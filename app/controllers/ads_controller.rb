class AdsController < ApplicationController
  # GET /ads
  # GET /ads.json
  def index
    redirect_to root_path and return true
    @ads = Ad.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ads }
    end
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @ad = Ad.find(params[:id])
    @category = Category.find(@ad.category_id)
    begin
      @parent_category = Category.find(@category.parent)
    rescue
      @parent_category = nil
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ad }
    end
  end

  # GET /ads/new
  # GET /ads/new.json
  def new
    @ad = Ad.new
    @ad.build_detail
    @ad.images.build
    @subcategories = Hash.new
    subcategories = Category.where('parent > 1')
    subcategories.each do |subcat|
      @subcategories[subcat.parent] =  Array.new if @subcategories[subcat.parent] == nil
      @subcategories[subcat.parent].push([subcat.id,subcat.name])
    end

    @options = Hash.new
    subcategories = Category.where('parent = 1')
    subcategories.each do |subcat|
      if subcat.options.size != 0
        @options[subcat.id] =  Hash.new if @options[subcat.id] == nil
        subcat.options.each do |option|
          @options[subcat.id][option.name] = option.variants.select('id, value')
        end
      end

      @cities = Hash.new
      State.all.each do |state|
        @cities[state.id] =  Array.new if @cities[state.id] == nil
        @cities[state.id] = state.cities.select('id, name')
      end

    end


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ad }
    end
  end

  # GET /ads/1/edit
  def edit
    @ad = Ad.find(params[:id])
  end

  # POST /ads
  # POST /ads.json
  def create
    if params[:ad][:subcategory_id]
      params[:ad][:category_id] = params[:ad][:subcategory_id]
      params[:ad].delete(:subcategory_id)
    end

    if params[:ad][:options]
      variants = params[:ad][:options]
      params[:ad].delete(:options)
    end


    @ad = Ad.new(params[:ad])


    respond_to do |format|
      if @ad.save
        if params[:image_ids]
          params[:image_ids].each do |value|
            @ad.image_id = value if @ad.image_id == nil
            Image.find(value).update_attribute(:ad_id, @ad.id)
          end
        end

        if variants
          begin
          variants.each do |val|
#            raise val.inspect.to_s
            @ad.variants << Variant.find(val[1])
          end

          #rescue 
          #  raise variants.inspect.to_s
          end
      end

        format.html { redirect_to ad_path(@ad.state, @ad.city, @ad.category,@ad), notice: 'Ad was successfully created.' }
        format.json { render json: @ad, status: :created, location: @ad }
      else
        format.html { render action: "new" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ads/1
  # PUT /ads/1.json
  def update
    @ad = Ad.find(params[:id])

    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy

    respond_to do |format|
      format.html { redirect_to ads_url }
      format.json { head :no_content }
    end
  end
end
