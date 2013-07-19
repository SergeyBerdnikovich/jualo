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

  def get_new_captcha
    respond_to do |format|
      data = form_captcha
      format.json  { render :json => data } # don't do msg.to_json
    end
  end

  def verify_captcha
    respond_to do |format|
      data = {"result" => check_captcha(params[:captcha_id], params[:captcha]) }
      format.json  { render :json => data } # don't do msg.to_json
    end
  end

  def verify_name
    respond_to do |format|
      params[:name].blank? ? result = 'Name can not be blank' : result = true
      data = {"result" => result }
      format.json  { render :json => data } # don't do msg.to_json
    end
  end

  def verify_email
    respond_to do |format|
      email = params[:email]
      result = true
      regexp = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/
      if email.present?
        result = 'Incorrect data' unless email =~ regexp
      else
        result = 'Email can not be blank'
      end
      data = {"result" => result }
      format.json  { render :json => data } # don't do msg.to_json
    end
  end

  def verify_phone_number
    respond_to do |format|
      params[:phone_number].blank? ? result = 'Phone Number can not be blank' : result = true
      data = {"result" => result }
      format.json  { render :json => data } # don't do msg.to_json
    end
  end

  def verify_subject
    respond_to do |format|
      params[:subject].blank? ? result = 'Subject can not be blank' : result = true
      data = {"result" => result }
      format.json  { render :json => data } # don't do msg.to_json
    end
  end

  def verify_message
    respond_to do |format|
      params[:message].blank? ? result = 'Message can not be blank' : result = true
      data = {"result" => result }
      format.json  { render :json => data } # don't do msg.to_json
    end
  end

  def form_captcha
    require 'securerandom'
    captcha_str = (0...7).map{ ('A'..'Z').to_a[rand(26)] }.join
    captcha_id = (0...10).map{ ('1'..'9').to_a[rand(9)] }.join
    session['captcha'] = Hash.new unless session['captcha']
    session['captcha'][captcha_id] = captcha_str
    captcha = generate_captcha(captcha_str)
    return captcha, captcha_id
  end
  def show
    @ad = Ad.find(params[:id])
    #@category = Category.find(@ad.category_id)
    begin
      @parent_category = Category.find(@ad.category.parent)
    rescue
      @parent_category = nil
    end
    @captcha, @captcha_id = form_captcha

    render :layout => 'application3' if params[:layout] == 'false'
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @ad }
    # end
  end

  def send_email
    if params[:modal] == 'true' && params[:nama].present? && params[:email].present? && params[:phone_number].present? && params[:subyek].present? && params[:pesan].present? && params[:captcha_id] && params[:captcha]
      if check_captcha(params[:captcha_id], params[:captcha])
        #Mailer.send_message_to_ad_user(params, params[:ad_user_email]).deliver
        flash[:notice] = 'Email has been sent'
      else
        flash[:alert] = 'Wrong captcha '
      end
    elsif params[:nama].present? && params[:email_a_friend].present? && params[:your_email].present? && params[:pesan].present?
      Mailer.send_message_to_friend(params).deliver
      flash[:notice] = 'Email has been sent to your friend'
    else
      flash[:error] = 'Please fill out fields correctly'
    end
    redirect_to ad_path(:state => params[:state], :city => params[:city], :category => params[:category], :id => params[:ad_id])
  end

  # GET /ads/new
  # GET /ads/new.json
  def check_captcha(captcha_id, captcha)

    if session
      session['captcha'] = Hash.new unless session['captcha']
      if session['captcha'][captcha_id].strip.upcase == captcha.upcase
        session['captcha'] = nil
        return true 
      end
    end
    return false
  end

  def new
    @ad = Ad.new
    @ad.build_detail
    @ad.images.build
    @captcha, @captcha_id = form_captcha

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
      if current_user
        @user = current_user
      else
        @user = User.new()
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

    if current_user  #if user doesn't exist don't make slug yet
      @ad.user = current_user
    else
      @ad.slug = nil
    end

    respond_to do |format|
      if @ad.save

        unless current_user  #if user not logged in or register create attach token to attach this ad to a user later
          require 'securerandom'
          @tok = AttachToken.new(:ad_id => @ad.id, :token => SecureRandom.hex(32))
          @tok.save
          session['attach_token'] = @tok.token
        end

        if params[:image_ids]
          params[:image_ids].each do |value|
            @ad.image_id = value if @ad.image_id == nil
            Image.find(value).update_attribute(:ad_id, @ad.id)
          end
        end

        if variants
          begin
            variants.each do |val|
              @ad.variants << Variant.find(val[1])
            end
          end
        end

        format.html {
          if current_user
            redirect_to ad_path(@ad.state, @ad.city, @ad.category,@ad), notice: 'Ad was successfully created.'
          else
            user_exist = User.where('email = ?', params[:user][:email]).first
            session[:user] = params[:user]

            if user_exist
              redirect_to new_user_session_path(:user => {:email => params[:user][:email]}), notice: "Please log in to post your ad"
            else
              redirect_to users_register_path(), notice: 'Please register to finalize posting.'
            end
          end

        }
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
